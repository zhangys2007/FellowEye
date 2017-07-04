
#import "FashionController.h"
#define kNEWSURL @"http://c.m.163.com/nc/article/headline/T1348650593803/%d-20.html"
#import "TechnologyControllerTableViewController.h"
#import "ThreeNewsCell.h"
#import "NewsCell.h"
#import "CarView.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "DetailController.h"
#import "NetworkEngine.h"
#import "NewsModel.h"
#import "ProgressHUD.h"
#import "ZMYNetManager.h"
#define darkModeColor [UIColor colorWithRed:0.016 green:0.018 blue:0.017 alpha:1.000]
#define darkBarTintColor [UIColor colorWithRed:0.329 green:0.059 blue:0.075 alpha:1.000]
#define whiteModeColor [UIColor colorWithRed:0.922 green:0.922 blue:0.945 alpha:1.000]
#define whiteBarTintColor [UIColor colorWithRed:0.702 green:0.122 blue:0.145 alpha:1.000]
#define cellDarkModeColor [UIColor colorWithRed:0.186 green:0.204 blue:0.192 alpha:1.000]


@interface FashionController ()<NetworkEngineDelegate>
@property(nonatomic,retain)UILabel *naviLabel;
@property(nonatomic,retain)UITableView *newsTableView;
@property(nonatomic,retain)NSMutableArray *datasource;
@property(nonatomic,retain)NSMutableArray *carsource;
@property(nonatomic,assign)int pageNumber;
@property(nonatomic,retain)UIImageView *carsouseImage;
-(void)loadingWithPage:(int)page;

@end

@implementation FashionController
-(void)dealloc
{
    
    [_naviLabel release];
    [_newsTableView release];
    [_datasource release];
    [_carsource release];
    [_carsouseImage release];
    [super dealloc];
}
- (UILabel *)naviLabel
{
    if (!_naviLabel)
    {
        self.naviLabel = [[[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width / 2 - 40, 5, 80, 35)]autorelease];
        _naviLabel.text = @"观世界";
        _naviLabel.font = [UIFont systemFontOfSize:20];
        _naviLabel.adjustsFontSizeToFitWidth = YES;
        _naviLabel.textColor = [UIColor whiteColor];
        
    }
    return _naviLabel;
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
- (void)loadingWithPage:(int)page
{
    NetworkEngine *netEngine = [NetworkEngine engineWithURL:[NSURL URLWithString:[NSString stringWithFormat:kNEWSURL,page]] parameters:nil delegate:self];
    [netEngine start];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}





- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor clearColor];
    [self.navigationController.navigationBar addSubview:self.naviLabel];
    
    
    
    UIButton *button = (UIButton *)[self.view viewWithTag:1000];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    
    
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    
    [self.tableView  registerClass:[NewsCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[ThreeNewsCell class] forCellReuseIdentifier:@"Cell"];
    
    
    self.pageNumber = 0;
    
    [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(downLoadNews)];
    [self.tableView.header beginRefreshing];
    [self.tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(upLoadNews)];
}
- (void)networkDidFinishLoading:(NetworkEngine *)engine withInfo:(id)info{
    if (!info)
    {
        [ProgressHUD showError:@"加载失败"];
        return;
        
    }
    [self.tableView.header endRefreshing];
    [self.tableView.footer endRefreshing];
    if (self.pageNumber == 0)
    {
        [self.datasource removeAllObjects];
        [self.carsource removeAllObjects];
    }
    self.pageNumber += 20;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:info options:NSJSONReadingMutableContainers error:nil];
    NSArray *carousItem = dict[@"T1348650593803"];
    for (NSDictionary *dic in carousItem)
    {
        if ([dic[@"template"] isEqualToString:@"manual"])
        {
            CarouselModel *carItem = [CarouselModel carouseWithDictionary:dic];
            [self.carsource addObject:carItem];
            //            NSLog(@"%@",carItem.titleName);
            for (int i = 0; i < self.carsource.count; i++)
            {
                CarouselModel *carouseItem = self.carsource[i];
                CarView *carV = [[CarView alloc]init];
                [self.carsouseImage sd_setImageWithURL:[NSURL URLWithString:carouseItem.imageName]];
                carV.label.text = carouseItem.titleName;
//                NSLog(@"%@",carouseItem.titleName);
            }
            
        }
        else
        {
            NewsModel *newsItem = [NewsModel newsWithDictionary:dic];
            [self.datasource addObject:newsItem];
        }
    }
    [self.tableView reloadData];
