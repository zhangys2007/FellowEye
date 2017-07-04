

#import <Foundation/Foundation.h>

@interface jokeItem : NSObject
@property(nonatomic ,retain)NSString *content;
@property(nonatomic ,retain)NSString *image;
+(id)itemWithDictionary:(NSDictionary *)dic;

@end
