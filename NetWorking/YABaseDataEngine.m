//
//  YABaseDataEngine.m
//  NetWorking
//
//  Created by Yasin on 16/4/27.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import "YABaseDataEngine.h"
#import "YAAPIBaseRequestDataModel.h"
#import "YAAPIClient.h"
#import "NSObject+YANetWorkingAutoCancel.h"
@interface YABaseDataEngine ()

@property (nonatomic, strong) NSNumber *requestID;

@end
@implementation YABaseDataEngine
#pragma mark - life cycle
- (void)dealloc{
    [self cancelRequest];
}
#pragma mark - public methods
/**
 *  取消self持有的hash的网络请求
 */
- (void)cancelRequest{
    [[YAAPIClient sharedInstance] cancelRequestWithRequestID:self.requestID];
}

/// get/post
+ (YABaseDataEngine *)control:(NSObject *)control
       callAPIWithServiceType:(YAServiceType)serviceType
                         path:(NSString *)path
                        param:(NSDictionary *)parameters
                  requestType:(YAAPIManagerRequestType)requestType
                    alertType:(DataEngineAlertType)alertType
                progressBlock:(ProgressBlock)progressBlock
                     complete:(CompletionDataBlock)responseBlock
       errorButtonSelectIndex:(ErrorAlertSelectIndexBlock)errorButtonSelectIndexBlock{
    YABaseDataEngine *engine = [[YABaseDataEngine alloc]init];
    __weak typeof(control) weakControl = control;
    YAAPIBaseRequestDataModel *dataModel = [engine dataModelWith:serviceType path:path param:parameters dataFilePath:nil dataName:nil fileName:nil mimeType:nil requestType:requestType uploadProgressBlock:progressBlock downloadProgressBlock:nil complete:^(id data, NSError *error) {
        if (responseBlock) {
            //可以在这里做错误的UI处理，或者是在上层engine做
            responseBlock(data,error);
        }
        [weakControl.networkingAutoCancelRequests removeEngineWithRequestID:engine.requestID];
    }];
    [engine callRequestWithRequestModel:dataModel control:control];
    return engine;
}

// upload/download
+ (YABaseDataEngine *)control:(NSObject *)control
     uploadAPIWithServiceType:(YAServiceType)serviceType
                         path:(NSString *)path
                        param:(NSDictionary *)parameters
                 dataFilePath:(NSString *)dataFilePath
                     dataName:(NSString *)dataName
                     fileName:(NSString *)fileName
                     mimeType:(NSString *)mimeType
                  requestType:(YAAPIManagerRequestType)requestType
                    alertType:(DataEngineAlertType)alertType
          uploadProgressBlock:(ProgressBlock)uploadProgressBlock
        downloadProgressBlock:(ProgressBlock)downloadProgressBlock
                     complete:(CompletionDataBlock)responseBlock
       errorButtonSelectIndex:(ErrorAlertSelectIndexBlock)errorButtonSelectIndexBlock
{
    YABaseDataEngine *engine = [[YABaseDataEngine alloc]init];
    __weak typeof(control) weakControl = control;
    YAAPIBaseRequestDataModel *dataModel = [engine dataModelWith:serviceType path:path param:parameters dataFilePath:dataFilePath dataName:dataName fileName:fileName mimeType:mimeType requestType:requestType uploadProgressBlock:uploadProgressBlock downloadProgressBlock:downloadProgressBlock complete:^(id data, NSError *error) {
        if (responseBlock) {
            //可以在这里做错误的UI处理，或者是在上层engine做
            responseBlock(data,error);
        }
        [weakControl.networkingAutoCancelRequests removeEngineWithRequestID:engine.requestID];
    }];
    [engine callRequestWithRequestModel:dataModel control:control];
    return engine;
}

#pragma mark - UITableViewDelegate
#pragma mark - CustomDelegate
#pragma mark - event response
#pragma mark - private methods
- (YAAPIBaseRequestDataModel *)dataModelWith:(YAServiceType)serviceType
                                        path:(NSString *)path
                                       param:(NSDictionary *)parameters
                                dataFilePath:(NSString *)dataFilePath
                                    dataName:(NSString *)dataName
                                    fileName:(NSString *)fileName
                                    mimeType:(NSString *)mimeType
                                 requestType:(YAAPIManagerRequestType)requestType
                         uploadProgressBlock:(ProgressBlock)uploadProgressBlock
                       downloadProgressBlock:(ProgressBlock)downloadProgressBlock
                                    complete:(CompletionDataBlock)responseBlock
{
    YAAPIBaseRequestDataModel *dataModel = [[YAAPIBaseRequestDataModel alloc]init];
    dataModel.serviceType = serviceType;
    dataModel.apiMethodPath = path;
    dataModel.parameters = parameters;
    dataModel.dataFilePath = dataFilePath;
    dataModel.dataName = dataName;
    dataModel.mimeType = mimeType;
    dataModel.requestType = requestType;
    dataModel.uploadProgressBlock = uploadProgressBlock;
    dataModel.downloadProgressBlock = downloadProgressBlock;
    dataModel.responseBlock = responseBlock;
    return dataModel;
}

- (void)callRequestWithRequestModel:(YAAPIBaseRequestDataModel *)dataModel control:(NSObject *)control{
    self.requestID = [[YAAPIClient sharedInstance] callRequestWithRequestModel:dataModel];
    [control.networkingAutoCancelRequests setEngine:self requestID:self.requestID];
}
#pragma mark - getters and setters
@end
