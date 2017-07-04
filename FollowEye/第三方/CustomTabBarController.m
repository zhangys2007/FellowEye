
#import "CustomTabBarController.h"
#import "NewsController.h"

#import "AudioVisualTableViewController.h"
#import "SelfViewController.h"
#import "JokeViewController.h"


@interface CustomTabBarController ()
-(void)_setup;//设置tabBarController
-(UINavigationController *)_navigationControllerWithClass:(Class)class;//根据制动的视图控制器类型创建对象以及导航控制器

@end

@implementation CustomTabBarController


-(UINavigationController *)_navigationControllerWithClass:(Class)class
{
   UIViewController *aViewController = [[class alloc]init];
    UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:aViewController];
    [aViewController release];
    return [navigation autorelease];
}
-(void)_setup{
    
    NSArray *title = @[@"新闻",@"试听",@"轻松一刻",@"我"];
    NSArray *className = @[@"NewsController",@"AudioVisualTableViewController",@"JokeViewController",@"SelfViewController"];
    NSArray *array = @[@"tabbar_icon_news_normal",@"tabbar_icon_media_normal",@"tabbar_icon_reader_normal",@"tabbar_icon_me_normal"];
    NSArray *array1 = @[@"tabbar_icon_news_highlight",@"tabbar_icon_media_highlight",@"tabbar_icon_reader_highlight",@"tabbar_icon_me_highlight"];
   
    NSMutableArray *viewContronller = [NSMutableArray array];

    for (int i = 0; i < title.count; i++)
    {
        UINavigationController *aNavi = [self _navigationControllerWithClass:NSClassFromString(className[i])];
//        [aNavi.tabBarItem setTitle:title[i]];
        
              [viewContronller addObject:aNavi];
        aNavi.tabBarItem = [[UITabBarItem alloc]initWithTitle:title[i] image:[[UIImage imageNamed:array[i]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:array1[i]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ]];
        
    
        aNavi.navigationBar.barTintColor = [UIColor  colorWithRed:0.702 green:0.122 blue:0.145 alpha:1.000];
        
        
    }
    self.viewControllers = viewContronller;
//    NSLog(@"%ld",viewContronller.count);
    self.tabBar.tintColor = [UIColor redColor];
    self.tabBar.backgroundColor = [UIColor darkGrayColor];
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self _setup];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
