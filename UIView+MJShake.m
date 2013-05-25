//
//  Copyright (c) 2013 Martin Johannesson
//
//  Permission is hereby granted, free of charge, to any person obtaining a
//  copy of this software and associated documentation files (the "Software"),
//  to deal in the Software without restriction, including without limitation
//  the rights to use, copy, modify, merge, publish, distribute, sublicense,
//  and/or sell copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
//  DEALINGS IN THE SOFTWARE.
//
//  (MIT License)
//

#if !__has_feature(objc_arc)
#error ARC must be enabled!
#endif

#import "UIView+MJShake.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (MJShake)

- (void)shake
{
    [self shakeWithIntensity:CGSizeMake(5, 0) duration:0.5];
}

- (void)shakeWithIntensity:(CGSize)intensity
                  duration:(NSTimeInterval)duration
{
    // Calculate points to animate between
    CGPoint center = [self center];
    CGPoint p0 = CGPointMake(center.x - intensity.width,
                             center.y - intensity.height);
    CGPoint p1 = CGPointMake(center.x + intensity.width,
                             center.y + intensity.height);
    
    CABasicAnimation *animation = [CABasicAnimation
                                            animationWithKeyPath:@"position"];
    
    // Duration of one cycle
    [animation setDuration:0.05f];
    
    // Auto reversed, so the duration of one cycle is doubled
    [animation setAutoreverses:YES];

    // Each cycle + reverse cycle = 0.1 sec, so duration * 10 = repeat count
    [animation setRepeatCount:duration * 10.0f];
    
    [animation setFromValue:[NSValue valueWithCGPoint:p0]];
    [animation setToValue:[NSValue valueWithCGPoint:p1]];
    
    [[self layer] addAnimation:animation forKey:@"position"];
}

@end
