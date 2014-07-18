//
//  dianpingViewController.m
//  pudongapp
//
//  Created by jiangjunli on 14-2-21.
//  Copyright (c) 2014年 jiangjunli. All rights reserved.
//

#import "dianpingViewController.h"
#import "CommonHeader.h"

#import "UserData.h"
@interface dianpingViewController ()<UIImagePickerControllerDelegate,UIPopoverControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *star1;
@property (weak, nonatomic) IBOutlet UIButton *star2;
@property (weak, nonatomic) IBOutlet UIButton *star3;
@property (weak, nonatomic) IBOutlet UIButton *star4;
@property (weak, nonatomic) IBOutlet UIButton *star5;
@property (weak, nonatomic) IBOutlet UILabel *fenshulabel;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UIImageView *image2;
@property (weak, nonatomic) IBOutlet UIImageView *image3;

@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (retain,nonatomic)UIPopoverController *imagePicker;

@end

@implementation dianpingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.image = nil;
    self.image2 = nil;
    self.image3 = nil;
}
- (IBAction)backbtnclisk:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}
- (IBAction)StarBtnClick:(id)sender {
    
    UIButton *button = (UIButton *)sender;
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
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}
- (void)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName
{
    NSData* imageData = UIImagePNGRepresentation(tempImage);
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    // Now we get the full path to the file
    NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:imageName];
    // and then we write it out
    [imageData writeToFile:fullPathToFile atomically:NO];
}
#pragma mark 从文档目录下获取Documents路径
- (NSString *)documentFolderPath
{
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
    path = [path stringByAppendingString:
            [NSString stringWithFormat:@"?userId=%@&viewId=%@score=%@&contents=%@", userid, self.idStr,
             self.fenshulabel.text, self.contentTextView.text]];
    
    NSMutableArray *arrayImage = [[NSMutableArray alloc] initWithObjects:self.image, self.image2, self.image3, nil];
    
    [HTTPAPIConnection postPicWithPath:path
                            arrayImage:arrayImage
                                 block:^(NSDictionary *json, NSError *error)
     {
         if(error || ![[json objectForKey:@"code"] isEqualToString:@"70"]){
             [AlertViewHandle showAlertViewWithMessage:@"提交失败"];
             return;
         }
         NSLog(@"json is %@",json);
         UserData *data = [UserData new];
         [data updateWithJsonDic:json];
         if([data->code isEqualToString:@"71"])
         {
             [AlertViewHandle showAlertViewWithMessage:@"点评成功！"];
         }
         
     }];
}

//    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"点评成功" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
//    [alert show];
//
//}


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
    [self presentViewController:picker animated:YES completion:nil];
    
}
- (void)saveImage:(UIImage *)image {
    //保存
    if (self.image.image == nil) {
        self.image.image = image;
    }
    else if (self.image2.image == nil)
    {
        self.image2.image = image;
    }
    else if(self.image3.image == nil)
    {
        self.image3.image = image;
    }
    else
    {
        [AlertViewHandle showAlertViewWithMessage:@"只能上传三张"];
    }
}
#pragma mark –
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)as:(UITapGestureRecognizer *)sender {
    [self.contentTextView resignFirstResponder];
}


@end
