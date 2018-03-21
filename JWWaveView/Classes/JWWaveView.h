//
//  JWWaveView.h
//  JWWaveView
//
//  Created by JiangWang on 18/03/2018.
//  Copyright © 2018 JiangWang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JWWaveView : UIView

/**
 Color used to fill the wave
 */
@property (nonatomic, strong) UIColor *waveColor;

/**
 Start waveing if all conditions are met.
 */
- (void)startWavingIfNeeded;

/**
 Stop waving if the view is currently do so. 
 */
- (void)pauseWavingIfNeeded;
@end
