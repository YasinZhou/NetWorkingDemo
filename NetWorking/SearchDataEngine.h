//
//  SearchDataEngine.h
//  NetWorking
//
//  Created by Yasin on 16/4/28.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YABaseDataEngine.h"

@interface SearchDataEngine : NSObject

+ (YABaseDataEngine *)control:(NSObject *)control
                    searchKey:(NSString *)searchKey
                     complete:(CompletionDataBlock)responseBlock;
@end
