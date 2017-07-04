
#import <UIKit/UIKit.h>
#import "ControlHeight.h"

@interface jokeImageCell : UITableViewCell
@property(nonatomic ,retain)UIImageView *image;
@property(nonatomic ,retain)UILabel *contentLabel;
-(void)configureCellWithModel:(ControlHeight *)model;

@end
