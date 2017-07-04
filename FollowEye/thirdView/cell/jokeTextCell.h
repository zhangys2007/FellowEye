

#import <UIKit/UIKit.h>
#import "ControlHeight.h"

@interface jokeTextCell : UITableViewCell
@property(nonatomic ,retain)UILabel *contentLabel;
@property(nonatomic ,retain)UILabel *buttonLabel;
-(void)configureCellWithModel:(ControlHeight *)joke;

@end
