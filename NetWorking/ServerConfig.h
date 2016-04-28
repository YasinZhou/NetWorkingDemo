//
//  ServerConfig.h
//  NetWorking
//
//  Created by Yasin on 16/4/27.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#ifndef ServerConfig_h
#define ServerConfig_h

#if !defined YA_BUILD_FOR_DEVELOP && !defined YA_BUILD_FOR_TEST && !defined YA_BUILD_FOR_RELEASE && !defined YA_BUILD_FOR_PRERELEASE

#define YA_BUILD_FOR_DEVELOP
//#define YA_BUILD_FOR_TEST
//#define YA_BUILD_FOR_PRERELEASE
//#define YA_BUILD_FOR_HOTFIX
//#define YA_BUILD_FOR_RELEASE      //该环境的优先级最高

#endif

#if (defined(DEBUG) || defined(ADHOC) || !defined YA_BUILD_FOR_RELEASE)
#define DELog(format, ...)  NSLog((@"FUNC:%s\n" "LINE:%d\n" format), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define DELog(format, ...)
#endif

typedef NS_ENUM(NSUInteger, YAServiceType) {
    YAServiceYA,      //YA服务器
    YAServiceFWZ,       //FWZ服务器
};

typedef NS_ENUM (NSUInteger, YAAPIManagerRequestType){
    YAAPIManagerRequestTypeGet,                 //get请求
    YAAPIManagerRequestTypePost,                //POST请求
    YAAPIManagerRequestTypePostUpload,             //POST数据请求
    YAAPIManagerRequestTypeGETDownload             //下载文件请求，不做返回值解析
};

typedef NS_ENUM(NSInteger, DataEngineAlertType) {
    DataEngineAlertType_None,
    DataEngineAlertType_Toast,
    DataEngineAlertType_Alert,
    DataEngineAlertType_ErrorView
};

typedef void (^ProgressBlock)(NSProgress *taskProgress);
typedef void (^CompletionDataBlock)(id data, NSError *error);
typedef void (^ErrorAlertSelectIndexBlock)(NSUInteger buttonIndex);



#endif /* ServerConfig_h */
