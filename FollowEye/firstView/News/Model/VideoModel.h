

#import <Foundation/Foundation.h>

@interface VideoModel : NSObject
@property(nonatomic ,retain)NSString *mp4_url;
+(id)videoWithDictionary:(NSDictionary *)dic;

@end
