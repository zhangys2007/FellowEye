

#import "NewsModel.h"

@implementation NewsModel
- (void)dealloc
{
    [_titleName release];
    [_digestName release];
    [_imageName release];
    [_imagextraName release];
    [super dealloc];
}
-(NSArray *)array
{
    if (!_array)
    {
        self.array = [NSArray array];
    }
    return _array;
}
+ (id)newsWithDictionary:(NSDictionary *)dict
{
    NewsModel *newsModel = [[[NewsModel alloc]init]autorelease];
    newsModel.titleName = dict[@"title"];
    newsModel.digestName = dict[@"digest"];
    newsModel.imageName = dict[@"imgsrc"];
    newsModel.imagextraName = dict[@"imgextra"];
    newsModel.docid = dict[@"docid"];
    newsModel.url_3w = dict[@"url_3w"];
    NSString *str =  dict[@"skipID"];
    newsModel.url = [[str componentsSeparatedByString:@"|"]lastObject];
    newsModel.urls = dict[@"url"];
    newsModel.array = dict[@"editor"];
    newsModel.skipType = dict[@"skipType"];
    newsModel.videoID = dict[@"videoID"];
   
    return newsModel;
}

@end
