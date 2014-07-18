//
//  EmbedReaderViewController.m
//  EmbedReader
//
//  Created by spadix on 5/2/11.
//

#import "EmbedReaderViewController.h"
#import "SoundDownloadViewController.h"
#import "CommonHeader.h"

@implementation EmbedReaderViewController

@synthesize readerView, resultText, downloadButton;

- (void) cleanup{
    [cameraSim release];
    cameraSim = nil;
    readerView.readerDelegate = nil;
    [readerView release];
    readerView = nil;
    [resultText release];
    resultText = nil;
}

- (void) dealloc{
    [self cleanup];
    [super dealloc];
}

- (void) viewDidLoad{
    [super viewDidLoad];
    
    // the delegate receives decode results
    readerView.readerDelegate = self;
    //CGRect scanMaskRect = CGRectMake(146, 152, 300, 237);
    //扫描区域
    CGRect scanMaskRect = CGRectMake(60, CGRectGetMidY(readerView.frame) - 126, 100, 250);

    readerView.scanCrop = [self getScanCrop:scanMaskRect readerViewBounds:self.readerView.bounds];

    // you can use this to support the simulator
    if(TARGET_IPHONE_SIMULATOR) {
        cameraSim = [[ZBarCameraSimulator alloc]
                        initWithViewController: self];
        cameraSim.readerView = readerView;
    }
}
-(CGRect)getScanCrop:(CGRect)rect readerViewBounds:(CGRect)readerViewBounds
{
    CGFloat x,y,width,height;
    
    x = rect.origin.x / readerViewBounds.size.width;
    y = rect.origin.y / readerViewBounds.size.height;
    width = rect.size.width / readerViewBounds.size.width;
    height = rect.size.height / readerViewBounds.size.height;
    
    return CGRectMake(x, y, width, height);
}
- (void) viewDidUnload{
    [self cleanup];
    [super viewDidUnload];
}

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) orient{
    // auto-rotation is supported
    return(YES);
}

- (void) willRotateToInterfaceOrientation: (UIInterfaceOrientation) orient
                                 duration: (NSTimeInterval) duration{
    // compensate for view rotation so camera preview is not rotated
    [readerView willRotateToInterfaceOrientation: orient
                                        duration: duration];
}

- (void) viewDidAppear: (BOOL) animated{
    // run the reader when the view is visible
    [readerView start];
}

- (void) viewWillDisappear: (BOOL) animated{
    [readerView stop];
}

- (void) readerView: (ZBarReaderView*) view
     didReadSymbols: (ZBarSymbolSet*) syms
          fromImage: (UIImage*) img{
    // do something useful with results
    for(ZBarSymbol *sym in syms) {
        resultText.text = [NSString stringWithFormat:@"语音包二维码:%@", sym.data];
        self.codeData = sym.data;
        
        NSString *path = [getVoiceList copy];
        path = [path stringByAppendingString: [NSString stringWithFormat:@"?pageNum=1&viewId=%@", self.codeData]];
        [HTTPAPIConnection postPathToGetJson:(NSString*)path block:^(NSDictionary *json, NSError *error){
            if (error || [json objectForKey:@"info"] == nil) {
                [AlertViewHandle showAlertViewWithMessage:@"无效的二维码"];
                return;
            }
            SoundDownLoadViewController *sdvc = [SoundDownLoadViewController new];
            sdvc.viewId = self.codeData;
            
            DDMenuController *ddMenuController = [(AppDelegate *)[UIApplication sharedApplication].delegate menuController];
            UINavigationController *navigationController = (UINavigationController*)ddMenuController.rootViewController;
            [navigationController pushViewController:sdvc animated:NO];
            [AppDelegate showMiddle];
        }];
        
        break;
    }
}
- (IBAction)downBtnClicked:(id)sender {
    NSString *path = [getVoiceList copy];
    if(self.voiceId){
        path = [path stringByAppendingString: [NSString stringWithFormat:@"?pageNum=1&viewId=%@", self.voiceId]];
        [HTTPAPIConnection postPathToGetJson:(NSString*)path block:^(NSDictionary *json, NSError *error){
            if (error || [json objectForKey:@"info"] == nil) {
                //[AlertViewHandle showAlertViewWithMessage:@"无效的二维码"];
                //return;
            }
            SoundDownLoadViewController *sdvc = [SoundDownLoadViewController new];
            sdvc.viewId = self.voiceId;
            
            DDMenuController *ddMenuController = [(AppDelegate *)[UIApplication sharedApplication].delegate menuController];
            UINavigationController *navigationController = (UINavigationController*)ddMenuController.rootViewController;
            [navigationController pushViewController:sdvc animated:NO];
            [AppDelegate showMiddle];
        }];
    }else{
        path = [path stringByAppendingString: [NSString stringWithFormat:@"?pageNum=1"]];
        [HTTPAPIConnection postPathToGetJson:(NSString*)path block:^(NSDictionary *json, NSError *error){
            SoundDownLoadViewController *sdvc = [SoundDownLoadViewController new];
            sdvc.viewId = nil;
            DDMenuController *ddMenuController = [(AppDelegate *)[UIApplication sharedApplication].delegate menuController];
            UINavigationController *navigationController = (UINavigationController*)ddMenuController.rootViewController;
            [navigationController pushViewController:sdvc animated:NO];
            [AppDelegate showMiddle];
        }];
    }
}

@end
