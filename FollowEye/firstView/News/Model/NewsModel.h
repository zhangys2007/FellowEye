
#import <Foundation/Foundation.h>

@interface NewsModel : NSObject
@property(nonatomic,retain)NSString *titleName;
@property(nonatomic,retain)NSString *digestName;
@property(nonatomic,retain)NSString *imageName;
@property(nonatomic,retain)NSArray *imagextraName;
@property(nonatomic ,retain)NSString *docid;
@property(nonatomic ,retain)NSString *url_3w;
@property(nonatomic ,retain)NSString *url;
@property(nonatomic ,retain)NSString *urls;
@property(nonatomic ,retain)NSArray *array;
@property(nonatomic ,retain)NSString *skipType;
@property(nonatomic ,retain)NSString *videoID;


+(id)newsWithDictionary:(NSDictionary *)dict;
@end

