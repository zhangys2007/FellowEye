

#import "VideoModel.h"

@implementation VideoModel
-(void)dealloc
{
    [_mp4_url release];
    [super dealloc];
}
+(id)videoWithDictionary:(NSDictionary *)dic
{
    VideoModel *model = [[[VideoModel alloc]init]autorelease];
    model.mp4_url = dic[@"mp4_url"];
    return model;
}

@end
