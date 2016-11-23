//
//  SXSubmitLoadingView.m
//  TPORoot
//
//  Created by SunX on 14-7-9.
//  Copyright (c) 2014年 SunX. All rights reserved.
//

#import "ComLoadingView.h"
#import "MBProgressHUD.h"
#import "UIView+Additions.h"

#define DefaultOpacity 0.3

static MBProgressHUD  *s_progressHUD = nil;

@implementation ComLoadingView

+ (void)showLoadingHUD:(NSString *)aString {
    [self showLoadingHUD:aString onWindow:NO];
}

+ (void)showLoadingHUD:(NSString *)aString onWindow:(BOOL)isOnWindow {
    UIView *view = isOnWindow ? mainWindow() : topMostViewController().view;
    if (!view) {
        return;
    }
    
    if (!s_progressHUD) {
        static dispatch_once_t once;
        dispatch_once(&once, ^{
            s_progressHUD = [[MBProgressHUD alloc] initWithView:view];
            s_progressHUD.opacity = DefaultOpacity;
            s_progressHUD.labelFont = [UIFont boldSystemFontOfSize:12.0];
            s_progressHUD.labelColor = [UIColor colorWithWhite:0.95 alpha:1.0];
        });
    }
    
    if (![view.subviews containsObject:s_progressHUD]) {
        [view addSubview:s_progressHUD];
    }
    [view bringSubviewToFront:s_progressHUD];
    
    s_progressHUD.labelText = aString;
    [s_progressHUD show:YES];
}


+ (void)showMsgHUD:(NSString *)aString duration:(CGFloat)duration touchClose:(BOOL)close{
    UIWindow *window = mainWindow();
    if (!window) {
        return;
    }
    
    [self hideLoadingHUD];
    MBProgressHUD *progressHUD = [[MBProgressHUD alloc] initWithView:window];
    [window addSubview:progressHUD];
    progressHUD.animationType = MBProgressHUDAnimationZoom;
    progressHUD.detailsLabelText = aString;
    progressHUD.removeFromSuperViewOnHide = YES;
    progressHUD.opacity = DefaultOpacity;
    progressHUD.mode = MBProgressHUDModeText;
    [progressHUD show:NO];
    [progressHUD hide:NO afterDelay:duration];
    if (close) {
        [progressHUD handleClick:^(UIView *view) {
            [(MBProgressHUD*)view hide:NO];
        }];
    }
}

+ (void)showMsgHUD:(NSString *)aString duration:(CGFloat)duration {
    [self showMsgHUD:aString duration:duration touchClose:NO];
}

+ (void)hideLoadingHUD {
    if (s_progressHUD) {
        [s_progressHUD hide:YES afterDelay:0.2];
    }
}

+ (void)updateLoadingHUD:(NSString*)progress {
    if (s_progressHUD) {
        s_progressHUD.detailsLabelText = progress;
    }
}

+ (void)showLoadingHUD:(NSString *)aString duration:(CGFloat)duration {
    UIWindow *window = mainWindow();
    if (!window) {
        return;
    }
    
    [self hideLoadingHUD];
    MBProgressHUD *progressHUD = [[MBProgressHUD alloc] initWithView:window];
    [window addSubview:progressHUD];
    progressHUD.animationType = MBProgressHUDAnimationZoom;
    progressHUD.detailsLabelText = aString;
    progressHUD.removeFromSuperViewOnHide = YES;
    progressHUD.opacity = DefaultOpacity;
    [progressHUD show:NO];
    [progressHUD hide:NO afterDelay:duration];
}

@end
