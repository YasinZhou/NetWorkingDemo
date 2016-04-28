//
//  YACommonParamsGenerator.m
//  NetWorking
//
//  Created by Yasin on 16/4/27.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import "YACommonParamsGenerator.h"
#import "YAAppContext.h"
#import "NSString+UtilNetworking.h"
@implementation YACommonParamsGenerator
+ (NSDictionary *)commonParamsDictionary
{
    YAAppContext *context = [YAAppContext sharedInstance];
    
    NSMutableDictionary *commonParams = [@{
                                           @"device_id":context.device_id,
                                           @"channel":context.channelID,
                                           @"os_version":context.os_version,
                                           @"api_version":context.bundle_version,
                                           @"app_client_id":context.app_client_id,
                                           @"device_model":context.device_model,
                                           @"time":context.qtime
                                           } mutableCopy];
    
    if (![NSString isEmptyString:context.user_id]) {
        commonParams[@"uid"] = context.user_id;
    }
    return commonParams;
}
@end
