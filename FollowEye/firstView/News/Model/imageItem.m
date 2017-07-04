

#import "imageItem.h"

@implementation imageItem
-(void)dealloc
{
    [_image release];
    [_title release];
    
    [super dealloc];
}
+(id)imageWithDictionary:(NSDictionary *)dic
{
    imageItem *image = [[[imageItem alloc]init]autorelease];
    image.image = dic[@"imgsrc"];
    image.title = dic[@"title"];
    image.url_3w = dic[@"url_3w"];
    image.url = dic[@"url"];
    
    
    
    
    return image;
}


@end
