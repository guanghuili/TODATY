//
//  ITTPageView.h
//  AiQiChe
//
//  Created by lian jie on 7/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#define PAGE_VIEW_SPACE_BETWEEN_DOTS 5
#define PAGE_VIEW_DOT_WIDTH 3
#define PAGE_VIEW_DOT_HEIGHT 3
#define PAGE_VIEW_SELECTED_DOT_IMAGE @"banner_cutdian"
#define PAGE_VIEW_DOT_IMAGE @"banner_cutdian2"

@interface PageDotView : UIView

@property (nonatomic,assign)int pageNum;
@property (nonatomic,assign)int currentPage;

- (id)initWithPageNum:(int)pageNum;
-(id) initWithPageNum:(int)pageNum dotImageName:(NSString *) dotImageName checkedDotImageName:(NSString *) checkedDotImageName;

@end
