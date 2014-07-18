//
//  dongfangbaliViewController.m
//  pudongapp
//
//  Created by jiangjunli on 14-3-2.
//  Copyright (c) 2014年 jiangjunli. All rights reserved.
//

#import "dongfangbaliViewController.h"
#import "ConvenienceServicesViewController.h"
#import "LujiazuiData.h"
#import "CommonHeader.h"
#import "PictureTable/PictureTableView.h"
#import "UIView+FrameHandle.h"

@interface dongfangbaliViewController ()<PullTableViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *contentscrollview;
@property (weak, nonatomic) IBOutlet UILabel *nameTitle;
@property (weak, nonatomic) IBOutlet UILabel *detail;
@property (weak, nonatomic) IBOutlet UITextView *moreDetail;
@property (weak, nonatomic) IBOutlet UIImageView *image1;

@property (weak, nonatomic) IBOutlet UIButton *showMoreBtn;
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *bianminfuwuBtn;

@property (weak, nonatomic) IBOutlet PictureTableView *table1;
@property (weak, nonatomic) IBOutlet PictureTableView *table2;
@property (weak, nonatomic) IBOutlet UIImageView *table_line;
@property (strong, nonatomic) NSArray * showTypes;
@end

@implementation dongfangbaliViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)initTable:(PictureTableView*)table{
    table.delegate = (id)self;
    table.dataSource = (id)table;
    table.pullDelegate = self;
    table.viewController = self;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    ((UILabel*)self.navigationItem.titleView).text = self.showType;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if(self.eScenicType == EDfbl)
        [PictureHelper addPicture:self.mainPictureUrl to:self.mainPicture withSize:CGRectMake(0, 0, 320, 160)];
    else{
        //当不是特殊景点时，使用本地文件加载图片
        self.mainPicture.image = [UIImage imageNamed:self.mainPictureUrl];
    }
    
    //隐藏详细内容，显示简要介绍
    self.moreDetail.hidden = YES;
    self.showMoreBtn.hidden = NO;
    self.detail.hidden = NO;
    
    [self.button1 setTitle:self.buttonname1 forState:UIControlStateNormal];
    [self.button2 setTitle:self.buttonname2 forState:UIControlStateNormal];
    
    [self setTables];
    NSString *path = [self getPathWithType:self.showType];
    [self loadDataFromWeb:path];
    
    
    static NSArray *showTypesLujiazui      = nil;
    static NSArray *showTypesExpo          = nil;
    static NSArray *showTypesSpecialTravel = nil;
    if(showTypesLujiazui == nil)
        showTypesLujiazui = @[@"著名景区", @"娱生活", @"楼宇群"];
    if(showTypesExpo == nil)
        showTypesExpo = @[@"世博符号", @"世博源", @"世博记忆"];
    if(showTypesSpecialTravel == nil)
        showTypesSpecialTravel =  @[@"都市观光游", @"乡村生态游", @"科技体验游"];
    
    
    BOOL (^AContainS)(NSArray *array, NSString *s) = ^(NSArray* array, NSString *s){
        for (NSString *str in array) {
            if( [str isEqualToString:s])
                return YES;
        }
        return NO;
    };
    //只有小陆家嘴才有便民服务
    if(AContainS(showTypesLujiazui, self.showType)){
        self.bianminfuwuBtn.hidden = NO;
    }else{
        self.bianminfuwuBtn.hidden = YES;
        self.downView.originY -= 50;
        
        if ([self.showType isEqualToString:@"世博记忆"]) {
            self.button2.hidden = YES;
            self.image1.hidden = YES;
            self.table_line.originX += 80;
            self.button1.originX += 80;
        }

    }

}

//see lujiazuiViewController.m:didSelectRowAtIndexPath
-(NSString *) getPathWithType:(NSString *)type{
    NSString *path = nil;
    //陆家嘴
    if([type isEqualToString:@"著名景区"]){
        path = [getTjxDetail copy];
    }else if([type isEqualToString:@"娱生活"]){
        path = [getDfblDetail copy];
    }else if([type isEqualToString:@"楼宇群"]){
        path = [getJrjlyDetail copy];
    }//世博
    else if([type isEqualToString:@"世博符号"]){
        path = [getSbfhDetail copy];
    }else if([type isEqualToString:@"世博源"]){
        path = [getSbxgDetail copy];
    }else if([type isEqualToString:@"世博记忆"]){
        path = [getSbjyDetail copy];
    }
    //特色旅游: @"都市观光游", @"乡村生态游", @"科技体验游"
    else {
        path = [getPathDetail copy];
        path = [path stringByAppendingFormat:@"?pathId=%@", self.pathId];
    }
    return path;
}

-(void)loadDataFromWeb:(NSString *)path{
    [HTTPAPIConnection postPathToGetJson:(NSString*)path block:^(NSDictionary *json, NSError *error){
        LujiazuiData *data = [[LujiazuiData alloc] init];
        [data updateWithJsonDic:json];
        self.nameTitle.text = data->info->title;
        self.detail.text = data->info->detail;
        
        NSString *imagePath = data->bigImg->imgUrl;
        [PictureHelper addPicture:imagePath to:(UIImageView*)self.mainPicture];
    }];
}

