//
//  MessageAlertView.m
//  ShenHuaLuGang
//
//  Created by ligh on 13-9-3.
//
//

#import "MessageAlertView.h"
#define MessageAlertViewTag 20000

@interface MessageAlertView()<UIGestureRecognizerDelegate>
{

    IBOutlet UIControl      *_alphaView;
    IBOutlet UILabel        *_msgLabel;

    IBOutlet UIButton       *_cancelButton;

    IBOutlet UIButton       *_confirmButton;
    
    IBOutlet UIImageView    *_backgroundView;
    
    IBOutlet UIView         *_animationView;
    
    IBOutlet UIView         *_titleLineView;
    
    IBOutlet UILabel *_titleLabel;
    
    //cancel
    void(^_onCancelBlock)();
    
    //update
    void(^_onConfirmBlock)();
    
}
@end

@implementation MessageAlertView

- (void)dealloc
{
    RELEASE_SAFELY(_msgLabel);
    RELEASE_SAFELY(_cancelButton);
    RELEASE_SAFELY(_confirmButton);
    RELEASE_SAFELY(_backgroundView);
    RELEASE_SAFELY(_onCancelBlock);
    RELEASE_SAFELY(_onConfirmBlock);
    RELEASE_SAFELY(_animationView);
    RELEASE_SAFELY(_alphaView);
    RELEASE_SAFELY(_titleLineView);
    [_titleLabel release];
    [super dealloc];
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    _titleLineView.height = 0.5;
    _animationView.layer.masksToBounds = YES;
    [_animationView.layer setCornerRadius: 3];
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] init];
    [self addGestureRecognizer:panGestureRecognizer];
    panGestureRecognizer.delegate = self;
    [panGestureRecognizer release];
}

-(void)showAlertViewInView:(UIView *)inView title:(NSString *)title msg:(NSString *)msg cancelTitle:(NSString *)cancelTitle confirmTitle:(NSString *)confirmTitle onCanleBlock:(void (^)())cancelBlock onConfirmBlock:(void (^)())confirmBlock
{
    for (UIView *subView in inView.subviews)
    {
        if (subView.tag == MessageAlertViewTag)
        {
            [subView removeFromSuperview];
        }
    }
    
    self.tag = MessageAlertViewTag;
    
    self.size = inView.size;
    _alphaView.size = inView.size;
    
    _titleLabel.text = title;
    [_cancelButton setTitle:cancelTitle forState:UIControlStateNormal];
    [_confirmButton setTitle:confirmTitle forState:UIControlStateNormal];
    
    if(!cancelTitle)
    {
        _cancelButton.hidden = YES;
        _confirmButton.width = 240;
        
        _confirmButton.left =  (_animationView.width - _confirmButton.width)/2.0;
    }
    
    
    if (!confirmTitle)
    {
        
        _confirmButton.hidden = YES;
        _cancelButton.width = 240;
        _cancelButton.left =  (_animationView.width - _cancelButton.width)/2.0;
        
    }
    
   CGSize msgSize = [msg sizeWithFont:_msgLabel.font constrainedToSize:CGSizeMake(_animationView.width , MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    
    _msgLabel.text = msg;
    _msgLabel.size =  msgSize;
    _msgLabel.left = (_animationView.width - msgSize.width)/2.0;
    
    _animationView.height = _msgLabel.bottom + 57;
    _animationView.top = (self.height - _animationView.height)/2.0;
    
    
    //
    if(cancelBlock)
    {
        _onCancelBlock = [cancelBlock copy];
    }
    if(confirmBlock)
    {
        _onConfirmBlock = [confirmBlock copy];
    }
    
    _alphaView.alpha = 0;
    [UIView beginAnimations:@"" context:nil];
    _alphaView.alpha = 0.7;
    [UIView commitAnimations];
    
    [_animationView.layer addAnimation:[self scaleAnimation:YES] forKey:nil];
    [inView addSubview:self];

}

-(void)showAlertViewInView:(UIView *)inView msg:(NSString *)msg cancelTitle:(NSString *)cancelTitle confirmTitle:(NSString *)confirmTitle onCanleBlock:(void (^)())cancelBlock onConfirmBlock:(void (^)())confirmBlock
{
    
    [self showAlertViewInView:inView title:@"温馨提示" msg:msg cancelTitle:cancelTitle confirmTitle:confirmTitle onCanleBlock:cancelBlock onConfirmBlock:confirmBlock];
}

-(void)showAlertViewInView:(UIView *)inView msg:(NSString *)msg onCanleBlock:(void (^)())cancelBlock onConfirmBlock:(void (^)())confirmBlock
{
    
    [self showAlertViewInView:inView msg:msg cancelTitle:@"取消" confirmTitle:@"确定" onCanleBlock:cancelBlock onConfirmBlock:confirmBlock];
}


- (IBAction)actionCancel:(id)sender
{
    if(_onCancelBlock)
    {
        _onCancelBlock();
    }
    
    [self removeFromSuperview];

}


- (IBAction)actionConfirm:(id)sender
{
    if(_onConfirmBlock)
    {
        _onConfirmBlock();
    }
    [self removeFromSuperview];
}

#pragma makr UIGestureRecognizerDelegate
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return YES;
}

#pragma mark - Animation
- (CAKeyframeAnimation*)scaleAnimation:(BOOL)show{
    CAKeyframeAnimation *scaleAnimation = nil;
    scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    scaleAnimation.delegate = show ? nil : self;
    scaleAnimation.fillMode = kCAFillModeForwards;
    
    NSMutableArray *values = [NSMutableArray array];
    if (show){
        scaleAnimation.duration = 0.5;
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.8, 0.8, 1.0)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    }else{
        scaleAnimation.duration = 0.3;
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.8, 0.8, 1.0)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.6, 0.6, 1.0)]];
    }
    scaleAnimation.values = values;
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    scaleAnimation.removedOnCompletion = TRUE;
    return scaleAnimation;
}


-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    
    NSLog(@"animationDidStop");
    [self removeFromSuperview];
    
}

@end
