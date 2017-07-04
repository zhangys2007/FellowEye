
#import "DetailController.h"
#import "NewsController.h"
#import "NetworkEngine.h"
#import "ProgressHUD.h"
#import "TFHpple.h"
#import "NetworkEngine.h"
#import "DetailModel.h"
#import "HeadlineInfoModel.h"



@interface DetailController ()<NetworkEngineDelegate,UIWebViewDelegate>
@property(nonatomic,retain)UIButton *button;
@property(nonatomic ,retain)UIWebView *web;

@end


@implementation DetailController
- (void)dealloc
{
    [_web release];
    [_button release];
    [super dealloc];
}
- (UIButton *)button
{
    if (!_button)
    {
        self.button = [[[UIButton alloc]initWithFrame:CGRectMake(0, 2, 40, 35)]autorelease];
        [_button setTitle:@"返回" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _button;
}
-(UIWebView *)web
{
    if (!_web)
    {
        self.web = [[[UIWebView alloc]initWithFrame:self.view.bounds]autorelease];
    }
    return _web;
}
-(void)loadNet
{
    if (self.count == 1)
    {
        NetworkEngine *net = [NetworkEngine engineWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://c.m.163.com/nc/article/%@/full.html",self.url]] parameters:nil delegate:self];
        NSLog(@"%@",self.url);
        [net start];
    }else if (self.count == 0)
    {
        NetworkEngine *net = [NetworkEngine engineWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://c.3g.163.com/nc/article/%@/full.html",self.url]] parameters:nil delegate:self];
        [net start];
    }
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"新闻详情";
    self.navigationController.navigationBar.tintColor = [UIColor redColor];
    self.view.backgroundColor = [UIColor whiteColor];
    self.web.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc]initWithCustomView:self.button];
    self.navigationItem.leftBarButtonItem = barButton;
    [self.button addTarget:self action:@selector(handleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.web];
//    self.web.scalesPageToFit = YES;
    self.web.backgroundColor = [UIColor whiteColor];
    [ProgressHUD show:@"正在加载，请稍后" Interaction:YES];
   
//        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://c.m.163.com/nc/article/%@/full.html",self.model.docid]];
//    NSURL *url = [NSURL URLWithString:self.url];
//        NSURLRequest *request = [NSURLRequest requestWithURL:url];
//        [self.web loadRequest:request];
//    self.web.delegate = self;
//    self.web.scalesPageToFit = YES;
//     [self.web reload];
        self.tabBarController.tabBar.hidden = YES;
    [self loadNet];
   
}
-(void)networkDidFinishLoading:(NetworkEngine *)engine withInfo:(id)info
{
    [ProgressHUD dismiss];
    if (!info)
    {
        [ProgressHUD showError:@"加载失败" Interaction:YES];
        return;
    }
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:info options:NSJSONReadingMutableContainers error:nil];//info!!
    NSDictionary *item = dict[self.url];
    HeadlineInfoModel *headModel = [[HeadlineInfoModel alloc] init];
    [headModel setValuesForKeysWithDictionary:item];

   
    [self getHtml:headModel];

   
}
-(void)handleButtonAction:(UIButton *)sender
{
    
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
    self.tabBarController.tabBar.hidden = NO;
    [ProgressHUD dismiss];
}

- (void)getHtml:(HeadlineInfoModel *)headModel
{
    //加载本地的html文件
    NSString *path = [[NSBundle mainBundle] pathForResource:@"html" ofType:@"txt"];
    
    //将文件转化成utf-8的格式
    NSMutableString *str = [NSMutableString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSString *cssPath = [[NSBundle mainBundle] pathForResource:@"htmlCSS" ofType:@"css"];
    NSRange rangeOfCSSPath = [str rangeOfString:@"#CSSPath#"];
    [str replaceCharactersInRange:rangeOfCSSPath withString:cssPath];
    
    NSRange titleRange = [str rangeOfString:@"#title#"];
    [str replaceCharactersInRange:titleRange withString:headModel.title_];
    
    NSRange sourceRange = [str rangeOfString:@"#source#"];
    if (headModel.source) {
        [str replaceCharactersInRange:sourceRange withString:headModel.source];
    }
    
    NSRange timeRange = [str rangeOfString:@"#time#"];
    if (headModel.ptime) {
        [str replaceCharactersInRange:timeRange withString:headModel.ptime];
    }
    
    NSRange bodyRange = [str rangeOfString:@"#body#"];
    if (headModel.body) {
        [str replaceCharactersInRange:bodyRange withString:headModel.body];
        
        for (NSDictionary *dict in headModel.img) {
            NSArray *arr = [dict[@"pixel"] componentsSeparatedByString:@"*"];
            int a = [arr[0] intValue];
            int b = [arr[1] intValue];
            if ([[dict objectForKey:@"alt"] length] != 0 && (a != 0)) {
                NSMutableString *imgHtml = [NSMutableString stringWithFormat:@"<img class=\"content-image\" src=\"%@\" alt=\"\" width = 305px height = %@px /><p style=\"font-size:14px\">%@</p>",[dict objectForKey:@"src"],[NSString stringWithFormat:@"%d",305*b/a],[dict objectForKey:@"alt"]];
                NSRange rangeOfImg = [str rangeOfString:[dict objectForKey:@"ref"]];
                if (rangeOfImg.length != 0) {
                    [str replaceCharactersInRange:rangeOfImg withString:imgHtml];
                }
            }else{
                NSMutableString *imgHtml = [NSMutableString stringWithFormat:@"<img class=\"content-image\" src=\"%@\" width = 305px height = 220px />",[dict objectForKey:@"src"]];
                NSRange rangeOfImg = [str rangeOfString:[dict objectForKey:@"ref"]];
                if (rangeOfImg.length != 0) {
                    [str replaceCharactersInRange:rangeOfImg withString:imgHtml];
                }
            }
        }
    }
    
    [self.web loadHTMLString:str baseURL:nil];
    
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
    [self.web stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '100%'"];
    self.web.scalesPageToFit = NO;
    //    CGRect frame = webView.frame;
    //    CGSize fittingSize = [webView sizeThatFits:CGSizeZero];
    //    frame.size = fittingSize;
    //    webView.frame = frame;
    
    [self.web stringByEvaluatingJavaScriptFromString:
     @"var script = document.createElement('script');"
     "script.type = 'text/javascript';"
     "script.text = \"function ResizeImages() { "
     "var myimg,oldwidth;"
     "var maxwidth=380;" //缩放系数
     "for(i=0;i <document.images.length;i++){"
     "myimg = document.images[i];"
     "if(myimg.width > maxwidth){"
     "oldwidth = myimg.width;"
     "myimg.width = maxwidth;"
     "myimg.height = myimg.height * (maxwidth/oldwidth);"
     "}"
     "}"
     "}\";"
     "document.getElementsByTagName('head')[0].appendChild(script);"];
    
    [self.web stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//- (void)viewWillDisappear:(BOOL)animated{
//    NewsController *a = [[NewsController alloc]init];
//    [self.navigationController pushViewController:a animated:NO];
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
