//
//  PageModel.h
//  Carte
//
//  Created by ligh on 14-4-29.
//
//

#import "BaseModelObject.h"

/**
 *  分页model
 */
@interface PageModel : BaseModelObject


@property (retain,nonatomic) NSString   *more;//当前页
@property (retain,nonatomic) NSArray   *listArray; //列表数据
@property (retain,nonatomic) NSString   *pageNo; //当前页数


//是否有更多数据
-(BOOL) isMoreData;


@end
