//
//  TodayEventRequest.m
//  iHistory
//
//  Created by ligh on 15/1/21.
//
//

#import "TodayEventRequest.h"

@implementation TodayEventRequest

-(NSString *)getRequestUrl
{
    return @"/toh";
}

-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodGet;
}

-(void)processResult
{
    [super processResult];
    
    if (!self.isSuccess)
    {
        return;
    }
    
    NSArray *eventDicArray = self.resultDic[@"result"];
    NSMutableArray *eventArray = [NSMutableArray array];
    PageModel *pageModel = [[[PageModel alloc] init] autorelease];
    pageModel.listArray = eventArray;
    
    for (id eventDic in eventDicArray)
    {
        EventModel *eventModel = [[EventModel alloc] initWithDataDic:eventDic];
        [eventArray addObject:eventModel];
        [eventModel release];
    }

    if (eventArray && eventArray.count > 0)
    {
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSInteger unitFlags = NSMonthCalendarUnit | NSDayCalendarUnit;
        NSDateComponents *comps = [calendar components:unitFlags fromDate:[NSDate date]];
        [[DataCacheManager sharedManager] addObject:[NSString stringWithFormat:@"%d-%d",comps.month,comps.day] forKey:TODAYEventCachedtKey];
        [[DataCacheManager sharedManager] addObject:pageModel forKey:EventListKey];
        
    }
    
    

    [self.resultDic setObject:pageModel forKey:KRequestResultDataKey];
}

@end
