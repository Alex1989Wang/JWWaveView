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
 */
@property (nonatomic, assign) NSInteger waveCycles;

/**
 Start the water waving animation if all conditions are met.
 */
- (void)startWavingIfNeeded;

/**
 Stop waving if the view is currently doing so. 
 */
- (void)pauseWavingIfNeeded;
@end
