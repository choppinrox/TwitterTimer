//
//  DAButton.h
//  Twittertimer
//
//  Created by nikolai on 1/17/17.
//  Copyright © 2017 Digital Arsenal. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    DAButtonThemeOne,
    DAButtonThemeTwo,
    DAButtonThemeTre,
} DAButtonTheme;

@interface DAButton : UIButton

@property (nonatomic) DAButtonTheme theme;

@end
