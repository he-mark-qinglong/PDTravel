//
//  wangyoudianpingViewController.m
//  pudongapp
//
//  Created by jiangjunli on 14-2-21.
//  Copyright (c) 2014年 jiangjunli. All rights reserved.
//

#import "wangyoudianpingViewController.h"
#import "CommonHeader.h"
#import "PullTableView.h"
#import "dianpingCell.h"
#import "ElseMainViewData.h"

@interface wangyoudianpingViewController ()
<UITableViewDataSource,UITableViewDelegate, PullTableViewDelegate,
UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet PullTableView *contentTableView;
@property(strong,nonatomic) NSMutableArray *usernameArray;
@property(strong,nonatomic) UIView *view1;


@property NSMutableArray *arrayToShow;
@property NSInteger pageNo;
@end

@implementation wangyoudianpingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.contentTableView FitViewOffsetY];
    
    if(!self.arrayToShow)
        self.arrayToShow = [[NSMutableArray alloc] init];

    // Do any additional setup after loading the view from its nib.
    self.contentTableView.delegate = self;
    self.contentTableView.dataSource = self;
    self.contentTableView.pullDelegate = self;
    self.contentTableView.backgroundColor = [UIColor clearColor];
    self.contentTableView .separatorStyle = UITableViewCellSeparatorStyleNone;
    if ([self.ismessage isEqualToString:@"0.0分"]) {
        self.messagelabel.hidden = NO;
    }
}

-(void)loadDataFromWeb:(BOOL)more{
    if(more){
        self.pageNo++;
    }else{
        self.pageNo = 1;
        [self.arrayToShow removeAllObjects];
    }
    NSString *path = [getCommentList copy];
    path = [path stringByAppendingString:
            [NSString stringWithFormat:@"?pageNum=%d&viewId=%@",
             self.pageNo, self.viewId]];
    [HTTPAPIConnection postPathToGetJson:(NSString*)path block:^(NSDictionary *json, NSError *error){
        if ([json objectForKey:@"info"] == nil) {
            //空数据
            [self.contentTableView reloadData];
            self.pageNo--;
            return;
        }
        
        CommentData *data = [CommentData new];
        [data updateWithJsonDic:json];
        [self.arrayToShow addObjectsFromArray:data->info];
        
        [self.contentTableView reloadData];
    }];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    ((UILabel*)self.navigationItem.titleView).text = @"网友点评";  //设置标题
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [HUDHandle startLoadingWithView:nil];
    [self loadDataFromWeb:NO];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
    self.contentTableView. pullTableIsRefreshing = NO;
    self.contentTableView. pullTableIsLoadingMore = NO;

    [HUDHandle stopLoading];
    return [self.arrayToShow count];
}
- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 155;
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"dianpingCell";
    //自定义cell类
    dianpingCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //通过xib的名称加载自定义的cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"dianpingCell" owner:self options:nil] lastObject];
    }
    NSUInteger row = [indexPath row];
    //添加测试数据
    
    [cell setContent:[self.arrayToShow objectAtIndex:row]];
           UIGestureRecognizer *singleTap
        = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigImage:)];
        singleTap.delegate = self;
        UIGestureRecognizer *singleTap2
        = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigImage:)];
        singleTap2.delegate = self;
        UIGestureRecognizer *singleTap3
        = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigImage:)];
        singleTap3.delegate = self;
        [cell.imageview1  addGestureRecognizer:singleTap];
        cell.imageview1.tag = 100;
        [cell.imageview2 addGestureRecognizer:singleTap2];
        cell.imageview2.tag = 200;
        
        [cell.imageview3 addGestureRecognizer:singleTap3];
        cell.imageview2.tag = 300;
 
    
  
    return cell;

}
-(void) showBigImage:( UIGestureRecognizer *)tap
{}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
       shouldReceiveTouch:(UITouch *)touch{
#if 1
    NSLog(@"touch.view.tag = %d,class = %@", touch.view.tag,[touch.view class]);
#endif
    UIImageView *cellImageView = (UIImageView *)touch.view;
    /*因为cell的图片是通过PictureHelper加载的，
     因此如果要去图片内容，需要再获取imageView的子view，
     然后才能拿到image的内容*/
    UIImage *image = [PictureHelper getImageOfView:cellImageView];
    
    if (image ==nil) {
        return NO;
    }
    self.view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320,
                                                          [UIScreen mainScreen].bounds.size.height)];
    self.view1.backgroundColor = [UIColor blackColor];
    self.view1.alpha = 0.75;
    UIImageView *imageViewer = [[UIImageView alloc] init];
    UITapGestureRecognizer *closeTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                               action:@selector(hideBigImage:)];
    imageViewer.multipleTouchEnabled = YES;
    imageViewer.userInteractionEnabled = YES;
    [imageViewer addGestureRecognizer:closeTap];
    imageViewer.animationDuration = 2.0;
    imageViewer.animationRepeatCount = 1;
    [imageViewer setFrame:CGRectMake(10, 130, 300, 200)];
    [imageViewer startAnimating];
    
    [imageViewer setImage:image];
    
    UIWindow *mainWindow = [UIApplication sharedApplication].delegate.window;
    [mainWindow.rootViewController.view addSubview:self.view1];
    [mainWindow.rootViewController.view addSubview:imageViewer];

    return YES;
}
-(void) hideBigImage:(id)sender{
    UITapGestureRecognizer *tap = (UITapGestureRecognizer*)sender;
    [tap.view removeFromSuperview];
    [self.view1 removeFromSuperview];
}

//下拉刷新在这个类中接收，传递给左右两个table ，让显示出来的那个table更新数据
#pragma mark - PullTableViewDelegate
- (void)pullTableViewDidTriggerRefresh:(PullTableView *)pullTableView{
    //因为TableView加载数据的函数（numberOfRowsInSection）可能又延迟，因此需要排斥加载更多的情况
    if(self.contentTableView.pullTableIsLoadingMore == YES){
        self.contentTableView.pullTableIsRefreshing = NO;
        return;
    }
    [HUDHandle startLoadingWithView:nil];
    [self performSelector:@selector(refreshTable) withObject:nil afterDelay:1.0f];
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView *)pullTableView{
    if( self.contentTableView.pullTableIsRefreshing == YES){
        self.contentTableView.pullTableIsLoadingMore = NO;
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
