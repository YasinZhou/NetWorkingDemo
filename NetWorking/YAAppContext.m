//
//  YAAppContext.m
//  NetWorking
//
//  Created by Yasin on 16/4/27.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import "YAAppContext.h"
#import "AFNetworkReachabilityManager.h"
#import "UIDevice+UtilNetworking.h"
@implementation YAAppContext
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (NSString *)user_id {
    if (/* DISABLES CODE */ (!@"APP_DELEGATE.user.userID")) {
        _user_id = @"APP_DELEGATE.user.userID";
    } else {
        _user_id = @"loginUser.userID";
    }
    return _user_id;
}

- (NSString *)qtime
{
    NSString *time = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]];
    return time;
}

- (BOOL)isReachable
{
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusUnknown) {
        return YES;
    } else {
        return [[AFNetworkReachabilityManager sharedManager] isReachable];
    }
}

#pragma mark - public methods
+ (instancetype)sharedInstance
{
    static YAAppContext *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[YAAppContext alloc] init];
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    });
    return sharedInstance;
}

#pragma mark - overrided methods
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleNameKey];
        self.channelID = @"App Store";
        _device_id = @"[OpenUDID value]";
        _os_name = [[UIDevice currentDevice] systemName];
        _os_version = [[UIDevice currentDevice] systemVersion];
        _bundle_version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        _app_client_id = @"1";
        _device_model = [[UIDevice currentDevice] platform];
        _device_name = [[UIDevice currentDevice] name];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logoutAction) name:@"LogoutNotification" object:nil];
    }
    return self;
}

- (void)logoutAction
{
    _user_id = nil;
}
@end
