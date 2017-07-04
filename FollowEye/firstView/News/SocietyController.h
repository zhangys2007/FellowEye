

#import <UIKit/UIKit.h>
#import "NewsModel.h"
#import "SocietyController.h"
#import "CarouselModel.h"

@protocol SocietyControllerDelegate <NSObject>


-(void)getTapCell:(NewsModel *)model
         withMark:(int)mark;

-(void)PassValue:(UITapGestureRecognizer *)model
        withInfo:(CarouselModel *)info
        withMark:(int)mark;



@end

@interface SocietyController : UITableViewController
@property(nonatomic ,assign)id<SocietyControllerDelegate> delegate;

@end
