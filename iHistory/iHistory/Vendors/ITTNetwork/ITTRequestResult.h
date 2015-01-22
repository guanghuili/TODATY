//
//  HHRequestResult.h
//
//  Copyright 2010 Apple Inc. All rights reserved.
//
#import "BaseModelObject.h"

@interface ITTRequestResult : NSObject

@property (nonatomic,retain) NSString *code;
@property (nonatomic,retain) NSString *message;
-(id)initWithCode:(NSString*)code withMessage:(NSString*)message;
-(BOOL)isSuccess;
-(void)showErrorMessage;
@end
