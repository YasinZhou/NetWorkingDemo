//
//  YAAPIClient.m
//  NetWorking
//
//  Created by Yasin on 16/4/27.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import "YAAPIClient.h"
#import "AFURLSessionManager.h"
#import "YAAPIURLRequestGenerator.h"
#import "YAAPIResponseErrorHandler.h"
@interface YAAPIClient()

//AFNetworking stuff
@property (nonatomic, strong) AFURLSessionManager *sessionManager;
// 根据 requestid，存放 task
@property (nonatomic, strong) NSMutableDictionary *dispatchTable;
@property (nonatomic, strong) NSNumber *recordedRequestId;
// 根据 requestID，存放 requestModel
@property (nonatomic, strong) NSMutableDictionary *requestModelDict;

@end
@implementation YAAPIClient
#pragma mark - life cycle
#pragma mark - public methods
+ (instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    static YAAPIClient *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[YAAPIClient alloc] init];
    });
    return sharedInstance;
}

/**
 *  根据dataModel发起网络请求，并根据dataModel发起回调
 *
 *
 *  @return 网络请求task哈希值
 */
- (NSNumber *)callRequestWithRequestModel:(YAAPIBaseRequestDataModel *)requestModel{
    NSURLRequest *request = [[YAAPIURLRequestGenerator sharedInstance] generateWithRequestDataModel:requestModel];
    typeof(self) __weak weakSelf = self;
    AFURLSessionManager *sessionManager = self.sessionManager;
    NSURLSessionDataTask *task = [sessionManager
                                  dataTaskWithRequest:request
                                  uploadProgress:requestModel.uploadProgressBlock
                                  downloadProgress:requestModel.downloadProgressBlock
                                  completionHandler:^(NSURLResponse * _Nonnull response,
                                                      id  _Nullable responseObject,
                                                      NSError * _Nullable error)
    {
        if (task.state == NSURLSessionTaskStateCanceling) {
            // 如果这个operation是被cancel的，那就不用处理回调了。
        } else {
            NSNumber *requestID = [NSNumber numberWithUnsignedInteger:task.hash];
            [weakSelf.dispatchTable removeObjectForKey:requestID];
            
            //在这里做网络错误的解析，只是整理成error(包含重新发起请求，比如重新获取签名后再次请求),不做任何UI处理(包含reload，常规reload不在这里处理)，
            //解析完成后通过调用requestModel.responseBlock进行回调
           [YAAPIResponseErrorHandler errorHandlerWithRequestDataModel:requestModel responseURL:response responseObject:responseObject error:error errorHandler:^(NSError *newError) {
                requestModel.responseBlock(responseObject, newError);
            }];
        }
    }];
    [task resume];
    NSNumber *requestID = [NSNumber numberWithUnsignedInteger:task.hash];
    [self.dispatchTable setObject:task forKey:requestID];
    return requestID;
}

/**
 *  取消网络请求
 */
- (void)cancelRequestWithRequestID:(NSNumber *)requestID{
    NSURLSessionDataTask *task = [self.dispatchTable objectForKey:requestID];
    [task cancel];
    [self.dispatchTable removeObjectForKey:requestID];
}
- (void)cancelRequestWithRequestIDList:(NSArray<NSNumber *> *)requestIDList{
    typeof(self) __weak weakSelf = self;
    [requestIDList enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSURLSessionDataTask *task = [weakSelf.dispatchTable objectForKey:obj];
        [task cancel];
    }];
    [self.dispatchTable removeObjectsForKeys:requestIDList];
}

#pragma mark - UITableViewDelegate
#pragma mark - CustomDelegate
#pragma mark - event response
#pragma mark - private methods
- (AFURLSessionManager *)getCommonSessionManager
{
    NSURLCache *URLCache = [[NSURLCache alloc] initWithMemoryCapacity:4 * 1024 * 1024 diskCapacity:20 * 1024 * 1024 diskPath:nil];
    [NSURLCache setSharedURLCache:URLCache];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.timeoutIntervalForResource = 20;
    
    AFURLSessionManager *sessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    return sessionManager;
}

#pragma mark - getters and setters
- (AFURLSessionManager *)sessionManager
{
    if (_sessionManager == nil) {
        _sessionManager = [self getCommonSessionManager];
        _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    return _sessionManager;
}
- (NSMutableDictionary *)dispatchTable{
    if (_dispatchTable == nil) {
        _dispatchTable = [[NSMutableDictionary alloc] init];
    }
    return _dispatchTable;
}
@end