-(void)setTables{
    [self initTable:self.table1];
    [self initTable:self.table2];
    //lujiazui
    NSLog(@"%@", self.showType);
    if([self.showType  isEqualToString: @"著名景区"]){
        self.table1.path = [getMsjdList copy];
        self.table2.path = [getTjxZbtjList copy];

    }else if([self.showType  isEqualToString:@"娱生活"]){
        self.table1.path = [getSsshList copy];
        self.table2.path = [getXzysList copy];
    }else if([self.showType isEqualToString:@"楼宇群"]){
        self.table1.path = [getJrjyList copy];
        self.table2.path = [getJrjlyZbtjList copy];
    }//expo
    else if([self.showType isEqualToString:@"世博符号"]){
        self.table1.path = [getYzsgList copy];
        self.table2.path = [getQtcgList copy];
    }else if([self.showType isEqualToString:@"世博源"]){
        self.table1.path = [getSbxgList copy];
        self.table2.path = [getTjcgList copy];
    }else if([self.showType isEqualToString:@"世博记忆"]){
        self.table1.path = [getZgzyList copy];
        self.table2.path = [getZbxxList copy];
    }//Special activity
    else {
        //@"都市观光游", @"乡村生态游", @"科技体验游"
        self.table1.isLeftViewDifferent = YES;
        
        self.table1.path = [getXctjList copy];
        self.table1.pathId = self.pathId;
        
        self.table2.path = [getZbtjList copy];
        self.table2.pathId = self.pathId;
    }
    [HUDHandle startLoadingWithView:nil];
    if(self.table1.hidden == NO)
        [self.table1 loadDataFromWeb:NO];
    else
        [self.table2 loadDataFromWeb:NO];
    
    NSLog(@"titleLeft = %@, titleRight = %@", self.button1.titleLabel.text, self.button2.titleLabel.text );
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    self.contentscrollview.contentSize = CGSizeMake(320, 857);
    if (IS_IPHONE5) {
        self.contentscrollview.frame = CGRectMake(0, 65, 320, 503);
    }else{
        self.contentscrollview.frame = CGRectMake(0, 150, 320, 423);
    }
    
    self.table2.hidden = YES;
    
    @weakify(self);
    [[self.bianminfuwuBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
         @strongify(self);
         [self.navigationController pushViewController:[ConvenienceServicesViewController new] animated:YES];
     }];
    [[self.showMoreBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
         @strongify(self);
         self.moreDetail.text    = self.detail.text;
         self.detail.hidden      = YES;
         self.moreDetail.hidden  = NO;
         self.showMoreBtn.hidden = YES;
     }];
    
    [[self.button1 rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
         @strongify(self);
         self.table2.hidden = !(self.table1.hidden = NO);
         [HUDHandle startLoadingWithView:nil];
         [self.table1 loadDataFromWeb:NO];
         
         self.button2.titleLabel.textColor = [UIColor whiteColor];
         self.button1.titleLabel.textColor = [UIColor cyanColor];
         self.table_line.frame = CGRectMake(20, 48, 140, 2);
         
     }];
    
    [[self.button2 rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
         @strongify(self);
         self.table2.hidden = !(self.table1.hidden = YES);
         [HUDHandle startLoadingWithView:nil];
         [self.table2 loadDataFromWeb:NO];
         
         self.button1.titleLabel.textColor = [UIColor whiteColor];
         [self.button2 setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
         self.table_line.frame = CGRectMake(160, 48, 140, 2);
     }];
}

//下拉刷新在这个类中接收，传递给左右两个table ，让显示出来的那个table更新数据
#pragma mark - PullTableViewDelegate
- (void)pullTableViewDidTriggerRefresh:(PullTableView *)pullTableView{
    [self performSelector:@selector(refreshTable) withObject:nil afterDelay:1.0f];
}
- (void)pullTableViewDidTriggerLoadMore:(PullTableView *)pullTableView{
    [self performSelector:@selector(loadMoreDataToTable) withObject:nil afterDelay:1.0f];
}
-(void)refreshTable{
    BOOL more = NO;
    if(self.table1.hidden){
        if(self.table2.pullTableIsLoadingMore  == YES){
            self.table2.pullTableIsRefreshing = NO;
            return;
        }
        [HUDHandle startLoadingWithView:nil];
        [self.table2 loadDataFromWeb:more];
    }else{
        if(self.table1.pullTableIsLoadingMore  == YES){
            self.table1.pullTableIsRefreshing = NO;
            return;
        }
        [HUDHandle startLoadingWithView:nil];
        [self.table1 loadDataFromWeb:more];
    }
}
-(void)loadMoreDataToTable{
    BOOL more = YES;
    if(self.table1.hidden){
        if(self.table2.pullTableIsRefreshing  == YES){
            self.table2.pullTableIsLoadingMore = NO;
            return;
        }
        [HUDHandle startLoadingWithView:nil];
        [self.table2 loadDataFromWeb:more];
    }else{
        if(self.table1.pullTableIsRefreshing  == YES){
            self.table1.pullTableIsLoadingMore = NO;
            return;
        }
        [HUDHandle startLoadingWithView:nil];
        [self.table1 loadDataFromWeb:more];
    }
}
@end
