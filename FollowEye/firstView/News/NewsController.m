

#import "NewsController.h"
#import "CarouselModel.h"
#import "NewsCell.h"
#import "NetworkEngine.h"
#import "CarView.h"
#import "ThreeNewsCell.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "DetailController.h"
#import "imageItem.h"
#import "SocietyController.h"
#import "ImageController.h"
#import "cicleCell.h"
#import "ProgressHUD.h"
#import "VideoViewController.h"
#import "OtherDetailViewController.h"
#import "ZMYNetManager.h"

#define darkModeColor [UIColor colorWithRed:0.016 green:0.018 blue:0.017 alpha:1.000]
#define darkBarTintColor [UIColor colorWithRed:0.329 green:0.059 blue:0.075 alpha:1.000]
#define whiteModeColor [UIColor colorWithRed:0.922 green:0.922 blue:0.945 alpha:1.000]
#define whiteBarTintColor [UIColor colorWithRed:0.702 green:0.122 blue:0.145 alpha:1.000]
#define cellDarkModeColor [UIColor colorWithRed:0.186 green:0.204 blue:0.192 alpha:1.000]



#import "BaseScroller.h"

#define kNEWSURL @"http://c.m.163.com/nc/article/headline/%@/%d-20.html"
#define kScrollerView @"http://c.m.163.com/nc/ad/headline/%d-4.html"
@interface NewsController ()<UITableViewDataSource,UITableViewDelegate,NetworkEngineDelegate,UIScrollViewDelegate,CarView,SocietyControllerDelegate,technologDelegate,originaldelegate,techdelegate,fashionDelegate,SDCycleScrollViewDelegate>
@property(nonatomic,retain)UIScrollView *titleSV;
@property(nonatomic,retain)UILabel *naviLabel;
@property(nonatomic,retain)UITableView *newsTableView;
@property(nonatomic,retain)NSMutableArray *datasource;
@property(nonatomic,retain)NSMutableArray *carsource;
@property(nonatomic,retain)UIImageView *carsouseImage;
@property(nonatomic,retain)BaseScroller *newsSV;
@property(nonatomic,assign)int pageNumber;
@property(nonatomic ,retain)NSString *URLString;
@property(nonatomic ,retain)NSMutableArray *buttonArray;
@property(nonatomic ,retain)NSMutableArray *imageArray;
@property(nonatomic ,assign)int i;
@property(nonatomic ,assign)BOOL refresh;
@property(nonatomic ,retain)NSString *url;
@property(nonatomic ,retain)NSMutableArray *imageurl;
@property(nonatomic ,retain)NSMutableArray *imageurl1;
@property(nonatomic ,retain)NSMutableArray *titleurl;
@property(nonatomic ,retain)NSMutableArray *titleurl1;

-(void)loadingWithPage:(int)page;
@end
@implementation NewsController
-(void)dealloc
{
    [_titleSV release];
    [_naviLabel release];
    [_newsTableView release];
    [_datasource release];
    [_carsource release];
    [_carsouseImage release];
    [_newsSV release];
    [_URLString release];
    [_buttonArray release];
    [_imageArray release];
    [_url release];
    [_imageurl release];
    [_titleurl release];
    [_imageurl1 release];
    [_titleurl1 release];
    [super dealloc];
}
#pragma 懒加载++++++++++++++++++++++
-(NSMutableArray *)titleurl1
{
    if (!_titleurl1)
    {
        self.titleurl1 = [NSMutableArray array];
    }
    return _titleurl1;
}
-(NSMutableArray *)imageurl
{
    if (!_imageurl)
    {
        self.imageurl = [NSMutableArray array];
    }
    return _imageurl;
}
-(NSMutableArray *)imageurl1
{
    if (!_imageurl1)
    {
        self.imageurl1 = [NSMutableArray array];
    }
    return _imageurl1;
}

-(NSMutableArray *)titleurl
{
    if (!_titleurl)
    {
        self.titleurl = [NSMutableArray array];
    }
    return _titleurl;
}


