
#import "jokeImageCell.h"

@implementation jokeImageCell
- (void)dealloc
{
    [_image release];
    [_contentLabel release];
    [super dealloc];
}
-(UIImageView *)image
{
    if (!_image)
    {
        self.image = [[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, self.contentView.frame.size.width - 10, 400)]autorelease];
        [self.contentView addSubview:_image];
    }
    return _image;
}
-(UILabel *)contentLabel
{
    if (!_contentLabel)
    {
        self.contentLabel = [[UILabel alloc]init];
        _contentLabel.numberOfLines = 0;
        _contentLabel.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:_contentLabel];
    }
    return _contentLabel;
}
-(void)configureCellWithModel:(ControlHeight *)model
{
//    self.contentLabel.text = model.joke.content;
//    CGRect frame = self.contentLabel.frame;
//    frame.size.height = model.contentHeigh;
//    frame = CGRectMake(5, self.image.frame.size.height + 10, self.image.frame.size.width, model.contentHeigh);
//    self.contentLabel.frame = frame;
    self.contentLabel.text = model.joke.content;
    self.contentLabel.frame = CGRectMake(5, self.image.frame.size.height + 10,model.textRect.size.width, [model lastHeigh]);
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
