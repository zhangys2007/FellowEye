

#import <Foundation/Foundation.h>

@interface AudioVisualItem : NSObject
@property (nonatomic,retain) NSString *cover;//图片地址
@property (nonatomic,retain) NSString *mp4_url;//视频地址
@property (nonatomic,retain) NSString *title;//内容标题
@property (nonatomic,retain) NSString *length;//播放时长
@property (nonatomic,retain) NSNumber *playCount;//播放次数
@property (nonatomic,retain) NSNumber *replyCount;//跟帖数
@property (nonatomic ,retain)NSString *vid;//下一个播放界面需要的参数
+ (id)itemWithDictionary:(NSDictionary *)dict;

@end
