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
<CAAnimationDelegate>

@property (nonatomic, strong) CAShapeLayer *waveShapeLayer;
@property (nonatomic, assign) BOOL shouldRestart; //if animation was started once; set this flat to YES;
@property (nonatomic, assign, getter=isWaving) BOOL waving;
@end

#pragma mark - NSCoding
static NSString *const kWaveColorEncodeKey = @"kWaveColorEncodeKey";
static NSString *const kWaveCyclesEncodeKey = @"kWaveCyclesEncodeKey";
static NSString *const kWaveDurationEncodeKey = @"kWaveDurationEncodeKey";
static NSString *const kWaveShiftEncodeKey = @"kWaveShiftEncodeKey";

@implementation JWWaveView (NSCoding)
//encode
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.waveColor forKey:kWaveColorEncodeKey];
    [aCoder encodeInteger:self.waveCycles forKey:kWaveCyclesEncodeKey];
    [aCoder encodeDouble:self.waveDuration forKey:kWaveDurationEncodeKey];
    [aCoder encodeDouble:self.waveShift forKey:kWaveShiftEncodeKey];
}
@end

#pragma mark - Class Implementation
@implementation JWWaveView

#pragma mark - Public
- (void)startWavingIfNeeded {
    //force layout sublayers if layouts are pending
    [self layoutIfNeeded];

    //setup shape
    [self renewWavePathWithForceRenew:NO animated:NO];

    //restart animtion
    [self restartWaveShapeTranslation];
    _shouldRestart = YES;
}

- (void)pauseWavingIfNeeded {
    if ([self.waveShapeLayer animationForKey:kWaveShapeTranslationAnimationKey]) {
        CFTimeInterval currentTime = CACurrentMediaTime();
        CFTimeInterval layerPausedTimestamp = [self.waveShapeLayer convertTime:currentTime fromLayer:nil];
        self.waveShapeLayer.speed = 0;
        self.waveShapeLayer.timeOffset = layerPausedTimestamp;
        self.waving = NO; //animation not removed or finished; but it's not waving;
    }
}

#pragma mark - Initialization
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialConfigWithDecoder:nil];
        [self configureWaveShapes];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialConfigWithDecoder:aDecoder];
        [self configureWaveShapes];
    }
    return self;
}

- (void)initialConfigWithDecoder:(NSCoder *)aDecoder {
    //do not allow shape layers to move outside of view's bounds rectangle.
    self.clipsToBounds = YES;
    _waving = NO;
    _shouldRestart = NO;
    if (!aDecoder) {
        _waveDuration = 1.0;
        _waveColor = [UIColor blueColor];
        _waveCycles = 1;
        _waveShift = 0;
    }
    else {
        _waveColor =
        [aDecoder decodeObjectForKey:kWaveColorEncodeKey] ?: [UIColor blueColor];
        _waveCycles = [aDecoder decodeIntegerForKey:kWaveCyclesEncodeKey] ?: 1;
        _waveDuration = [aDecoder decodeDoubleForKey:kWaveDurationEncodeKey] ?: 1.0;
        _waveShift = [aDecoder decodeDoubleForKey:kWaveShiftEncodeKey] ?: 0;
    }
}

#pragma mark - Override
+ (Class)layerClass {
    return [CAReplicatorLayer class];
}

- (CAReplicatorLayer *)replicatorLayer {
    return (CAReplicatorLayer *)self.layer;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    if (!newSuperview) {
        [self pauseWavingIfNeeded];
    }
    else {
        //has started before by calling the public api
        if (self.shouldRestart) {
            [self restartWaveShapeTranslation];
        }
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CAReplicatorLayer *replicatorLayer = [self replicatorLayer];
    CGRect replicatorRect = replicatorLayer.bounds;
    self.waveShapeLayer.frame = replicatorRect;
}

#pragma mark - Private
- (void)restartWaveShapeTranslation {
    //layer setup
    CAReplicatorLayer *replicatorLayer = [self replicatorLayer];
    CGRect replicatorRect = replicatorLayer.bounds;
    CGFloat instanceWidth = CGRectGetWidth(replicatorRect);
    replicatorLayer.instanceTransform = CATransform3DMakeTranslation(instanceWidth, 0, 0);
    if (CGRectIsEmpty(replicatorRect)) {
        return;
    }
    
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
        transAnim.delegate = self;
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
        self.waving = YES; //paused last time;
    }
}

- (void)configureWaveShapes {
    CAReplicatorLayer *replicatorLayer = [self replicatorLayer];
    
    //add two shape layers
    CGRect replicatorRect = replicatorLayer.bounds;
    self.waveShapeLayer.frame = replicatorRect;
    [replicatorLayer addSublayer:self.waveShapeLayer];
    replicatorLayer.instanceCount = 2;
    replicatorLayer.instanceDelay = 0;
}

- (void)renewWavePathWithForceRenew:(BOOL)forceRenew animated:(BOOL)animated {
    CGRect sinPathCanvasRect = self.waveShapeLayer.bounds;
    sinPathCanvasRect = CGRectIntegral(sinPathCanvasRect);
    if (CGRectIsEmpty(sinPathCanvasRect)) {
        return;
    }
    
    //use default implicit animation
    if (!self.waveShapeLayer.path || forceRenew) {
        [CATransaction begin];
        [CATransaction setDisableActions:!animated];
        CGFloat canvasWidth = sinPathCanvasRect.size.width;
        CGFloat canvasHeight = sinPathCanvasRect.size.height;
        CGFloat canvasMidY = CGRectGetMidY(sinPathCanvasRect);
        UIBezierPath *sinPath = [UIBezierPath bezierPath];
        sinPath.lineWidth = 1.f;
        CGFloat yPos = 0;
        for (CGFloat xPos = 0.f; xPos <= canvasWidth; xPos += 1.f) {
            //wave path starts at the canvasMidY and uses (canvasHeight * 0.5) as amplitude
            CGFloat halfAmplitude = canvasHeight / 4.f;
            yPos = canvasMidY + sin((xPos/canvasWidth) * M_PI * 2 * _waveCycles + _waveShift) * halfAmplitude;
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
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStart:(CAAnimation *)anim {
    self.waving = YES; //KVO compatible
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    self.waving = NO;
}

#pragma mark - Accessors
- (void)setWaveColor:(UIColor *)waveColor {
    self.waveShapeLayer.fillColor = waveColor.CGColor;
    self.waveShapeLayer.strokeColor = waveColor.CGColor;
}

- (void)setWaveCycles:(NSInteger)waveCycles {
    if (_waveCycles != waveCycles) {
        NSInteger adjustedCycles = MAX(1, waveCycles);
        if (adjustedCycles != _waveCycles) {
            _waveCycles = adjustedCycles;
            [self renewWavePathWithForceRenew:YES animated:YES];
        }
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

- (void)setWaveShift:(CGFloat)waveShift {
    if (waveShift < 0 || waveShift > 2 * M_PI) {
        return;
    }
    _waveShift = waveShift;
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


