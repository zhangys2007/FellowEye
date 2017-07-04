

#import "GudieViewController.h"
#import "CustomTabBarController.h"
@interface GudieViewController ()<UIScrollViewDelegate>
@property (nonatomic,retain) UIScrollView *scrollView;
//@property (nonatomic,retain) NSTimer *timer;
@property (nonatomic,retain) UIPageControl *pageControl;
@property (nonatomic,retain) UIButton *button;

@end

@implementation GudieViewController
-(void)dealloc {
    [_scrollView release];
    [_pageControl release];
    [_button release];
//    [_timer release];
    [super dealloc];
}

-(UIScrollView *)scrollView {
    if (!_scrollView) {
        self.scrollView = [[[UIScrollView alloc] initWithFrame:self.view.bounds] autorelease];
        _scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.bounds) * 3, 0);
        _scrollView.pagingEnabled = YES;
        _scrollView.tag = 100;
        _scrollView.delegate = self;
    }
    return _scrollView;
}


-(UIPageControl *)pageControl {
    if (!_pageControl) {
        self.pageControl = [[[UIPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.bounds) - 70, CGRectGetWidth(self.view.bounds), 40)] autorelease];
        _pageControl.numberOfPages = 3;
        _pageControl.currentPage = 0;//设置默认选中页码
        _pageControl.tag = 200;
        [_pageControl addTarget:self action:@selector(handlePageControl:) forControlEvents:UIControlEventValueChanged];
    }
    return _pageControl;
}

-(UIButton *)button {
    if (_button) {
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setTitle:@" " forState:UIControlStateNormal];
//        _button.frame = self.view.bounds;
        _button.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
        _button.backgroundColor = [UIColor redColor];
        [_button addTarget:self action:@selector(handleButton:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _button;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.pageControl];
    
    NSArray *array = @[@"first.jpg",@"second.jpg",@"third.jpg"];
    for (int i = 0; i < array.count; i++) {
        
//        NSString *path = [[NSBundle mainBundle] pathForResource:array[i] ofType:@"jpg"];
//        UIImageView *guideImage = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.bounds) * i, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
//        guideImage.image = [UIImage imageWithContentsOfFile:path];
        
        
        UIImageView *guideImage = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.scrollView.bounds) * i, 0, CGRectGetWidth(self.scrollView.bounds), CGRectGetHeight(self.scrollView.bounds))];
        guideImage.image = [UIImage imageNamed:array[i]];
        
        if (i == 2) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(0,0,CGRectGetWidth(self.view.bounds),CGRectGetHeight(self.view.bounds));
            //UILabel和UIImageView需要打开用户交互
            guideImage.userInteractionEnabled = YES;
            [button addTarget:self action:@selector(handleButton:) forControlEvents:UIControlEventTouchUpInside];
            [guideImage addSubview:button];

           
        }
        [self.scrollView addSubview:guideImage];
        

    }

//    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(startApp:) userInfo:nil repeats:NO];
//    [self.timer fire];


    
}

//通过点击小豆豆让滑动视图偏移
-(void)handlePageControl:(UIPageControl *)sender {
    UIScrollView *scrollView = (UIScrollView *)[self.view viewWithTag:100];
    CGPoint offset = CGPointMake(sender.currentPage * CGRectGetWidth(scrollView.bounds), 0);
    [scrollView setContentOffset:offset animated:YES];
}


-(void)handleButton:(UIButton *)button {
    CustomTabBarController *custom = [[[CustomTabBarController alloc] init]autorelease];
    [self presentViewController:custom animated:YES completion:nil];
}

//让小圆点跟着滑动视图偏移
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //通过最终得到的offset值来确定pageControl当前应该指定第几个视图
    NSInteger index = scrollView.contentOffset.x / CGRectGetWidth(scrollView.bounds);
    //pageControl作为控件需要在接受到点击事件后产生相应操作，通过targetAction来实现
    UIPageControl *pageControl = (UIPageControl *)[self.view viewWithTag:200];
      //修改currentPage属性
    pageControl.currentPage = index;

}


//-(void)startApp:(UIScrollView *)scrollView {
//    scrollView = (UIScrollView *)[self.view viewWithTag:100];
//    for (int i = 0; i < 3; i++) {
//        scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.view.bounds) * i, 0);
//        if (i == 3) {
//            CustomTabBarController *customController = [[CustomTabBarController alloc] init];
//            [self presentViewController:customController animated:YES completion:nil];
//        }
//    }
//
//}


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
