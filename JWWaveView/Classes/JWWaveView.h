//
//  JWWaveView.h
//  JWWaveView
//
//  Created by JiangWang on 18/03/2018.
//  Copyright © 2018 JiangWang. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 JWWaveView is used to add a water-waving effect to any of your UIView instance. 
 
 @note Half of the view's bounds.size.height value is used as the wave'e amplitude,
 which means the wave will try to fill the middle half of view's bounds rectangle.
 This should be duly noted.
 */
@interface JWWaveView : UIView

/**
 The color used to fill the wave shape.
 The default color is [UIColor blueColor].
 */
@property (nonatomic, strong) UIColor *waveColor;

/**
 The number of complete wave cycles to show. Since the wave path is modeled using
 the mathmatical sin(x) function, a complete wave cycle means x starts from any 
 random value y and ends at (y + 2 * M_PI). 
 
 The default value is 1.
 
 Setting a value less than 1 has no effect. 
 */
@property (nonatomic, assign) NSInteger waveCycles;

/**
 The waving animation duration. The value defines how long does it take to move
 all current displayed waves off screen. 
 
 @note The unit of this property is second.
 
 If large waveCycles are used, normally, you also need a fairly large
 waveDuration so that visually the waving speed is acceptable. 
 
 The default value for this property is 1. 
 
 Setting a value less than 0 has no effect. 
 */
@property (nonatomic, assign) CGFloat waveDuration;

/**
 The wave path is modeled using the mathmatical sin(x) function. The default value
 for x starts at 0, which yeilds an amplitude of 0.
 This propery adds a shift to the x value.
 
 The effective range for this property is [0, 2 * M_PI]. The default value is 0,
 which means no shift is added to the wave.
 
 @note changing this value after animation has no effect.
 */
@property (nonatomic, assign) CGFloat waveShift;

/**
 Start the water waving animation if all conditions are met.
 */
- (void)startWavingIfNeeded;

/**
 Stop waving if the view is currently doing so. 
 */
- (void)pauseWavingIfNeeded;
@end
