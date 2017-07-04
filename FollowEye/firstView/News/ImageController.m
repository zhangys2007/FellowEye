
#import "ImageController.h"
#import "NetworkEngine.h"
#import "UIImageView+WebCache.h"
#import "FirstImage.h"
#import "ProgressHUD.h"



@interface ImageController ()<NetworkEngineDelegate,UIScrollViewDelegate>
@property(nonatomic ,retain)UIScrollView *imageScroll;
@property(nonatomic ,retain)UILabel *contentLabel;
@property(nonatomic ,retain)UILabel *titleLabel;
@property(nonatomic ,retain)NSMutableArray *imageArray;
@property(nonatomic ,retain)NSMutableArray *imageArrays;
@property(nonatomic ,retain)NSMutableArray *datasource;
@property(nonatomic ,assign)BOOL isHiden;






@end

@implementation ImageController
- (void)dealloc
{
    [_imageScroll release];
    [_contentLabel release];
    [_titleLabel release];
    [_imageArray release];
    [_imageArrays release];
    [_datasource release];
    [super dealloc];
}
-(NSMutableArray *)datasource
{
    if (!_datasource)
    {
        self.datasource = [NSMutableArray array];
    }return _datasource;
}





-(UIScrollView *)imageScroll
{
    if (!_imageScroll)
    {
        self.imageScroll = [[[UIScrollView alloc]initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height / 2 + 50)]autorelease];
                _imageScroll.pagingEnabled = YES;
        _imageScroll.showsHorizontalScrollIndicator = NO;
    }
    return _imageScroll;
}
-(NSMutableArray *)imageArrays
{
    if (!_imageArrays)
   {
       self.imageArrays = [NSMutableArray array];
    }
    return _imageArrays;
}
-(UILabel *)contentLabel
{
    if (!_contentLabel)
    {
        self.contentLabel = [[[UILabel alloc]initWithFrame:CGRectMake(0, self.imageScroll.frame.size.height + 90, self.view.frame.size.width, self.view.frame.size.height / 3 - 100)]autorelease];
        _contentLabel.backgroundColor = [UIColor clearColor];
        _contentLabel.numberOfLines = 0;
        _contentLabel.textColor = [UIColor whiteColor];
        _contentLabel.adjustsFontSizeToFitWidth = YES;
        _contentLabel.font = [UIFont systemFontOfSize:15];
    }
    return _contentLabel;
}
-(UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        self.titleLabel = [[[UILabel alloc]initWithFrame:CGRectMake(0, self.imageScroll.frame.size.height + 50, self.view.frame.size.width, 40 )]autorelease];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        _titleLabel.font = [UIFont systemFontOfSize:20];
    }
    return _titleLabel;
}
-(NSMutableArray *)imageArray
{
    if (!_imageArray)
    {
        self.imageArray = [NSMutableArray array];
    }
    return _imageArray;
}
-(void)loadNet
{
    if (self.mark == 0)
    {
        NetworkEngine *net = [NetworkEngine engineWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://c.3g.163.com/photo/api/set/0096/%@.json",self.imageURL]] parameters:nil delegate:self];
        net.tag = 100;
        [net start];
   }else if (self.mark == 10)
   {
       NetworkEngine *nets = [NetworkEngine engineWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://c.m.163.com/photo/api/set/0096/%@.json",self.cellURL]] parameters:nil delegate:self];
       nets.tag = 101;
       [nets start];
       
   }else if(self.mark == 100)
   {
       NetworkEngine *net = [NetworkEngine engineWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://c.3g.163.com/photo/api/set/0009/%@.json",self.imageURL]] parameters:nil delegate:self];
       [net start];
   }else if (self.mark == 2)
   {
       NetworkEngine *net = [NetworkEngine engineWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://c.3g.163.com/photo/api/set/0026/%@.json",self.imageURL]] parameters:nil delegate:self];
       [net start];
   }else if (self.mark == 3)
   {
       NetworkEngine *net = [NetworkEngine engineWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://c.3g.163.com/photo/api/set/0029/%@.json",self.imageURL]] parameters:nil delegate:self];
       [net start];
   }

    

    
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isHiden = YES;
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.imageScroll];
    [self.view addSubview:self.contentLabel];
    [self.view addSubview:self.titleLabel];
    self.imageScroll.delegate = self;
    self.tabBarController.tabBar.hidden = YES;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 40, 40);
    [button addTarget:self action:@selector(handleButton:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    UIBarButtonItem *left = [[[UIBarButtonItem alloc]initWithCustomView:button]autorelease];
    UITapGestureRecognizer *tap = [[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapAction:)]autorelease];
    [self.view addGestureRecognizer:tap];
    
    self.navigationItem.leftBarButtonItem = left;
    [self loadNet];
   
    [ProgressHUD show:@"正在加载中" Interaction:YES];
   

   }






-(void)handleTapAction:(UITapGestureRecognizer *)sender
{
    if (self.isHiden == YES)
    {
        self.contentLabel.hidden = YES;
        self.titleLabel.hidden = YES;
        self.navigationController.navigationBar.hidden = YES;
        self.isHiden = NO;
    }else if(self.isHiden == NO)
    {
        self.contentLabel.hidden = NO;
        self.titleLabel.hidden = NO;
        self.navigationController.navigationBar.hidden = NO;
        self.isHiden = YES;
    }
}

-(void)networkDidFinishLoading:(NetworkEngine *)engine withInfo:(id)info
{
    if (!info)
    {
        [ProgressHUD showError:@"加载失败"];
        return;
        
    }
    [ProgressHUD dismiss];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:info options:NSJSONReadingMutableContainers error:nil];
    NSArray *array = dic[@"photos"];
        self.titleLabel.text = dic[@"setname"];

        for (NSDictionary *dict in array)
        {
            FirstImage *img = [FirstImage firstimageWithDictionary:dict];
            [self.imageArray addObject:img];
            NSLog(@"%@",img.title);
            [self loadImage];
            
        }
}
-(void)handleButton:(UIButton *)sender
{
    [ProgressHUD dismiss];
    [self.navigationController popViewControllerAnimated:YES];
    self.tabBarController.tabBar.hidden = NO;
}
-(void)loadImage
{
   
    self.imageScroll.contentSize = CGSizeMake(self.view.frame.size.width * self.imageArray.count, 0);
    for (int i = 0; i < self.imageArray.count; i++)
    {
        FirstImage *images = self.imageArray[i];
        UIImageView *image = [[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width * i, 50, self.view.frame.size.width, self.view.frame.size.height / 2 + 50)]autorelease];
        NSLog(@"%@",images.imgurl);
        [image sd_setImageWithURL:[NSURL URLWithString:images.imgurl]placeholderImage:[UIImage imageNamed:@"place"]];
        [self.imageScroll addSubview:image];
        

    }
    FirstImage *content = self.imageArray[0];
   
    self.contentLabel.text = content.content;
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / CGRectGetWidth(scrollView.bounds);
    FirstImage *image = self.imageArray[index];
    self.contentLabel.text = image.content;
    NSLog(@"%@",image.title);
   
    
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
