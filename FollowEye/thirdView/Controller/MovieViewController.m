
#import "headerView.h"
#import "MovieViewController.h"
#import <MediaPlayer/MediaPlayer.h>//系统自带框架
#import "VideoCell.h"
#import "NetworkEngine.h"
#import "UIImageView+WebCache.h"
#import "DetailVideoController.h"
#define darkModeColor [UIColor colorWithRed:0.016 green:0.018 blue:0.017 alpha:1.000]
#define darkBarTintColor [UIColor colorWithRed:0.329 green:0.059 blue:0.075 alpha:1.000]
#define whiteModeColor [UIColor colorWithRed:0.922 green:0.922 blue:0.945 alpha:1.000]
#define whiteBarTintColor [UIColor colorWithRed:0.702 green:0.122 blue:0.145 alpha:1.000]
#define cellDarkModeColor [UIColor colorWithRed:0.186 green:0.204 blue:0.192 alpha:1.000]
/*
 视频播放的三种方法
 1.使用系统自带的播放器框架<MediaPlayer/MediaPlayer.h>
 2.使用UIWebView
 */

@interface MovieViewController ()<UITableViewDataSource,UITableViewDelegate,NetworkEngineDelegate>
//@property (nonatomic ,retain)UIWebView *web;


@property (nonatomic ,retain)MPMoviePlayerController *moviePlayer;//控制器播放类
//@property (nonatomic,retain) MPMoviePlayerViewController *viewPlayer;//播放器视图展示
@property(nonatomic ,retain)NSMutableArray *datasource;
@property(nonatomic ,retain)UIActivityIndicatorView *activity;
@property(nonatomic ,retain)UILabel *loadLabel;

@end

@implementation MovieViewController
-(void)dealloc {
    [_titles release];
    [_movieTableView release];
    [_item release];
    [_moviePlayer release];
    [_appendingStr release];
    [_activity release];
    [_loadLabel release];
    [super dealloc];
  }
-(UIActivityIndicatorView *)activity
{
    if (!_activity)
    {
        self.activity = [[[UIActivityIndicatorView alloc]init]autorelease];
        _activity.center = self.moviePlayer.view.center;
        
        
    }
    return _activity;
}
-(UILabel *)loadLabel
{
    if (!_loadLabel)
    {
        self.loadLabel = [[[UILabel alloc]initWithFrame:CGRectMake(0  , self.activity.frame.origin.y + 5, self.view.bounds.size.width, 50)]autorelease];
        self.loadLabel.font = [UIFont systemFontOfSize:10];
        self.loadLabel.textColor = [UIColor whiteColor];
        
        self.loadLabel.textAlignment = NSTextAlignmentCenter;
        
        
    }
    return _loadLabel;
}
-(NSMutableArray *)datasource
{
    if (!_datasource)
    {
        self.datasource = [NSMutableArray array];
    }
    return _datasource;
}

-(NSString *)titles {
    if (!_titles) {
        self.titles = @"推荐";
    }
    return _titles;
}

//方法2
- (MPMoviePlayerController *)moviePlayer
{
    if (!_moviePlayer) {
        // 负责控制媒体播放的控制器

        self.moviePlayer = [[[MPMoviePlayerController alloc]initWithContentURL:[NSURL URLWithString:self.item.mp4_url]]autorelease];
        _moviePlayer.view.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height / 3);
//        _moviePlayer.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:_moviePlayer.view];
        
//        NSLog(@"%@",self.item.mp4_url);
    }
    return _moviePlayer;
}


-(UITableView *)movieTableView
{
    if (!_movieTableView) {
        self.movieTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64 + CGRectGetHeight(self.view.bounds) / 3 , CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 110 - CGRectGetHeight(self.view.bounds) / 3 + 44) style:UITableViewStylePlain];
    }
    return _movieTableView;
}



- (void)viewDidLoad {
    self.tabBarController.tabBar.hidden = YES;
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    self.movieTableView.rowHeight = 100;
    
    [self.moviePlayer play];
    [self.view addSubview:self.activity];
    [self.activity startAnimating];
    [self.view addSubview:self.loadLabel];
    self.loadLabel.text = @"正在加载中";

    
    //返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 40, 40);
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(handleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = left;
    [left release];
    

    
    self.movieTableView.dataSource = self;
    self.movieTableView.delegate = self;
    
   //注册单元格
    
    [self.movieTableView registerClass:[VideoCell class] forCellReuseIdentifier:@"cell"];
    //将表视图控制器添加到视图控制器上
    [self.view addSubview:self.movieTableView];
    NetworkEngine *anEngine = [NetworkEngine engineWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://c.m.163.com/nc/video/detail/%@.html",self.appendingStr]] parameters:nil delegate:self];
    
    [anEngine start];
    [self _prepareplay];
    

}
-(void)viewWillAppear:(BOOL)animated
{
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"nightSwitch"])
    {
        self.movieTableView.backgroundColor = [UIColor blackColor];
    }else
    {
        self.movieTableView.backgroundColor = [UIColor whiteColor];
    }
    [self.movieTableView reloadData];
}
-(void)_prepareplay
{
    if ([self.moviePlayer respondsToSelector:@selector(loadState)])
    {
        [self.moviePlayer prepareToPlay];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(MPMoviePlayerLoadingStateChanged:)                                                   name:MPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                                   object:nil];
    }
}
-(void)MPMoviePlayerLoadingStateChanged:(NSNotification *)notification {
    [self.activity stopAnimating];
    [self.loadLabel removeFromSuperview];
    
}






//返回按钮的方法
-(void)handleButtonAction:(UIButton *)button
{
    [self.moviePlayer pause];
    [self.navigationController popViewControllerAnimated:YES];
    self.tabBarController.tabBar.hidden = NO;
}
-(void)networkDidFinishLoading:(NetworkEngine *)engine withInfo:(id)info
{
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:info options:NSJSONReadingMutableContainers error:nil];
    NSArray *array = dict[@"recommend"];
    for (NSDictionary *dic in array)
    {
         AudioVisualItem *item = [AudioVisualItem itemWithDictionary:dic];
        [self.datasource addObject:item];
        NSLog(@"%ld",self.datasource.count);
    }
    
    [self.movieTableView reloadData];

    
}
#pragma mark - UITableViewDataSource
//指定分区显示多少行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VideoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    AudioVisualItem * item = self.datasource[indexPath.row];
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"nightSwitch"])
    {
        cell.backgroundColor = cellDarkModeColor;
        cell.titleLabel.textColor = [UIColor whiteColor];
        cell.contentLabel.textColor = [UIColor whiteColor];
    }else
    {
        cell.backgroundColor = [UIColor whiteColor];
        cell.titleLabel.textColor = [UIColor blackColor];
        cell.contentLabel.textColor = [UIColor blackColor];
    }
    [cell.VideoImage sd_setImageWithURL:[NSURL URLWithString:item.cover]placeholderImage:[UIImage imageNamed:@"place"]];
    cell.titleLabel.text = item.title;
    cell.contentLabel.text = item.length;
    
    return cell;
  
}

//传值
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    DetailVideoController *detail = [[[DetailVideoController alloc]init]autorelease];
    detail.item = self.datasource[indexPath.row];
    UINavigationController *navi = [[[UINavigationController alloc]initWithRootViewController:detail]autorelease];
    navi.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:navi animated:YES completion:nil];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.titles;
}

#pragma mark - UITableViewDelegate





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
