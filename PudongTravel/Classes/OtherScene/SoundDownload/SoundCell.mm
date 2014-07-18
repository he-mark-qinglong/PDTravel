//
//  SoundCell.m
//  pudongapp
//
//  Created by jiangjunli on 14-2-19.
//  Copyright (c) 2014年 jiangjunli. All rights reserved.
//

#import "SoundCell.h"
#import "AFNetworking.h"
#import "CommonHeader.h"
#include "DownloadSqlProcess.h"
#import "NSString+Interception.h"

static AVAudioPlayer *player;

@interface SoundCell(){
    // AFN的客户端，使用基本地址初始化，同时会实例化一个操作队列，以便于后续的多线程处理
    AFHTTPClient    *_httpClient;
    
    // 下载操作
    AFHTTPRequestOperation *_downloadOperation;
    
    NSOperationQueue *_queue;
}

//下载进度条显示
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@property NSString *path;
@property NSString *audioName;
@property NSString *fullPathDld;
@property VoiceInfo *info;
@property (weak, nonatomic) IBOutlet UILabel *percentLabel;

@property BOOL thisIsPlaying;
@end

@implementation SoundCell

-(void)setContent:(VoiceInfo *)info{
    self.info = info;
    //设置播放按钮
    [self.listenBtn setImage:[UIImage imageNamed:@"icon_play.png"] forState:UIControlStateSelected];
    self.progressView.progress = 0.0;
    self.progressView.hidden = YES;
    
    [PictureHelper addPicture:info->imgUrl to:self.iconView
                     withSize:CGRectMake(0, 0, 46, 46)];
    self.Title.text = info->title;
    self.area.text = info->area;
    
    NSString *fileName = [info->voiceUrl backWardsSearchInterception:@"/"];
    info->fileName = fileName;
    self.info = info;
    NSString *url = [info->voiceUrl frontWardsSearchInterception:@"/"];
    [self setUpUrl:url path:fileName fileName:fileName];
}

- (void)setUpUrl:(NSString*)baseUrl path:(NSString *)path fileName:(NSString *)fileName{
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    self.path = path;
    self.audioName = fileName;
    // 指定文件保存路径，将文件保存在沙盒中
    NSArray *downloadDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* tmpDocumentsDirectory = [downloadDir objectAtIndex:0];
    NSString* localFilePath = [tmpDocumentsDirectory stringByAppendingPathComponent:fileName];
    
    //判断数据库中是否有这个语音包的ID,如果有了，就禁止下载，设置播放器的路径（即下载文件存放的位置）
    DownloadSqlProcess *downloderSql  = DownloadSqlProcess::instance();
    Element elem = convertInfo2Element(self.info);
    std::vector<Element> elems = downloderSql->readElements();
    if(0 != elems.size()){
        for(Element e:elems){
            if(e.voiceId == elem.voiceId){
                self.downLoadBtn.enabled = NO;
                self.fullPathDld = localFilePath;
                return;
            }
        }
    }

    //不同的ID，相同的名字，改一下名字的后缀
    if([[NSFileManager defaultManager] fileExistsAtPath:localFilePath]){
        NSLog(@"同名不同ID的语音包，将被改名字:%@", localFilePath);
        //循环添加后缀名，比如 “夜空中最亮的星1.mp3”
        NSString *extension = [fileName pathExtension];
        NSString *fileNamePrefix = [self.audioName stringByDeletingPathExtension];
        int i = 0;
        while(1){
            NSString *tmpFileName = [fileNamePrefix stringByAppendingFormat:@"%d.%@", ++i, extension];
            NSString* localFilePath = [tmpDocumentsDirectory stringByAppendingPathComponent:tmpFileName];
            if(![[NSFileManager defaultManager] fileExistsAtPath:localFilePath]){
                self.fullPathDld = [downloadDir[0] stringByAppendingPathComponent:tmpFileName];
                break;
            }
            if(i > 1000){  //太多重复的文件了，直接禁止用户下载和播放
                self.listenBtn.enabled = NO;
                self.downLoadBtn.enabled = NO;
                break;
            }
        }
        
    }else{
        NSLog(@"File not found:%@", localFilePath);
        self.fullPathDld = [downloadDir[0] stringByAppendingPathComponent:fileName];
        self.listenBtn.enabled = YES;
    }
    
    NSURL *url = [NSURL URLWithString:baseUrl];
    _httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    _queue = [[NSOperationQueue alloc] init];
    self.percentLabel.hidden = YES;
}

#pragma mark 下载
-(void)finishedDld{
    self.percentLabel.text = @"";
    self.percentLabel.hidden = YES;
    self.listenBtn.enabled = YES;
    self.downLoadBtn.enabled = NO;
    
    DownloadSqlProcess *downloderSql  = DownloadSqlProcess::instance();
    Element elem = convertInfo2Element(self.info);
    downloderSql->insertElement(elem);
}
- (IBAction)download{
    self.downLoadBtn.enabled = NO;
    NSLog(@"开始下载");
    // 1. 建立请求
    NSURLRequest *request = [_httpClient requestWithMethod:@"GET"
                                                      path:self.path
                                                parameters:nil];
    // 2. 操作
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    _downloadOperation = op;
    op.outputStream = [NSOutputStream outputStreamToFileAtPath:self.fullPathDld
                                                        append:YES];
    
    // 设置下载进程块代码
    [op setDownloadProgressBlock:^(NSUInteger bytesRead,
                                   long long totalBytesRead,
                                   long long totalBytesExpectedToRead)
     {
         CGFloat precent = (CGFloat)totalBytesRead / totalBytesExpectedToRead;
         NSString *per = [NSString stringWithFormat:@"%2.f%%", precent * 100];
         self.percentLabel.text = per;
         _progressView.progress = precent;  // 设置进度条的百分比
     }];
    
    // 设置下载完成操作
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        // 下一步可以进行进一步处理，或者发送通知给用户。
        [self finishedDld];
        NSLog(@"下载成功");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"下载失败");
    }];
    
    [_httpClient.operationQueue addOperation:op];    // 启动下载
    self.percentLabel.hidden = NO;
}

- (IBAction)onPlayBtnClicked:(id)sender {
    NSLog(@"开始播放:%@", self.fullPathDld);
    NSURL  *url = [NSURL fileURLWithPath:self.fullPathDld];
    if(player == nil){
        NSLog(@"Begin playing music");
        player  = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        player.numberOfLoops = 0;
        [player play];
        self.thisIsPlaying = YES;
    }else{
        if([player isPlaying]){
            if(self.thisIsPlaying){
                [player stop];
                self.thisIsPlaying = NO;
                NSLog(@"Stop playing");
            }else{
                NSLog(@"Stop and playing music");
                player  = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
                
                player.numberOfLoops = 0;
                [player play];
                self.thisIsPlaying = YES;
            }
        }else{
            NSLog(@"New playing music");
            player  = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
            player.numberOfLoops = 0;
            [player play];
            
            self.thisIsPlaying = YES;
        }
    }
}
+(void)clearPlayer{
    player = nil;
}
#pragma mark 检测网路状态
- (IBAction)checkNetwork:(id)sender{
    // 1. AFNetwork 是根据是否能够连接到baseUrl来判断网络连接状态的
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:url];
    _httpClient = client;
    [_httpClient setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 之所以区分无线和3G主要是为了替用户省钱，省流量
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"无线网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                [AlertViewHandle showAlertViewWithMessage:@"您在3G网络环境下，下载可能使用较多流量，是否要继续下载"];
                NSLog(@"3G网络");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"未连接");
                break;
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知错误");
                break;
        }
    }];
}


@end
