//
//  ZHLZButton.m
//  ZHLZ
//
//  Created by apple on 2019/11/14.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZButton.h"

@implementation ZHLZButton


- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    self.layer.cornerRadius = 5.f;
    self.layer.masksToBounds = YES;
    self.backgroundColor = kHexRGB(0x0558FF);
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = kFont16;
}


@end
