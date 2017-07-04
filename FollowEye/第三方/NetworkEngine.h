

#import <Foundation/Foundation.h>
@class NetworkEngine;

@protocol NetworkEngineDelegate <NSObject>

@optional
-(void)networkDidStartLoading:(NetworkEngine *)engine;//网络开始加载
-(void)networkDidFinishLoading:(NetworkEngine *)engine
                      withInfo:(id)info;//网络结束加载


@end

@interface NetworkEngine : NSObject
@property(nonatomic ,assign)int tag;
+(id)engineWithURL:(NSURL *)url
        parameters:(NSDictionary *)params
          delegate:(id<NetworkEngineDelegate>)delegate;
//设置请求方式GET/POST
-(void)setHTTPType:(NSString *)method;
//开始请求
-(void)start;

@end
