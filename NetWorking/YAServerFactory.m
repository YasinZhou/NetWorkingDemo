//
//  YAServerFactory.m
//  NetWorking
//
//  Created by Yasin on 16/4/27.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import "YAServerFactory.h"
#import "YAServer.h"
#import "FWZServer.h"

@interface YAServerFactory ()

@property (nonatomic, strong) NSMutableDictionary *serviceStorage;

@end
@implementation YAServerFactory
#pragma mark - life cycle
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static YAServerFactory *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[YAServerFactory alloc] init];
    });
    return sharedInstance;
}

#pragma mark - public methods
+ (NSString *)YABaseAPI{
    return [[YAServerFactory sharedInstance] serviceWithType:YAServiceYA].apiBaseUrl;
}
+ (EnvironmentType)getEnvironmentType{
    return [[YAServerFactory sharedInstance] serviceWithType:YAServiceYA].environmentType;
}
+ (void)changeEnvironmentType:(EnvironmentType)environmentType{
    YAServerFactory *factory = [self sharedInstance];
    [factory.serviceStorage.allValues enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        YABaseServers *service = obj;
        service.environmentType = environmentType;
    }];
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:environmentType] forKey:@"environmentType"];
}
- (YABaseServers<YABaseServiceProtocol> *)serviceWithType:(YAServiceType)type
{
    if (self.serviceStorage[@(type)] == nil) {
        self.serviceStorage[@(type)] = [self newServiceWithType:type];
    }
    return self.serviceStorage[@(type)];
}

#pragma mark - private methods
- (YABaseServers<YABaseServiceProtocol> *)newServiceWithType:(YAServiceType)type
{
    YABaseServers<YABaseServiceProtocol> *service = nil;
    switch (type) {
        case YAServiceYA:
            service = [[YAServer alloc] init];
            break;
        case YAServiceFWZ:
            service = [[FWZServer alloc] init];
            break;
        default:
            break;
    }
    return service;
}
#pragma mark - getters and setters
- (NSMutableDictionary *)serviceStorage
{
    if (_serviceStorage == nil) {
        _serviceStorage = [[NSMutableDictionary alloc] init];
    }
    return _serviceStorage;
}

@end
