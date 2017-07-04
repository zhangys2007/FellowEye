
#import "DetailSelfViewController.h"

@interface DetailSelfViewController ()

@end

@implementation DetailSelfViewController
-(void)loadView
{
    UIImageView *image = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    image.image = [UIImage imageNamed:@"GUOY06)]ZAVJ7I4IT_L)~RJ.jpg"];
    self.view = image;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBarController.tabBar.hidden = YES;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 44, 44);
    [button addTarget:self action:@selector(handleButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *back = [[[UIBarButtonItem alloc]initWithCustomView:button]autorelease];
    self.navigationItem.leftBarButtonItem = back;
}
-(void)handleButton:(UIButton *)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
