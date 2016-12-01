//
//  ComBaseViewController.h
//  CommonApp
//
//  Created by lipeng on 16/5/2.
//  Copyright © 2016年 common. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LogInPprotocol.h"

@interface ComBaseViewController : UIViewController <LogInPprotocol>

- (void)showRightBar:(NSString *)title action:(VoidBlock)block;

@end
