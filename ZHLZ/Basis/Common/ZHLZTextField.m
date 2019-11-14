//
//  ZHLZTextField.m
//  ZHLZ
//
//  Created by apple on 2019/11/14.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZTextField.h"

@implementation ZHLZTextField


- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    self.backgroundColor = kHexRGB(0xf7f7f7);
    self.font = [UIFont fontWithName:@"Arial" size:16.0f];
    self.textColor = [UIColor blackColor];
    
}


@end
