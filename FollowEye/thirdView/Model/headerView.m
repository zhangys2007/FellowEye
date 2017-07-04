
#import "headerView.h"

@implementation headerView
-(void)dealloc {
    [_recommendButton release];
    [_commentButton release];
    [super dealloc];
}

-(instancetype)initWithFrame:(CGRect)frame {
//    frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), 30);
    if (self = [super initWithFrame:frame]) {
        [self addSubview:_recommendButton];
        [self addSubview:_commentButton];
    }
    return self;
}

-(UIButton *)recommendButton {
    if (!_recommendButton) {
        self.recommendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _recommendButton.frame = CGRectMake((CGRectGetWidth(self.bounds) - 100) / 2, 0, 40, 30);
        [_recommendButton setTitle:@"推荐" forState:UIControlStateNormal];
        [_recommendButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_recommendButton addTarget:self action:@selector(handleRecommendButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_recommendButton];
    }
    return _recommendButton;
}
-(void)handleRecommendButton:(UIButton *)sender {
    
}

-(UIButton *)commentButton {
    if (!_commentButton) {
        self.commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _commentButton.frame = CGRectMake((CGRectGetWidth(self.bounds) - 100) / 2 + 50, 0, 50, 30);
        [_commentButton setTitle:@"跟帖" forState:UIControlStateNormal];
        [_commentButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_commentButton addTarget:self action:@selector(handleCommentButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commentButton;
}

-(void)handleCommentButton:(UIButton *)sender {
    
}

@end
