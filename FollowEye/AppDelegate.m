

#import "AppDelegate.h"
#import "CustomTabBarController.h"
#import "GudieViewController.h"

@interface AppDelegate ()
@property(nonatomic ,retain)UIImageView *imageView;

@end

@implementation AppDelegate
-(void)dealloc
{
    [_window release];
    [super dealloc];
}
-(UIImageView *)imageView {
    if (!_imageView) {
        self.imageView = [[UIImageView alloc] initWithFrame:self.window.bounds];
        _imageView.image = [UIImage imageNamed:@"UL]IITN6`QX3M44[4~{B{3M.jpg"];
    }
    return _imageView;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]]autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
   
    
//    CustomTabBarController *cus = [[CustomTabBarController alloc]init];
//    self.window.rootViewController = cus;
//    [cus release];
//    如果不为空的话
    if (![[NSUserDefaults standardUserDefaults]boolForKey:@"firstLaunch"]){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        NSLog(@"第一次启动");
        GudieViewController *guideVC = [[[GudieViewController alloc]init]autorelease];
        self.window.rootViewController = guideVC;
    }else{
        NSLog(@"不是第一次启动");
        //添加启动图片
        [self.window addSubview:self.imageView];
        
        [self.imageView removeFromSuperview];
        
        CustomTabBarController *tabBarController = [[[CustomTabBarController alloc] init] autorelease];
        self.window.rootViewController = tabBarController;
        //[NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(loadingApp:) userInfo:nil repeats:NO];
    }
    
    return YES;
}

- (void)loadingApp:(NSTimer *)timer {
    [self.imageView removeFromSuperview];
    
    CustomTabBarController *tabBarController = [[[CustomTabBarController alloc] init] autorelease];
    self.window.rootViewController = tabBarController;

    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
