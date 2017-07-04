

#import "BaseScroller.h"


@interface BaseScroller()




@end

@implementation BaseScroller
-(void)dealloc
{
    [_technology release];
    [_tech release];
    [_fashion release];
    [_socity release];
    [_original release];
    [super dealloc];
}
-(TechnologyControllerTableViewController *)technology
{
    if (!_technology)
    {
        self.technology = [[[TechnologyControllerTableViewController alloc]initWithStyle:UITableViewStylePlain]autorelease];
        [self addSubview:_technology.tableView];
    }
    return _technology;
}
-(FashionController *)fashion
{
    if (!_fashion)
    {
        self.fashion = [[[FashionController alloc]initWithStyle:UITableViewStylePlain]autorelease];
        [self addSubview:_fashion.tableView];
    }
    return _fashion;
}
-(OriginalController *)original
{
    if (!_original)
    {
        self.original = [[[OriginalController alloc]initWithStyle:UITableViewStylePlain]autorelease];
        [self addSubview:_original.tableView];
        
    }
    return _original;
}
-(TeachController *)tech
{
    if (!_tech)
    {
        self.tech = [[[TeachController alloc]initWithStyle:UITableViewStylePlain]autorelease];
        [self addSubview:_tech.tableView];
    }
    return _tech;
}
-(SocietyController *)socity
{
    if (!_socity)
    {
        self.socity = [[[SocietyController alloc]initWithStyle:UITableViewStylePlain]autorelease];
        [self addSubview:_socity.tableView];
    }
    return _socity;
}
-(void)layoutSubviews
{
     [super layoutSubviews];
    CGFloat width = [UIScreen mainScreen].bounds.size.width ;
    
    CGFloat heigh = [UIScreen mainScreen].bounds.size.height - 100;
    self.technology.tableView.frame = CGRectMake(width, 94, width, heigh);
    self.socity.tableView.frame = CGRectMake(width * 2, 94, width, heigh);
    self.original.tableView.frame = CGRectMake(width * 3,94, width, heigh);
    self.tech.tableView.frame =CGRectMake(width * 4, 94, width, heigh);
    self.fashion.tableView.frame = CGRectMake(width * 5, 94, width, heigh);
}





















/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
