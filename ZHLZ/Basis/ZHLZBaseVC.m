//
//  ZHLZBaseVC.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/12.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZBaseVC.h"

@interface ZHLZBaseVC ()

@end

@implementation ZHLZBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageNo = 1;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self cancelAllTask];
}

- (void)dismissViewControllerAnimated:(BOOL)animated completion:(void (^ __nullable)(void))completion {
    [super dismissViewControllerAnimated:animated completion:completion];
    
    [self cancelAllTask];
}

- (void)cancelAllTask {
    for (NSURLSessionTask *task in self.tasks) {
        [task cancel];
    }
}

- (void)popActionWithTip:(NSString *)tip withBlock:(dispatch_block_t)block {
    [self popActionWithTitle:nil withTip:tip withBlock:block];
}

- (void)popActionWithTitle:(NSString * _Nullable)title withTip:(NSString *)tip withBlock:(dispatch_block_t)block {
    UIAlertAction *leftAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *rightAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        block();
    }];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:tip preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:leftAction];
    [alertController addAction:rightAction];
    [self presentViewController:alertController animated:NO completion:nil];
}

#pragma mark - getter and setter

- (void)setTask:(__kindof NSURLSessionTask *)task {
    if (task && [task isKindOfClass:[NSURLSessionTask class]]) {
        [self.tasks addObject:task];
    }
}

- (NSMutableArray <__kindof NSURLSessionTask *> *)tasks {
    if (_tasks) {
        return _tasks;
    }
    _tasks = [NSMutableArray array];
    return _tasks;
}

- (void)setNavTitle:(NSString *)navTitle {
    self.navigationItem.title = navTitle;
}

@end
