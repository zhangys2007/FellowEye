

#import "OtherDetailViewController.h"
#import "NetworkEngine.h"

@interface OtherDetailViewController ()<NetworkEngineDelegate>
@property(nonatomic ,retain)UIWebView *web;




@end

@implementation OtherDetailViewController
-(void)dealloc
{
    [_str release];
    [_web release];
    [super dealloc];
}
-(UIWebView *)web
{
    if (!_web)
    {
        self.web = [[[UIWebView alloc]initWithFrame:self.view.frame]autorelease];
        
    }
    return _web;
}
-(void)loadNet
{
    NetworkEngine *engine = [NetworkEngine engineWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://c.m.163.com/nc/article/%@/full.html",self.str]] parameters:nil delegate:self];
    [engine start];
}

-(void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.web];
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.str]];
//    [self.web loadRequest:request];
    self.web.scalesPageToFit = YES;
    [self.web reload];
    self.tabBarController.tabBar.hidden = YES;
    UIButton *bactButton = [UIButton buttonWithType:UIButtonTypeCustom];
    bactButton.frame = CGRectMake(0, 0, 40, 40);
    [bactButton addTarget:self action:@selector(handleButton:) forControlEvents:UIControlEventTouchUpInside];
    [bactButton setTitle:@"返回" forState:UIControlStateNormal];
    UIBarButtonItem *left = [[[UIBarButtonItem alloc]initWithCustomView:bactButton]autorelease];
    self.navigationItem.leftBarButtonItem = left;
}
-(void)networkDidFinishLoading:(NetworkEngine *)engine withInfo:(id)info
{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:info options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *dict = dic[self.str];
    [self showNews:dict];
}
-(void)showNews:(NSDictionary *)news
{
    //取出来网页内容
    NSString *body = news[@"body"];
    //取出来图片
    NSArray *imageArray = news[@"img"];
    for (NSDictionary *dict in imageArray)
    {
        //取出来图片信息
        NSString *imgUrlStr = dict[@"src"];
        NSString *sizeStr = dict[@"pixel"];
        NSString *positionStr = dict[@"ref"];
        //高度自适应
        NSArray *sizeArr = [sizeStr componentsSeparatedByString:@"*"];
        NSInteger width = [UIScreen mainScreen].bounds.size.width - 20;
        NSInteger height = [sizeArr[1] floatValue] / [sizeArr[0] floatValue] * width;
        //设置图片的Html
         NSString *imgHTML = [NSString stringWithFormat:@"<p></p><img src=\"%@\" width=\"%ld\" height=\"%ld\">", imgUrlStr, width, height];
        //把图片的html与body拼接
        NSString *currentHTMl = [body stringByReplacingOccurrencesOfString:positionStr withString:imgHTML];
        body = currentHTMl;
        NSArray *videoArr = news[@"video"];
        
        for (NSDictionary *dict in videoArr) {
            NSString *videoUrlStr = dict[@"url_mp4"];
            NSString *positionStr = dict[@"ref"];
            NSString *diegst = dict[@"alt"];
            NSString *coverImg = dict[@"cover"];
            
            
            NSString *videoHTML = [NSString stringWithFormat:@"<p><video width=360 height=240 controls=controls poster=%@><source src=%@ type=video/mp4 /></video><p><font size=2 color=#888>%@</font></p>", coverImg, videoUrlStr, diegst ];
            NSString *currentHTML = [body stringByReplacingOccurrencesOfString:positionStr withString:videoHTML];
            body = currentHTML;
        }
        
        //4.取出标题
        NSString *titleStr = news[@"title"];
        
        //5.取出时间
        NSString *timeStr = news[@"ptime"];
        
        body = [NSString stringWithFormat:@"<h3>%@</h3><h5>%@</h5>%@",titleStr, timeStr, body];
        
        [self.web loadHTMLString:body baseURL:nil];
        
    }
    
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
