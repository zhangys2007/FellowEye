

#import "VideoViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "NetworkEngine.h"
#import "VideoModel.h"


@interface VideoViewController ()<NetworkEngineDelegate>
@property(nonatomic ,retain)MPMoviePlayerController *mp;
@property(nonatomic ,retain)NSMutableArray *datasource;

@end

@implementation VideoViewController
-(void)dealloc
{
    [_mp release];
    [_datasource release];
    [super dealloc];
}
-(MPMoviePlayerController *)mp
{
    if (!_mp)
    {
        self.mp = [[[MPMoviePlayerController alloc]init]autorelease];
        _mp.view.frame = self.view.frame;
        [self.view addSubview:_mp.view];
    }
    return _mp;
}
-(NSMutableArray *)datasource
{
    if (!_datasource)
    {
        self.datasource = [NSMutableArray array];
        
    }
    return _datasource;
}

- (void)viewDidLoad {
    self.tabBarController.tabBar.hidden = YES;
    [super viewDidLoad];
    NetworkEngine *net = [NetworkEngine engineWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://c.m.163.com/nc/video/detail/%@.html",self.item.videoID]] parameters:nil delegate:self];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 40, 40);
    [button addTarget:self action:@selector(hanleButton:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    UIBarButtonItem *leftButton = [[[UIBarButtonItem alloc]initWithCustomView:button]autorelease];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    [net start];
    [self.mp play];
   }




-(void)hanleButton:(UIButton *)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    self.tabBarController.tabBar.hidden = NO;
    [self.mp stop];
}
-(void)networkDidFinishLoading:(NetworkEngine *)engine withInfo:(id)info
{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:info options:NSJSONReadingMutableContainers error:nil];
    NSArray *temp = dic[@"secList"];
    for (NSDictionary *dict in temp)
    {
        VideoModel *model = [VideoModel videoWithDictionary:dict];
        [self.datasource addObject:model];
    }
    VideoModel *first = self.datasource[0];
    self.mp.contentURL = [NSURL URLWithString:first.mp4_url];
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
