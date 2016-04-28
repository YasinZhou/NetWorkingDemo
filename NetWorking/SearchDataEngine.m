//
//  SearchDataEngine.m
//  NetWorking
//
//  Created by Yasin on 16/4/28.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import "SearchDataEngine.h"

@implementation SearchDataEngine
+ (YABaseDataEngine *)control:(NSObject *)control
                    searchKey:(NSString *)searchKey
                     complete:(CompletionDataBlock)responseBlock
{
    //baike.baidu.com/api/openapi/BaikeLemmaCardApi?scope=103&format=json&appid=379020&bk_key=%E5%85%B3%E9%94%AE%E5%AD%97&bk_length=600
    NSDictionary *param = @{@"scope":@"103",
                            @"format":@"json",
                            @"appid":@"379020",
                            @"bk_key":searchKey,
                            @"bk_length":@"600"};
    return [YABaseDataEngine control:control callAPIWithServiceType:YAServiceFWZ path:@"api/openapi/BaikeLemmaCardApi" param:param requestType:YAAPIManagerRequestTypeGet alertType:DataEngineAlertType_None progressBlock:nil complete:responseBlock errorButtonSelectIndex:nil];
}
@end
