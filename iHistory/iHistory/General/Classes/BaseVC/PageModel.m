//
//  PageModel.m
//  Carte
//
//  Created by ligh on 14-4-29.
//
//

#import "PageModel.h"

@implementation PageModel

-(void)dealloc{
    
    RELEASE_SAFELY(_more);
    RELEASE_SAFELY(_listArray);
    
    [super dealloc];
}


-(BOOL) isMoreData
{

    return _more.boolValue;
}

@end
