//
//  YASignatureGenerator.m
//  NetWorking
//
//  Created by Yasin on 16/4/27.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import "YASignatureGenerator.h"
#import <CommonCrypto/CommonDigest.h>
@implementation YASignatureGenerator
+ (NSString *)sign:(NSDictionary *)dict {
    NSString *result;
    NSArray *sortedKeys = [[dict allKeys] sortedArrayUsingSelector:@selector(compare:)];
    NSMutableArray *sortedValues = [NSMutableArray array];
    for (NSString *key in sortedKeys) {
        [sortedValues addObject:key];
    }
    NSString *inputString;
    for (int i = 0; i < [sortedValues count]; i++) {
        if (i == 0) {
            inputString = [NSString stringWithFormat:@"%@=%@", [sortedValues objectAtIndex:i], [dict valueForKey:[sortedValues objectAtIndex:i]]];
        } else {
            inputString = [inputString stringByAppendingString:[NSString stringWithFormat:@"&%@=%@", [sortedValues objectAtIndex:i], [dict valueForKey:[sortedValues objectAtIndex:i]]]];
        }
    }
    
    result = [self md5:inputString];
    
    return result;
}
+ (NSString *)md5:(NSString *)input {
    const char *cStr = [[input dataUsingEncoding:NSUTF8StringEncoding] bytes];
    
    unsigned char digest[16];
    CC_MD5(cStr, (uint32_t)[[input dataUsingEncoding:NSUTF8StringEncoding] length], digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}
@end
