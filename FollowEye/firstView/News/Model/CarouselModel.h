

#import <Foundation/Foundation.h>

@interface CarouselModel : NSObject
@property(nonatomic,retain)NSString *titleName;
@property(nonatomic,retain)NSString *imageName;
@property(nonatomic ,retain)NSString *url;
@property(nonatomic ,retain)NSString *url_3w;
@property(nonatomic ,retain)NSString *docid;
+(id)carouseWithDictionary:(NSDictionary *)dict;

@end
