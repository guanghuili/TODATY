//
//  SHBaseViewController.m
//  ShenHuaLuGang
//
//  Created by sprint on 13-6-27.
//
//

#import "BetterVC.h"


#define KNavigationBarHeight 64

@interface BetterVC ()
{
    
    NavigationBarView       *_navigationBarView;
    PromptView              *_promptView;
    
    //***************键盘弹起时自动拖动TextField 到可见区域******************/
    //正在编辑的textview
    UIView                  *_editingTextFieldOrTextView;
    id                      _textViewOrFieldOrgDelegate;

    float                   _contentViewTop;
}
@end

@implementation BetterVC
@synthesize contentView = _contentView;

+(id)initVC
{
    return [[self alloc] init];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    RELEASE_SAFELY(_contentView);
    RELEASE_SAFELY(_promptView);
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    [self configViewController];
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self enableKeyboardManger];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self endEditing];
    [self disableKeyboardManager];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self endEditing];
}

-(void)endEditing
{
     [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

/**
    配置ViewController 调整contentView的高度和top属性 如果是ios7版本则设置ViewController的edgesForExtendedLayout 取消偏移
 */
-(void) configViewController
{
    
    if([ self isCustomNavigationBar])
    {
        [self loadNavigationBar];
        
        if(!_contentView)
        {
            _contentView = [[UIView alloc] init];
            [self.view addSubview:_contentView];
        }
    }

    UIWindow *window = KAPP_Delegate.window;
    self.view.size = window.size;
    self.navigationBarView.width = self.view.width;

    _contentView.top =  _navigationBarView.bottom ;
    _contentView.size = CGSizeMake(self.view.width, self.view.height - _contentView.top);
    
    
    //设置Viewcontroller背景颜色
    _contentView.backgroundColor =  UIColorFromRGB(234,234,234);
    [_contentView setClipsToBounds:YES];
    [self.view setClipsToBounds:YES];
    self.view.backgroundColor = UIColorFromRGB(234,234,234);
    
    if ([self respondsToSelector:@selector(extendedLayoutIncludesOpaqueBars)])
    {
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    

}


//自定义导航栏背景
-(void) loadNavigationBar
{

      UIWindow *window = KAPP_Delegate.window;

    [self.navigationController setNavigationBarHidden:YES];
    _navigationBarView = [NavigationBarView viewFromXIB];
    _navigationBarView.size = CGSizeMake(window.size.width, _navigationBarView.height +=  (IOS_VERSION_CODE > 6 ? 20  : 0));
    _navigationBarView.top = 0;
  
    
    [self.view addSubview:_navigationBarView];
    [_navigationBarView.rightBarButton addTarget:self action:@selector(actionClickNavigationBarRightButton) forControlEvents:UIControlEventTouchUpInside];
    [_navigationBarView.leftBarButton addTarget:self action:@selector(actionClickNavigationBarLeftButton) forControlEvents:UIControlEventTouchUpInside];
    [_navigationBarView.right2BarButton addTarget:self action:@selector(actionClickNavigationBarRightButton2) forControlEvents:UIControlEventTouchUpInside];
    
    [self setUIButtonStyle:UIButtonStyleBack withUIButton:self.navigationBarView.leftBarButton];
    
    _navigationBarView.leftBarButton.hidden = NO;
    
    [self.view bringSubviewToFront:_navigationBarView];
    
}

-(void)setNavigationBarTitle:(NSString *)title
{
    if([self isCustomNavigationBar])
    {
        [self.navigationBarView setNavigationBarTitle:title];
    
    } else
    {
        [self.navigationController setTitle:title];
    }
}

-(NavigationBarView *)navigationBarView
{
    return _navigationBarView;
}


-(PromptView *)promptView
{
    if (!_promptView)
    {
        _promptView = [[PromptView viewFromXIB] retain];
        _promptView.size = self.contentView.size;
        [_promptView.actionButton addTarget:self action:@selector(tapPromptViewAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _promptView;
}

-(void)showPromptViewWithText:(NSString *)text
{
    [self.contentView addSubview:[self promptView]];
    [self.contentView sendSubviewToBack:_promptView];
    [_promptView setPromptText:text];
}

-(void)hidePromptView
{
    [_promptView removeFromSuperview];
}

-(void)tapPromptViewAction
{
    
}

-(void)setUIButtonStyle:(UIButtonStyle)style withUIButton:(UIButton *)button
{
    
    if(style == UIButtonStyleBack)
    {

        [button setImage:[UIImage imageNamed:@"back_btn"] forState:UIControlStateNormal];
     
    } else if(style == UIButtonStyleMenu)
    {
        [button setImage:[UIImage imageNamed:@"menu_btn"] forState:UIControlStateNormal];
        
    }else if(style == UIButtonStyleVoice)
    {
        [button setImage:[UIImage imageNamed:@"nav_Customer service"] forState:UIControlStateNormal];
        
    }else if(style == UIButtonStyleShare)
    {
        [button setImage:[UIImage imageNamed:@"content_Fig_Share"] forState:UIControlStateNormal];
        button.frame = CGRectMake(button.left + MARGIN_S, button.top, 32, 28);
        
    }else if(style == UIButtonStylePicture)
    {
        [button setImage:[UIImage imageNamed:@"nav_picture"] forState:UIControlStateNormal];
        
    }else if(style == UIButtonStyleDownload)
    {
        [button setImage:[UIImage imageNamed:@"content_Fig._Download"] forState:UIControlStateNormal];
        button.frame = CGRectMake(button.left + MARGIN_S, button.top, 32, 28);
        
    }else if(style == UIButtonStyleStores)
    {
        [button setImage:[UIImage imageNamed:@"nav_The store"] forState:UIControlStateNormal];
        button.frame = CGRectMake(button.left + MARGIN_S, button.top, 32, 28);
        
    }else if(style == UIButtonStyleMap)
    {
        [button setImage:[UIImage imageNamed:@"nav_map"] forState:UIControlStateNormal];
        button.frame = CGRectMake(button.left + MARGIN_S, button.top, 32, 28);
        
    }else if(style == UIButtonStyleRecords)
    {
        [button setImage:[UIImage imageNamed:@"history_btn"] forState:UIControlStateNormal];
        button.frame = CGRectMake(button.left + MARGIN_S, button.top, 32, 28);
    }
    
    
}

-(void)setNavigationRightButtonTitle:(NSString *)title
{
    [self.navigationBarView.rightBarButton setTitle:title forState:UIControlStateNormal];
    self.navigationBarView.rightBarButton.width =  [self.navigationBarView.rightBarButton.titleLabel sizeThatFits:CGSizeMake(100, self.navigationBarView.rightBarButton.height)].width;;
    self.navigationBarView.rightBarButton.right = self.navigationBarView.width - MARGIN_M;
    
    
}

-(void)setLeftNavigationBarButtonStyle:(UIButtonStyle)style
{
    [self setUIButtonStyle:style withUIButton:self.navigationBarView.leftBarButton];
    
}

-(void) setRightNavigationBarButtonStyle:(UIButtonStyle)style
{
    [self setUIButtonStyle:style withUIButton:self.navigationBarView.rightBarButton];

}
//
-(Boolean)isCustomNavigationBar
{
    return true;
}

///////////////////////////////////////////////////////////////////////////////
#pragma mark  view actions
///////////////////////////////////////////////////////////////////////////////
-(void)actionClickNavigationBarLeftButton
{
     [self endEditing];
    
     [self.navigationController popViewControllerAnimated:YES];
}

-(void)actionClickNavigationBarRightButton
{

}

-(void)actionClickNavigationBarRightButton2
{

}

-(void)setViewController:(UIViewController *)vc
{
    
    NSArray *allViewControllers = self.navigationController.viewControllers;
    
    if (![allViewControllers containsObject:self])
    {
        [self.navigationController setViewControllers:@[allViewControllers[0],vc] animated:YES];

    }else
    {
        NSArray *fillterViewControllers = [allViewControllers subarrayWithRange:NSMakeRange(0,[allViewControllers indexOfObject:self]+1)];
        NSMutableArray  *viewControllers = [NSMutableArray arrayWithArray:fillterViewControllers];
        [viewControllers addObject:vc];
        [self.navigationController setViewControllers:viewControllers animated:YES];
        
    }
    
    

}

///////////////////////////////////////////////////////////////////////////////
#pragma mark  键盘事件
///////////////////////////////////////////////////////////////////////////////

-(BOOL)isEnableKeyboardManger
{
    return YES;
}

-(void)enableKeyboardManger
{
    
    if (![self isEnableKeyboardManger])
    {
        return;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    /*Registering for textField notification*/
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidBeginEditingNotification:) name:UITextFieldTextDidBeginEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidEndEditingNotification:) name:UITextFieldTextDidEndEditingNotification object:nil];
    
    /*Registering for textView notification*/
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidBeginEditingNotification:) name:UITextViewTextDidBeginEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidEndEditingNotification:) name:UITextViewTextDidEndEditingNotification object:nil];

}

-(void)disableKeyboardManager
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidBeginEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidEndEditingNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidBeginEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidEndEditingNotification object:nil];
}


