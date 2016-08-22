//
//  HBViewController.m
//  课题1
//
//  Created by yyh on 16/8/2.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "HBViewController.h"
#import "ChatViewController.h"
#import "ChangeViewController.h"
@interface HBViewController ()<UITextFieldDelegate,ChangeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *hbNumber;
@property (weak, nonatomic) IBOutlet UITextField *hbMoney;
@property (weak, nonatomic) IBOutlet UITextField *hbLeaveWord;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
/** 支付密码 */
@property (nonatomic, copy) NSString *originalPassword;
//支付按钮
@property (weak, nonatomic) IBOutlet UIButton *payment;
//支付提示
@property (strong ,nonatomic) UIAlertController *alert;
@end

@implementation HBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.originalPassword = @"123456";
    
    self.payment.enabled = NO;
}
-(void)changButtonState{
    self.moneyLabel.text = [NSString stringWithFormat:@"￥%.2f",[self.hbMoney.text doubleValue]];
    if (![_hbNumber.text isEqualToString:@""] && ![_hbMoney.text isEqualToString:@""]&&[_hbNumber.text integerValue] != 0 && [_hbMoney.text doubleValue] != 0.0) {
        self.payment.backgroundColor = [UIColor colorWithRed:0.892 green:0.245 blue:0.212 alpha:1.000];
        
        self.payment.enabled = YES;
    }

}
- (IBAction)hbNumberTextField:(UITextField *)sender {
    [self.hbMoney becomeFirstResponder];
    [self changButtonState];
    }
- (IBAction)hbMenoyTextField:(UITextField *)sender {
    [self.hbLeaveWord becomeFirstResponder];
    [self changButtonState];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    [self changButtonState];
}
- (IBAction)hbLeaveWordTextField:(UITextField *)sender {
    [self changButtonState];
    
}
- (IBAction)backButton:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
/**
 *  输入成功，跳转回聊天界面
 */
-(void)succeedPayment{
    if ([_hbLeaveWord.text isEqualToString:@""] == YES) {
        _hbLeaveWord.text = @"恭喜发财，大吉大利！";
    }
    [self.delegate hbMoney:[NSString stringWithFormat:@"￥%0.2f",arc4random()%[self.hbMoney.text longLongValue]*1.0-0.33] andLeaveWord:self.hbLeaveWord.text andShowHB:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}
/**
 *  输入错误弹出提示框
 */
-(void)popupHint{
    // 1.创建警告控制器
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"支付密码输入错误" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"忘记密码" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"跳转至修改密码界面");
        ChangeViewController *changeVC = [[ChangeViewController alloc]init];
        changeVC.userName = @"isd1606";
        changeVC.delegate = self;
        [self presentViewController:changeVC animated:YES completion:nil];
    }];
    
    UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"重试" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self presentViewController:self.alert animated:YES completion:nil];
    }];
    
    [alert addAction:yesAction];
    [alert addAction:noAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}
/**
 *  支付，密码输入
 */
- (IBAction)paymentHBMenoy:(UIButton *)sender {
    self.alert = [UIAlertController alertControllerWithTitle:@"金额支付" message:self.moneyLabel.text preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 获取在文本框中的输入
        NSLog(@"%@",self.alert.textFields[0].text);
        if ([self.originalPassword isEqualToString:self.alert.textFields[0].text]) {
            //返回方法调用
            [self succeedPayment];
        }else{
            //弹出提示框
            [self popupHint];
        }
    }];
    
    UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了NO按钮");
    }];
    
    // 3.将yes和no按钮添加到控制器中
    [self.alert addAction:yesAction];
    [self.alert addAction:noAction];
    
    [self.alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.delegate = self;
        textField.keyboardType = UIKeyboardTypeNumberPad;
        textField.secureTextEntry = YES;
        textField.clearsOnBeginEditing = YES;
        textField.font = [UIFont systemFontOfSize:16];
        textField.textColor = [UIColor redColor];
    }];
    
    [self presentViewController:self.alert animated:YES completion:nil];
}
/**
 *  UITextFieldDelegate 代理方法
 */
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (range.length + range.location > textField.text.length) {
        return NO;
    }
    NSUInteger newlength = textField.text.length + string.length - range.length;
    NSLog(@"%lu",newlength);
    return  newlength <= 6;
}
/**
 *  修改支付密码的代理方法
 */
-(void)changPassword:(NSString *)password{
    self.originalPassword = password;
}

@end
