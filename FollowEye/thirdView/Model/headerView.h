

#import <UIKit/UIKit.h>

@protocol HeaderViewDelagate <NSObject>

- (void)getClickAction;

@end

@interface headerView : UIView
@property (nonatomic,retain) UIButton *recommendButton;
@property (nonatomic,retain) UIButton *commentButton;
@property (nonatomic, retain) id<HeaderViewDelagate>delagate;
@end
