//
//  NavRootVC.m
//  CRM
//
//  Created by Arthur on 16/2/29.
//  Copyright © 2016年 Arthur. All rights reserved.
//
#import "NSString+Check.h"
#import "NavRootVC.h"


@interface NavRootVC ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>
//@property(nonatomic,weak) UIViewController* currentShowVC;
@end

@implementation NavRootVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //  避免禁用了滑动手势返回的操作
    self.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if ([NSStringFromClass(self.viewControllers.lastObject.class) containsText:@"Success"]) {
        return NO;
    }
    if (self.viewControllers.count>1) {
        return YES;
    }
    return NO;
}


@end
