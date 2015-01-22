//
//  ShareView.m
//  Carte
//
//  Created by ligh on 14-4-16.
//
//

#import "ShareView.h"
#import "JCRBlurView.h"


@interface ShareView()
{
    
    
    //显示的标题
    IBOutlet UILabel    *_titleLabel;
    
    //朋友圈
    IBOutlet UILabel    *_friendCircleTitleLabel;
    //新浪微博
    IBOutlet UILabel    *_sinaWeiboTitleLabel;
    //腾讯微博
    IBOutlet UILabel    *_weixinFriendLabel;
    IBOutlet UIButton   *_cancelButton;
    
    //QQApi
    TencentOAuth        *_tencentOAuth;

}
@end

@implementation ShareView

- (void)dealloc
{
    RELEASE_SAFELY(_titleLabel);
    
    RELEASE_SAFELY(_friendCircleTitleLabel);
    RELEASE_SAFELY(_sinaWeiboTitleLabel);
    RELEASE_SAFELY(_weixinFriendLabel);
    RELEASE_SAFELY(_cancelButton);

    [super dealloc];
}


-(void)awakeFromNib
{
    [super awakeFromNib];
    
    _shareContent = @"初始化内容";
}

-(void)showInView:(UIView *)inView shareContent:(NSString *)shareContent title:(NSString *)title
{
    self.shareContent = shareContent;
    [self showInView:inView title:title];
}

-(void)showInView:(UIView *)inView shareContent:(NSString *)shareContent
{
    [self showInView:inView shareContent:shareContent title:@"分享到"];
}

-(void)showInView:(UIView *)inView title:(NSString *)title
{
    _titleLabel.text = title;
    
    [self showPickerInView:inView];
}


//#pragma mark ViewAcitons
//#//////////////////////////////////////////////////////////////////////////////////////////////
//#pragma mark 新浪微博
/////////////////////////////////////////////////////////////////////////////////////////////////


- (void)handleQQSendResult:(QQApiSendResultCode)sendResult
{
    switch (sendResult)
    {
            
        case EQQAPIQQNOTINSTALLED:
        {
            [BDKNotifyHUD showCryingHUDInView:self.superview text:@"尚未安装手机QQ"];
            
            break;
        }
        default:
        {
            [BDKNotifyHUD showCryingHUDInView:self.superview text:@"发送失败"];
            break;
        }
    }
}

- (IBAction)qqAction:(id)sender
{

    if (!_tencentOAuth)
        //必须调用此OAuth 注册AppID
        _tencentOAuth = [[TencentOAuth alloc] initWithAppId:QQAppKey andDelegate:nil];
    
    QQApiTextObject *txtObj = [QQApiTextObject objectWithText:_shareContent];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:txtObj];
    QQApiSendResultCode code = [QQApiInterface sendReq:req];
    [self handleQQSendResult:code];
    [self dismissPicker];
}


- (IBAction)sinaAction:(id)sender
{
    
    if(![WeiboSDK isWeiboAppInstalled])
    {
        [BDKNotifyHUD showCryingHUDInView:self.superview text:@"尚未新浪微博客户端"];
        [self dismissPicker];
        return;
    }

    [self dismissPicker];
    
    WBMessageObject *message = [WBMessageObject message];
    message.text = _shareContent;
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message];
    [WeiboSDK sendRequest:request];
}


//分享到微信朋友圈
- (IBAction)wxSceneTimelineAction:(id)sender
{
    
        //未安装微信客户端
        if(![WXApi isWXAppInstalled])
        {
            [BDKNotifyHUD showCryingHUDWithText:@"尚未安装微信客户端"];
            [self dismissPicker];
            return;
        }
    
        SendMessageToWXReq* req = [[[SendMessageToWXReq alloc] init]autorelease];
        req.bText = YES;
        req.text = _shareContent;
        req.scene = WXSceneTimeline;
        
        [WXApi sendReq:req];  
    
        [self dismissPicker];
}


- (IBAction)wxSceneSessionAction:(id)sender
{
    
    //未安装微信客户端
    if(![WXApi isWXAppInstalled])
    {
        [BDKNotifyHUD showCryingHUDWithText:@"尚未安装微信客户端"];
        [self dismissPicker];
        return;
    }
    
    SendMessageToWXReq* req = [[[SendMessageToWXReq alloc] init]autorelease];
    req.bText = YES;
    req.text = _shareContent;
    req.scene = WXSceneSession;
    
    [WXApi sendReq:req];
    
    [self dismissPicker];
}


@end
