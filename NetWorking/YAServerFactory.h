//
//  YAServerFactory.h
//  NetWorking
//
//  Created by Yasin on 16/4/27.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YABaseServers.h"
#import "ServerConfig.h"

@interface YAServerFactory : NSObject
+ (instancetype)sharedInstance;
+ (NSString *)YABaseAPI;
+ (EnvironmentType)getEnvironmentType;
+ (void)changeEnvironmentType:(EnvironmentType)environmentType;

- (YABaseServers<YABaseServiceProtocol> *)serviceWithType:(YAServiceType)type;
@end
