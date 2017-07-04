

#import <UIKit/UIKit.h>

@protocol CarView <NSObject>

-(void)getcarSC:(UIScrollView *)sender;

@end

@interface CarView : UIView
@property(nonatomic,retain)UIScrollView *carSC;
@property(nonatomic,retain)UILabel *label;
@property(nonatomic,retain)UIPageControl *pageC;

@property(nonatomic ,assign)id<CarView>delegate;

@end
