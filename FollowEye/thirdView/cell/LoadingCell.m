
#import "LoadingCell.h"
@interface LoadingCell()
@property (nonatomic,retain) UIActivityIndicatorView *indicator;//风火轮
@property (nonatomic,retain) UILabel *loadingLabel;//正在载入
@end



@implementation LoadingCell
-(void)dealloc {
    [_indicator release];
    [_loadingLabel release];
    [super dealloc];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.indicator];
        [self.contentView addSubview:self.loadingLabel];
    }
    return self;
}

-(UILabel *)loadingLabel {
    if (!_loadingLabel) {
        self.loadingLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)]autorelease];
        _loadingLabel.textAlignment = NSTextAlignmentCenter;
        _loadingLabel.font = [UIFont systemFontOfSize:15];
        _loadingLabel.text = @"正在载入中";
        _loadingLabel.textColor = [UIColor grayColor];
        
    }
    return _loadingLabel;
}


//设置风火轮样式为UIActivityIndicatorViewStyleGray
-(UIActivityIndicatorView *)indicator {
    if (!_indicator) {
        self.indicator = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]autorelease];
        _indicator.frame = CGRectMake(140, 20, 0, 0);
    }
    return _indicator;
}


-(void)startLoading {
    [self.indicator startAnimating];//让风火轮开始转动
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
