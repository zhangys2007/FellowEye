

#import <Foundation/Foundation.h>

@interface FirstImage : NSObject

@property(nonatomic ,retain)NSString *imgurl;
@property(nonatomic ,retain)NSString *title;
@property(nonatomic ,retain)NSString *content;
+(id)firstimageWithDictionary:(NSDictionary *)dic;


@end
