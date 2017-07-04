

#import "DetailModel.h"

@implementation DetailModel
-(void)dealloc
{
    [_body release];
    [_title release];
    [super dealloc];
}
+(id)detailWithDictionary:(NSDictionary *)dic
{
    DetailModel *detail = [[[DetailModel alloc]init]autorelease];
    detail.body = dic[@"body"];
    detail.title = dic[@"title"];
    return detail;
}


@end
