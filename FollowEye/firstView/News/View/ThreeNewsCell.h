

#import <UIKit/UIKit.h>
#import "NewsModel.h"

@interface ThreeNewsCell : UITableViewCell
@property(nonatomic,retain)UIImageView *oneView;
@property(nonatomic,retain)UIImageView *twoView;
@property(nonatomic,retain)UIImageView *threeView;
@property(nonatomic,retain)UILabel *titleLabel;

- (void)loadingThreeNewsDataWithModel:(NewsModel *)model;
@end
