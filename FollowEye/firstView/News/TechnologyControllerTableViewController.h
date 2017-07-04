

#import <UIKit/UIKit.h>
#import "NewsModel.h"
#import "CarouselModel.h"

@protocol technologDelegate <NSObject>

-(void)getTapCell:(NewsModel *)model
         withMark:(int)mark;
-(void)PassValue:(UITapGestureRecognizer *)model
        withInfo:(CarouselModel *)info
        withMark:(int)mark;


@end

@interface TechnologyControllerTableViewController : UITableViewController
@property(nonatomic ,retain)id<technologDelegate>delegate;

@end
