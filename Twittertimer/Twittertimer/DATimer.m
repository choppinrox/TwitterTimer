//
//  DATimer.m
//  Twittertimer
//
//  Created by nikolai on 1/16/17.
//  Copyright © 2017 Digital Arsenal. All rights reserved.
//

#import "DATimer.h"

NSTimeInterval const startTime = 10;
NSTimeInterval const endTime = 0;
NSTimeInterval const interval = 0.01;

@interface DATimer ()

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) IBOutlet UIButton *start;
@property (strong, nonatomic) IBOutlet UIButton *stop;

@property (strong, nonatomic) NSTimer *timer;
@property (nonatomic) NSTimeInterval currentTime;
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
}

#pragma mark - User Actions

- (IBAction)startPressed:(id)sender {
    self.isPaused = NO;
}

- (IBAction)resetPressed:(id)sender {
    self.isPaused = NO;
    [self reset];
}

- (IBAction)stopPressed:(id)sender {
    self.isPaused = YES;
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
        self.currentTime -= interval;
    }
    
    if (self.currentTime < endTime) {
        [self.stop setEnabled:NO];
        [self destroytimer];
    } else {
        [self applyTime];
    }
}

- (void)applyTime {
    [self.label setText:[NSString stringWithFormat:@"%.2f", self.currentTime]];
}

@end
