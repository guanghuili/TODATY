//
//  MessageAlertView.h
//  ShenHuaLuGang
//
//  Created by ligh on 13-9-3.
//
//

#import <UIKit/UIKit.h>
#import "XibView.h"

@interface MessageAlertView : XibView


-(void) showAlertViewInView:(UIView *) inView msg:(NSString *) msg cancelTitle:(NSString *) cancelTitle confirmTitle:(NSString *) confirmTitle onCanleBlock:(void(^)()) cancelBlock onConfirmBlock:(void(^)()) confirmBlock;

-(void) showAlertViewInView:(UIView *) inView title:(NSString *) title msg:(NSString *) msg cancelTitle:(NSString *) cancelTitle confirmTitle:(NSString *) confirmTitle onCanleBlock:(void(^)()) cancelBlock onConfirmBlock:(void(^)()) confirmBlock;


-(void) showAlertViewInView:(UIView *)inView msg:(NSString *)msg onCanleBlock:(void (^)())cancelBlock onConfirmBlock:(void (^)())confirmBlock;


@end
