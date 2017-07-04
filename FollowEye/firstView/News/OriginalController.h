

#import <UIKit/UIKit.h>
#import "NewsModel.h"
#import "CarouselModel.h"

@protocol originaldelegate <NSObject>

-(void)getTapCell:(NewsModel *)model
         withMark:(int)mark;
-(void)PassValue:(UITapGestureRecognizer *)model
        withInfo:(CarouselModel *)info
        withMark:(int)mark;

@end

@interface OriginalController : UITableViewController
@property(nonatomic ,assign)id<originaldelegate>delegate;


@end
