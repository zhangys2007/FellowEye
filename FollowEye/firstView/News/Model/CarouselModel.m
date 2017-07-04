

#import "CarouselModel.h"

@implementation CarouselModel
- (void)dealloc
{
    [_imageName release];
    [_titleName release];
    [super dealloc];
}
+(id)carouseWithDictionary:(NSDictionary *)dict
{
    CarouselModel *carousItem = [[CarouselModel alloc]init];
    carousItem.imageName = dict[@"imgsrc"];
    carousItem.titleName = dict[@"title"];
    NSString *str =  dict[@"skipID"];
   carousItem.url = [[str componentsSeparatedByString:@"|"]lastObject];
    carousItem.url_3w = dict[@"url_3w"];
    carousItem.docid = dict[@"docid"];
    return carousItem;
}

@end
