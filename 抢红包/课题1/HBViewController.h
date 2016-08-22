//
//  HBViewController.h
//  课题1
//
//  Created by yyh on 16/8/2.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HBViewControllerDelegate <NSObject>

-(void)hbMoney:(NSString*)money andLeaveWord:(NSString*)leaveWord andShowHB:(BOOL)show;

@end

@interface HBViewController : UIViewController

@property (nonatomic , weak) id<HBViewControllerDelegate> delegate;
@end
