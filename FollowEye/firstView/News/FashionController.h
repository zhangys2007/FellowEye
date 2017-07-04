

#import <UIKit/UIKit.h>
#import "NewsModel.h"
#import "CarouselModel.h"



@protocol fashionDelegate <NSObject>

-(void)getTapCell:(NewsModel *)model
         withMark:(int)mark;


-(void)PassValue:(UITapGestureRecognizer *)model
        withInfo:(CarouselModel *)info
        withMark:(int)mark;


@end
@interface FashionController : UITableViewController
@property(nonatomic ,assign)id<fashionDelegate>delegate;



@end
