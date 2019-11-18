//
//  ZHLZTextField.h
//  ZHLZ
//
//  Created by apple on 2019/11/14.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZHLZTextField : UITextField

- (CGRect)textRectForBounds:(CGRect)bounds;
- (CGRect)editingRectForBounds:(CGRect)bounds;  

@end

NS_ASSUME_NONNULL_END
