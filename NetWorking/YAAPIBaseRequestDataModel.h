//
//  YAAPIBaseRequestDataModel.h
//  NetWorking
//
//  Created by Yasin on 16/4/27.
//  Copyright © 2016年 Yasin. All rights reserved.
//
/**
 *  网络请求参数传递类，只在BaseEngine以下的层次传递使用
 */
#import <Foundation/Foundation.h>
#import "ServerConfig.h"
@interface YAAPIBaseRequestDataModel : NSObject
/**
 *  网络请求参数
 */
@property (nonatomic, strong) NSString *apiMethodPath;              //网络请求地址
@property (nonatomic, assign) YAServiceType serviceType;            //服务器标识
@property (nonatomic, strong) NSDictionary *parameters;             //请求参数
@property (nonatomic, assign) YAAPIManagerRequestType requestType;  //网络请求方式
@property (nonatomic, copy) CompletionDataBlock responseBlock;      //请求着陆回调

// upload
// upload file
@property (nonatomic, strong) NSString *dataFilePath;
@property (nonatomic, strong) NSString *dataName;
@property (nonatomic, strong) NSString *fileName;
@property (nonatomic, strong) NSString *mimeType;

// download
// download file

// progressBlock
@property (nonatomic, copy) ProgressBlock uploadProgressBlock;
@property (nonatomic, copy) ProgressBlock downloadProgressBlock;


@end
