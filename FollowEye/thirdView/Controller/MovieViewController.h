
#import <UIKit/UIKit.h>

#import "AudioVisualItem.h"

@interface MovieViewController : UIViewController
//通过属性传值
@property (nonatomic ,retain) AudioVisualItem *item;
@property (nonatomic ,retain) NSString *appendingStr;


@property (nonatomic,retain) UITableView *movieTableView;
@property (nonatomic,retain) NSString *titles;

@end
