//
//  AppSheetPicker.h
//  EKS
//
//  Created by ligh on 14/12/5.
//
//

#import "AnimationPicker.h"

typedef void(^AppSheetPickerBlock)(NSInteger,NSString *);

//对UIPickerView做UI包装
@interface AppSheetPicker : AnimationPicker

@property (copy,nonatomic) AppSheetPickerBlock actionBlock;

-(void) showPickerInView:(UIView *)inView withItemArray:(NSArray *) itemArray withBlock:(AppSheetPickerBlock) block;


@end
