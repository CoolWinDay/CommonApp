//
//  ComErrorViewManager.m
//  CommonApp
//
//  Created by lipeng on 16/4/8.
//  Copyright © 2016年 common. All rights reserved.
//

#import "ComErrorViewManager.h"

#define ERROR_VIEW_TAG         201601

@implementation ComErrorViewManager

+ (UILabel *)initErrorViewInView:(UIView *)view {
    [[view viewWithTag:ERROR_VIEW_TAG] removeFromSuperview];
    UILabel *errorView = [[UILabel alloc] initWithFrame:view.bounds];
    errorView.tag = ERROR_VIEW_TAG;
    errorView.textAlignment = NSTextAlignmentCenter;
    errorView.numberOfLines = 0;
    errorView.backgroundColor = [UIColor whiteColor];
    [view addSubview:errorView];
    
    return errorView;
}

+ (UIView*)showErrorViewInView:(UIView*)view withError:(NSError*)error clickBlock:(voidBlock)block {
    UILabel *errorView = [[self class] initErrorViewInView:view];
    NSString *errorMsg = error.domain;
    errorView.text = @"报错啦~~~\n点击重新加载";
    
    [errorView handleTapEventWithBlock:^{
        if (block) {
            block();
        }
    }];
    
    return errorView;
}

+ (UIView*)showErrorViewInView:(UIView*)view withError:(NSError*)error {
    UILabel *errorView = [[self class] initErrorViewInView:view];
    NSString *errorMsg = error.domain;
    errorView.text = @"报错啦~~~";
    
    return errorView;
}

+ (void)removeErrorViewFromView:(UIView*)view  {
    [[view viewWithTag:ERROR_VIEW_TAG] removeFromSuperview];
}

+ (UIView*)showEmptyViewInView:(UIView*)view clickBlock:(voidBlock)block {
    UILabel *errorView = [[self class] initErrorViewInView:view];
    errorView.text = @"空的啊~~~\n点击重新加载";
    
    [errorView handleTapEventWithBlock:^{
        if (block) {
            block();
        }
    }];
    
    return errorView;
}

+ (UIView*)showEmptyViewInView:(UIView*)view {
    UILabel *errorView = [[self class] initErrorViewInView:view];
    errorView.text = @"空的啊~~~";
    
    return errorView;
}

+ (UIView*)showErrorString:(NSString*)string inView:(UIView*)view {
    UILabel *errorView = [[self class] initErrorViewInView:view];
    errorView.font = [UIFont systemFontOfSize:18.f];
    errorView.text = string;
    return errorView;
}

@end
