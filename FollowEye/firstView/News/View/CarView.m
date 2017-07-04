

#import "CarView.h"

@implementation CarView

- (instancetype)initWithFrame:(CGRect)frame
{
    frame.origin.x = 0;
    frame.origin.y = 0;
    frame.size.width = CGRectGetWidth([UIScreen mainScreen].bounds);
    frame.size.height = 220;
    self = [super initWithFrame:frame];
    if (self)
    {
        
    }
    return self;
}
- (UIScrollView *)carSC
{
    if (!_carSC)
    {
        self.carSC = [[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 220)]autorelease];
        _carSC.contentSize = CGSizeMake(CGRectGetWidth(self.bounds)*5, 0);
        _carSC.showsHorizontalScrollIndicator =NO;
//        _carSC.backgroundColor = [UIColor greenColor];
        _carSC.pagingEnabled = YES;
        [self addSubview:self.label];
        [self addSubview:self.pageC];
        [self addSubview:_carSC];
//        if (self.delegate && [self.delegate respondsToSelector:@selector(getcarSC:)])
//        {
//            [self.delegate getcarSC:self.carSC];
//        }
        
    }
    return _carSC;
}
- (UILabel *)label
{
    if (!_label)
    {
        self.label = [[[UILabel alloc]initWithFrame:CGRectMake(5, 200, CGRectGetWidth(self.bounds)/3*2, 20)]autorelease];
        _label.adjustsFontSizeToFitWidth = YES;
//        _label.backgroundColor = [UIColor redColor];
        _label.textColor = [UIColor blackColor];
    }
    return _label;
    
}
- (UIPageControl *)pageC
{
    if (!_pageC)
    {
        self.pageC = [[[UIPageControl alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.bounds)/3*2 + 10, 200, CGRectGetWidth(self.bounds)/3 - 15, 20)]autorelease];
        _pageC.numberOfPages = 3;
        _pageC.tag = 2200;
        _pageC.pageIndicatorTintColor = [UIColor grayColor];
        _pageC.currentPageIndicatorTintColor = [UIColor blackColor];

    }
    return _pageC;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
