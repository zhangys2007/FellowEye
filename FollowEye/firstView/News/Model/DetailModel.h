

#import <Foundation/Foundation.h>

@interface DetailModel : NSObject
@property(nonatomic ,retain)NSString *body;//网页内容
@property(nonatomic ,retain)NSString *title;//网页标题
+(id)detailWithDictionary:(NSDictionary *)dic;


@end
