//
//  YASignatureGenerator.h
//  NetWorking
//
//  Created by Yasin on 16/4/27.
//  Copyright © 2016年 Yasin. All rights reserved.
//
/**
 *  网络请求签名
 */
#import <Foundation/Foundation.h>

@interface YASignatureGenerator : NSObject
+ (NSString *)sign:(NSDictionary *)dict;
@end
