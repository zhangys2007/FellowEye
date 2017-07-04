
#import "AudioVisualTableViewController.h"
#import "NetworkEngine.h"
#import "AudioVisualViewCell.h"
#import "LoadingCell.h"
#import "MovieViewController.h"
#import "JokeViewController.h"
#import "ProgressHUD.h"
#import "MJRefresh.h"
#define darkModeColor [UIColor colorWithRed:0.016 green:0.018 blue:0.017 alpha:1.000]
#define darkBarTintColor [UIColor colorWithRed:0.329 green:0.059 blue:0.075 alpha:1.000]
#define whiteModeColor [UIColor colorWithRed:0.922 green:0.922 blue:0.945 alpha:1.000]
#define whiteBarTintColor [UIColor colorWithRed:0.702 green:0.122 blue:0.145 alpha:1.000]
#define cellDarkModeColor [UIColor colorWithRed:0.186 green:0.204 blue:0.192 alpha:1.000]

//#import "MJMoviePlayerViewController.h"



//每10条为一页，在当前条的基础上添加10个
#define AudioVisualTextAPI @"http://c.m.163.com/nc/video/list/V9LG4B3A0/y/%d-10.html"
@interface AudioVisualTableViewController ()<NetworkEngineDelegate>
@property (nonatomic,retain) NSMutableArray *dataSource;
-(void)_startLoadingDataWithPage:(int)page;
@property (nonatomic,assign) int pageNumber;
@property(nonatomic ,retain)NSString *playurl;
@end

@implementation AudioVisualTableViewController
-(void)dealloc {
    [_dataSource release];
    [_playurl release];
    [super dealloc];
}

-(NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray array];
    }
    return _dataSource;
}


- (void)_startLoadingDataWithPage:(int)page{
    NetworkEngine *engine = [NetworkEngine engineWithURL:[NSURL URLWithString:[NSString stringWithFormat:AudioVisualTextAPI,page]] parameters:nil delegate:self];
    [engine start];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    
    [self.tableView registerClass:[AudioVisualViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[LoadingCell class] forCellReuseIdentifier:@"loading"];
    self.pageNumber = 0;
    [self _startLoadingDataWithPage:0];
    [ProgressHUD show:@"正在加载中" Interaction:YES];
    
    [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    [self _startLoadingDataWithPage:self.pageNumber];
    [self.tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    self.title = @"视听";
    self.tableView.footer.hidden = YES;
   
}


-(void)headerRefresh
{
    self.pageNumber = 0;
    [self _startLoadingDataWithPage:self.pageNumber];
}
-(void)footerRefresh
{
    [self _startLoadingDataWithPage:self.pageNumber];
}

//上提自增

-(void)networkDidFinishLoading:(NetworkEngine *)engine withInfo:(id)info
{
    [self.tableView.header endRefreshing];
    [self.tableView.footer endRefreshing];
    if (!info)
    {
        [ProgressHUD showError:@"数据加载失败"];
        return;
        
    }
    [ProgressHUD dismiss];
    [self.refreshControl endRefreshing];//结束刷新
    if (self.pageNumber == 0) {
        [self.dataSource removeAllObjects];
    }
    self.pageNumber += 10;
    //nslog(@"~~~~~~~~~~~~~pageNumber:%d",self.pageNumber);
    
    //JSON解析
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:info options:NSJSONReadingMutableContainers error:nil];//info!!
    
    NSArray *items = dict[@"V9LG4B3A0"];
    //在数组中遍历字典
    for (NSDictionary *dict in items) {
        AudioVisualItem *model = [AudioVisualItem itemWithDictionary:dict];
        [self.dataSource addObject:model];
        //nslog(@"%@",self.dataSource);
    
    }
    [self.tableView reloadData];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.tableView.footer.hidden = NO;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    if (self.dataSource.count == 0) {
        return 0;
    }
    return self.dataSource.count ;//!!
  

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 70 + CGRectGetWidth(self.view.bounds) * 270 / 480;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AudioVisualViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
   
    cell.videoImage.tag = 2353;
    cell.videoImage.userInteractionEnabled = YES;
    NSLog(@"%@",cell.videoImage);
    
   
    
    
    //在单元格中调用model中的方法
    AudioVisualItem *model = self.dataSource[indexPath.row];
    [cell configureCellWithModel:model];
    return cell;
}



//点击某个单元格会响应相应方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieViewController *movie = [[MovieViewController alloc]init];
    AudioVisualItem *items = self.dataSource[indexPath.row];
    movie.item =items;
    movie.appendingStr = items.vid;
    self.playurl = movie.item.mp4_url;
    
    [self.navigationController pushViewController:movie animated:YES];
    [movie release];
    


    
    
}


//- (void)moviePlayerDidFinished {
//    [self.movie.view removeFromSuperview];
//}


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
