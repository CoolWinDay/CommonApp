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
    UIWindow *window = mainWindow();
    if (!window) {
        return;
    }
    
    if (!s_progressHUD) {
        static dispatch_once_t once;
        dispatch_once(&once, ^{
            s_progressHUD = [[MBProgressHUD alloc] initWithView:window];
            s_progressHUD.opacity = DefaultOpacity;
            s_progressHUD.labelFont = [UIFont boldSystemFontOfSize:14.0];
        });
        [window addSubview:s_progressHUD];
    }
    
    s_progressHUD.labelText = aString;
    [s_progressHUD show:NO];
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
        [s_progressHUD hide:NO];
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
