//
//  AppTextView.h
//  EKS
//
//  Created by ligh on 14/12/5.
//
//

#import <UIKit/UIKit.h>

@interface AppTextView : UITextView
{
    BOOL    _shouldDrawPlaceholder;
}

/*!
 * @brief 占位符文本,与UITextField的placeholder功能一致
 */
@property (nonatomic, strong) NSString *placeholder;

/*!
 * @brief 占位符文本颜色
 */
@property (nonatomic, strong) UIColor *placeholderTextColor;

@end