-(void)setContentViewTop:(float)contentViewTop
{
    _contentView.top = contentViewTop;
}

-(void)keyboardWillShow:(NSNotification *)notification
{

    /*
        获取通知携带的信息
     */
    NSDictionary *userInfo = [notification userInfo];
    
    if (userInfo)
    {
        [[DataCacheManager sharedManager] addObject:userInfo forKey:UIKeyboardFrameEndUserInfoKey];
    }
    
    if (!_editingTextFieldOrTextView)
    {
        return;
    }
    
    // Get the origin of the keyboard when it's displayed.
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    // Get the top of the keyboard as the y coordinate of its origin in self's view's coordinate system. The bottom of the text view's frame should align with the top of the keyboard's final position.
    CGRect keyboardRect = [aValue CGRectValue];
    if (CGRectEqualToRect(keyboardRect, CGRectZero))
    {
        NSDictionary *userInfo = (NSDictionary *)[[DataCacheManager sharedManager] getCachedObjectByKey:UIKeyboardFrameEndUserInfoKey];
        NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
        keyboardRect = [aValue CGRectValue];
    }
    
    keyboardRect = [self.view convertRect:keyboardRect toView:self.view];
    
    CGRect textViewRect =  [_editingTextFieldOrTextView.superview convertRect:_editingTextFieldOrTextView.frame toView:self.view];
    
    
    float offsetY  = (textViewRect.origin.y + textViewRect.size.height) - keyboardRect.origin.y;
    
    //输入框未被键盘遮挡 无需调整
    if (offsetY <=0)
    {
        return;
    }
    
  //  offsetY += IOS_VERSION_CODE < IOS_SDK_7 ? 44 :0;
  
    //获取键盘的动画执行时长
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    
     self.contentView.top -= (offsetY + 10);
    
    [UIView commitAnimations];
}


