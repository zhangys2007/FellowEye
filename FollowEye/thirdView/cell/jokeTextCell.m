

#import "jokeTextCell.h"


@implementation jokeTextCell
-(void)dealloc
{
    [_buttonLabel release];
    [_contentLabel release];
    [super dealloc];
}
-(UILabel *)contentLabel
{
    if (!_contentLabel)
    {
        self.contentLabel = [[[UILabel alloc]init]autorelease];
        _contentLabel.numberOfLines = 0;
        _contentLabel.adjustsFontSizeToFitWidth = YES;
//        _contentLabel.frame = CGRectMake(5, 5, self.contentView.frame.size.width - 10, 0);
        [self.contentView addSubview:self.contentLabel];
//        
    }
    return _contentLabel;
}

//-(UILabel *)buttonLabel
//{
//    if (!_buttonLabel)
//    {
//        self.buttonLabel = [[[UILabel alloc]init]autorelease];
//        _buttonLabel.frame = CGRectMake(5, self.contentLabel.frame.size.height + 10, self.contentView.frame.size.width, 20);
//        
//    }
//    return _buttonLabel;
//}
-(void)configureCellWithModel:(ControlHeight *)joke
{
//    self.contentLabel.text = joke.joke.content;
//    CGRect frame = self.contentLabel.frame;
//    frame.size.height = joke.contentHeigh;
//    self.contentLabel.frame = frame;
//    [self.contentView addSubview:self.contentLabel];
//
    self.contentLabel.text = joke.joke.content;
    self.contentLabel.frame =CGRectMake(5, 5, joke.textRect.size.width, [joke lastHeigh]);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
