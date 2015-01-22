//
//  TodayVC.m
//  iHistory
//
//  Created by ligh on 15/1/20.
//
//

#import "TodayVC.h"
#import "YouMiView.h"
#import "EventCell.h"
#import "EventProfileVC.h"
#import "TodayEventRequest.h"
#import "ZFModalTransitionAnimator.h"


@interface TodayVC ()<YouMiDelegate>
{
    YouMiView *_youMiView;
}
@end

@implementation TodayVC


-(void)dealloc
{
    RELEASE_SAFELY(_youMiView);
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadYouMiView];
    [self setNavigationBarTitle:@"TODAY"];
    [self.tableView headerBeginRefreshing] ;
}

-(void) loadYouMiView
{
    // 320x50
    _youMiView = [[YouMiView alloc] initWithContentSizeIdentifier:YouMiBannerContentSizeIdentifier320x50 delegate:self];
    _youMiView.frame = CGRectMake(0, 0, CGRectGetWidth(_youMiView.bounds), CGRectGetHeight(_youMiView.bounds));
    _youMiView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.5];
    [_youMiView start];
    _youMiView.left = (self.contentView.width - _youMiView.width)/2.0;
}


#pragma mark UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EventModel *eventModel = self.dataArray[indexPath.row];
    return [eventModel cellHeightWithMaxWidth:tableView.width - 100];
}

-(Class)cellClassForIndexPath:(NSIndexPath *)indexPath
{
    return  [EventCell class];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    EventModel *eventModel = self.dataArray[indexPath.row];
    EventProfileVC *eventDetailsVC = [[EventProfileVC alloc] initWithEventModel:eventModel];
    eventDetailsVC.modalPresentationStyle = UIModalPresentationCustom;
    
    ZFModalTransitionAnimator *animator = [[ZFModalTransitionAnimator alloc] initWithModalViewController:eventDetailsVC];
    animator.dragable = YES;
    animator.bounces = NO;
    animator.behindViewAlpha = 0.5f;
    animator.behindViewScale = 0.75f;
    animator.direction = ZFModalTransitonDirectionRight;
    eventDetailsVC.transitioningDelegate = animator;
    [self presentViewController:eventDetailsVC animated:YES completion:nil];
    

   
}

-(void)pullTableViewDidTriggerRefresh:(UITableView *)pullTableView
{
    [self sendTodayEventRequest];
}


#pragma mark YouMiViewDelegate
- (void)didReceiveAd:(YouMiView *)adView
{
    [UIView beginAnimations:@"YouMiViewAnimation" context:nil];
    [self.contentView addSubview:_youMiView];
    self.tableView.height -= _youMiView.height;
    self.tableView.top = _youMiView.height;
    [UIView commitAnimations];

}

- (void)didFailToReceiveAd:(YouMiView *)adView  error:(NSError *)error
{
    
}


#pragma mark Request
-(void) sendTodayEventRequest
{
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:[NSDate date]];
    
    NSString *TODAYCached = [NSString stringWithFormat:@"%d-%d",comps.month,comps.day];
    if ([TODAYCached isEqualToString:(NSString *)[[DataCacheManager sharedManager] getCachedObjectByKey:TODAYEventCachedtKey]])
    {
        PageModel *pageModel = (PageModel *)[[DataCacheManager sharedManager] getCachedObjectByKey:EventListKey];
        [self setPageModel:pageModel];

    }else
    {
        [TodayEventRequest requestWithParameters:@{@"month":[NSString stringWithFormat:@"%d",comps.month],@"day":[NSString stringWithFormat:@"%d",comps.day]} withIndicatorView:self.contentView onRequestFinished:^(ITTBaseDataRequest *request)
         {
             if (request.isSuccess)
             {
                 PageModel *pageModel = request.resultDic[KRequestResultDataKey];
                 [self setPageModel:pageModel];
             }else
             {
                [self endPullRefresh];
             }
             
         } onRequestFailed:^(ITTBaseDataRequest *request)
         {
                [self endPullRefresh];
         }];
    }
}

@end
