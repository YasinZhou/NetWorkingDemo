//
//  YAAPIResponseErrorHandler.h
//  NetWorking
//
//  Created by Yasin on 16/4/27.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YAAPIBaseRequestDataModel.h"
@interface YAAPIResponseErrorHandler : NSObject
+ (void)errorHandlerWithRequestDataModel:(YAAPIBaseRequestDataModel *)requestDataModel responseURL:(NSURLResponse *)responseURL responseObject:(id)responseObject error:(NSError *)error errorHandler:(void(^)(NSError *newError))errorHandler;
@end
