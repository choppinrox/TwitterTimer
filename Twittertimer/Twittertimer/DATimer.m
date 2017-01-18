//
//  DATimer.m
//  Twittertimer
//
//  Created by nikolai on 1/16/17.
//  Copyright © 2017 Digital Arsenal. All rights reserved.
//

#import "DATimer.h"
#import "DAColors.h"
#import "DAButton.h"

NSTimeInterval const startTime = 10;
NSTimeInterval const endTime = 0;
NSTimeInterval const interval = 0.01;

@interface DATimer ()

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UILabel *seconds;
@property (strong, nonatomic) IBOutlet UILabel *secondsM;
@property (strong, nonatomic) IBOutlet UIView *container;
@property (strong, nonatomic) IBOutlet DAButton *start;
@property (strong, nonatomic) IBOutlet DAButton *stop;
@property (strong, nonatomic) IBOutlet DAButton *pause;

@property (strong, nonatomic) NSTimer *timer;
@property (nonatomic) NSTimeInterval currentTime;
@property (nonatomic) NSDate *timeSinceLast;
@property (nonatomic) BOOL isPaused;

@end

@implementation DATimer

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Load View
    [[NSBundle mainBundle] loadNibNamed:@"DATimer" owner:self options:nil];
    [self addSubview:self.contentView];
    
    // Initial State
    self.isPaused = YES;
    [self reset];
    
    [self.seconds  setTextColor:[DAColors plastic]];
    [self.secondsM setTextColor:[DAColors plastic]];
    [self setBackgroundColor:[UIColor clearColor]];
    [self.contentView setBackgroundColor:[UIColor clearColor]];
    [self.start setTheme:DAButtonThemeOne];
    [self.pause setTheme:DAButtonThemeOne];
    [self.stop  setTheme:DAButtonThemeOne];
}

#pragma mark - User Actions

- (IBAction)startPressed:(id)sender {
    if (self.isPaused) {
        self.timeSinceLast = [NSDate date];
    }
    if ([self.delegate respondsToSelector:@selector(timerDidStart)]) {
        [self.delegate timerDidStart];
    }
    self.isPaused = NO;
}

- (IBAction)resetPressed:(id)sender {
    if (self.isPaused || self.currentTime <= 0) {
        self.timeSinceLast = [NSDate date];
    }
    if ([self.delegate respondsToSelector:@selector(timerDidStart)]) {
        [self.delegate timerDidStart];
    }
    self.isPaused = NO;
    [self reset];
}

- (IBAction)stopPressed:(id)sender {
    self.isPaused = YES;
    if ([self.delegate respondsToSelector:@selector(timerDidStop)]) {
        [self.delegate timerDidStop];
    }
}

#pragma mark - System Actions

- (void)createTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:interval
                                                  target:self
                                                selector:@selector(tick:)
                                                userInfo:nil
                                                 repeats:YES];
}

- (void)destroytimer {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)reset {
    if (!self.timer) {
        [self createTimer];
    }
    
    [self.stop setEnabled:YES];
    self.currentTime = startTime;
    [self applyTime];
}

- (void)tick:(id)sender {
    if (!self.isPaused) {
        self.currentTime += [self.timeSinceLast timeIntervalSinceNow];
        self.timeSinceLast = [NSDate date];
    }
    
    if (self.currentTime < endTime) {
        if ([self.delegate respondsToSelector:@selector(timerDidComplete)]) {
            [self.seconds  setText:@"00"];
            [self.secondsM setText:@"00"];
            [self.delegate timerDidComplete];
        }
        [self.stop setEnabled:NO];
        [self destroytimer];
    } else {
        [self applyTime];
    }
}

- (void)applyTime {
    NSInteger integerPortion = floor(self.currentTime);
    NSInteger decimalPortion = (self.currentTime - integerPortion) * 100;
    
    [self.seconds  setText:[NSString stringWithFormat:@"%02ld", integerPortion]];
    [self.secondsM setText:[NSString stringWithFormat:@"%02ld", decimalPortion]];
}

@end