-(void)keyboardWillHide:(NSNotification *)notification
{

    NSDictionary* userInfo = [notification userInfo];
    
    /*
     Restore the size of the text view (fill self's view).
     Animate the resize so that it's in sync with the disappearance of the keyboard.
     */
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    
    self.contentView.top =   _contentViewTop > 0? _contentViewTop : self.navigationBarView.bottom;

    [UIView commitAnimations];
}


#pragma mark - UITextField Delegate methods
//Fetching UITextField object from notification.
-(void)textFieldDidBeginEditingNotification:(NSNotification *) notification
{
    _editingTextFieldOrTextView = notification.object;
    if ([_editingTextFieldOrTextView isKindOfClass:[UITextField class]])
    {
        UITextField *textFiled = (UITextField *)_editingTextFieldOrTextView;
        if (!textFiled.delegate)
        {
            [textFiled setDelegate:self];
        }
        [textFiled addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }else
    {
        //在ios8上textView发送通知的时机比键盘通知稍早 这里手动调用
        [self keyboardWillShow:notification];
    }
    
    [_editingTextFieldOrTextView performSelector:@selector(setReturnKeyType:) withObject:UIReturnKeyDone];
}

//Removing fetched object.
-(void)textFieldDidEndEditingNotification:(NSNotification*)notification
{
    [_editingTextFieldOrTextView resignFirstResponder];
    _editingTextFieldOrTextView = nil;
    _textViewOrFieldOrgDelegate =nil;
}

//禁止textView换行
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
/////////////////////////////////////////////////////////////////////////
#pragma mark UITextViewDelegate
/////////////////////////////////////////////////////////////////////////
//-(void)textViewDidBeginEditing:(UITextView *)textView
//{
//    
//    [[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidBeginEditingNotification object:textView];
//    
//}

- (void) textFieldDidChange:(UITextField *) textField
{

}

//-(UIStatusBarStyle)preferredStatusBarStyle
//{
//    return UIStatusBarStyleBlackOpaque;
//}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self endEditing];
    return YES;
}

-(void)postNotificaitonName:(NSString *)notificationName
{
    [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:nil];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self endEditing];
}



@end
