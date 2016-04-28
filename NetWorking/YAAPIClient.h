//
//  YAAPIClient.h
//  NetWorking
//
//  Created by Yasin on 16/4/27.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YAAPIBaseRequestDataModel.h"
/**
 *   Client 负责 计算 request， 发起请求。做出回调,尽量不暴露 底层实现。比如 AF，NSSessionData
 */
@interface YAAPIClient : NSObject

+ (instancetype)sharedInstance;

/**
 *  根据dataModel发起网络请求，并根据dataModel发起回调
 *
 *
 *  @return 网络请求task哈希值
 */
- (NSNumber *)callRequestWithRequestModel:(YAAPIBaseRequestDataModel *)requestModel;

/**
 *  取消网络请求
 */
- (void)cancelRequestWithRequestID:(NSNumber *)requestID;
- (void)cancelRequestWithRequestIDList:(NSArray<NSNumber *> *)requestIDList;
@end
