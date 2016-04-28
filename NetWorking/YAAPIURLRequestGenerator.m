//
//  YAAPIURLRequestGenerator.m
//  NetWorking
//
//  Created by Yasin on 16/4/27.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import "YAAPIURLRequestGenerator.h"
#import "AFURLRequestSerialization.h"

#import "YAServerFactory.h"
#import "YACommonParamsGenerator.h"
#import "YASignatureGenerator.h"
#import "NSString+UtilNetworking.h"

static NSTimeInterval kYANetworkingTimeoutSeconds = 20.0f;
@interface YAAPIURLRequestGenerator()
@property (nonatomic, strong) AFHTTPRequestSerializer *httpRequestSerializer;
//@property (nonatomic, strong) AFJSONRequestSerializer *jsonRequestSerializer;
@end
@implementation YAAPIURLRequestGenerator
#pragma mark - life cycle
/**
 *  生成一个单例
 */
+ (instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    static YAAPIURLRequestGenerator *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[YAAPIURLRequestGenerator alloc] init];
    });
    return sharedInstance;
}

#pragma mark - public methods
- (NSURLRequest *)generateWithRequestDataModel:(YAAPIBaseRequestDataModel *)dataModel{
    YABaseServers *service = [[YAServerFactory sharedInstance] serviceWithType:dataModel.serviceType];
    NSMutableDictionary *commonParams = [NSMutableDictionary dictionaryWithDictionary:[YACommonParamsGenerator commonParamsDictionary]];
    [commonParams addEntriesFromDictionary:dataModel.parameters];
    if (![NSString isEmptyString:service.privateKey]) {
        /**
         *  每个公司的签名方法不同，可以根据自己的设计进行修改，这里是将privateKey放在参数里面，然后将所有的参数和参数名转成字符串进行MD5，将得到的MD5值放进commonParams，上传的时候再讲privateKey从commonParams移除
         */
//        commonParams[@"private_key"] = service.privateKey;
//        NSString *signature = [YASignatureGenerator sign:commonParams];
//        commonParams[@"sign"] = signature;
//        [commonParams removeObjectForKey:@"private_key"];
    }
    
    NSString *urlString = [self URLStringWithServiceUrl:service.apiBaseUrl path:dataModel.apiMethodPath];
    NSError *error;
    NSMutableURLRequest *request;
    /**
     *      YAAPIManagerRequestTypeGet,                 //get请求
     YAAPIManagerRequestTypePost,                //POST请求
     YAAPIManagerRequestTypePostUpload,             //POST数据请求
     YAAPIManagerRequestTypeGETDownload
     */
    if (dataModel.requestType == YAAPIManagerRequestTypeGet) {
        request = [self.httpRequestSerializer requestWithMethod:@"GET" URLString:urlString parameters:commonParams error:&error];
    } else if (dataModel.requestType == YAAPIManagerRequestTypePost) {
        request = [self.httpRequestSerializer requestWithMethod:@"POST" URLString:urlString parameters:commonParams error:&error];
    } else if (dataModel.requestType == YAAPIManagerRequestTypePostUpload) {
        request = [self.httpRequestSerializer multipartFormRequestWithMethod:@"POST" URLString:urlString parameters:commonParams constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            /**
             *  这里的参数配置也可以根据自己的设计修改默认值.
             为什么没有直接使用NSData?
             */
            if (![NSString isEmptyString:dataModel.dataFilePath]) {
                NSURL *fileURL = [NSURL fileURLWithPath:dataModel.dataFilePath];
                NSString *name = dataModel.dataName?dataModel.dataName:@"data";
                NSString *fileName = dataModel.fileName?dataModel.fileName:@"data.zip";
                NSString *mimeType = dataModel.mimeType?dataModel.mimeType:@"application/zip";
                NSError *error;
                [formData appendPartWithFileURL:fileURL
                                           name:name
                                       fileName:fileName
                                       mimeType:mimeType
                                          error:&error];
            }
            
        } error:&error];
    }
    if (error || request == nil) {
        DELog(@"NSMutableURLRequests生成失败：\n---------------------------\n\
              urlString:%@\n\
              \n---------------------------\n",urlString);
        return nil;
    }
    
    request.timeoutInterval = kYANetworkingTimeoutSeconds;
    return request;
}
#pragma mark - private methods
- (NSString *)URLStringWithServiceUrl:(NSString *)serviceUrl path:(NSString *)path{
    NSURL *fullURL = [NSURL URLWithString:serviceUrl];
    if (![NSString isEmptyString:path]) {
        fullURL = [NSURL URLWithString:path relativeToURL:fullURL];
    }
    if (fullURL == nil) {
        DELog(@"YAAPIURLRequestGenerator--URL拼接错误:\n---------------------------\n\
              apiBaseUrl:%@\n\
              urlPath:%@\n\
              \n---------------------------\n",serviceUrl,path);
        return nil;
    }
    return [fullURL absoluteString];
}
#pragma mark - getters and setters
- (AFHTTPRequestSerializer *)httpRequestSerializer
{
    if (_httpRequestSerializer == nil) {
        _httpRequestSerializer = [AFHTTPRequestSerializer serializer];
        _httpRequestSerializer.timeoutInterval = kYANetworkingTimeoutSeconds;
        _httpRequestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    }
    return _httpRequestSerializer;
}
@end