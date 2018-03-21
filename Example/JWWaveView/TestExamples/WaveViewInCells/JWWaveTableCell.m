//
//  JWWaveTableCell.m
//  JWWaveView
//
//  Created by JiangWang on 19/03/2018.
//  Copyright © 2018 JiangWang. All rights reserved.
//

#import "JWWaveTableCell.h"
#import "JWWaveView.h"

#define kJWWaveTableCellPadding (5)

@interface JWWaveTableCell ()
@property (nonatomic, strong) JWWaveView *waveView;
@end

@implementation JWWaveTableCell

#pragma mark - Initialization
- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    //image view + text label
    self = [super initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:reuseIdentifier];
    if (self) {
        //initial setup
        [self resetWaveView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    //round corner;
    CGRect avatarRect = self.imageView.bounds;
    self.imageView.layer.cornerRadius = CGRectGetHeight(avatarRect) * 0.5;
    self.imageView.layer.masksToBounds = YES;
    
    //start wave animation
    CGRect waveRect = (CGRect){0, CGRectGetMidY(avatarRect),
        CGRectGetWidth(avatarRect), CGRectGetHeight(avatarRect) * 0.5};
    self.waveView.frame = waveRect;
    [self.imageView addSubview:self.waveView];
    [self.waveView startWavingIfNeeded];
}

#pragma mark - Private
- (void)resetWaveView {
    [self.waveView removeFromSuperview];
    
    CGRect avatarRect = self.imageView.bounds;
    CGRect waveRect = (CGRect){0, CGRectGetMidY(avatarRect),
        CGRectGetWidth(avatarRect), CGRectGetHeight(avatarRect) * 0.5};
    self.waveView.frame = waveRect;
    self.waveView.waveColor = [UIColor yellowColor];
    [self.imageView addSubview:self.waveView];
}

#pragma mark - Lazy Loading
- (JWWaveView *)waveView {
    if (!_waveView) {
        _waveView = [[JWWaveView alloc] init];
    }
    return _waveView;
}

@end
