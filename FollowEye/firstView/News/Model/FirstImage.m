

#import "FirstImage.h"

@implementation FirstImage
-(void)dealloc
{
    [_content release];
    [_title release];
    [_imgurl release];
    [super dealloc];
}
+(id)firstimageWithDictionary:(NSDictionary *)dic
{
    FirstImage *image = [[[FirstImage alloc]init]autorelease];
    image.imgurl = dic[@"imgurl"];
    image.title = dic[@"imgtitle"];
    image.content = dic[@"note"];
    return image;
}

@end
