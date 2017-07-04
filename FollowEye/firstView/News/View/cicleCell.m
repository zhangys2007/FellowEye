

#import "cicleCell.h"

@implementation cicleCell
-(void)dealloc
{
    [_cicle release];
    [super dealloc];
}
-(SDCycleScrollView *)cicle
{
    if (!_cicle)
    {
        self.cicle = [[[SDCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)]autorelease];
        [self.contentView addSubview:_cicle];
        
    }
    return _cicle;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
