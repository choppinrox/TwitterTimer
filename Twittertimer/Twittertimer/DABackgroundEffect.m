//
//  DABackgroundEffect.m
//  Twittertimer
//
//  Created by nikolai on 1/17/17.
//  Copyright © 2017 Digital Arsenal. All rights reserved.
//

#import "DABackgroundEffect.h"
#import "DAColors.h"

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_ZOOMED (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)

@implementation DABackgroundEffect

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setBackgroundColor:[UIColor clearColor]];
    if (!IS_IPHONE_5) {
        [NSTimer scheduledTimerWithTimeInterval:0.05f target:self selector:@selector(tick:) userInfo:nil repeats:YES];
    }
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
        
        [UIView animateWithDuration:8.0f
                              delay:0.0f
             usingSpringWithDamping:0.7f
              initialSpringVelocity:0.3f
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             CGFloat scale = [self random:.1 value:3];
                             [view setTransform:CGAffineTransformTranslate(view.transform,
                                                                           [self random:-10 value:10],
                                                                           [self random:-300 value:-500])];
                             [view setTransform:CGAffineTransformScale(view.transform, scale, scale)];
                             [view setTransform:CGAffineTransformRotate(view.transform, [self random:0 value:360])];
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
