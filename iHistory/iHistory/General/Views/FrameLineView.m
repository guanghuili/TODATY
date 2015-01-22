//
//  FrameLineView.m
//  iSchool
//
//  Created by ligh on 13-9-26.
//
//

#import "FrameLineView.h"

@implementation FrameLineView


-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
            self.backgroundColor = UIColorFromRGB(200, 200, 200);
    }
    
    return self;
}

-(id) init
{
    if (self = [super init])
    {
        self.backgroundColor = UIColorFromRGB(200, 200, 200);
        
        
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.backgroundColor = UIColorFromRGB(200, 200, 200);
    
    if (self.width > 1)
    {
        self.height = [[UIDevice currentDevice] isIPHONE4] ? 1 : 0.5;
        if (self.top > 0)
        {
            self.top += 0.5;
        }
        
    }else if(self.height > 1)
    {
        self.width = [[UIDevice currentDevice] isIPHONE4] ? 1 : 0.5;
    }
    
}


@end
