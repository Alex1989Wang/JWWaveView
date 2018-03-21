//
//  JWMultiCylceWaveTestViewController.m
//  JWWaveView
//
//  Created by JiangWang on 21/03/2018.
//  Copyright © 2018 JiangWang. All rights reserved.
//

#import "JWMultiCylceWaveTestViewController.h"
#import "JWWaveView.h"

@interface JWMultiCylceWaveTestViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (nonatomic, strong) JWWaveView *waveView;
@end

@implementation JWMultiCylceWaveTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    //start wave animation
    CGRect avatarRect = self.avatarImageView.bounds;
    CGRect waveRect = (CGRect){0, CGRectGetHeight(avatarRect) * 3/4,
        CGRectGetWidth(avatarRect), CGRectGetHeight(avatarRect) * 1/4};
    self.waveView.frame = waveRect;
    [self.avatarImageView addSubview:self.waveView];
    [self.waveView startWavingIfNeeded];
}

#pragma mark - Lazy Loading
- (JWWaveView *)waveView {
    if (!_waveView) {
        _waveView = [[JWWaveView alloc] init];
        _waveView.waveColor =
        [UIColor colorWithRed:0 green:0 blue:0.5 alpha:1.0];
        _waveView.waveCycles = 2;
    }
    return _waveView;
}

@end
