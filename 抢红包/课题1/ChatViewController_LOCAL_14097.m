//
//  ChatViewController.m
//  课题1
//
//  Created by yyh on 16/8/1.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ChatViewController.h"
#import "HBViewController.h"
@interface ChatViewController ()<HBViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *hbView;
@property (weak, nonatomic) IBOutlet UILabel *hbLYLabel;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UIButton *openButton;
@property (weak, nonatomic) IBOutlet UIView *openView;

@end

@implementation ChatViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"测试git 分支+++++++++");
}
/**
 *  跳转至红包界面
 *
 */
- (IBAction)goToHBView:(UIButton *)sender {
    self.hbView.hidden = YES;
    self.openView.hidden = YES;
    HBViewController *HBVC = [[HBViewController alloc]init];
    HBVC.delegate = self;
    [self presentViewController:HBVC animated:YES completion:nil];
}
/**
 *  查看红包
 *
 */
- (IBAction)showHB:(UIButton *)sender {
    NSLog(@"%@",self.hbMoney);
    self.hbView.hidden = YES;
    self.openView.hidden = NO;
    self.userLabel.text = @"isd1606";
    self.hbLYLabel.text = self.leaveWordLabel.text;
}
/**
 *  打开红包
 *
 */
- (IBAction)openHBButton:(UIButton *)sender {
    self.hbLYLabel.text = [NSString stringWithFormat:@"抢到%@",self.hbMoney];
}

/**
 *  实现代理
 */
-(void)hbMoney:(NSString *)money andLeaveWord:(NSString *)leaveWord andShowHB:(BOOL)show{
    self.hbMoney = money;
    self.hbView.hidden = !show;
    self.leaveWordLabel.text = leaveWord;
}


@end
