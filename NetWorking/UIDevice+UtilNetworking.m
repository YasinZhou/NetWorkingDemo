//
//  UIDevice+UtilNetworking.m
//  NetWorking
//
//  Created by Yasin on 16/4/27.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import "UIDevice+UtilNetworking.h"
#include <sys/sysctl.h>
@implementation UIDevice (UtilNetworking)
- (NSString *)platform
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *answer = malloc(size);
    sysctlbyname("hw.machine", answer, &size, NULL, 0);
    NSString *results = [NSString stringWithCString:answer encoding: NSUTF8StringEncoding];
    free(answer);
    if (!results) {
        results = @"";
    }
    return results;
}

-(NSString *)correspondVersion
{
    NSString *platform = [self platform];
    
    if ([platform isEqualToString:@"i386"])      return@"Simulator";
    if ([platform isEqualToString:@"x86_64"])    return @"Simulator";
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G (A1203)";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G (A1241/A1324)";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS (A1303/A1325)";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4 (A1349)";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S (A1387/A1431)";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5 (A1428)";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5 (A1429/A1442)";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c (A1456/A1532)";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c (A1507/A1516/A1526/A1529)";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s (A1453/A1533)";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s (A1457/A1518/A1528/A1530)";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus (A1522/A1524)";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6 (A1549/A1586)";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6S";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6S Plus";
    
    
    if ([platform isEqualToString:@"iPod1,1"])     return@"iPod Touch 1";
    if ([platform isEqualToString:@"iPod2,1"])     return@"iPod Touch 2";
    if ([platform isEqualToString:@"iPod3,1"])     return@"iPod Touch 3";
    if ([platform isEqualToString:@"iPod4,1"])     return@"iPod Touch 4";
    if ([platform isEqualToString:@"iPod5,1"])     return@"iPod Touch 5";
    
    if ([platform isEqualToString:@"iPad1,1"])     return@"iPad 1";
    if ([platform isEqualToString:@"iPad2,1"] || [platform isEqualToString:@"iPad2,2"] || [platform isEqualToString:@"iPad2,3"] || [platform isEqualToString:@"iPad2,4"])     return@"iPad 2";
    if ([platform isEqualToString:@"iPad2,5"] || [platform isEqualToString:@"iPad2,6"] || [platform isEqualToString:@"iPad2,7"] )      return @"iPad Mini";
    if ([platform isEqualToString:@"iPad3,1"] || [platform isEqualToString:@"iPad3,2"] || [platform isEqualToString:@"iPad3,3"] || [platform isEqualToString:@"iPad3,4"] || [platform isEqualToString:@"iPad3,5"] || [platform isEqualToString:@"iPad3,6"])      return @"iPad 3";
    
    return platform;
}
@end
