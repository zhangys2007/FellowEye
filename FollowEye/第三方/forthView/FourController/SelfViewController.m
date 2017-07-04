

#import "SelfViewController.h"

#import "UIView+WebCacheOperation.h"
#import <StoreKit/StoreKit.h>
#import "DetailSelfViewController.h"
#define darkModeColor [UIColor colorWithRed:0.016 green:0.018 blue:0.017 alpha:1.000]
#define darkBarTintColor [UIColor colorWithRed:0.329 green:0.059 blue:0.075 alpha:1.000]
#define whiteModeColor [UIColor colorWithRed:0.922 green:0.922 blue:0.945 alpha:1.000]
#define whiteBarTintColor [UIColor colorWithRed:0.702 green:0.122 blue:0.145 alpha:1.000]
#define cellDarkModeColor [UIColor colorWithRed:0.186 green:0.204 blue:0.192 alpha:1.000]
#define switchTintColor [UIColor colorWithRed:0.251 green:0.219 blue:0.772 alpha:0.900]



@interface SelfViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,SKStoreProductViewControllerDelegate>
@property(nonatomic ,retain)UITableView *tableView;
@property(nonatomic ,retain)NSUserDefaults *userdefault;//下次启动程序的时候默认的状态
@property(nonatomic ,retain)UILabel *contentLabel;
@property(nonatomic ,assign)BOOL isblack;
@property(nonatomic ,retain)UISwitch *nightModeSwitch;

@end

@implementation SelfViewController
-(void)dealloc
{
    [_userdefault release];
    [_contentLabel release];
    [_tableView release];
    [_nightModeSwitch release];
    [super dealloc];
}






