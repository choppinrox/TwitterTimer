//
//  ViewController.m
//  Twittertimer
//
//  Created by nikolai on 1/16/17.
//  Copyright © 2017 Digital Arsenal. All rights reserved.
//

#import "ViewController.h"
#import <TwitterKit/TwitterKit.h>
#import "DABackgroundEffect.h"
#import "DAColors.h"
#import "DATimer.h"

@interface ViewController () <DATimerDelegate>

@property (strong, nonatomic) IBOutlet DABackgroundEffect *backgroundEffect;
@property (weak, nonatomic) IBOutlet DATimer *timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[DAColors mildBlack]];
    [self.timer setDelegate:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - DATimerDelegate

- (void)timerDidStart {
    [self.backgroundEffect setIsPaused:YES];
}

- (void)timerDidStop {
    [self.backgroundEffect setIsPaused:NO];
}

- (void)timerDidComplete {
    [self.backgroundEffect setIsPaused:NO];
    [self performSegueWithIdentifier:@"showTweets" sender:self];
}

@end
