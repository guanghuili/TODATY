//
//  HHRequestResult
//
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "ITTRequestResult.h"


@implementation ITTRequestResult
///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject

-(id)initWithCode:(NSString*)code withMessage:(NSString*)message{
    self = [super init];


    if (self = [super init])
    {
        _code = [code retain];
        _message = [message retain];
        
    }
    return self;
}


-(void)showErrorMessage{
    if (_message && _message.length > 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" 
                                                            message:_message
                                                           delegate:nil 
                                                  cancelButtonTitle:@"确定" 
                                                  otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }
}

-(BOOL)isSuccess
{
    return [_code isEqualToString:@"true"] || _code.intValue == 0;
}

- (void)dealloc
{
    [_code release];
    _code = nil;
    [_message release];
    _message = nil;
    [super dealloc];
}
@end
