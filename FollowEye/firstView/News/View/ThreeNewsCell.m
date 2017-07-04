

#import "ThreeNewsCell.h"
#import "UIImageView+WebCache.h"


@implementation ThreeNewsCell
- (void)dealloc
{
    [_oneView release];
    [_twoView release];
    [_threeView release];
    [_titleLabel release];
    [super dealloc];
}
- (UIImageView *)oneView
{
    if (!_oneView)
    {
        self.oneView = [[[UIImageView alloc]initWithFrame:CGRectMake(5, 25, (self.contentView.bounds.size.width - 20) / 3, 80)]autorelease];
        [self.contentView addSubview:_oneView];
    }
    return _oneView;
}
- (UIImageView *)twoView
{
    if (!_twoView)
    {
        self.twoView = [[[UIImageView alloc]initWithFrame:CGRectMake(10 + CGRectGetWidth(self.oneView.bounds), 25, (self.contentView.bounds.size.width - 20) / 3, 80)]autorelease];
        [self.contentView addSubview:_twoView];
    }
    return _twoView;
}
- (UIImageView *)threeView
{
    if (!_threeView)
    {
        self.threeView = [[[UIImageView alloc]initWithFrame:CGRectMake(15 + CGRectGetWidth(self.twoView.bounds) * 2, 25, (self.contentView.bounds.size.width - 20) / 3, 80)]autorelease];
        
        [self.contentView addSubview:_threeView];
    }
    return _threeView;
}
- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel.font = [UIFont systemFontOfSize:15];
        self.titleLabel = [[[UILabel alloc]initWithFrame:CGRectMake(5, 0, CGRectGetWidth(self.contentView.bounds)-10, 20)]autorelease ];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}
- (void)loadingThreeNewsDataWithModel:(NewsModel *)model
{
    [self.oneView sd_setImageWithURL:[NSURL URLWithString:model.imageName]placeholderImage:[UIImage imageNamed:@"place"]];
    for (int i = 0; i < model.imagextraName.count; i++)
    {
        NSMutableDictionary *dict = [[[NSMutableDictionary alloc]init]autorelease];
        dict = model.imagextraName[i];
        if (i == 0)
        {
            [self.twoView sd_setImageWithURL:[NSURL URLWithString:dict[@"imgsrc"]]placeholderImage:[UIImage imageNamed:@"place"]];
        }
        else 
        {
            [self.threeView sd_setImageWithURL:[NSURL URLWithString:dict[@"imgsrc"]]placeholderImage:[UIImage imageNamed:@"place"]];
        }
    }
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
