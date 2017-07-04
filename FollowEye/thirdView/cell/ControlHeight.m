
#import "ControlHeight.h"
#define kSCREEN [UIScreen mainScreen].bounds.size.width

@implementation ControlHeight
+(id)controlWithDictionary:(NSDictionary *)dic
{
    ControlHeight *control = [[[ControlHeight alloc]init]autorelease];
    control.joke = [jokeItem itemWithDictionary:dic];
    return control;
}
- (CGRect )textRect
{
    CGRect rect = [self.joke.content boundingRectWithSize:CGSizeMake(kSCREEN - 10, 20000) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil];
    return rect;
}
-(CGFloat)lastHeigh
{
    return self.textRect.size.height;
}


@end