-(NSMutableArray *)imageArray
{
    if (!_imageArray)
    {
        self.imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

-(NSMutableArray *)buttonArray
{
    if (!_buttonArray)
    {
        self.buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}


- (UIScrollView *)titleSV
{
    if (!_titleSV)
    {
        NSArray *array = @[@"头条",@"科技",@"社会",@"原创",@"教育",@"时尚"];
        self.titleSV = [[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), 30)]autorelease];
        _titleSV.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width / 4 * 6, 0);
        _titleSV.backgroundColor = [UIColor grayColor];
        _titleSV.showsHorizontalScrollIndicator = NO;
        _titleSV.tag = 10000;
        _titleSV.backgroundColor = [UIColor colorWithRed:255 / 255.0 green:255 / 255.0 blue:255 / 255.0 alpha:1];
        
        for (int i = 0; i < array.count; i++)
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 4 * i, 0, [UIScreen mainScreen].bounds.size.width / 4, 30) ;
            [button setTitle:array[i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            button.tag = 1000 + 100*i;
            [button addTarget:self action:@selector(handleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            button.showsTouchWhenHighlighted = YES;
//            button.layer.cornerRadius = 10;
//            button.backgroundColor = [UIColor redColor];
           
            [self.buttonArray addObject:button];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
             [self.titleSV addSubview:button];
        }
    }
    return _titleSV;
}
- (BaseScroller *)newsSV
{
    if (!_newsSV)
    {
        self.newsSV = [[[BaseScroller alloc]initWithFrame:self.view.bounds]autorelease];
        _newsSV.contentSize = CGSizeMake(CGRectGetWidth(self.view.bounds)*6, 40);
        _newsSV.pagingEnabled = YES;
        _newsSV.showsHorizontalScrollIndicator = NO;
        _newsSV.showsVerticalScrollIndicator = NO;
        _newsSV.delegate = self;
        _newsSV.pagingEnabled = YES;
        _newsSV.socity.delegate = self;
        [self addChildViewController:_newsSV.socity];
        _newsSV.technology.delegate = self;
        [self addChildViewController:_newsSV.technology];
        _newsSV.original.delegate =self;
        [self addChildViewController:_newsSV.original];
        _newsSV.tech.delegate = self;
        [self addChildViewController:_newsSV.tech];
        _newsSV.fashion.delegate = self;
        [self addChildViewController:_newsSV.fashion];
        
        [_newsSV layoutSubviews];

    }
    return _newsSV;
}

-(UITableView *)newsTableView
{
    if (!_newsTableView)
    {
        
        self.newsTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _newsTableView.frame = CGRectMake(0, 94, self.view.bounds.size.width, self.view.frame.size.height - 100);
        _newsTableView.showsVerticalScrollIndicator = NO;
        
    }
    return _newsTableView;
}
- (NSMutableArray *)datasource
{
    if (!_datasource)
    {
        self.datasource = [NSMutableArray array];
    }
    return _datasource;
}
- (NSMutableArray *)carsource
{
    if (!_carsource)
    {
        self.carsource = [NSMutableArray array];
    }
    return _carsource;
}



- (UIImageView *)carsouseImage
{
    if (!_carsouseImage)
    {
        self.carsouseImage = [[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 200)]autorelease];
        
    }
    return _carsouseImage;
}



#pragma 加载网络++++++++++++++++++++++++
- (void)loadingWithPage:(int)page
{
    NetworkEngine *netEngine = [NetworkEngine engineWithURL:[NSURL URLWithString:[NSString stringWithFormat:kNEWSURL,self.URLString,page]] parameters:nil delegate:self];
    netEngine.tag = 100;
    [netEngine start];
    NetworkEngine *anEngine = [NetworkEngine engineWithURL:[NSURL URLWithString:[NSString stringWithFormat:kScrollerView,page]] parameters:nil delegate:self];
    anEngine.tag = 101;
    [anEngine start];
}





- (void)viewDidLoad
{
    //第一次请求网络  需要的参数
    self.URLString = @"T1348647853363";
    [super viewDidLoad];
   //设置button设置属性
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor clearColor];
//给首页设置标题
    self.navigationItem.title = @"观世界";
    [self.view addSubview:self.newsSV];
    [self.newsSV addSubview:self.newsTableView];
    [self.view addSubview:self.titleSV];
    self.refresh = YES;
    
    
    for (int i = 0; i < self.buttonArray.count; i++)
    {
        [self.buttonArray[i] setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        
    }
    UIButton *button = (UIButton *)[self.view viewWithTag:1000];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
 
    [self.newsTableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(downLoadNews)];
    [self.newsTableView.header beginRefreshing];
    [self.newsTableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(upLoadNews)];
    self.newsTableView.footer.hidden = YES;
    self.newsTableView.dataSource = self;
    self.newsTableView.delegate = self;
    [self.newsTableView registerClass:[NewsCell class] forCellReuseIdentifier:@"cell"];
    [self.newsTableView registerClass:[cicleCell class] forCellReuseIdentifier:@"cicle"];
    [self.newsTableView registerClass:[ThreeNewsCell class] forCellReuseIdentifier:@"Cell"];

}
#pragma mark 夜间模式
-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"+++++++++++++++++++++++++++999999999");
    [super viewWillAppear:animated];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    if ([user boolForKey:@"nightSwitch"]) {
        self.newsTableView.backgroundColor = [UIColor darkGrayColor];
        self.view.backgroundColor = [UIColor darkGrayColor];
        self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
        self.navigationController.navigationBar.barTintColor = darkBarTintColor;
        self.tabBarController.tabBar.barTintColor = darkBarTintColor;
        self.tabBarController.tabBar.tintColor = [UIColor whiteColor];
        self.titleSV.backgroundColor = [UIColor lightGrayColor];
        
        
        
    } else {
        self.newsTableView.backgroundColor = [UIColor whiteColor];
        self.view.backgroundColor = [UIColor whiteColor];
        self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
        self.view.backgroundColor = [UIColor whiteColor];
        self.navigationController.navigationBar.barTintColor = whiteBarTintColor;
        self.tabBarController.tabBar.barTintColor = whiteBarTintColor;
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        self.tabBarController.tabBar.tintColor = [UIColor whiteColor];
        self.titleSV.backgroundColor = [UIColor whiteColor];
        
    }
    [self.newsTableView reloadData];
    
}


