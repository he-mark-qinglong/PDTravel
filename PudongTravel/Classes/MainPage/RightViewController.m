//
//  RightViewController.m
//  pudongapp
//
//  Created by jiangjunli on 14-1-7.
//  Copyright (c) 2014年 jiangjunli. All rights reserved.
//

#import "RightViewController.h"
#import "SetUpViewController.h"
#import "myqiangpiao.h"
#import "mydianpingview.h"
#import "myyuyinbao.h"
#import "loginView.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "UIImage+Resize.h"
#import "personalSetingView.h"
#import "CommonHeader.h"
#import "MyMD5.h"
#import "CustomNavigationController.h"
#import "OtherSceneViewController.h"
#import "UIImageView+AFNetworking.h"
#import "UIView+FrameHandle.h"
@interface RightViewController ()<UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    BOOL _imageUpdate;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *qiehuanview;
@property (weak, nonatomic) IBOutlet UIView *contentview;

@property (strong,nonatomic) UITextField * pwdTextField;
@property (strong,nonatomic) UITextField * userTextField;
@property (weak, nonatomic) IBOutlet UIView *qiehuanview2;
@property (weak, nonatomic) IBOutlet UIView *actionSheetView;
@property (weak, nonatomic) IBOutlet UIView *maskView;

@property (strong,nonatomic) myqiangpiao *myqiangpiao;
@property (strong,nonatomic) mydianpingview *mydianpingview;
@property (strong,nonatomic) myyuyinbao *myyuyinbao;
@property (strong,nonatomic) loginView *lv;
@property (strong,nonatomic) personalSetingView *psv;

@property (strong, nonatomic) UIImagePickerController *imagePickerController;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *userAccount;
@property (weak, nonatomic) IBOutlet UILabel *userNickname;
@property (weak, nonatomic) IBOutlet UILabel *storeCntLabel;
@property (weak, nonatomic) IBOutlet UILabel *commonCntLabel;


@property (strong, nonatomic) UIWindow *window;

@end

@implementation RightViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self hiddenActionSheetView];
    
    if (!IS_IPHONE5) {
        if (!IOSVersion70) {
            self.actionSheetView.frame = CGRectMake(0, 480-64, 320, 155);
        }else{
            self.actionSheetView.frame = CGRectMake(0, 480, 320, 155);
        }
    }else{
        self.actionSheetView.frame = CGRectMake(0, 568, 320, 155);
    }
    
    self.imagePickerController = [[UIImagePickerController alloc] init];
    self.imagePickerController.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginSuccess)
                                                 name:@"loginSuccess" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(quitlogin)
                                                 name:@"quitlogin" object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(getnumber)
                                                 name:@"getnumber" object:nil];
    
    
    self.lv= [[[NSBundle mainBundle] loadNibNamed:@"loginView"
                                            owner:self options:nil] objectAtIndex:0];
    
    
    User *user = [[LocalCache sharedCache] cachedObjectForKey:@"user"];
    if(user == nil){
        self.qiehuanview.hidden = NO;
        self.qiehuanview2.hidden = YES;
    }else{
        if(user.isLoginSuccess == YES){
            self.qiehuanview.hidden = YES;
            self.qiehuanview2.hidden = NO;
            self.userAccount.text = user.userName;
            NSLog(@"userAccount:%@",self.userAccount.text);
            self.userNickname.text = user.nickName;
            NSString * password=user.password;
            
            NSString *path = [NSString stringWithString:(NSString*)login];
            path = [path stringByAppendingString:
                    [NSString stringWithFormat:@"?account=%@&passWord=%@",user.userName,password]];
            [HTTPAPIConnection postPathToGetJson:path block:^(NSDictionary *json, NSError *error) {
                UserData *data = [UserData new];
                [data updateWithJsonDic:json];
                if(data->info != nil){
                    user.isLoginSuccess = YES;
                    user.userId = data->info->userId;
                    user.imgUrl = data->info->imgUrl;
                    [[LocalCache sharedCache] storeCacheObject:user forKey:@"user"];
                    if (![user.imgUrl isEqualToString:@""]) {
                        [self.iconImageView setImageWithURL:[NSURL URLWithString:user.imgUrl] placeholderImage:nil];
                    }
                    else{
                        [self.iconImageView setImageWithURL:[NSURL URLWithString:data->info->imgUrl] placeholderImage:nil];
                    }
                     [self getnumber];
                }else{
                    User *user = [User new];
                    user.isLoginSuccess = NO;
                    [[LocalCache sharedCache] storeCacheObject:user forKey:@"user"];
                   
                }
            }];
        }else{
            NSLog(@"userName:%@", user.userName);
            self.qiehuanview.hidden = NO;
            self.qiehuanview2.hidden = YES;
            User *user = [User new];
            user.isLoginSuccess = NO;
            [[LocalCache sharedCache] storeCacheObject:user forKey:@"user"];
        }
    }
}
-(void)loginSuccess{
    //TODO switch status UI
    User *user = [[LocalCache sharedCache] cachedObjectForKey:@"user"];
    
    self.qiehuanview.hidden  = YES;
    self.qiehuanview2.hidden = NO;
    self.userAccount.text    = user.userName;
    NSLog(@"userAccount:%@",self.userAccount.text);
    self.userNickname.text   = user.nickName;
    self.storeCntLabel.text  = user.storeCnt;
    self.commonCntLabel.text = user.commonCnt;
    if (![user.imgUrl isEqualToString:@""]) {
        [self.iconImageView setImageWithURL:[NSURL URLWithString:user.imgUrl] placeholderImage:nil];
    }
}
-(void)quitlogin
{
    self.qiehuanview.hidden  = NO;
    self.qiehuanview2.hidden = YES;
    User *user = [User new];
    user.isLoginSuccess = NO;

    self.commonCntLabel.text = @"0";
    self.storeCntLabel.text =@"0";
    [[LocalCache sharedCache] storeCacheObject:user forKey:@"user"];
  
       }
