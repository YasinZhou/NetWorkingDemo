//
//  ViewController.m
//  NetWorking
//
//  Created by Yasin on 16/4/27.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import "ViewController.h"
#import "SearchDataEngine.h"
@interface ViewController ()
@property (nonatomic, strong) YABaseDataEngine *searchDataEngine;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.searchDataEngine cancelRequest];
    self.searchDataEngine = [SearchDataEngine control:self searchKey:@"关键字" complete:^(id data, NSError *error) {
        if (error) {
            NSLog(@"%@",error.localizedDescription);
        } else {
            NSLog(@"%@",data);
        }
        
    }];
}

@end
