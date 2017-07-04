

#import <UIKit/UIKit.h>
#import "NewsModel.h"

@interface NewsCell : UITableViewCell
@property(nonatomic,retain)UIImageView *NewsImage;
@property(nonatomic,retain)UILabel *NewsLabel;
@property(nonatomic,retain)UILabel *NewsTitleLabel;

-(void)loadingDataWithModel:(NewsModel *)medel;
@end
