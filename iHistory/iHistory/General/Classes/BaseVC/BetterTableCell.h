//
//  BetterTableCell.h
//  KunshanTalent
//
//  Created by ligh on 13-9-23.
//
//

#import <UIKit/UIKit.h>

@interface BetterTableCell : UITableViewCell
{

    NSInteger _cellHeight;

}
///////////////////////////////////////////////////////////////////////////////
#pragma mark  data
///////////////////////////////////////////////////////////////////////////////
@property (retain,nonatomic) id cellData;
@property (assign,nonatomic) UIViewController *viewController;
@property (assign,nonatomic) NSInteger cellIndex;
@property (assign,nonatomic) NSInteger cellHeight;

///////////////////////////////////////////////////////////////////////////////
#pragma mark  view
///////////////////////////////////////////////////////////////////////////////

-(void)disableSelectedBackgroundView;

+(id) cellFromXIB;

+(NSString *) cellIdentifier;


@end