-(void)getnumber
{
     User *user = [[LocalCache sharedCache] cachedObjectForKey:@"user"];
    NSString *path = [NSString stringWithString:(NSString*)getNumberInfo];
    path = [path stringByAppendingString:
            [NSString stringWithFormat:@"?userId=%@",user.userId]];
    [HTTPAPIConnection postPathToGetJson:path block:^(NSDictionary *json, NSError *error)
     {
                  if(error || ![json objectForKey:@"info"]){
             //TODO 错误处理
             
             return ;
         }else{
             GetNumberInfo *info=[GetNumberInfo new];
             [info updateWithJsonDic:[json objectForKey:@"info"]];
             self.commonCntLabel.text = info->commentCnt;
             NSLog(@"4444444%@",self.commonCntLabel.text);
             self.storeCntLabel.text =  info->storeCnt;
         }
     }];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.contentview.backgroundColor = [UIColor clearColor];
    self.qiehuanview.backgroundColor = [UIColor clearColor];
    self.qiehuanview2.backgroundColor = [UIColor clearColor];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    array = [[NSArray alloc] initWithObjects:@"我的优惠卷", @"我的预订", @"我的抢票", @"我的语音包", @"设置",nil];
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView setSeparatorColor:[UIColor whiteColor]];
    [self.tableView setSeparatorStyle: UITableViewCellSeparatorStyleNone ];
    
    self.pwdTextField.returnKeyType = UIReturnKeyGo;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showTable)
                                                 name:@"showTable" object:nil];
    if (!IS_IPHONE5) {
        self.tableView.height = 276;
    }
}



#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             SimpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier: SimpleTableIdentifier] ;
    }
    NSUInteger row = [indexPath row];
    //    cell.textLabel.textColor = [UIColor whiteColor];
    //    cell.textLabel.text = [array objectAtIndex:row];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;//设置选择cell的颜色
    NSString *imageName = [NSString stringWithFormat:@"icon_my_%d.png",row ];
    UIImage *image1 = [UIImage imageNamed:imageName];
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 278,39)];
    imageView1.image = image1;
    [cell addSubview:imageView1];
    UIImage *image2 = [UIImage imageNamed:@"my_segmentation2.png"];
    UIImageView *imageview2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 55, 300, 1)];
    imageview2.image = image2;
    [cell addSubview:imageview2];
    return cell;
}

-(void)addQiangPiaoView{
    self.tableView.hidden = YES;
    [self.contentview addSubview:self.myqiangpiao];
}
-(void)showTable{
    self.tableView.hidden = NO;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //不知道是不是需要，为了避免子视图点击点到这个table。做一下判断，当table隐藏起来时，不需要做任何事情.
    BOOL hidded = self.tableView.hidden;
    if(hidded == YES){
        return;
    }
    int row = indexPath.row;
    
    self.myqiangpiao = [[[NSBundle mainBundle] loadNibNamed:@"myqiangpiao" owner:nil
                                                    options:nil] objectAtIndex:0];
    self.myqiangpiao.titleLabel.text = [array objectAtIndex:row];
    self.myqiangpiao.backgroundColor = [UIColor clearColor];
    if (indexPath.row == 0) {
        self.myqiangpiao.cellType = ECouponDetailCell;
    }else if(indexPath.row == 1){
        self.myqiangpiao.cellType = EOrderCell;
    }else if(indexPath.row == 2){
        self.myqiangpiao.cellType = ETicketCell;
    }else if(indexPath.row == 3){
        self.myqiangpiao.cellType = EVoiceCell;
    }else if(indexPath.row == 4){
        /*
         //建立一个全新的window 设置为keyWindow,并将视图控制器添加到这个窗口上.
         UIWindow *mainWindow = [UIApplication sharedApplication].delegate.window;
         */
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        self.window.rootViewController = [SetUpViewController new];
        [self.window makeKeyAndVisible];
        
        return;
    }
    [self addQiangPiaoView];
}
- (IBAction)mydiangpingBtnClick:(id)sender {
    //_type = CommentCell;
    NSString *titlestr = @"我的点评";
    self.myqiangpiao = [[[NSBundle mainBundle] loadNibNamed:@"myqiangpiao" owner:nil options:nil] objectAtIndex:0];
    self.myqiangpiao.titleLabel.text = titlestr;
    self.myqiangpiao.cellType = ECommentCell;
    self.myqiangpiao.backgroundColor = [UIColor clearColor];
    [self.contentview addSubview:self.myqiangpiao];
    
}

