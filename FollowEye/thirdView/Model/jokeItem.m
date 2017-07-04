
#import "jokeItem.h"

@implementation jokeItem
+(id)itemWithDictionary:(NSDictionary *)dic
{
    jokeItem *joke = [[[jokeItem alloc]init]autorelease];
    joke.content = dic[@"digest"];
    joke.image = dic[@"img"];
    return joke;
}

@end
