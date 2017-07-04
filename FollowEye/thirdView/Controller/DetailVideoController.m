

#import "DetailVideoController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface DetailVideoController ()
@property(nonatomic ,retain)MPMoviePlayerController *moviePlayer;
@property(nonatomic ,retain)UIActivityIndicatorView *activity;
@property(nonatomic ,retain)UILabel *loadLabel;

@end

@implementation DetailVideoController
-(void)dealloc
{
    [_moviePlayer release];
    [_url release];
    [_loadLabel release];
    [_activity release];
    [super dealloc];
}
-(UILabel *)loadLabel
{
    if (!_loadLabel)
    {
        self.loadLabel = [[[UILabel alloc]init]autorelease];
        _loadLabel.textColor =[UIColor whiteColor];
        _loadLabel.font = [UIFont systemFontOfSize:20];
        _loadLabel.text = @"正在加载中";
        _loadLabel.frame = CGRectMake(0, self.activity.frame.origin.y + 44, self.view.frame.size.width, 50);
        _loadLabel.textAlignment = NSTextAlignmentCenter;
  
        
    }
    return _loadLabel;
}
-(UIActivityIndicatorView *)activity
{
    if (!_activity)
    {
        self.activity = [[[UIActivityIndicatorView alloc]init]autorelease];

        _activity.frame = CGRectMake(100, 200, 50, 50);
                _activity.center = self.view.center;
        _activity.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    
        
        
    }
    return _activity;
}
-(MPMoviePlayerController *)moviePlayer
{
    if (!_moviePlayer)
    {
        self.moviePlayer = [[MPMoviePlayerController alloc]initWithContentURL:[NSURL URLWithString:self.item.mp4_url]];
        _moviePlayer.view.frame = CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height - 60);
    }
    return _moviePlayer;
}


- (void)viewDidLoad {
    [super viewDidLoad];


    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.moviePlayer.view];
    [self.moviePlayer play];
    [self.view addSubview:self.activity];
    [self.activity startAnimating];
        [self.view addSubview:self.loadLabel];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 40, 40);
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(handleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = left;
    [left release];
    [self _prepareplay];
    
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
-(void)handleButtonAction:(UIButton *)sender
{
    [self.moviePlayer pause];
    [self dismissViewControllerAnimated:YES completion:nil];
    self.tabBarController.tabBar.hidden = NO;
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
