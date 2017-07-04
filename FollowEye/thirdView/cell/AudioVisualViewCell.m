


#import "AudioVisualViewCell.h"

#import "UIImageView+WebCache.h"//从网络上加载图片


@interface AudioVisualViewCell()

@end


@implementation AudioVisualViewCell
-(void)dealloc {
    [_videoImage release];
    [_keyWordsLabel release];
    [_controlPad release];
   
    [_movePlayer release];
    [super dealloc];
}








-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:_videoImage];
        [self.contentView addSubview:_keyWordsLabel];
        [self.contentView addSubview:_controlPad];
        
    }
    return self;
}

-(UIImageView *)videoImage {
    if (!_videoImage) {
        self.videoImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds) , CGRectGetWidth(self.bounds) * 270 / 480)];
    [self.contentView addSubview:_videoImage];
    }
    return _videoImage;
}

-(UILabel *)keyWordsLabel {
    if (!_keyWordsLabel) {
        self.keyWordsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetWidth(self.bounds) * 270 / 480, CGRectGetWidth(self.bounds), 30)];
       [self.contentView addSubview:_keyWordsLabel];
    }
    return _keyWordsLabel;
}

-(ControlPad *)controlPad {
    if (!_controlPad) {
        self.controlPad = [[ControlPad alloc] initWithFrame:CGRectMake(0,CGRectGetWidth(self.bounds) * 270 / 480 + 30, CGRectGetWidth(self.bounds), 40)];

        [self.contentView addSubview:_controlPad];
    }
    return _controlPad;
}



//在cell中通过网络获取图片
-(void)configureCellWithModel:(AudioVisualItem *)model {
    [self.videoImage sd_setImageWithURL:[NSURL URLWithString:model.cover]placeholderImage:[UIImage imageNamed:@"place"]];
    
    
    self.keyWordsLabel.text = model.title;
    
//    self.controlPad.backgroundColor = [UIColor cyanColor];

    //播放时长
    self.controlPad.durationLabel.text = [NSString stringWithFormat:@"播放时长 %@",model.length];
    
    //播放次数
    self.controlPad.countLabel.text = [NSString stringWithFormat:@"播放次数 %@",model.playCount];
    

    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
