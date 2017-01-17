//
//  DATimer.h
//  Twittertimer
//
//  Created by nikolai on 1/16/17.
//  Copyright © 2017 Digital Arsenal. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DATimerDelegate <NSObject>
@optional
- (void)timerDidComplete;

@end

@interface DATimer : UIView

@property (strong, nonatomic) id <DATimerDelegate> delegate;

@end
