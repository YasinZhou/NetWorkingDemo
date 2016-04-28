//
//  NSObject+YANetWorkingAutoCancel.m
//  NetWorking
//
//  Created by Yasin on 16/4/27.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import "NSObject+YANetWorkingAutoCancel.h"
#import <objc/runtime.h>
@implementation NSObject (YANetWorkingAutoCancel)
- (YANetworkingAutoCancelRequests *)networkingAutoCancelRequests{
    YANetworkingAutoCancelRequests *requests = objc_getAssociatedObject(self, @selector(networkingAutoCancelRequests));
    if (requests == nil) {
        requests = [[YANetworkingAutoCancelRequests alloc]init];
        objc_setAssociatedObject(self, @selector(networkingAutoCancelRequests), requests, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return requests;
}

@end