#pragma  mark 请求网络
- (void)networkDidFinishLoading:(NetworkEngine *)engine withInfo:(id)info{
    if (!info)
    {
        return;
    }
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:info options:NSJSONReadingMutableContainers error:nil];
    [self.newsTableView.header endRefreshing];
    [self.newsTableView.footer endRefreshing];
   
    
    if (engine.tag == 100) {
        
        
        if (self.pageNumber == 0)
        {
            [self.datasource removeAllObjects];
            [self.carsource removeAllObjects];
        }
        self.pageNumber += 20;
        
        
        NSArray *carousItem = dict[self.URLString];
        if (self.refresh)
        {
            if (self.carsource > 0)
            {
                [self.imageurl removeAllObjects];
                [self.titleurl removeAllObjects];
            }
        }
        
        for (NSDictionary *dic in carousItem)
        {
            if ([dic[@"template"] isEqualToString:@"manual"])
            {
                CarouselModel *carItem = [CarouselModel carouseWithDictionary:dic];
                self.url = carItem.url;
                [self.carsource addObject:carItem];
                NSURL *url = [NSURL URLWithString:carItem.imageName];
                
                NSString *title = carItem.titleName;
                
                [self.titleurl addObject:title];
                [self.imageurl addObject:url];
                NSLog(@"%@+++++++++++++++++++++++++",self.titleurl.lastObject);
                 NSLog(@"%ld",self.titleurl.count);
            }
           
            else
            {
                NewsModel *newsItem = [NewsModel newsWithDictionary:dic];
                [self.datasource addObject:newsItem];
            }
        }

        
        
    }
    
    
    
    if (engine.tag == 101)
    {
        NSArray *array = dict[@"headline_ad"];
        if (self.refresh)
        {
            if (self.imageurl1.count > 0)
            {
                [self.imageurl1 removeAllObjects];
                [self.titleurl1 removeAllObjects];
            }
        }
        
        for (NSDictionary *adic in array)
        {
            imageItem *imageGroup = [imageItem imageWithDictionary:adic];
            [self.imageArray addObject:imageGroup];
            NSURL *img = [NSURL URLWithString:imageGroup.image];
            NSString *titles = imageGroup.title;
            [self.titleurl1 addObject:titles];
            
            [self.imageurl1 addObject:img];
            NSLog(@"%ld",self.imageurl1.count);
        }
    }
    [self.newsTableView reloadData];

}




