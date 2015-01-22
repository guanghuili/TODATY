//
//  AnimationPicker.m
//  PMS
//
//  Created by ligh on 14/11/3.
//
//

#import "AnimationPicker.h"

@interface AnimationPicker()
{
 
}
@end

@implementation AnimationPicker


-(void)dealloc
{

    RELEASE_SAFELY(_alphaView);
    RELEASE_SAFELY(_contentView);
    [super dealloc];
}

- (IBAction)cancelAction:(id)sender
{
    [self dismissPicker];
}


- (IBAction)okAction:(id)sender
{
    [self dismissPicker];
}


- (IBAction)touchAlphaViewAction:(id)sender
{
    [self dismissPicker];
}

-(void) showPickerInView:(UIView *) inView
{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    
    self.frame = CGRectMake(0, 0, inView.width, inView.height);
    _contentView.top = inView.height;
    _alphaView.alpha = 0;
    [inView addSubview:self];
    
    [UIView beginAnimations:@"ShowAnimation" context:nil];
    
    _contentView.top = inView.height - _contentView.height;
    _alphaView.alpha = 0.7;
    
    [UIView commitAnimations];
    
}

-(void) dismissPicker
{
    
    [UIView animateWithDuration:0.3 animations:^{
        
        _contentView.top += _contentView.height;
        _alphaView.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
}



@end
