

#import <UIKit/UIKit.h>
#import "ZMYNetManager.h"
#import "Reachability.h"

static ZMYNetManager *zmyNetWorkManager = nil;

@implementation ZMYNetManager


+ (ZMYNetManager *)shareZMYNetManager
{
    @synchronized(self)
    {
        if (zmyNetWorkManager == nil) {
            zmyNetWorkManager = [[ZMYNetManager alloc] init];
        }
        return zmyNetWorkManager;
    }
}


+ (ZMY_NetWork_TYPE)getZMYNetWorkTypeFromStatusBar
{
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *subViews = [[[app valueForKey:@"statusBar"] valueForKey:@"foregroundView"] subviews];
    NSNumber *dataZMYNetWorkingItemView = nil;
    for (id subview in subViews) {
        if ([subview isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
            dataZMYNetWorkingItemView = subview;
            break;
        }
    }
    ZMY_NetWork_TYPE zmy_NetWork_Type = ZMY_NetWork_TYPE_NONE;
    NSNumber *num = [dataZMYNetWorkingItemView valueForKey:@"dataNetworkType"];
    zmy_NetWork_Type = [num integerValue];
    
    return zmy_NetWork_Type;
}

- (BOOL)isZMYNetWorkRunning
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus state = reachability.currentReachabilityStatus;
    
    BOOL result = NO;
    switch (state) {
        case NotReachable:
            result = NO;
            break;
        case ReachableViaWiFi:
            result = YES;
            break;
        case ReachableViaWWAN:
            result = NO;
            break;
        default:
            result = NO;
            break;
    }
    return result;
}








@end




























