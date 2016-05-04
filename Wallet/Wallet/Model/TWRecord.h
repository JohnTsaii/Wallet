//
//  TWRecord.h
//  Wallet
//
//  Created by xiaofeishen on 4/28/16.
//  Copyright © 2016 JohnTsai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TWRecord : NSObject

@property (assign, nonatomic) NSInteger mId;
@property (assign, nonatomic) float money;
@property (assign, nonatomic) NSTimeInterval timeStamp; //
@property (copy, nonatomic) NSString *desc; //备注
@property (assign, nonatomic) NSInteger category_id; //外键
@property (copy, nonatomic) NSString *categoryName; //分类名称

@end
