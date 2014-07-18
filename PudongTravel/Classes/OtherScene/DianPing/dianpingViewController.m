//
//  dianpingViewController.m
//  pudongapp
//
//  Created by jiangjunli on 14-2-21.
//  Copyright (c) 2014年 jiangjunli. All rights reserved.
//

#import "dianpingViewController.h"
#import "CommonHeader.h"
#import <ShareSDK/ShareSDK.h>
#import "UserData.h"

@interface dianpingViewController ()
<UIImagePickerControllerDelegate, UIPopoverControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *star1;
@property (weak, nonatomic) IBOutlet UIButton *star2;
@property (weak, nonatomic) IBOutlet UIButton *star3;
@property (weak, nonatomic) IBOutlet UIButton *star4;
@property (weak, nonatomic) IBOutlet UIButton *star5;
@property (weak, nonatomic) IBOutlet UILabel *fenshulabel;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UIImageView *image2;
@property (weak, nonatomic) IBOutlet UIImageView *image3;

@property (weak, nonatomic) IBOutlet UILabel *scenicTitle;
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;

@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (retain,nonatomic)UIPopoverController *imagePicker;

@end

@implementation dianpingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    ((UILabel*)self.navigationItem.titleView).text = @"点评";  //设置标题
}
- (void)viewDidLoad{
    [super viewDidLoad];
    [self.contentScrollView FitViewOffsetY];
    
    [self setKeyboardForInputView:self.contentTextView];
    self.scenicTitle.text = self.data->info->title;
    [self cleanUpImgs];
}

-(void)setKeyboardForInputView:(UITextView *)contentView{
    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    [topView setBarStyle:UIBarStyleBlackTranslucent];
    topView.backgroundColor = [UIColor clearColor];
    
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                              target:self action:nil];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(2, 5, 50, 25);
    [btn addTarget:self action:@selector(dismissKeyBoard) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:@"icon_download_activating.png"] forState:UIControlStateNormal];
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace, doneBtn, nil];
    [topView setItems:buttonsArray];
    [contentView setInputAccessoryView:topView];
}
-(void)dismissKeyBoard{
    [self.contentTextView resignFirstResponder];
}

-(void)cleanUpImgs{
    self.image.image = nil;
    self.image2.image = nil;
    self.image3.image = nil;
}

