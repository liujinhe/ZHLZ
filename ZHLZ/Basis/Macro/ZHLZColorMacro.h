//
//  ZHLZColorMacro.h
//  ZHLZ
//
//  Created by liujinhe on 2019/11/12.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#ifndef ZHLZColorMacro_h
#define ZHLZColorMacro_h

#define kRGB(r, g, b) [UIColor colorWithRed:((r) / 255.0)green:((g) / 255.0)blue:((b) / 255.0)alpha:1.0]
#define kRGBAlpha(r, g, b, a) [UIColor colorWithRed:((r) / 255.0)green:((g) / 255.0)blue:((b) / 255.0)alpha:(a)]

#define kHexRGB(rgb) [UIColor colorWithRed:((float)((rgb & 0xFF0000) >> 16)) / 255.0 green:((float)((rgb & 0xFF00) >> 8)) / 255.0 blue:((float)(rgb & 0xFF)) / 255.0 alpha:1.0]
#define kHexRGBAlpha(rgb, a) [UIColor colorWithRed:((float)((rgb & 0xFF0000) >> 16)) / 255.0 green:((float)((rgb & 0xFF00) >> 8)) / 255.0 blue:((float)(rgb & 0xFF)) / 255.0 alpha:(a)]

// 背景色
#define kBgColor kHexRGB(0xFFFFFF)
// 主色
#define kThemeColor kHexRGB(0x03A9F4)

#endif /* ZHLZColorMacro_h */
