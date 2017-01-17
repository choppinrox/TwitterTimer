//
//  ViewController.m
//  Twittertimer
//
//  Created by nikolai on 1/16/17.
//  Copyright © 2017 Digital Arsenal. All rights reserved.
//

#import "ViewController.h"
#import <TwitterKit/TwitterKit.h>
#import "DATimer.h"

@interface ViewController () <DATimerDelegate>

@property (weak, nonatomic) IBOutlet DATimer *timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.timer setDelegate:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - DATimerDelegate

- (void)timerDidComplete {
    [self performSegueWithIdentifier:@"showTweets" sender:self];
}

@end