-(UILabel *)contentLabel
{
    if (!_contentLabel)
    {
        self.contentLabel = [[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 40)]autorelease];
        _contentLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _contentLabel;
}
-(UISwitch *)nightModeSwitch
{
    if (!_nightModeSwitch)
    {
        self.nightModeSwitch = [[[UISwitch alloc]initWithFrame:CGRectZero]autorelease];
        
    }
    return _nightModeSwitch;
    
}
-(UITableView *)tableView
{
    if (!_tableView)
    {
        self.tableView = [[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped]autorelease];
        
    }
    return  _tableView;
}
-(NSUserDefaults *)userdefault
{
    if (!_userdefault)
    {
        self.userdefault = [NSUserDefaults standardUserDefaults];
    }
    return _userdefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.isblack = YES;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 2;
    }else
    {
        return 3;
    }
    
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *sectionone = @[@"清除缓存",@"仅限WI-FI下观看图片"];
    NSArray *sectionTwo = @[@"给我们评分",@"夜间模式",@"关于我们"];
     UISwitch *swich = [[[UISwitch alloc]init]autorelease];
    if ([self.userdefault boolForKey:@"nightSwitch"]) {
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.backgroundColor = cellDarkModeColor;
        self.view.backgroundColor = [UIColor blackColor];
        self.tableView.backgroundColor = darkModeColor;
    }
  
    [swich addTarget:self action:@selector(handleSwichAction:) forControlEvents:UIControlEventValueChanged];
    [swich setOn:[self.userdefault boolForKey:@"wifiSwitchState"] animated:YES];
    if (indexPath.section == 0)
    {
        cell.textLabel.text = sectionone[indexPath.row];
        if (indexPath.row == 1)
        {
             cell.accessoryView = swich;
            
            
        }else
        {
            cell.accessoryView = self.contentLabel;
        }
        
       
    }else
    {
        cell.textLabel.text = sectionTwo[indexPath.row];
        if (indexPath.row == 1)
        {
            

            cell.accessoryView = self.nightModeSwitch;
            [self.nightModeSwitch setOn:[self.userdefault boolForKey:@"nightSwitch"] animated:YES];
            [self.nightModeSwitch addTarget:self action:@selector(darkMode) forControlEvents:UIControlEventValueChanged];
        }
    }
   
    
    return cell;
    
}
-(void)handleSwichAction:(UISwitch *)sender
{
    if(sender.on)
    {
        NSLog(@"开关打开状态,只有wifi情况下可以下载图片");
    }else
    {
        NSLog(@"开关管壁，任何形势下都可以下载图片");
    }
    [self.userdefault setBool:sender.on forKey:@"wifiSwitchState"];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"清除缓存" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
     DetailSelfViewController *Detailself = [[[DetailSelfViewController alloc]init]autorelease];
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            [alertView show];
            [self.view addSubview:alertView];
            [alertView release];
        }
        
        
    }else if(indexPath.section == 1)
    {
        switch (indexPath.row)
        {
            case 0:
                [self jumuToAppStore];
                break;
                case 2:
               
                [self.navigationController pushViewController:Detailself animated:YES];
                break;
                
            default:
                break;
        }
       
    }
}
-(NSString *)getCache
{
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)firstObject];
    return cachePath;
}
//获取文件夹的大小
-(CGFloat)folderSizeAtPath:(NSString *)folderPath
{
    NSFileManager *mananger = [NSFileManager defaultManager];//创建管理器
    folderPath = [self getCache];//接收文件夹路径
    if (![mananger fileExistsAtPath:folderPath])//管理器查找如果不存在文件的话返回0；
    {
        return 0;
    }
    NSEnumerator *childFilesEnumerator = [[mananger subpathsAtPath:folderPath]objectEnumerator];
    NSString *fileName = nil;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil)
    {
        NSString *fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        float singleFileSize = 0.0;
        if ([mananger fileExistsAtPath:fileAbsolutePath])
        {
            singleFileSize = [[mananger attributesOfItemAtPath:fileAbsolutePath error:nil]fileSize];
        }
        folderSize += singleFileSize;
    }
    return folderSize;
}
-(void)clearCache:(NSString *)floderPath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //遍历文件夹
    if ([fileManager fileExistsAtPath:floderPath])
    {
        NSArray *childerFiles = [fileManager subpathsAtPath:floderPath];
        for (NSString *fileName in childerFiles)
        {
            NSString *absolutePath = [floderPath stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
    [[SDImageCache sharedImageCache] clearDisk];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    NSString *path = [self getCache];
    CGFloat cacheSize = [self folderSizeAtPath:path] / 1024 / 1024;
    [self.userdefault setDouble:cacheSize forKey:@"cacheSize"];
    self.contentLabel.text = [NSString stringWithFormat:@"%0.1lfMB",cacheSize];
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        return;
    }else
    {
        NSString *cachePath = [self getCache];
        [self clearCache:cachePath];
        float cacheSize = [self folderSizeAtPath:cachePath];

        self.contentLabel.text = @"0.0M";
    
    }
}
-(void)jumuToAppStore
{

    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms://itunes.apple.com/cn/app/bai-du-wen-kuhd/id483064532?mt=8"]];

    
}
//夜间模式的方法
-(void)darkMode
{
    [self.userdefault setBool:self.nightModeSwitch.on
                       forKey:@"nightSwitch"];

    NSArray *array = [self.tableView visibleCells];
    if (self.nightModeSwitch.on)
    {
        self.tableView.backgroundColor =darkModeColor;
        self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
        self.navigationController.navigationBar.barTintColor = darkBarTintColor;
        self.tabBarController.tabBar.barTintColor = darkBarTintColor;
        for (UITableViewCell *cell in array)
        {
            cell.backgroundColor = cellDarkModeColor;
            cell.textLabel.textColor = [UIColor whiteColor];
            
        }
        
        
        
        

    }else
    {
        self.tableView.backgroundColor = [UIColor whiteColor];
        self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
        self.navigationController.navigationBar.barTintColor = whiteBarTintColor;
        self.tabBarController.tabBar.barTintColor = whiteBarTintColor;
        for (UITableViewCell *cell in array)
        {
            cell.backgroundColor = [UIColor whiteColor];
            cell.textLabel.textColor = [UIColor blackColor];
        }
        
    }
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
