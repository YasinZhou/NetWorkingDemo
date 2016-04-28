//
//  YABaseDataEngine.h
//  NetWorking
//
//  Created by Yasin on 16/4/27.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServerConfig.h"
@interface YABaseDataEngine : NSObject
/**
 *  取消self持有的hash的网络请求
 */
- (void)cancelRequest;

/**
 *  下面的区分get/post/upload/download只是为了上层Engine调用方便，实现都是一样的
 */

/// get/post
+ (YABaseDataEngine *)control:(NSObject *)control
       callAPIWithServiceType:(YAServiceType)serviceType
                         path:(NSString *)path
                        param:(NSDictionary *)parameters
                  requestType:(YAAPIManagerRequestType)requestType
                    alertType:(DataEngineAlertType)alertType
                progressBlock:(ProgressBlock)progressBlock
                     complete:(CompletionDataBlock)responseBlock
       errorButtonSelectIndex:(ErrorAlertSelectIndexBlock)errorButtonSelectIndexBlock;

// upload
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
       errorButtonSelectIndex:(ErrorAlertSelectIndexBlock)errorButtonSelectIndexBlock;

// download
@end
