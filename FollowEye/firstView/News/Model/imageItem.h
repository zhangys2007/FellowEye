
#import <Foundation/Foundation.h>

@interface imageItem : NSObject
@property(nonatomic ,retain)NSString *image;
@property(nonatomic ,retain)NSString *title;
@property(nonatomic ,retain)NSString *url;
@property(nonatomic ,retain)NSString *url_3w;
@property(nonatomic ,retain)NSString *diocd;
+(id)imageWithDictionary:(NSDictionary *)dic;

@end