- (IBAction)StarBtnClick:(id)sender {
    UIButton *button = (UIButton *)sender;
    /*下面的switch语句可以用这句段代码代替，但是为了更直观，仍然实用下面的代码。如果超过7个星，建议用下面这段代码
    NSArray *arrayStar = [[NSMutableArray alloc ] initWithObjects:self.star1, self.star2,
                          self.star3, self.star4, self.star5, nil];
    int i = 0;
    for(; i < button.tag; i++){
        UIButton *star = [arrayStar objectAtIndex:i];
        [star setBackgroundImage:[UIImage imageNamed:@"icon_Star_bright.png"] forState:UIControlStateNormal];
    }
    self.fenshulabel.text = [NSString stringWithFormat:@"%0.1d", i];
    for(; i < arrayStar.count; ++i){
        UIButton *star = [arrayStar objectAtIndex:i];
        [star setBackgroundImage:[UIImage imageNamed:@"icon_Star.png"] forState:UIControlStateNormal];
    }
    */
    switch (button.tag) {
        case 1:
            [self.star1 setBackgroundImage:[UIImage imageNamed:@"icon_Star_bright.png"] forState:UIControlStateNormal];
            [self.star2 setBackgroundImage:[UIImage imageNamed:@"icon_Star.png"] forState:UIControlStateNormal];
            [self.star3 setBackgroundImage:[UIImage imageNamed:@"icon_Star.png"] forState:UIControlStateNormal];
            [self.star4 setBackgroundImage:[UIImage imageNamed:@"icon_Star.png"] forState:UIControlStateNormal];
            [self.star5 setBackgroundImage:[UIImage imageNamed:@"icon_Star.png"] forState:UIControlStateNormal];
            self.fenshulabel.text = @"1.0";
            break;
        case 2:
            [self.star1 setBackgroundImage:[UIImage imageNamed:@"icon_Star_bright.png"] forState:UIControlStateNormal];
            [self.star2 setBackgroundImage:[UIImage imageNamed:@"icon_Star_bright.png"] forState:UIControlStateNormal];
            [self.star3 setBackgroundImage:[UIImage imageNamed:@"icon_Star.png"] forState:UIControlStateNormal];
            [self.star4 setBackgroundImage:[UIImage imageNamed:@"icon_Star.png"] forState:UIControlStateNormal];
            [self.star5 setBackgroundImage:[UIImage imageNamed:@"icon_Star.png"] forState:UIControlStateNormal];
            self.fenshulabel.text = @"2.0";
            break;
        case 3:
            [self.star1 setBackgroundImage:[UIImage imageNamed:@"icon_Star_bright.png"] forState:UIControlStateNormal];
            [self.star2 setBackgroundImage:[UIImage imageNamed:@"icon_Star_bright.png"] forState:UIControlStateNormal];
            [self.star3 setBackgroundImage:[UIImage imageNamed:@"icon_Star_bright.png"] forState:UIControlStateNormal];
            [self.star4 setBackgroundImage:[UIImage imageNamed:@"icon_Star.png"] forState:UIControlStateNormal];
            [self.star5 setBackgroundImage:[UIImage imageNamed:@"icon_Star.png"] forState:UIControlStateNormal];
            self.fenshulabel.text = @"3.0";
            break;
        case 4:
            [self.star1 setBackgroundImage:[UIImage imageNamed:@"icon_Star_bright.png"] forState:UIControlStateNormal];
            [self.star2 setBackgroundImage:[UIImage imageNamed:@"icon_Star_bright.png"] forState:UIControlStateNormal];
            [self.star3 setBackgroundImage:[UIImage imageNamed:@"icon_Star_bright.png"] forState:UIControlStateNormal];
            [self.star4 setBackgroundImage:[UIImage imageNamed:@"icon_Star_bright.png"] forState:UIControlStateNormal];
            [self.star5 setBackgroundImage:[UIImage imageNamed:@"icon_Star.png"] forState:UIControlStateNormal];
            self.fenshulabel.text = @"4.0";
            break;
        default:
            [self.star1 setBackgroundImage:[UIImage imageNamed:@"icon_Star_bright.png"] forState:UIControlStateNormal];
            [self.star2 setBackgroundImage:[UIImage imageNamed:@"icon_Star_bright.png"] forState:UIControlStateNormal];
            [self.star3 setBackgroundImage:[UIImage imageNamed:@"icon_Star_bright.png"] forState:UIControlStateNormal];
            [self.star4 setBackgroundImage:[UIImage imageNamed:@"icon_Star_bright.png"] forState:UIControlStateNormal];
            [self.star5 setBackgroundImage:[UIImage imageNamed:@"icon_Star_bright.png"] forState:UIControlStateNormal];
            self.fenshulabel.text = @"5.0";
            break;
    }
}

//压缩图片
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}
- (void)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName{
    NSData* imageData = UIImagePNGRepresentation(tempImage);
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    // Now we get the full path to the file
    NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:imageName];
    [imageData writeToFile:fullPathToFile atomically:NO];
}

//从文档目录下获取Documents路径
- (NSString *)documentFolderPath{
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
}

- (IBAction)sendBtnClick:(id)sender {
    NSString *path = [NSString stringWithString:(NSString*)saveUserComment];
    User *user = [[LocalCache sharedCache] cachedObjectForKey:@"user"];
    if(user == nil || user.isLoginSuccess == NO){
        [AppDelegate showLogin];
        return;
    }
    
    NSString *userid = user.userId;
    path = [path stringByAppendingFormat:@"?userId=%@&viewId=%@&score=%@&contents=%@",
            userid, self.idStr, self.fenshulabel.text, self.contentTextView.text];
    NSLog(@"idStr = %@,fenshulabel = %@,contentTextView = %@",_idStr,_fenshulabel.text,self.contentTextView.text);
    NSMutableArray *arrayImage = [[NSMutableArray alloc] initWithCapacity:3];
    
    if (self.image.image)
        [arrayImage addObject:self.image.image];
    if (self.image2.image)
        [arrayImage addObject:self.image2.image];
    if (self.image3.image)
        [arrayImage addObject:self.image3.image];
    
    [HTTPAPIConnection postPicWithPath:path  arrayImage:arrayImage
                                 block:^(NSDictionary *json, NSError *error)
     {
         // 70代码表示数据库中中没有数据，71表示成功
         if(error || [[json objectForKey:@"code"] isEqualToString:@"70"]){
             [AlertViewHandle showAlertViewWithMessage:@"提交失败"];
             return;
         }
         
         NSLog(@"json is %@",json);
         UserData *data = [UserData new];
         [data updateWithJsonDic:json];
         if([data->code isEqualToString:@"71"]){
             [AlertViewHandle showAlertViewWithMessage:@"点评成功"];
         }
         if([data->code isEqualToString:@"87"]){
             [AlertViewHandle showAlertViewWithMessage:@"点评太频繁"];
         }
     }];
}

