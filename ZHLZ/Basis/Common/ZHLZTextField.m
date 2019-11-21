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
    
    self.backgroundColor = [UIColor whiteColor];
    self.font = [UIFont fontWithName:@"Arial" size:16.0f];
    self.textColor = [UIColor blackColor];
    self.layer.cornerRadius = 5.0f;
    self.layer.borderWidth = 1.0f;
    self.layer.borderColor = kHexRGB(0xF7F7F7).CGColor;
    
}

//控制文本所在的的位置，左右缩 10
- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset( bounds , 10 , 0 );
}
  
//控制编辑文本时所在的位置，左右缩 10
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset( bounds , 10 , 0 );
}
  

@end