#pragma mark 代理传值的方法
-(void)getTapCell:(NewsModel *)model withMark:(int)mark
{
    DetailController *deatil = [[[DetailController alloc]init]autorelease];
    ImageController *image = [[[ImageController alloc]init]autorelease];

    if (model.url_3w)
    {
      
        deatil.url = model.docid;
        deatil.count = 1;
        [self.navigationController pushViewController:deatil animated:YES];
    }else if(!model.url_3w)
    {
        image.mark = mark;
        image.imageURL = model.url;
        NSLog(@"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++%@",model.url);
        NSLog(@"%d",mark);
        [self.navigationController pushViewController:image animated:YES];
    }
    
}

-(void)PassValue:(UITapGestureRecognizer *)model withInfo:(CarouselModel *)info withMark:(int)mark
{
    DetailController *detail = [[[DetailController alloc]init]autorelease];
    ImageController *image = [[[ImageController alloc]init]autorelease];
    if (info.url_3w)
    {
        detail.url = info.docid;
        [self.navigationController pushViewController:detail animated:YES];
    }else
    {
        image.imageURL = info.url;
        [self.navigationController pushViewController:image animated:YES];
        image.mark = mark;
        NSLog(@"%@",info.url);
        
    }
    
    NSLog(@"正在执行这个方法");
    
}
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    ImageController *img = [[[ImageController alloc]init]autorelease];
    DetailController *detail = [[[DetailController alloc]init]autorelease];
    
    if (index == 0)
    {
        CarouselModel *model = self.carsource[index];
        if (model.url_3w)
        {
            detail.url = model.docid;
            [self.navigationController pushViewController:detail animated:YES];
        }else
        {
            [self.navigationController pushViewController:img animated:YES];
            img.imageURL = model.url;
            NSLog(@"%@",img.imageURL);
            
        }
        
        
        
    }
    else if(index > 0)
    {
        imageItem *image = self.imageArray[index - 1];
        img.cellURL = image.url;
        NSLog(@"%@++++++++++++++++++++++++++++++",image.url);
        if (image.url_3w)
        {
            NSString *str = [[image.url componentsSeparatedByString:@"|" ] lastObject];
            detail.url = str;
            detail.count = 1;
            
            [self.navigationController pushViewController:detail animated:YES];
        }else
        {
            if ([image.url containsString:@"|"])
            {
                [self.navigationController pushViewController:img animated:YES];
                NSString *str = [[image.url componentsSeparatedByString:@"|"]lastObject];
                img.imageURL = str;
                img.mark = 0;
                NSLog(@"%@",img.imageURL);
            }else
            {
                detail.count = 0;
                detail.url = image.url;
                [self.navigationController pushViewController:detail animated:YES];
            }
            
            
        }

        
    }

    
       
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma tableView的datasource
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.newsTableView.footer.hidden = NO;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsModel *model = self.datasource[indexPath.row];
    if (indexPath.row == 0)
    {
        return 200;
    }
    if (model.imagextraName.count == 2)
    {
        return 115;
    }
    return 80;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datasource.count;
}
-(void)noLineNet
{
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsModel *newsItem = self.datasource[indexPath.row];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    if (indexPath.row == 0)
    {
        cicleCell *ciclecell = [tableView dequeueReusableCellWithIdentifier:@"cicle" forIndexPath:indexPath];
        ciclecell.cicle.delegate = self;
        NSMutableArray *array = [NSMutableArray array];
         [array addObjectsFromArray:self.imageurl];
        [array addObjectsFromArray:self.imageurl1];
                NSMutableArray *titleArray = [NSMutableArray array];
        [titleArray addObjectsFromArray:self.titleurl];
        [titleArray addObjectsFromArray:self.titleurl1];
        ciclecell.cicle.titlesGroup = titleArray;
        ciclecell.cicle.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        ciclecell.cicle.placeholderImage = [UIImage imageNamed:@"place"];
        if ([[NSUserDefaults standardUserDefaults]boolForKey:@"wifiSwitchState"])
        {
            if ([ZMYNetManager shareZMYNetManager].isZMYNetWorkRunning == YES)
            {
                ciclecell.cicle.imageURLsGroup = array;

                
            }else
            {
                NSMutableArray *image = [NSMutableArray array];
                UIImage *images = [UIImage imageNamed:@"place"];
                [image addObject:images];
                ciclecell.cicle.localizationImagesGroup =image;
            }
            
        }else
        {
            ciclecell.cicle.imageURLsGroup = array;
        }

        ciclecell.cicle.autoScrollTimeInterval = 3;
       
    
    } else if (newsItem.imagextraName.count == 2)
    {
        ThreeNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
        if ([user boolForKey:@"nightSwitch"]) {
            cell.backgroundColor = cellDarkModeColor;
            cell.titleLabel.textColor = [UIColor whiteColor];
        }else
        {
            cell.backgroundColor = [UIColor whiteColor];
            cell.titleLabel.textColor = [UIColor blackColor];
        }
        cell.titleLabel.text = newsItem.titleName;
        if ([[NSUserDefaults standardUserDefaults]boolForKey:@"wifiSwitchState"])
        {
            if ([ZMYNetManager shareZMYNetManager].isZMYNetWorkRunning == YES)
            {
                [cell loadingThreeNewsDataWithModel:newsItem];

            }else
            {
                cell.oneView.image = [UIImage imageNamed:@"place"];
                cell.twoView.image = [UIImage imageNamed:@"place"];
                cell.threeView.image = [UIImage imageNamed:@"place"];
            }
            
        }else
        {
            [cell loadingThreeNewsDataWithModel:newsItem];
        }
        return cell;
    }
        NewsCell *cells = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if ([user boolForKey:@"nightSwitch"]) {
        cells.backgroundColor = cellDarkModeColor;
        cells.NewsLabel.textColor = [UIColor whiteColor];
        cells.NewsTitleLabel.textColor = [UIColor whiteColor];
    }else
    {
        cells.backgroundColor = [UIColor whiteColor];
        cells.NewsTitleLabel.textColor = [UIColor blackColor];
        cells.NewsLabel.textColor = [UIColor blackColor];
    }
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"wifiSwitchState"])
    {
        if ([ZMYNetManager shareZMYNetManager].isZMYNetWorkRunning == YES)
        {
            [cells loadingDataWithModel:newsItem];
            
        }else
        {
            cells.NewsImage.image = [UIImage imageNamed:@"place"];
        }
        
    }else
    {
        [cells loadingDataWithModel:newsItem];
    }

    
    cells.NewsTitleLabel.text = newsItem.titleName;
    cells.NewsLabel.text = newsItem.digestName;
    
    
    
    
    return cells;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailController *detailC = [[[DetailController alloc]init]autorelease];
    ImageController *image = [[[ImageController alloc]init]autorelease];
   
    VideoViewController *video = [[[VideoViewController alloc]init]autorelease];
    OtherDetailViewController *other = [[[OtherDetailViewController alloc]init]autorelease];
    NewsModel *new = self.datasource[indexPath.row];