- (IBAction)loginBtnClick:(id)sender {
    [self.view addSubview:self.lv];
}

- (void)showActionSheetView
{
    [UIView animateWithDuration:0.3 animations:^{
        self.actionSheetView.hidden = NO;
        self.maskView.hidden = NO;
        NSLog(@"frame:%@", NSStringFromCGRect(self.actionSheetView.frame));
        [self.view bringSubviewToFront:self.actionSheetView];
        self.actionSheetView.frame = CGRectMake(self.actionSheetView.frame.origin.x,
                                                self.actionSheetView.frame.origin.y - self.actionSheetView.frame.size.height,
                                                self.actionSheetView.frame.size.width,
                                                self.actionSheetView.frame.size.height);
    }];
}

- (IBAction)phoneImage:(id)sender {
    [self showActionSheetView];
}

- (IBAction)shoucangBtn:(id)sender {
    
    //_type = StoreCell;
    NSString *titlestr=@"我的收藏";
    
    self.myqiangpiao = [[[NSBundle mainBundle] loadNibNamed:@"myqiangpiao" owner:nil options:nil] objectAtIndex:0];
    self.myqiangpiao.titleLabel.text = titlestr;
    self.myqiangpiao.cellType = EStoreCell;
    self.myqiangpiao.backgroundColor = [UIColor clearColor];
    [self.contentview addSubview:self.myqiangpiao];
}


- (void)hiddenActionSheetView
{
    [UIView animateWithDuration:0.3 animations:^{
        self.actionSheetView.hidden = YES;
        self.maskView.hidden = YES;
        self.actionSheetView.frame = CGRectMake(self.actionSheetView.frame.origin.x, self.actionSheetView.frame.origin.y + self.actionSheetView.frame.size.height, self.actionSheetView.frame.size.width, self.actionSheetView.frame.size.height);
        
    }];
}
//修改图像取消按钮单机事件
- (IBAction)cancelBtnClick:(id)sender {
    [self hiddenActionSheetView];
}
- (IBAction)takePictureButtonClicked:(id)sender {
    [self hiddenActionSheetView];
    
    BOOL isCameraSupport = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    if (!isCameraSupport) {
        //        [AlertViewHandle showAlertViewWithMessage:@"你的设备不支持拍照"];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示"
                                                       message:@"你的设备不支持拍照"
                                                      delegate:self
                                             cancelButtonTitle:@"ok"
                                             otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self showImagePickerController];
}
- (IBAction)choosePictureButtonClicked:(id)sender {
    [self hiddenActionSheetView];
    
    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self showImagePickerController];
}


#pragma mark - UIImagePickerControllerDelegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString* type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *orignaImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        //        CGSize orignalSize = orignaImage.size;
        
        CGSize newSize = CGSizeMake(500,500);
        
        
        UIImage *newImage = [orignaImage resize:newSize quality:kCGInterpolationLow];
        self.iconImageView.image = newImage;
        _imageUpdate = YES;
        
        User *user = [[LocalCache sharedCache] cachedObjectForKey:@"user"];
        NSString *userid = user.userId;
        NSString *path = [NSString stringWithString:(NSString*)updateHeadImg];
        path = [path stringByAppendingFormat:@"?userId=%@",
                userid];
        [HTTPAPIConnection personalSettingPicWithUserId:path image:self.iconImageView.image
                                                  block:^(NSDictionary *json, NSError *error)
         {
             // 70代码表示数据库中中没有数据，71表示成功
             if(error || [[json objectForKey:@"code"] isEqualToString:@"70"]){
               

                 [AlertViewHandle showAlertViewWithMessage:@"修改失败"];
                 return;
             }
             UserData *data = [UserData new];
             [data updateWithJsonDic:json];
             if([data->code isEqualToString:@"71"]){
                 
                 [AlertViewHandle showAlertViewWithMessage:@"修改成功！"];
             }
         }];
        
        [self showWindowBack];
    }
}
- (IBAction)personsetingBtnClick:(id)sender {
    self.psv = [[[NSBundle mainBundle] loadNibNamed:@"personalSetingView"
                                              owner:self options:nil] objectAtIndex:0];
    [self.view addSubview:self.psv];
    [self.myqiangpiao removeFromSuperview];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self showWindowBack];
}

-(void)showImagePickerController{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window = [[UIApplication sharedApplication] keyWindow];
    self.window.rootViewController =  self.imagePickerController ;
}
-(void)showWindowBack{
    AppDelegate *appdelegate = (AppDelegate*)([UIApplication sharedApplication].delegate);
    UIWindow *mainWindow = appdelegate.window;
    mainWindow.rootViewController = appdelegate.menuController;
}
@end
