
#import "NetworkEngine.h"

@interface NetworkEngine()
@property(nonatomic ,assign)id<NetworkEngineDelegate>delegate;//代理对象
@property(nonatomic ,retain)NSURL *url;//请求的网址
@property (nonatomic ,retain)NSDictionary *params;//请求的参数字典
@property(nonatomic ,copy)NSString *HTTPMethod;//请求方式
@property(nonatomic ,copy)NSString *packagedParams;//参数列表字符串
- (NSString *)_packageParams:(NSDictionary *)params;//将参数列表字典转化成指定格式的字符串：p1 = v1&p2 = v2&p3 = v3;

@end

@implementation NetworkEngine
-(void)dealloc
{
    [_url release];
    [_params release];
    [_HTTPMethod release];
    [_packagedParams release];
    [super dealloc];
}
+(id)engineWithURL:(NSURL *)url parameters:(NSDictionary *)params delegate:(id<NetworkEngineDelegate>)delegate
{
    NetworkEngine *engine = [[NetworkEngine alloc]init];
    engine.url = url;
    engine.delegate = delegate;
    engine.params = params;
    engine.HTTPMethod = @"GET";
    return [engine autorelease];
}
-(void)setHTTPType:(NSString *)method
{
    if (!method)
    {
       return;//如果并未设置请求方式，则使用默认的GET请求
    }
    self.HTTPMethod = method;
    
}
-(NSString *)_packageParams:(NSDictionary *)params
{
    NSMutableArray *temps = [NSMutableArray array];
    for (NSString *key in params)
    {
        NSString *aParam = [NSString  stringWithFormat:@"%@=%@",key,params[key]];
        [temps addObject:aParam];
    }
    return [temps componentsJoinedByString:@"&"];
}
-(void)setParams:(NSDictionary *)params
{
    if (!_params)
    {
        return;
    }
    //如果参数字典存在，直接调用私有方法将其转成参数列表字符串
    self.packagedParams  = [self _packageParams:params];
}
-(void)start
{
    if ([self.HTTPMethod isEqualToString:@"GET"]&& self.packagedParams)
    {
        NSString *getURLString = [self.url.absoluteString stringByAppendingFormat:@"?%@",self.packagedParams];
        self.url = [NSURL URLWithString:getURLString];
    }
    
    //根据url创建Request对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:self.url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60];
    //设置请求方式
    request.HTTPMethod = self.HTTPMethod;
    if ([self.HTTPMethod isEqualToString:@"POST"])
    {
        request.HTTPBody = [self.packagedParams dataUsingEncoding:NSUTF8StringEncoding];
    }
    //先让代理对象执行一次开始下载的协议方法；
    if (self.delegate && [self.delegate respondsToSelector:@selector(networkDidStartLoading:)])
    {
        [self.delegate networkDidStartLoading:self];
    }
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(networkDidFinishLoading:withInfo:)])
        {
            [self.delegate networkDidFinishLoading:self withInfo:data];
        }
    }];
}

@end
