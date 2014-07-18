//
//  SoundDownLoadViewController.m
//  pudongapp
//
//  Created by jiangjunli on 14-2-19.
//  Copyright (c) 2014年 jiangjunli. All rights reserved.
//

#import "SoundDownLoadViewController.h"
#import "CommonHeader.h"
#import "PullTableView.h"
#import "SoundCell.h"
#import "ElseMainViewData.h"
#import "NSString+Interception.h"

@interface TempStruct : NSObject
@property NSString *title;
@property NSString *name;
@property NSString *name2;
@end

@implementation TempStruct
@end

@interface SoundDownLoadViewController ()<PullTableViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet PullTableView *soundContenTable;
@property(strong,nonatomic) NSMutableArray *arrayToShow;
@property (weak, nonatomic) IBOutlet UIImageView *mainPicture;

@property NSInteger pageNo;
@end

@implementation SoundDownLoadViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)setAutomaticallyAdjustsScrollViewInsets:(BOOL)automaticallyAdjustsScrollViewInsets{
    if(IOS7){
        [super setAutomaticallyAdjustsScrollViewInsets:automaticallyAdjustsScrollViewInsets];
    }
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self.contentView FitViewOffsetY];
    
    if([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]){
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    // Do any additional setup after loading the view from its nib.
    self.soundContenTable.delegate = self;
    self.soundContenTable.dataSource = self;
    self.soundContenTable.pullDelegate = self;
    
    self.soundContenTable.backgroundColor = [UIColor clearColor];
    self.soundContenTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    if(!IS_IPHONE5) {
        self.soundContenTable.height = 264;
    }
}

-(void)loadDataFromWeb:(BOOL)more{
    if(!self.arrayToShow)
        self.arrayToShow = [[NSMutableArray alloc] init];
    
    if(more){
        self.pageNo++;
    }else{
        self.pageNo = 1;
        [self.arrayToShow removeAllObjects];
    }
    NSString *path = [getVoiceList copy];
    if(self.viewId == nil){
        path = [path stringByAppendingString:
                [NSString stringWithFormat:@"?pageNum=%d",
                 self.pageNo]];
    }else{
        path = [path stringByAppendingString:
                [NSString stringWithFormat:@"?pageNum=%d&viewId=%@",
                 self.pageNo, self.viewId]];
    }
    [HTTPAPIConnection postPathToGetJson:(NSString*)path block:^(NSDictionary *json, NSError *error){
        //注意：voiceUrl为UTF8编码路径时，会下载失败，没有找到具体原因
        if ([json objectForKey:@"info"] == nil) {
            //空数据
            /*
            VoiceInfo *info = [VoiceInfo new];
            info->imgUrl = @"http://192.168.0.66:9090/img/be86dba2-75c7-4a20-9fb4-dab3781d3e5d.png";
            info->area = @"地区";
            info->title = @"假数据标题";
            info->voiceId = @"没有id";
            info->voiceUrl = @"http://192.168.41.226/夜空中最亮的星.mp3";
            [self.arrayToShow addObject:info];
            */
            self.pageNo--;
            [self.soundContenTable reloadData];
            return;
        }
        
        VoiceData *data = [VoiceData new];
        [data updateWithJsonDic:json];
        [self.arrayToShow addObjectsFromArray:data->arrayVoiceInfo];
        
        [self.soundContenTable reloadData];
    }];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    ((UILabel*)self.navigationItem.titleView).text = @"语音包";  //设置标题
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [HUDHandle startLoadingWithView:nil];
    [self loadDataFromWeb:NO];
    
    NSString *path = [getVoicePic copy];
    path = [path stringByAppendingString:
            [NSString stringWithFormat:@"?viewId=%@", self.viewId]];
    [HTTPAPIConnection postPathToGetJson:(NSString*)path block:^(NSDictionary *json, NSError *error){
        if(error || json == nil || [json objectForKey:@"info"] == nil){
            
        }else{
            [PictureHelper addPicture:[[json objectForKey:@"info"] objectForKey:@"imgUrl"]
                                   to:self.mainPicture
                             withSize:CGRectMake(0, 0, 320, 173)];
        }
    }];
    
    [SoundCell clearPlayer];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [SoundCell clearPlayer];
}
#pragma mark UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    self.soundContenTable.pullTableIsLoadingMore = NO;
    self.soundContenTable.pullTableIsRefreshing = NO;
    [HUDHandle stopLoading];
    
    return [self.arrayToShow count];
}
- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger row = [indexPath row];
    
    static NSString *CellIdentifier = @"SoundCell";
    SoundCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SoundCell" owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;//设置选择cell的颜色
    cell.backgroundColor = [UIColor clearColor];
    
    VoiceInfo *info = [self.arrayToShow objectAtIndex:row];
    
    [cell setContent:info];
    cell.tag = row;
    cell.tableDelegate = self.soundContenTable;
    return cell;
}

#pragma mark Editding
- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.arrayToShow removeObjectAtIndex:row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                         withRowAnimation:UITableViewRowAnimationAutomatic];
        [tableView cellForRowAtIndexPath: indexPath];
    }
}

#pragma mark - PullTableViewDelegate
- (void)pullTableViewDidTriggerRefresh:(PullTableView *)pullTableView{
    if(self.soundContenTable.pullTableIsLoadingMore == YES){
        self.soundContenTable.pullTableIsRefreshing = NO;
        return;
    }
    [HUDHandle startLoadingWithView:nil];
    [self performSelector:@selector(refreshTable) withObject:nil afterDelay:1.0f];
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView *)pullTableView{
    if(self.soundContenTable.pullTableIsRefreshing == YES){
        self.soundContenTable.pullTableIsLoadingMore = NO;
        return;
    }
    [HUDHandle startLoadingWithView:nil];
    [self performSelector:@selector(loadMoreDataToTable) withObject:nil afterDelay:1.0f];
}

-(void)refreshTable{
    [self loadDataFromWeb:NO];
}

-(void)loadMoreDataToTable{
    [self loadDataFromWeb:YES];
}



@end
