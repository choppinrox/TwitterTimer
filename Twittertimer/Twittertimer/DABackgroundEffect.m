//
//  DABackgroundEffect.m
//  Twittertimer
//
//  Created by nikolai on 1/17/17.
//  Copyright © 2017 Digital Arsenal. All rights reserved.
//

#import "DABackgroundEffect.h"
#import "DAColors.h"

@implementation DABackgroundEffect

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setBackgroundColor:[UIColor clearColor]];
    [NSTimer scheduledTimerWithTimeInterval:0.05f target:self selector:@selector(tick:) userInfo:nil repeats:YES];
}

- (void)tick:(id)sender {
    if (!self.isPaused) {
        CGSize windowSize = [UIApplication sharedApplication].keyWindow.frame.size;
        CGFloat size = [self random:10 value:30];
        CGSize bubbleSize = CGSizeMake(size, size);
        
        
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(0, 0, bubbleSize.width, bubbleSize.height);
        view.center = CGPointMake([self random:0 value:windowSize.width],
                                  windowSize.height + bubbleSize.height);
        [view setBackgroundColor:[DAColors burge]];
        [view setTranslatesAutoresizingMaskIntoConstraints:YES];
        [view setAlpha:((double)arc4random() / 0x100000000)];
        [view.layer setCornerRadius:view.frame.size.height / 2.0f];
        [self addSubview:view];
        
        [UIView animateWithDuration:3.6f
                              delay:0.0f
             usingSpringWithDamping:0.7f
              initialSpringVelocity:0.3f
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             [view setTransform:CGAffineTransformTranslate(view.transform,
                                                                           [self random:-10 value:10],
                                                                           [self random:-300 value:-500])];
                             [view setAlpha:0.0f];
                         }
                         completion:^(BOOL completion){
                             [view removeFromSuperview];
                         }];
    }
}

- (NSInteger)random:(NSInteger)low value:(NSInteger)high {
     return low + arc4random() % (high - low);
}

- (void)setIsPaused:(BOOL)isPaused {
    _isPaused = isPaused;
    
    if (isPaused) {
        for (UIView *view in [self subviews]) {
            [view removeFromSuperview];
        }
    }
}

@end
