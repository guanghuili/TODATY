//
//  EventProfileVC.m
//  iHistory
//
//  Created by ligh on 15/1/21.
//
//

#import "EventProfileVC.h"
#import "EventDetailsRequest.h"

@interface EventProfileVC ()
{
    EventModel          *_eventModel;
    IBOutlet UILabel    *_eventNameLabel;
    IBOutlet FrameView  *_frameView;
    IBOutlet FrameLineView *_lineView;
    IBOutlet UILabel *_dateLabel;
    IBOutlet UILabel *_contentLabel;
    
    IBOutlet UIScrollView *_contentScrollView;
    
}
@end

@implementation EventProfileVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavigationBarTitle:@"TODAY"];
    self.contentView.hidden = YES;
    [self sendEventDetailsRequest];
}

-(id)initWithEventModel:(EventModel *)eventModel
{
    if (self =[self init])
    {
        _eventModel =  [eventModel retain];
    }
    
    return self;
}


-(void) refrshUI
{
    
    self.contentView.hidden = NO;
    
    _eventNameLabel.text = _eventModel.title;
    _eventNameLabel.height = [_eventNameLabel heightForMAXFLOAT];
    _dateLabel.top = _eventNameLabel.bottom;
    _dateLabel.text = [NSString stringWithFormat:@"%@年%@月%@日",_eventModel.year,_eventModel.month,_eventModel.day];
    _lineView.top = _dateLabel.bottom + MARGIN_S;
    
    _contentLabel.top = _lineView.bottom + MARGIN_L;
    _contentLabel.text = _eventModel.content;
    _contentLabel.height = [_contentLabel heightForMAXFLOAT];
    _frameView.height = _contentLabel.bottom;
    [_contentScrollView setContentSize:CGSizeMake(0, _frameView.bottom + MARGIN_L)];
    
}

#pragma mark sendRequest
-(void) sendEventDetailsRequest
{
    __block NSMutableDictionary *eventDetailsDataDic = (NSMutableDictionary *)[[DataCacheManager sharedManager] getCachedObjectByKey:EventDetailsDataKey];
    if (eventDetailsDataDic)
    {
        EventModel *cacheEventModel =  eventDetailsDataDic[_eventModel._id];
        if (cacheEventModel)
        {
            RELEASE_SAFELY(_eventModel);
            _eventModel = [cacheEventModel retain];
             [self refrshUI];
            return;
        }
    }
    
    [EventDetailsRequest requestWithParameters:@{@"id":_eventModel._id} withIndicatorView:self.view onRequestFinished:^(ITTBaseDataRequest *request)
     {
         
         if (request.isSuccess)
         {
             RELEASE_SAFELY(_eventModel);
             _eventModel = request.resultDic[KRequestResultDataKey];
             if (!eventDetailsDataDic)
             {
                 eventDetailsDataDic = [NSMutableDictionary dictionary];
             }
             
             [eventDetailsDataDic retain];
             [eventDetailsDataDic setObject:_eventModel forKey:_eventModel._id];
             [[DataCacheManager sharedManager] addObject:eventDetailsDataDic forKey:EventDetailsDataKey];
             [eventDetailsDataDic release];
             
             [self refrshUI];
         }
         
         
     } onRequestFailed:^(ITTBaseDataRequest *request)
     {
         
     }];
}

@end
