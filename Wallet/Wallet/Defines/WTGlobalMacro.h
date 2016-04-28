//
//  WTGlobalMacro.h
//  Wallet
//
//  Created by John TSai on 16/4/27.
//  Copyright © 2016年 JohnTsai. All rights reserved.
//

#ifndef WTGlobalMacro_h
#define WTGlobalMacro_h

///////////////////////// SIZE ////////////////////////////////////
#define WT_SCREEN_WIDTH CGRectGetWidth([UIScreen mainScreen].bounds)
#define WT_SCREEN_HEIGHT CGRectGetHeight([UIScreen mainScreen].bounds)
#define WT_GOLDEN_RATIO 0.618f

///////////////////////// STYLE ///////////////////////////////////
#define WT_DECIMAL_FONT_SIZE(x) [UIFont fontWithName:@"HelveticaNeue" size:x]

#define WT_DECIMAL_POSITIVE_COLOR [UIColor colorWithRed:0/255.0 green:204/255.0 blue:116/255.0 alpha:1.0]
#define WT_DECIMAL_NEGATIVE_COLOR [UIColor colorWithRed:243/255.0 green:78/255.0 blue:64/255.0 alpha:1.0]

#endif /* WTGlobalMacro_h */
