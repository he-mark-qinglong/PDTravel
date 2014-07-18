//
//  EmbedReaderViewController.h
//  EmbedReader
//
//  Created by spadix on 5/2/11.
//

#import <UIKit/UIKit.h>

@interface EmbedReaderViewController
    : UIViewController
    < ZBarReaderViewDelegate >
{
    ZBarReaderView *readerView;
    UITextView *resultText;
    ZBarCameraSimulator *cameraSim;
}

@property (nonatomic, retain) IBOutlet ZBarReaderView *readerView;
@property (nonatomic, retain) IBOutlet UITextView *resultText;
@property (nonatomic, retain) IBOutlet UIButton *downloadButton;

@property (nonatomic, strong) NSString *codeData;

@property (nonatomic, strong) NSString *voiceId;  //从景点进入拿到的id
@end
