//
//  YANetworkingAutoCancelRequests.h
//  NetWorking
//
//  Created by Yasin on 16/4/27.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YABaseDataEngine.h"
@interface YANetworkingAutoCancelRequests : NSObject
- (void)setEngine:(YABaseDataEngine *)engine requestID:(NSNumber *)requestID;
- (void)removeEngineWithRequestID:(NSNumber *)requestID;
@end