- (IBAction)CameraBtnClick:(id)sender {
    BOOL isCameraSupport = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    if (!isCameraSupport) {
        //        [AlertViewHandle showAlertViewWithMessage:@"你的设备不支持拍照"];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"你的设备不支持拍照" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    //    if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
    //        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //    }
    //sourceType = UIImagePickerControllerSourceTypeCamera; //照相机
    //sourceType = UIImagePickerControllerSourceTypePhotoLibrary; //图片库
    //sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum; //保存的相片
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
    // picker.delegate = self;
    picker.delegate = self;
    picker.allowsEditing = YES;//设置可编辑
    picker.sourceType = sourceType;
    // [self presentModalViewController:picker animated:YES];//进入照相界面
    [self.navigationController presentViewController:picker animated:YES completion:nil];
}
- (void)saveImage:(UIImage *)image {
    //保存
    if (self.image.image == nil) {
        self.image.image = image;
    }else if (self.image2.image == nil){
        self.image2.image = image;
    }else if(self.image3.image == nil){
        self.image3.image = image;
    }else{
        [AlertViewHandle showAlertViewWithMessage:@"只能上传三张"];
    }
}

#pragma mark Camera View Delegate Methods
//点击相册中的图片或者照相机照完后点击use 后触发的方法
- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image;
    if (picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary){//如果打开相册
        [self.imagePicker dismissPopoverAnimated:YES];//关掉相册
        image = [info objectForKey:UIImagePickerControllerOriginalImage] ;
    }
    else{//照相机
        
        [picker dismissViewControllerAnimated:YES completion:nil];//关掉照相机
        image = [info objectForKey:UIImagePickerControllerEditedImage] ;
    }
    //把选中的图片添加到界面中
    [self performSelector:@selector(saveImage:)
               withObject:image
               afterDelay:0.5];
}
//点击cancel调用的方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)as:(UITapGestureRecognizer *)sender {
    [self.contentTextView resignFirstResponder];
}

- (void)shareContentWithType:(ShareType)type{
    ViewDetailData *data = self.data;
    
    id<ISSContent> publishContent
    = [ShareSDK content:[ NSString stringWithFormat:@"%@ %@",
                         data->info->title, @"http://www.sun3d.com"]
         defaultContent:@"浦东旅游app"
                  image:[ShareSDK imageWithUrl: data->info->imgUrl]
                  title:data->info->title
                    url:nil
            description:@"浦东旅游，大家一起来看看"
              mediaType:SSPublishContentMediaTypeImage];
    
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                         allowCallback:YES
                                                         authViewStyle:SSAuthViewStyleFullScreenPopup
                                                          viewDelegate:nil
                                               authManagerViewDelegate:nil];
    
    //在授权页面中添加关注 官方微博
    [authOptions setFollowAccounts:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"], SHARE_TYPE_NUMBER(ShareTypeSinaWeibo),
      [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"], SHARE_TYPE_NUMBER(ShareTypeTencentWeibo),
      nil]];
    
    [ShareSDK shareContent:publishContent
                      type:type
               authOptions:authOptions
              shareOptions:nil
             statusBarTips:YES
                    result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end)
     {
         if (state == SSPublishContentStateSuccess){
             [AlertViewHandle showAlertViewWithMessage:@"恭喜你分享成功，朋友们都知道你在上海玩啦，快去叫他们来看看吧"];
         } else if (state == SSPublishContentStateFail){
             UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                message:[NSString stringWithFormat:@"错误码:%@", [error errorDescription]]
                                                               delegate:nil cancelButtonTitle:NSLocalizedString(@"确定",nil) otherButtonTitles:nil];
             [alerView show];
             NSLog(NSLocalizedString(@"TEXT_SHARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
             [AlertViewHandle showAlertViewWithMessage:@"分享失败"];
         }
     }];
}

- (IBAction)sinaButtonClicked:(id)sender {
    [self shareContentWithType:ShareTypeSinaWeibo];
}
- (IBAction)qqButtonClicked:(id)sender {
    [self shareContentWithType:ShareTypeTencentWeibo];
}
- (IBAction)renrenButtonClicked:(id)sender {
    [self shareContentWithType:ShareTypeRenren];
}
- (IBAction)kaixinButtonClicked:(id)sender {
    [self shareContentWithType:ShareTypeKaixin];
}

@end
