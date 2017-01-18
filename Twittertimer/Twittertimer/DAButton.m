//
//  DAButton.m
//  Twittertimer
//
//  Created by nikolai on 1/17/17.
//  Copyright © 2017 Digital Arsenal. All rights reserved.
//

#import "DAButton.h"
#import "DAColors.h"

@interface DAButton ()

@property (strong, nonatomic) CALayer *ring;

@end

@implementation DAButton

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.ring = [CALayer layer];
    self.ring.frame = CGRectInset(self.bounds, 1.0f, 1.0f);
    [self.ring setBackgroundColor:[UIColor clearColor].CGColor];
    [self.ring setBorderColor:[DAColors mildBlack].CGColor];
    [self.ring setBorderWidth:1.0f];
    [self.layer addSublayer:self.ring];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.ring.cornerRadius = self.ring.frame.size.height / 2.0f;
    self.layer.cornerRadius = self.frame.size.height / 2.0f;
}

- (void)setTheme:(DAButtonTheme)theme {
//    [self.layer setShadowColor:[DAColors burge].CGColor];
//    [self.layer setShadowOffset:CGSizeMake(2.0f, 2.0f)];
//    [self.layer setShadowRadius:2.0f];
//    [self.layer setShadowOpacity:0.2f];
    
    [self setTitleColor:[DAColors plastic] forState:UIControlStateNormal];
    switch (theme) {
        case DAButtonThemeOne:
            [self setBackgroundColor:[DAColors twilight]];
            break;
            
        case DAButtonThemeTwo:
            [self setBackgroundColor:[DAColors graze]];
            break;
            
        case DAButtonThemeTre:
            [self setBackgroundColor:[DAColors plastic]];
            break;
            
        default:
            break;
    }
}

@end