//    imageItem *item = self.datasource[indexPath.row];
    
    if (new.url_3w)
    {
        if ([new.url_3w isEqualToString:nil])
        {
            
            detailC.url = new.docid;
            other.str = new.docid;
            [self.navigationController pushViewController:detailC animated:YES];
            NSLog(@"%@",new.urls);
           
        }else  if (![new.url_3w isEqualToString:nil])
        {
            detailC.url = new.docid;
            other.str = new.docid;
            
            NSLog(@"%@",new.url_3w);
            
            [self.navigationController pushViewController:detailC animated:YES];
        
        }
        
    }else if(!new.url_3w)
    {
        if ([new.skipType isEqualToString:@"photoset"]) {
            image.cellURL = new.url;
            image.mark = 10;
            NSLog(@"%@",new.url);
            [self.navigationController pushViewController:image animated:YES];

        }else if ([new.skipType isEqualToString:@"video"])
        {
            
            video.item = new;
            [self.navigationController pushViewController:video animated:YES];
            
            
        }
        
    }
   
       // else if(new.url_3w && [new.url_3w isEqualToString:nil])
//    {
//            detailC.url = new.urls;
//        [self.navigationController pushViewController:detailC animated:YES];
//    }
    
    
}

#pragma 轮播图上的Button的响应方法

