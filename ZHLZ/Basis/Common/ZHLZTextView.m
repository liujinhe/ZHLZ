//
//  ZHLZTextView.m
//  ZHLZ
//
//  Created by apple on 2019/11/21.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZTextView.h"

@implementation ZHLZTextView


- (void)drawRect:(CGRect)rect {
    
    self.backgroundColor = [UIColor whiteColor];
    self.font = [UIFont fontWithName:@"Arial" size:14.0f];
    self.textColor = [UIColor blackColor];
    self.layer.cornerRadius = 10.0f;
    self.layer.borderWidth = 1.0f;
    self.layer.borderColor = kHexRGB(0xE5E5E5).CGColor;
}


@end
