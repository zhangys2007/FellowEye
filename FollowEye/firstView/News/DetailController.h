

#import <UIKit/UIKit.h>
#import "NewsModel.h"
#import "CarouselModel.h"

@interface DetailController : UIViewController
@property(nonatomic ,retain)NewsModel *model;
@property(nonatomic ,retain)CarouselModel *onlyModel;
@property(nonatomic ,retain)NSString *url;
@property(nonatomic ,assign)int count;
@end
