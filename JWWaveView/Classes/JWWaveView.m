//
//  JWWaveView.m
//  JWWaveView
//
//  Created by JiangWang on 18/03/2018.
//  Copyright © 2018 JiangWang. All rights reserved.
//

#import "JWWaveView.h"

static NSString *const kWaveShapeTranslationAnimationKey = @"jiangwang.com.waveTranslation";

@interface JWWaveView ()
@property (nonatomic, strong) CAShapeLayer *waveShapeLayer;
@end

@implementation JWWaveView

#pragma mark - Public
- (void)startWavingIfNeeded {
    CAReplicatorLayer *replicatorLayer = [self replicatorLayer];
    CGRect replicatorRect = replicatorLayer.bounds;
    if (CGRectIsEmpty(replicatorRect)) {
        return;
    }
    
    self.waveShapeLayer.frame = replicatorRect;
    CGFloat instanceWidth = CGRectGetWidth(replicatorRect);
    replicatorLayer.instanceTransform = CATransform3DMakeTranslation(instanceWidth, 0, 0);
    
    //setup shape
    [self setupWavePath];
    
    //restart animtion
    [self restartWaveShapeTranslation];
}

- (void)pauseWavingIfNeeded {
    if ([self.waveShapeLayer animationForKey:kWaveShapeTranslationAnimationKey]) {
        CFTimeInterval currentTime = CACurrentMediaTime();
        CFTimeInterval layerPausedTimestamp = [self.waveShapeLayer convertTime:currentTime fromLayer:nil];
        self.waveShapeLayer.speed = 0;
        self.waveShapeLayer.timeOffset = layerPausedTimestamp;
    }
}

#pragma mark - Initialization
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configureIntialSetup];
        [self configureWaveShapes];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self configureIntialSetup];
        [self configureWaveShapes];
    }
    return self;
}

- (void)configureIntialSetup {
    //do not allow shape layers to move outside of view's bounds rectangle.
    self.clipsToBounds = YES;
    _waveDuration = 1.0;
    _waveColor = [UIColor blueColor];
    _waveCycles = 1;
}

#pragma mark - Override
+ (Class)layerClass {
    return [CAReplicatorLayer class];
}

- (CAReplicatorLayer *)replicatorLayer {
    return (CAReplicatorLayer *)self.layer;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (!newSuperview) {
        [self pauseWavingIfNeeded];
    }
    else {
        [self restartWaveShapeTranslation];
    }
    [super willMoveToSuperview:newSuperview];
}

#pragma mark - Private
- (void)restartWaveShapeTranslation {
    CAReplicatorLayer *replicatorLayer = [self replicatorLayer];
    CGRect replicatorRect = replicatorLayer.bounds;
    if (![self.waveShapeLayer animationForKey:kWaveShapeTranslationAnimationKey]) {
        //add translation animation to shape layer;
        CABasicAnimation *transAnim = [CABasicAnimation animation];
        transAnim.keyPath = @"transform.translation.x";
        transAnim.fromValue = [NSNumber numberWithFloat:0];
        transAnim.toValue = [NSNumber numberWithFloat:(-1.0 * replicatorRect.size.width)];
        transAnim.repeatCount = CGFLOAT_MAX;
        transAnim.duration = _waveDuration;
        transAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        transAnim.removedOnCompletion = NO;
        transAnim.fillMode = kCAFillModeBoth;
        [self.waveShapeLayer addAnimation:transAnim forKey:kWaveShapeTranslationAnimationKey];
    }
    
    //if paused last time
    CFTimeInterval previousTimeOffset = self.waveShapeLayer.timeOffset;
    if (previousTimeOffset) {
        self.waveShapeLayer.speed = 1.0;
        self.waveShapeLayer.beginTime = 0;
        self.waveShapeLayer.timeOffset = 0;
        CFTimeInterval currentTime = CACurrentMediaTime();
        CFTimeInterval layerTimestamp = [self.waveShapeLayer convertTime:currentTime fromLayer:nil];
        CFTimeInterval timeOffsetSincePaused = layerTimestamp - previousTimeOffset;
        self.waveShapeLayer.beginTime = timeOffsetSincePaused;
    }
}

- (void)configureWaveShapes {
    CAReplicatorLayer *replicatorLayer = [self replicatorLayer];
    
    //add two shape layers
    [replicatorLayer addSublayer:self.waveShapeLayer];
    replicatorLayer.instanceCount = 2;
    replicatorLayer.instanceDelay = 0;
}

- (void)setupWavePath {
    CGRect sinPathCanvasRect = self.waveShapeLayer.bounds;
    sinPathCanvasRect = CGRectIntegral(sinPathCanvasRect);
    if (CGRectIsEmpty(sinPathCanvasRect)) {
        return;
    }
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    CGFloat canvasWidth = sinPathCanvasRect.size.width;
    CGFloat canvasHeight = sinPathCanvasRect.size.height;
    CGFloat canvasMidY = CGRectGetMidY(sinPathCanvasRect);
    UIBezierPath *sinPath = [UIBezierPath bezierPath];
    sinPath.lineWidth = 1.f;
    CGFloat yPos = 0;
    for (CGFloat xPos = 0.f; xPos <= canvasWidth; xPos += 1.f) {
        //wave path starts at the canvasMidY and uses (canvasHeight * 0.5) as amplitude
        CGFloat halfAmplitude = canvasHeight / 4.f;
        yPos = canvasMidY + sin((xPos)/canvasWidth * M_PI * 2 * _waveCycles) * halfAmplitude;
        if (fpclassify(xPos) == FP_ZERO) {
            [sinPath moveToPoint:(CGPoint){xPos, yPos}];
        }
        else {
            [sinPath addLineToPoint:(CGPoint){xPos, yPos}];
        }
    }
    
    //close path
    [sinPath addLineToPoint:(CGPoint){canvasWidth, canvasHeight}];
    [sinPath addLineToPoint:(CGPoint){0, canvasHeight}];
    [sinPath closePath];
    self.waveShapeLayer.path = sinPath.CGPath;
    [CATransaction commit];
}

#pragma mark - Accessors
- (void)setWaveColor:(UIColor *)waveColor {
    self.waveShapeLayer.fillColor = waveColor.CGColor;
    self.waveShapeLayer.strokeColor = waveColor.CGColor;
}

- (void)setWaveCycles:(NSInteger)waveCycles {
    if (_waveCycles != waveCycles) {
        _waveCycles = MAX(1, waveCycles);
    }
}

- (void)setWaveDuration:(CGFloat)waveDuration {
    if (waveDuration < 0) {
        return;
    }
    
    if (_waveDuration != waveDuration) {
        _waveDuration = waveDuration;
    }
}

#pragma mark - Lazy Loading 
- (CAShapeLayer *)waveShapeLayer {
    if (!_waveShapeLayer) {
        _waveShapeLayer = [CAShapeLayer layer];
        _waveShapeLayer.strokeColor = _waveColor.CGColor;
        _waveShapeLayer.fillColor = _waveColor.CGColor;
    }
    return _waveShapeLayer;
}

@end
