//
//  JWClickToRemoveWaveViewTestController.m
//  JWWaveView
//
//  Created by JiangWang on 21/03/2018.
//  Copyright © 2018 JiangWang. All rights reserved.
//

#import "JWClickToRemoveWaveViewTestController.h"
#import "JWWaveView.h"

static NSInteger kLayoutPassNumber = 0;

@interface JWClickToRemoveWaveViewTestController ()
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (nonatomic, strong) JWWaveView *waveView;
@property (nonatomic, assign, getter=isAnimationPaused) BOOL animationPaused;
@end

@implementation JWClickToRemoveWaveViewTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    kLayoutPassNumber = 0;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    //start wave animation
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

- (IBAction)clickToRemoveWaveView:(UIButton *)sender {
    if (_waveView.superview) {
        [_waveView removeFromSuperview];
    }
    else {
        CGRect avatarRect = self.avatarImageView.bounds;
        CGRect waveRect = (CGRect){0, CGRectGetHeight(avatarRect) * 3/4,
            CGRectGetWidth(avatarRect), CGRectGetHeight(avatarRect) * 1/4};
        self.waveView.frame = waveRect;
        [self.avatarImageView addSubview:self.waveView];
    }
}

- (IBAction)clickToAddWaveCycle:(UIButton *)sender {
    NSInteger currentCycle = self.waveView.waveCycles;
    currentCycle++;
    self.waveView.waveCycles = currentCycle;
}

- (void)setAnimationPaused:(BOOL)animationPaused {
    _animationPaused = animationPaused;
}

#pragma mark - Lazy Loading
- (JWWaveView *)waveView {
    if (!_waveView) {
        _waveView = [[JWWaveView alloc] init];
        _waveView.waveColor =
        [UIColor colorWithRed:0 green:0 blue:0.5 alpha:1.0];
        _waveView.waveCycles = 2;
        _waveView.waveDuration = 2;
    }
    return _waveView;
}

@end
