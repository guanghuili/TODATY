//
//  EventModel.h
//  iHistory
//
//  Created by ligh on 15/1/21.
//
//

#import "BaseModelObject.h"

//事件
@interface EventModel : BaseModelObject


@property (retain,nonatomic) NSString *day;
@property (retain,nonatomic) NSString *des;
@property (retain,nonatomic) NSString *_id;
@property (retain,nonatomic) NSString *lunar;
@property (retain,nonatomic) NSString *month;
@property (retain,nonatomic) NSString *pic;
@property (retain,nonatomic) NSString *title;
@property (retain,nonatomic) NSString *year;
@property (retain,nonatomic) NSString *content;

@property (retain,nonatomic) NSString *cellHeight;
-(float) cellHeightWithMaxWidth:(float) width;

@end
