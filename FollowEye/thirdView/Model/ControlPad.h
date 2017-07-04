

#import <UIKit/UIKit.h>

@interface ControlPad : UIView

@property (nonatomic,retain) UILabel *durationLabel;//时长
@property (nonatomic,retain) UILabel *countLabel;//播放次数
@property (nonatomic,retain) UILabel *commentLable;//评论次数
//@property (nonatomic,retain) UIButton *commentButton;


@property (nonatomic,retain) UIImageView *durationImage;//时长图片
@property (nonatomic,retain) UIImageView *countImage;//播放次数的图片
@end