-(void)handleButtonAction:(UIButton *)sender
{
    
    [self _handle:sender];
}
-(void)_handle:(UIButton *)sender
{
    int a = 0;
    for (int i = 0; i < self.buttonArray.count; i++)
    {
        if ([sender isEqual:self.buttonArray[i]])
        {
            a = i;
            [UIView animateWithDuration:0.5 animations:^{
                self.newsSV.contentOffset = CGPointMake(self.view.frame.size.width * i, 0);
            }];
        }
    }
    for (int i = 0; i < self.buttonArray.count; i++)
    {
        if (a != i)
        {
            UIButton *button = self.buttonArray[i];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            
            
            
            
        }else if(a == i)
        {
            UIButton *abutton = self.buttonArray[a];
            [abutton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        }
    }
    if (sender == self.buttonArray[3])
    {
        UIScrollView *soc = (UIScrollView *)[self.view viewWithTag:10000];
        [soc setContentOffset:CGPointMake(200, 0) animated:YES];
    }else if (sender == self.buttonArray[2])
    {
        UIScrollView *soc = (UIScrollView *)[self.view viewWithTag:10000];
        [soc setContentOffset:CGPointMake(0, 0) animated:YES];
        
    }
    
    
}



#pragma scorolerView的代理方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
            if (scrollView == self.newsSV)
        {
            int  bigIndex = scrollView.contentOffset.x / CGRectGetWidth(scrollView.bounds);
            //nslog(@"%d",bigIndex);
            for (int i = 0; i < 5; i++)
            {
                
                for (int i = 0; i < 6; i++)
                {
                    if (bigIndex != i)
                    {
                        UIButton *button = self.buttonArray[i];
                        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    }else if(bigIndex == i)
                    {
                        UIButton *abutton = self.buttonArray[bigIndex];
                        [abutton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
                        //nslog(@"！！！！！！！！！！！！！！！！！！！！");
                        
                        
                    }
                }

            }
            
            
            if (bigIndex > 3)
            {
                [self.titleSV setContentOffset:CGPointMake(200, 0) animated:YES];
            }else if (bigIndex < 4)
            {
                [self.titleSV setContentOffset:CGPointMake(0, 0) animated:YES];
            }

            
        }

}

#pragma 上提加载，下拉刷新
-(void)downLoadNews
{
  

    self.pageNumber = 0;
    [self loadingWithPage:self.pageNumber];
    self.refresh = YES;
    
}
-(void)upLoadNews
{
   
   
   
        [self loadingWithPage:self.pageNumber];
    self.refresh = NO;
    
}

@end
