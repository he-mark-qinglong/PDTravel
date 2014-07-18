//
//  myyuyinbaoCell.m
//  pudongapp
//
//  Created by jiangjunli on 14-3-3.
//  Copyright (c) 2014年 jiangjunli. All rights reserved.
//

#import "myyuyinbaoCell.h"

static NSString * deleteStoreNotification  =  @"deleteCellnotifaction";

static AVAudioPlayer *player;

@interface myyuyinbaoCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *viewNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *viewAreaLabel;
@property NSString *fullFilePath;
@property BOOL thisIsPlaying;
@end
@implementation myyuyinbaoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (id)cell:(VoiceInfo *)info
{
    myyuyinbaoCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"myyuyinbaoCell" owner:nil options:nil] objectAtIndex:0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.titleLabel.text = info->title;
    cell.viewNameLabel.text = info->fileName;
    cell.viewAreaLabel.text = info->area;
    
    NSArray *downloadDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    cell.fullFilePath = [downloadDir[0] stringByAppendingPathComponent:info->fileName];
    return cell;
}
- (IBAction)onDeleteBtnClicked:(id)sender {
    if(self.thisIsPlaying){
        [player stop];
        self.thisIsPlaying = NO;
    }
    [[NSNotificationCenter defaultCenter]   postNotificationName:deleteStoreNotification object:self];
}

+(void)clearPlayer{
    player = nil;
}
- (IBAction)onPlayBtnClicked:(id)sender {
    
    NSURL  *url = [NSURL fileURLWithPath:self.fullFilePath];
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

@end
