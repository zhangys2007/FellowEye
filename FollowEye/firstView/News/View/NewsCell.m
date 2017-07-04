
#import "NewsCell.h"
#import "UIImageView+WebCache.h"

@implementation NewsCell
- (void)dealloc
{
    [_NewsImage release];
    [_NewsLabel release];
    [_NewsTitleLabel release];
    [super dealloc];
}
- (UIImageView *)NewsImage
{
    if (!_NewsImage)
    {
        self.NewsImage = [[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 80, 70)]autorelease];
        [self.contentView addSubview:_NewsImage];
    }
    return _NewsImage;
}
- (UILabel *)NewsTitleLabel
{
    if (!_NewsTitleLabel)
    {
        self.NewsTitleLabel = [[[UILabel alloc]initWithFrame:CGRectMake(90, 5, CGRectGetWidth(self.contentView.bounds) - 95, 30)]autorelease];
        _NewsTitleLabel.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:_NewsTitleLabel];
    }
    return _NewsTitleLabel;
}
- (UILabel *)NewsLabel
{
    if (!_NewsLabel)
    {
        self.NewsLabel = [[[UILabel alloc]initWithFrame:CGRectMake(90, 30, CGRectGetWidth(self.contentView.bounds) - 90, 45)]autorelease];
        _NewsLabel.textColor = [UIColor lightGrayColor];
    
        _NewsLabel.font = [UIFont systemFontOfSize:14];
        
        _NewsLabel.numberOfLines = 0;
        [self.contentView addSubview:_NewsLabel];
    }
    return _NewsLabel;
}

- (void)loadingDataWithModel:(NewsModel *)medel
{
    [self.NewsImage sd_setImageWithURL:[NSURL URLWithString:medel.imageName]placeholderImage:[UIImage imageNamed:@"place"]];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
