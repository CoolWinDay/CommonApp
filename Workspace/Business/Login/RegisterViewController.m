//
//  RegisterViewController.m
//  smsSDKDemo
//
//  Created by GKC on 16/4/6.
//  Copyright © 2016年 HXHG. All rights reserved.
//

#import "RegisterViewController.h"
#import <SMS_SDK/SMSSDK.h>
#import "AFNetworkReachabilityManager.h"
#import "ComAppDelegate.h"

typedef void(^NetWorkReachableBlock)(void);


static int _flag;

@interface RegisterViewController ()
{
    NSTimer * _timer;
    NSDate * _tempDate;
    int _tempFlag;
}

@end

@implementation RegisterViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _flag = 60;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapForKeyBoardHide)];
    [self.view addGestureRecognizer:tap];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appStateBackgroundForTimer) name:NotiApplicationStateBackground object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appStateForegroundForTimer) name:NotiApplicationStateForeground object:nil];
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
    
    __weak __typeof__(self) weakSelf = self;
    
    [weakSelf isNetWorkReachable:^{
        
        if (![self isValidatePhoneNum:self.numText.text]) {
            [weakSelf alertViewShow:@"请输入有效手机号码"];
            return;
        }
        
        if (!_timer) {
            _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:weakSelf selector:@selector(resetGetCodeBtn) userInfo:nil repeats:YES];
        }
        
        [sender setEnabled:NO];
        weakSelf.tileNumLab.text = [NSString stringWithFormat:@"(%d)",_flag];
        weakSelf.tileNumLab.hidden = NO;
        
        [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:weakSelf.numText.text zone:@"+86" customIdentifier:nil result:^(NSError *error) {
            if (!error)
            {
                [weakSelf alertViewShow:@"验证码已发送"];
            }
            else {
                [weakSelf alertViewShow:[error.userInfo objectForKey:NSLocalizedDescriptionKey]];
                NSLog(@"上传手机号失败 error %ld",(long)error.code);
                [self.getCodeBtn setEnabled:YES];
                self.tileNumLab.hidden = YES;
                [_timer invalidate];
                _timer = nil;
            }
        }];
        
//        [JSMSSDK getVerificationCodeWithPhoneNumber:weakSelf.numText.text andTemplateID:[NSString stringWithFormat:@"%d",1] completionHandler:^(id resultObject, NSError *error) {
//            if (!error) {
//                [weakSelf alertViewShow:@"验证码已发送"];
//            }
//            else {
//                [weakSelf alertViewShow:[error.userInfo objectForKey:NSLocalizedDescriptionKey]];
//                NSLog(@"上传手机号失败 error %ld",(long)error.code);
//                [self.getCodeBtn setEnabled:YES];
//                self.tileNumLab.hidden = YES;
//                [_timer invalidate];
//                _timer = nil;
//            }
//        }];
    }];
}


- (IBAction)registerBtnClick:(UIButton *)sender {
    [self.view endEditing:YES];
    
    __weak __typeof__(self) weakSelf = self;
    
    [weakSelf isNetWorkReachable:^{
        if (!weakSelf.codeText.text.length) {
            [weakSelf alertViewShow:@"请输入验证码"];
        }
        
        [SMSSDK commitVerificationCode:weakSelf.codeText.text phoneNumber:weakSelf.numText.text zone:@"+86" result:^(NSError *error) {
            if (!error) {
                [weakSelf alertViewShow:@"注册---验证成功"];
                NSLog(@"注册---验证成功");
            }
            else {
                [weakSelf alertViewShow:[error.userInfo objectForKey:NSLocalizedDescriptionKey]];
                NSLog(@"注册---验证失败 error %ld",(long)error.code);
            }
        }];
        
//        [JSMSSDK commitWithPhoneNumber:weakSelf.numText.text verificationCode:weakSelf.codeText.text completionHandler:^(id resultObject, NSError *error) {
//            if (!error) {
//                [weakSelf alertViewShow:@"注册---验证成功"];
//                NSLog(@"注册---验证成功");
//            }
//            else {
//                [weakSelf alertViewShow:[error.userInfo objectForKey:NSLocalizedDescriptionKey]];
//                NSLog(@"注册---验证失败 error %ld",(long)error.code);
//            }
//        }];
    }];
    
}

- (BOOL)isValidatePhoneNum:(NSString *)num {
    NSString * MOBILE = @"\\d{11}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",MOBILE];
    
    return [regextestmobile evaluateWithObject:num];
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

// 网络状态检测
- (BOOL)isNetWorkReachable:(NetWorkReachableBlock)block
{
    __weak __typeof__(self) weakSelf = self;
    
    __weak AFNetworkReachabilityManager *afNetworkReachabilityManager = [AFNetworkReachabilityManager sharedManager];
    // 开启网络监视器
    [afNetworkReachabilityManager startMonitoring];
    
    [afNetworkReachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //          stopMonitoring
        [afNetworkReachabilityManager stopMonitoring];
        
        switch (status) {
                case AFNetworkReachabilityStatusNotReachable:
            {
                NSString * temp = @"当前无网络连接";
                [weakSelf alertViewShow:temp];
                break;
            }
                case AFNetworkReachabilityStatusReachableViaWiFi:
                case AFNetworkReachabilityStatusReachableViaWWAN:
            {
                block();
                break;
            }
            default:
                break;
        }
        
    }];
    
    return afNetworkReachabilityManager.isReachable;
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
