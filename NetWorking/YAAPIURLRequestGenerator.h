//
//  YAAPIURLRequestGenerator.h
//  NetWorking
//
//  Created by Yasin on 16/4/27.
//  Copyright © 2016年 Yasin. All rights reserved.
//
/**
 *  网络请求生成URLRequest
 */
#import <Foundation/Foundation.h>
#import "YAAPIBaseRequestDataModel.h"
@interface YAAPIURLRequestGenerator : NSObject
/**
 *  生成一个单例
 *
 */
+ (instancetype)sharedInstance;

- (NSURLRequest *)generateWithRequestDataModel:(YAAPIBaseRequestDataModel *)dataModel;


@end
