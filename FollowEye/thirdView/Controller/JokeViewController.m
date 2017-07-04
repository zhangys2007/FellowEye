

#import "JokeViewController.h"
#import "jokeTextCell.h"
#import "jokeImageCell.h"
#import "NetworkEngine.h"
#import "ControlHeight.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "ZMYNetManager.h"
#define darkModeColor [UIColor colorWithRed:0.016 green:0.018 blue:0.017 alpha:1.000]
#define darkBarTintColor [UIColor colorWithRed:0.329 green:0.059 blue:0.075 alpha:1.000]
#define whiteModeColor [UIColor colorWithRed:0.922 green:0.922 blue:0.945 alpha:1.000]
#define whiteBarTintColor [UIColor colorWithRed:0.702 green:0.122 blue:0.145 alpha:1.000]
#define cellDarkModeColor [UIColor colorWithRed:0.186 green:0.204 blue:0.192 alpha:1.000]

@interface JokeViewController ()<NetworkEngineDelegate>
@property(nonatomic ,retain)NSMutableArray *datasource;
@property(nonatomic ,assign)int numberPage;


@end

@implementation JokeViewController
-(void)dealloc
{
    [_datasource release];
    [super dealloc];
}

-(void)loadData:(int)page;
{
    NetworkEngine *anengine = [NetworkEngine engineWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://c.3g.163.com/recommend/getChanListNews?passport=&devId=865703023590758&size=%d&channel=duanzi",page]] parameters:nil delegate:self];
    [anengine start];
}
-(NSMutableArray *)datasource
{
    if (!_datasource)
    {
        self.datasource = [NSMutableArray array];
    }
    return _datasource;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectZero;
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = left;
    [left release];
    [self.tableView registerClass:[jokeTextCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[jokeImageCell class] forCellReuseIdentifier:@"Cell"];
    self.numberPage = 20;
//    [self loadData:self.numberPage];
    [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(upFresh)];
    [self.tableView.header beginRefreshing];
    [self.tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(downLoad)];
   
    self.tableView.footer.hidden = YES;
    self.title = @"轻松一刻";
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)viewWillAppear:(BOOL)animated
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    if ([user boolForKey:@"nightSwitch"]) {
        self.view.backgroundColor = [UIColor darkGrayColor];
        self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
        self.navigationController.navigationBar.barTintColor = darkBarTintColor;
        self.tabBarController.tabBar.barTintColor = darkBarTintColor;
        self.tabBarController.tabBar.tintColor = [UIColor whiteColor];
        
        
        
    } else {
        self.view.backgroundColor = [UIColor whiteColor];
        self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
        self.view.backgroundColor = [UIColor whiteColor];
        self.navigationController.navigationBar.barTintColor = whiteBarTintColor;
        self.tabBarController.tabBar.barTintColor = whiteBarTintColor;
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        self.tabBarController.tabBar.tintColor = [UIColor whiteColor];
        
    }
    [self.tableView reloadData];
    
    
}
-(void)networkDidFinishLoading:(NetworkEngine *)engine withInfo:(id)info
{
    
    [self.tableView.header endRefreshing];
    [self.tableView.footer endRefreshing];
    if (self.numberPage == 20)
    {
        [self.datasource removeAllObjects];
    }
    self.numberPage += 20;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:info options:NSJSONReadingMutableContainers error:nil];
    NSArray *array = dic[@"段子"];
    for (NSDictionary *dict in array)
    {
        ControlHeight *item = [ControlHeight controlWithDictionary:dict];
        [self.datasource addObject:item];
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

    
    return self.datasource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    ControlHeight *item = self.datasource[indexPath.section];
    if (!item.joke.image)
    {
        jokeTextCell *textcell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        if ([user boolForKey:@"nightSwitch"]) {
            textcell.backgroundColor = darkModeColor;
           textcell.contentLabel.textColor = [UIColor whiteColor];
        }else
        {
            textcell.backgroundColor = [UIColor whiteColor];
            textcell.contentLabel.textColor = [UIColor blackColor];
        }
        [textcell configureCellWithModel:item];
        return textcell;
    }else if(item.joke.image)
    {
        jokeImageCell *imagecell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
        if ([[NSUserDefaults standardUserDefaults]boolForKey:@"wifiSwitchState"])
        {
            if ([ZMYNetManager shareZMYNetManager].isZMYNetWorkRunning == YES)
            {
                [imagecell.image sd_setImageWithURL:[NSURL URLWithString:item.joke.image]placeholderImage:[UIImage imageNamed:@"place"]];
            }else
            {
                imagecell.image.image = [UIImage imageNamed:@"place"];
            }
        }else
        {
            [imagecell.image sd_setImageWithURL:[NSURL URLWithString:item.joke.image]placeholderImage:[UIImage imageNamed:@"place"]];
        }
        
        if ([user boolForKey:@"nightSwitch"]) {
            imagecell.backgroundColor = darkModeColor;
            imagecell.contentLabel.textColor = [UIColor whiteColor];
        }else
        {
            imagecell.backgroundColor = [UIColor whiteColor];
           imagecell.contentLabel.textColor = [UIColor blackColor];
        }

       
        [imagecell configureCellWithModel:item];
        return imagecell;
        
    }
   
    
    
    
    
    
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ControlHeight *item = self.datasource[indexPath.section];
    if (!item.joke.image)
    {
        return [item lastHeigh] + 20;
       
        
    }else if(item.joke.image)
    {
        return [item lastHeigh] + 400 +20;
        
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

-(void)upFresh
{
 
    self.numberPage = 20;
    [self loadData:self.numberPage];
}
-(void)downLoad

{
    [self loadData:self.numberPage];
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
