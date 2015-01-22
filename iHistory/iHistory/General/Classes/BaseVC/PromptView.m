//
//  PromptView.m
//  EKS
//
//  Created by ligh on 14/12/19.
//
//

#import "PromptView.h"

@interface PromptView()
{

    //提示view
    IBOutlet UILabel *_promptLabel;

}
@end

@implementation PromptView

- (void)dealloc
{
    RELEASE_SAFELY(_promptLabel);
    [_actionButton release];
    [super dealloc];
}

-(void)setPromptText:(NSString *)promptText
{
    _promptLabel.text = promptText;
}

@end
