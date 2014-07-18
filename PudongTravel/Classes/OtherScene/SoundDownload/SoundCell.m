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

@property BOOL thisIsPlaying;
@end

@implementation SoundCell

//@"http://222.73.28.48/ishare.down.sina.com.cn/"
- (void)setUpUrl:(NSString*)baseUrl path:(NSString *)path fileName:(NSString *)fileName{
    {
        self.progressView.hidden = NO;
    }
    self.path = path;
    self.audioName = fileName;
    
    NSURL *url = [NSURL URLWithString:baseUrl];
    _httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    
    _queue = [[NSOperationQueue alloc] init];
    
    self.progressView.progress = 0.0;
    
    [self.listenBtn setImage:[UIImage imageNamed:@"icon_play.png"]
                    forState:UIControlStateSelected];
    // 指定文件保存路径，将文件保存在沙盒中
    NSArray *downloadDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    self.fullPathDld = [downloadDir[0] stringByAppendingPathComponent:self.audioName];

    NSString* tmpDocumentsDirectory = [downloadDir objectAtIndex:0];
    NSString* localFilePath = [tmpDocumentsDirectory stringByAppendingPathComponent:fileName];
    if([[NSFileManager defaultManager] fileExistsAtPath:localFilePath]){
        NSLog(@"File is found:%@", localFilePath);
        self.downLoadBtn.enabled = NO;
    }else{
        NSLog(@"File not found:%@", localFilePath);
        self.listenBtn.enabled = NO;
    }
}

#pragma mark 下载
- (IBAction)download
{
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
    /*
     bytesRead                      当前一次读取的字节数(100k)
     totalBytesRead                 已经下载的字节数(4.9M）
     totalBytesExpectedToRead       文件总大小(5M)
     */
    [op setDownloadProgressBlock:^(NSUInteger bytesRead,
                                   long long totalBytesRead,
                                   long long totalBytesExpectedToRead)
     {
         // 设置进度条的百分比
         CGFloat precent = (CGFloat)totalBytesRead / totalBytesExpectedToRead;
         NSLog(@"%2.f%%", precent * 100);
         _progressView.progress = precent;
     }];
    
    // 设置下载完成操作
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.listenBtn.enabled = YES;
        self.downLoadBtn.enabled = NO;
        // 下一步可以进行进一步处理，或者发送通知给用户。
        NSLog(@"下载成功");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"下载失败");
        
    }];
    
    // 启动下载
    [_httpClient.operationQueue addOperation:op];
}
- (IBAction)onPlayBtnClicked:(id)sender {
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



#pragma mark 检测网路状态
- (IBAction)checkNetwork:(id)sender
{
    // 1. AFNetwork 是根据是否能够连接到baseUrl来判断网络连接状态的
    // 提示：最好使用门户网站来判断网络连接状态。
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:url];
    _httpClient = client;
    [_httpClient setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        // 之所以区分无线和3G主要是为了替用户省钱，省流量
        // 如果应用程序占流量很大，一定要提示用户，或者提供专门的设置，仅在无线网络时使用！
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

+(void)emptyPlayer{
    player = nil;
}
@end
