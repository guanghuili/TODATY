//
//  EventModel.m
//  iHistory
//
//  Created by ligh on 15/1/21.
//
//

#import "EventModel.h"

@implementation EventModel


-(float)cellHeightWithMaxWidth:(float) widht
{
    if (_cellHeight)
    {
        return _cellHeight.floatValue;
    }
    float newCellHeight = [_des sizeWithFont:FONT_L constrainedToSize:CGSizeMake(widht, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping].height + 50;
    self.cellHeight = [NSString stringWithFormat:@"%f",newCellHeight];
    
    return newCellHeight;
}

@end
