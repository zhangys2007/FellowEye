

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "jokeItem.h"

@interface ControlHeight : NSObject
@property(nonatomic ,assign)CGFloat contentHeigh;
@property(nonatomic ,assign)CGRect textRect;
@property(nonatomic ,retain)jokeItem *joke;
-(CGFloat)lastHeigh;
+(id)controlWithDictionary:(NSDictionary *)dic;


@end
