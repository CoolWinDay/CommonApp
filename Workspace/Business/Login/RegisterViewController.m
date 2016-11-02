//
//  RegisterViewController.m
//  smsSDKDemo
//
//  Created by GKC on 16/4/6.
//  Copyright © 2016年 HXHG. All rights reserved.
//

#import "RegisterViewController.h"
#import "AFNetworkReachabilityManager.h"
#import "ComAppDelegate.h"
#import "ComSMSManager.h"
#import "NSString+Validate.h"
#import "ComNetManager.h"

typedef void(^NetWorkReachableBlock)(void);

static int _flag;

@interface RegisterViewController ()
{
    NSDate * _tempDate;
    int _tempFlag;
}
@property(nonatomic, strong) NSTimer *timer;

@end

@implementation RegisterViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"注册";
    
    _flag = 60;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapForKeyBoardHide)];
    [self.view addGestureRecognizer:tap];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appStateBackgroundForTimer) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appStateForegroundForTimer) name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (void)appStateBackgroundForTimer {
    if (_timer) {
        _tempDate = [NSDate date];
        _tempFlag = _flag;
    }
}

- (void)appStateForegroundForTimer {
    if (_timer) {
        double temp = [[NSDate date] timeIntervalSinceDate:_tempDate];
        _flag = _tempFlag - temp;
        
        if (_flag <= 0) {
            _flag = 60;
            [self.getCodeBtn setEnabled:YES];
            self.tileNumLab.hidden = YES;
            [_timer invalidate];
            _timer = nil;
        }
    }
}

- (void)tapForKeyBoardHide {
    [self.view endEditing:YES];
}

- (void)resetGetCodeBtn {
    self.tileNumLab.text = [NSString stringWithFormat:@"(%d)",_flag];
    if (_flag <= 0) {
        _flag = 60;
        [self.getCodeBtn setEnabled:YES];
        self.tileNumLab.hidden = YES;
        [_timer invalidate];
        _timer = nil;
        return;
    }
    
    _flag--;
}

- (IBAction)getCodeBtnClick:(UIButton *)sender {
    [self.view endEditing:YES];
    AppWeakSelf
    if ([ComNetManager isNetwork]) {
        NSString *phoneNumber = [weakSelf.numText.text trimSpace];
        if (![phoneNumber isPhoneNumber]) {
            [weakSelf alertViewShow:@"请输入有效手机号码"];
            return;
        }
        
        if (!weakSelf.timer) {
            weakSelf.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:weakSelf selector:@selector(resetGetCodeBtn) userInfo:nil repeats:YES];
        }
        
        [sender setEnabled:NO];
        weakSelf.tileNumLab.text = [NSString stringWithFormat:@"(%d)", _flag];
        weakSelf.tileNumLab.hidden = NO;
        
        [ComSMSManager getVerificationCodeWithPhoneNumber:weakSelf.numText.text result:^(NSError *error) {
            if (!error) {
                [weakSelf alertViewShow:@"验证码已发送"];
            }
            else {
                [weakSelf alertViewShow:[error.userInfo objectForKey:NSLocalizedDescriptionKey]];
                NSLog(@"上传手机号失败 error %ld",(long)error.code);
                [self.getCodeBtn setEnabled:YES];
                self.tileNumLab.hidden = YES;
                [weakSelf.timer invalidate];
                weakSelf.timer = nil;
            }
        }];
    }
}


- (IBAction)registerBtnClick:(UIButton *)sender {
    [self.view endEditing:YES];
    AppWeakSelf
    if ([ComNetManager isNetwork]) {
        if (!weakSelf.codeText.text.length) {
            [weakSelf alertViewShow:@"请输入验证码"];
        }
        
        [ComSMSManager commitWithPhoneNumber:weakSelf.numText.text verificationCode:weakSelf.codeText.text result:^(NSError *error) {
            if (!error) {
                [weakSelf alertViewShow:@"注册---验证成功"];
                NSLog(@"注册---验证成功");
                
                [UserManager userLogin:[UserModel new]];
                
                [weakSelf closePage:nil];
                if (weakSelf.resultBlock) {
                    weakSelf.resultBlock(YES);
                }
            }
            else {
                [weakSelf alertViewShow:[error.userInfo objectForKey:NSLocalizedDescriptionKey]];
                NSLog(@"注册---验证失败 error %ld",(long)error.code);
            }
        }];
    }
    
}

- (void)alertViewShow:(NSString *)alertText {
    UILabel* alertLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 250, 20)];
    alertLabel.center = CGPointMake(160, 400);
    alertLabel.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.3];
    alertLabel.text = alertText;
    alertLabel.font = [UIFont systemFontOfSize:10];
    alertLabel.textAlignment = NSTextAlignmentCenter;
    [[UIApplication sharedApplication].keyWindow addSubview:alertLabel];
    
    [alertLabel performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:3.0];
}

- (IBAction)closePage:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