//    NSLog(@"%@",self.carsource);
    
}
- (void)play{
    
    if (self.carsource.count != 0)
    {
        CarouselModel *carouseItem = (CarouselModel *)self.carsource[0];
        CarView *caView = [[CarView alloc] initWithFrame:CGRectZero];
        [caView addSubview:self.carsouseImage];
        [self.carsouseImage sd_setImageWithURL:[NSURL URLWithString:carouseItem.imageName]];
        
        
        UITapGestureRecognizer *tap = [[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)]autorelease];
        [caView addGestureRecognizer:tap];
        
        caView.label.text = carouseItem.titleName;
        [caView addSubview:caView.label];
        
        
        self.tableView.tableHeaderView = caView;
    }
}
-(void)tapAction:(UITapGestureRecognizer *)tap
{
    int i = 2;
    CarouselModel *model = self.carsource[0];
    if (self.delegate && [self.delegate respondsToSelector:@selector(PassValue:withInfo:withMark:)])
    {
        [self.delegate PassValue:tap withInfo:model withMark:i];
    }
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    [self play];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    return self.datasource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    NewsModel *newsItem = self.datasource[indexPath.row];
       NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    if (newsItem.imagextraName.count == 2)
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
        
        

        

        
        
        cell.titleLabel.text = newsItem.titleName;
        
        return cell;
    }
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if ([user boolForKey:@"nightSwitch"]) {
        cell.backgroundColor = cellDarkModeColor;
        cell.NewsLabel.textColor = [UIColor whiteColor];
        cell.NewsTitleLabel.textColor = [UIColor whiteColor];
    }else
    {
        cell.backgroundColor = [UIColor whiteColor];
        cell.NewsTitleLabel.textColor = [UIColor blackColor];
        cell.NewsLabel.textColor = [UIColor blackColor];
    }
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"wifiSwitchState"])
    {
        if ([ZMYNetManager shareZMYNetManager].isZMYNetWorkRunning == YES)
        {
            [cell loadingDataWithModel:newsItem];
            
        }else
        {
            cell.NewsImage.image = [UIImage imageNamed:@"place"];
        }
        
    }else
    {
        [cell loadingDataWithModel:newsItem];
    }
    

    
    cell.NewsTitleLabel.text = newsItem.titleName;
    cell.NewsLabel.text = newsItem.digestName;
  
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsModel *model = self.datasource[indexPath.row];
    if (model.imagextraName.count == 2)
    {
        return 115;
    }
    return 80;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    DetailController *detailC = [[[DetailController alloc]init]autorelease];
//    UINavigationController *navi = [[[UINavigationController alloc]initWithRootViewController:detailC]autorelease];
//    [self presentViewController:navi animated:YES completion:nil];
    int i = 2;
    if (self.delegate && [self.delegate respondsToSelector:@selector(getTapCell:withMark:)])
    {
        [self.delegate getTapCell:self.datasource[indexPath.row] withMark:i];
    }
    
    
    
    
    
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    
    NSInteger index = scrollView.contentOffset.x / CGRectGetWidth(scrollView.bounds);
    UIPageControl *pageControl = (UIPageControl *) [self.view viewWithTag:200];
    pageControl.currentPage =index;
}
-(void)downLoadNews
{
    //    self.newsTableView.headerRefreshingText = @"刷新中";
    self.pageNumber = 0;
    [self loadingWithPage:self.pageNumber];
}
-(void)upLoadNews
{
    //    self.newsTableView.footerRefreshingText = @"加载中";
    
    [self loadingWithPage:self.pageNumber];
    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
