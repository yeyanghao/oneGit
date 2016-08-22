//
//  ChangeViewController.h
//  课题1
//
//  Created by yyh on 16/8/2.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChangeViewControllerDelegate <NSObject>

-(void)changPassword:(NSString*)password;

@end
@interface ChangeViewController : UIViewController
@property (nonatomic ,strong) NSString *userName;
@property (weak ,nonatomic) id<ChangeViewControllerDelegate> delegate;
@end
