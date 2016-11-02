//
//  RegisterViewController.h
//  smsSDKDemo
//
//  Created by GKC on 16/4/6.
//  Copyright © 2016年 HXHG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *numText;
@property (strong, nonatomic) IBOutlet UITextField *codeText;
@property (strong, nonatomic) IBOutlet UIButton *getCodeBtn;
@property (strong, nonatomic) IBOutlet UILabel *tileNumLab;
@property (strong, nonatomic) IBOutlet UIButton *closeButton;

@property (nonatomic, copy) BoolBlock resultBlock;

@end
