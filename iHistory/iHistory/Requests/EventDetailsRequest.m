//
//  EventDetailsRequest.m
//  iHistory
//
//  Created by ligh on 15/1/21.
//
//

#import "EventDetailsRequest.h"

@implementation EventDetailsRequest

-(NSString *)getRequestUrl
{
    return @"/tohdet";
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
    
    EventModel *eventModel = [[[EventModel alloc] initWithDataDic:self.resultDic[@"result"]] autorelease];
    [self.resultDic setObject:eventModel forKey:KRequestResultDataKey];
}

@end
