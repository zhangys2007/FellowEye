
#import <UIKit/UIKit.h>
#import "BaseScroller.h"
#import "TechnologyControllerTableViewController.h"
#import "SocietyController.h"
#import "OriginalController.h"
#import "TeachController.h"
#import "FashionController.h"

@interface BaseScroller : UIScrollView
@property(nonatomic ,retain)TechnologyControllerTableViewController *technology;//科技
@property(nonatomic ,retain)SocietyController *socity;//社会
@property(nonatomic ,retain)OriginalController *original;//原创
@property(nonatomic ,retain)TeachController *tech;//教育
@property(nonatomic ,retain)FashionController *fashion;//时尚

@end
