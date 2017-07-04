
#import "VideoCell.h"

@implementation VideoCell
-(void)dealloc
{
    [_VideoImage release];
    [_titleLabel release];
    [_contentLabel release];
    [super dealloc];
}
-(UIImageView *)VideoImage
{
    if (!_VideoImage)
    {
        self.VideoImage = [[[UIImageView alloc]init]autorelease];
        _VideoImage.frame = CGRectMake(5, 5, self.contentView.frame.size.width / 3, self.contentView.frame.size.height - 10);
        [self.contentView addSubview:_VideoImage];
    }
    return _VideoImage;
}
-(UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        self.titleLabel = [[[UILabel alloc]init]autorelease];
        _titleLabel.frame = CGRectMake(self.VideoImage.frame.size.width + 10, 5, self.contentView.frame.size.width / 3 * 1.8, self.contentView.frame.size.height * 2 / 3);
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:15];
     
        _titleLabel.numberOfLines = 0;
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}
-(UILabel *)contentLabel
{
    if (!_contentLabel)
    {
        self.contentLabel = [[[UILabel alloc]init]autorelease];
        _contentLabel.frame = CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.size.height + 8, self.titleLabel.frame.size.width,20);
        _contentLabel.font = [UIFont systemFontOfSize:10];
        _contentLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_contentLabel];
    }
    return _contentLabel;
}







- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
