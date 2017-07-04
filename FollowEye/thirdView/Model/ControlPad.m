

#import "ControlPad.h"
@interface ControlPad()

@end


@implementation ControlPad

//-(UIButton *)commentButton {
//    if (!_commentButton) {
//        self.commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        self.commentButton.frame = CGRectMake(CGRectGetWidth(self.bounds) - 50, 15, 40, 20);
////        [_commentButton addTarget:self action:@selector(handleCommetButton:) forControlEvents:UIControlEventTouchUpInside];
////        _commentButton.backgroundColor = [UIColor redColor];
//        [_commentButton setImage:[UIImage imageNamed:@"video_placehold_button"] forState:UIControlStateNormal];
//    }
//    return _commentButton;
//}


-(void)dealloc {
    [_durationLabel release];
    [_commentLable release];
//    [_commentButton release];
    [_countLabel release];
    [_durationImage release];
    [_countImage release];
    [super dealloc];
}

-(UIImageView *)durationImage {
    if (!_durationImage) {
        self.durationImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 4, 32, 32)];
        _durationImage.image = [UIImage imageNamed:@"video_list_cell_time"];
    }
    return _durationImage;
}


-(UILabel *)durationLabel {
    
    if (!_durationLabel) {
        self.durationLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 4, 100, 32)];
        _durationLabel.textColor = [UIColor lightGrayColor];
        _durationLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _durationLabel;
}

-(UIImageView *)countImage {
    if (!_countImage) {
        self.countImage = [[UIImageView alloc] initWithFrame:CGRectMake(137, 4, 32, 32)];
        _countImage.image = [UIImage imageNamed:@"video_list_cell_count"];
    }
    return _countImage;
}

-(UILabel *)countLabel {
    if (!_countLabel) {
        self.countLabel = [[UILabel alloc] initWithFrame:CGRectMake(174, 4, 100, 32)];
        _countLabel.adjustsFontSizeToFitWidth = YES;
//        _countLabel.backgroundColor = [UIColor redColor];
        _countLabel.textColor = [UIColor lightGrayColor];
    }
    return _countLabel;
}


-(UILabel *)commentLable {
    if (!_commentLable) {
        self.commentLable = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.bounds) - 50, 10, 40, 20)];
//        _commentLable.backgroundColor = [UIColor redColor];
        _commentLable.textColor = [UIColor lightGrayColor];
//        _commentLable.backgroundColor = [UIColor colorWithRed:230 / 255.0 green:230 / 255.0 blue:230 / 255.0 alpha:1];
        _commentLable.adjustsFontSizeToFitWidth = YES;
    }
    return _commentLable;
}



-(instancetype)initWithFrame:(CGRect)frame {
//    frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50);
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.durationLabel];
        [self addSubview:self.countLabel];
        [self addSubview:self.commentLable];
        [self addSubview:self.durationImage];
        [self addSubview:self.countImage];
    }
    return self;
}
@end
