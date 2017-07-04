

#import <UIKit/UIKit.h>
#import "ControlPad.h"
#import <MediaPlayer/MediaPlayer.h>
#import "AudioVisualItem.h"



#import "AudioVisualItem.h"//引入model模块
@interface AudioVisualViewCell : UITableViewCell
@property (nonatomic,retain) UIImageView *videoImage;
@property (nonatomic,retain) UILabel *keyWordsLabel;//关键字标签
@property (nonatomic,retain) ControlPad *controlPad;//控制面板
@property(nonatomic ,retain)UIButton *hideButton;//隐藏的大Button;
@property(nonatomic ,retain)MPMoviePlayerController *movePlayer;//在cell上播放的播放器；


-(void)configureCellWithModel:(AudioVisualItem *)model;

@end
