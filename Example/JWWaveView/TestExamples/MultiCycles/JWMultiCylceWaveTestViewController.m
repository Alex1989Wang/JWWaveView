//
//  JWMultiCylceWaveTestViewController.m
//  JWWaveView
//
//  Created by JiangWang on 21/03/2018.
//  Copyright © 2018 JiangWang. All rights reserved.
//

#import "JWMultiCylceWaveTestViewController.h"
#import "JWWaveView.h"

static NSInteger kLayoutPassNumber = 0;

@interface JWMultiCylceWaveTestViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UIButton *pauseAnimationBtn;
@property (nonatomic, strong) JWWaveView *waveView;
@property (nonatomic, assign, getter=isAnimationPaused) BOOL animationPaused;
@end

@implementation JWMultiCylceWaveTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    kLayoutPassNumber = 0;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    //start wave animation after avatarImageView has been laid out.
    if (kLayoutPassNumber == 0) {
        CGRect avatarRect = self.avatarImageView.bounds;
        CGRect waveRect = (CGRect){0, CGRectGetHeight(avatarRect) * 3/4,
            CGRectGetWidth(avatarRect), CGRectGetHeight(avatarRect) * 1/4};
        self.waveView.frame = waveRect;
        [self.avatarImageView addSubview:self.waveView];
        [self.waveView startWavingIfNeeded];
        self.animationPaused = NO;
    }
    
    kLayoutPassNumber++;
}

- (IBAction)pauseOrUnpauseAnimation:(UIButton *)sender {
    if (self.isAnimationPaused) {
        [self.waveView startWavingIfNeeded];
        self.animationPaused = NO;
    }
    else {
        [self.waveView pauseWavingIfNeeded];
        self.animationPaused = YES;
    }
}

- (void)setAnimationPaused:(BOOL)animationPaused {
    _animationPaused = animationPaused;
    NSString *btnTitle = (animationPaused) ? @"Unpause Animation" :
    @"Pause Animation";
    [self.pauseAnimationBtn setTitle:btnTitle forState:UIControlStateNormal];
}

#pragma mark - Lazy Loading
- (JWWaveView *)waveView {
    if (!_waveView) {
        _waveView = [[JWWaveView alloc] init];
        _waveView.waveColor =
        [UIColor colorWithRed:0 green:0 blue:0.5 alpha:1.0];
        _waveView.waveCycles = 2;
        _waveView.waveDuration = 2;
        _waveView.waveShift = 1.5 * M_PI;
    }
    return _waveView;
}

@end
