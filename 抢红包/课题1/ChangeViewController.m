//
//  ChangeViewController.m
//  课题1
//
//  Created by yyh on 16/8/2.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ChangeViewController.h"
#import "HBViewController.h"
@interface ChangeViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *user;
@property (weak, nonatomic) IBOutlet UITextField *pw;
@property (weak, nonatomic) IBOutlet UITextField *pw2;

@property (weak, nonatomic) IBOutlet UIButton *confirm;
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UIImageView *passwordImageView;
@property (weak, nonatomic) IBOutlet UIImageView *passwordTooImageView;
//输入正确计算
@property (nonatomic ,assign) NSInteger number;
@property (nonatomic ,assign) NSInteger userNumber;
@property (nonatomic ,assign) NSInteger pwNumber;
@property (nonatomic ,assign) NSInteger pw2Number;

@end

@implementation ChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.number = 0;
    self.userNumber = 0;
    self.pwNumber = 0;
    self.pw2Number = 0;
    self.user.delegate = self;
    self.pw.delegate = self;
    self.pw2.delegate = self;
}
/**
 *  UITextField代理方法
 *
 */
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if ([textField isEqual:self.user]) {
        if ([textField.text isEqualToString:self.userName] ) {
            self.userImageView.image = [UIImage imageNamed:@"true"];
            self.userNumber = 1;
        } else {
            self.userImageView.image = [UIImage imageNamed:@"false"];
        }
        
    }
    /**
     *  密码判断
     */
    if ( [textField isEqual:self.self.pw]) {
        if (textField.text.length == 6) {
            self.passwordImageView.image = [UIImage imageNamed:@"true"];
            self.pwNumber = 1;
        }else{
            self.passwordImageView.image = [UIImage imageNamed:@"false"];
        }
    }
    /**
     *  再次输入密码的判断
     */
    if ([textField isEqual:self.self.pw2]) {
        if ([textField.text isEqualToString:self.pw.text]) {
            self.passwordTooImageView.image = [UIImage imageNamed:@"true"];
            self.pw2Number = 1;
            if (self.pwNumber + self.pw2Number + self.userNumber == 3) {
                //正确输入所有信息，返回红包界面，并返回新支付密码
                [self.delegate changPassword:self.pw.text];
                [self dismissViewControllerAnimated:YES completion:nil];
            }else{
                //弹出提示框
                [self popupHint];
            }
        }else{
            self.passwordTooImageView.image = [UIImage imageNamed:@"false"];
            //弹出提示框
            [self popupHint];
        }
    }
    
}
- (IBAction)pw2TextField:(UITextField *)sender {
}


- (IBAction)pwTextField:(UITextField *)sender {
    [self.pw2 becomeFirstResponder];
}



- (IBAction)userTextField:(UITextField *)sender {
    [self.pw becomeFirstResponder];
}

- (IBAction)confirmButton:(UIButton *)sender {
    if (self.pwNumber + self.pw2Number + self.userNumber == 3) {
        //正确输入所有信息，返回红包界面，并返回新支付密码
        [self.delegate changPassword:self.pw.text];
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        //弹出提示框
        [self popupHint];
    }
}

- (IBAction)backButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
/**
 *  输入错误弹出提示框
 */
-(void)popupHint{
    // 1.创建警告控制器
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"信息填写有误" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"重新输入" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {     
    }];
    
    [alert addAction:noAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}


@end
