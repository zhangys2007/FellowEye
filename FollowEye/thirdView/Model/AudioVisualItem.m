

#import "AudioVisualItem.h"


@interface AudioVisualItem ()
-(NSString *)_getTime:(NSNumber *)timer;

@end


@implementation AudioVisualItem
-(void)dealloc {
    [_cover release];
    [_mp4_url release];
    [_title release];
    [_length release];
    [_playCount release];
    [_replyCount release];
    [_vid release];
    [super dealloc];
}

+(id)itemWithDictionary:(NSDictionary *)dict {
    AudioVisualItem *anItem = [[AudioVisualItem alloc] init];
    anItem.cover = dict[@"cover"];
    anItem.mp4_url = dict[@"mp4_url"];
    anItem.title = dict[@"title"];
    anItem.length = [anItem _getTime:dict[@"length"]];//时长
    anItem.playCount = dict[@"playCount"];//播放次数
    anItem.replyCount = dict[@"replyCount"];//评论次数
    anItem.vid = dict[@"vid"];
//    NSLog(@".............%@",anItem.mp4_url);
    return [anItem autorelease];
}
-(NSString *)_getTime:(NSNumber *)timer
{
    int time = [timer intValue];
    if (time < 60)
    {
        if (time / 10 == 0)
        {
            return [NSString stringWithFormat:@"0%ds",time];

        }else if (time / 10 > 0)
        {
            return [NSString stringWithFormat:@"%ds",time];
        }
    }else if(time < 3600)
    {
        int minute = time / 60;
        int second = time % 60;
        return [NSString stringWithFormat:@"%d:%d",minute,second];
    }
    return nil;
}











- (NSString *)description
{
    return [NSString stringWithFormat:@"cover=%@ , url=%@ , title=%@ , legth = %@ , count = %@ , repCount = %@" , _cover , _mp4_url , _title , _length , _playCount , _replyCount];
}

@end
