//
//  EventCell.m
//  iHistory
//
//  Created by ligh on 15/1/21.
//
//

#import "EventCell.h"
#import "EventModel.h"


@interface EventCell()
{

    IBOutlet WebImageView *_picImageView;
    IBOutlet UIView *_contentView;
    IBOutlet UILabel *_titleLabel;
    IBOutlet UILabel *_dateLabel;
    IBOutlet UILabel *_desLabel;
}
@end

@implementation EventCell


- (void)dealloc
{
    RELEASE_SAFELY(_titleLabel);
    RELEASE_SAFELY(_dateLabel);
    RELEASE_SAFELY(_desLabel);
    RELEASE_SAFELY(_contentView);
    RELEASE_SAFELY(_picImageView);
    [super dealloc];
}

-(void)setCellData:(id)cellData
{
    [super setCellData:cellData];
    EventModel *eventModel = cellData;
    _titleLabel.text = eventModel.title;
    _dateLabel.text = [NSString stringWithFormat:@"%@年%@月%@日",eventModel.year,eventModel.month,eventModel.day];
    _desLabel.text = eventModel.des;
    [_picImageView setImageWithURLString:eventModel.pic placeholderImage:nil];
    
}

@end
