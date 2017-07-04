

#import <UIKit/UIKit.h>
#import "NewsModel.h"
#import "CarouselModel.h"


@protocol techdelegate <NSObject>

-(void)getTapCell:(NewsModel *)model
         withMark:(int)mark;
-(void)PassValue:(UITapGestureRecognizer *)model
        withInfo:(CarouselModel *)info
        withMark:(int)mark;

@end

@interface TeachController : UITableViewController
@property(nonatomic ,assign)id<techdelegate>delegate;

@end
