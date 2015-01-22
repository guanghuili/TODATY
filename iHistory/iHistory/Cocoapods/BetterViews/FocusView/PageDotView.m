//
//  ITTPageView.m
//  AiQiChe
//
//  Created by lian jie on 7/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PageDotView.h"

@interface PageDotView()
{
    float dotImageWidth;
    float dotImageHeight;
}
@end

@implementation PageDotView

- (id)initWithPageNum:(int)pageNum
{
    return [self initWithPageNum:pageNum dotImageName:PAGE_VIEW_DOT_IMAGE checkedDotImageName:PAGE_VIEW_SELECTED_DOT_IMAGE];
}

-(id) initWithPageNum:(int)pageNum dotImageName:(NSString *) dotImageName checkedDotImageName:(NSString *) checkedDotImageName
{
  
    UIImage *dotImage = [UIImage imageNamed:dotImageName];
    
    dotImageWidth = dotImage.size.width + 1;
    dotImageHeight = dotImage.size.height +1;
    
    float pageViewWidth =  (pageNum *dotImageWidth) + ((pageNum-1)  *  PAGE_VIEW_SPACE_BETWEEN_DOTS);

    self = [super initWithFrame:CGRectMake(0, 0, pageViewWidth,dotImageHeight)];
    _pageNum = pageNum;
  
    for (int i = 0; i < _pageNum; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:dotImage forState:UIControlStateNormal];
        [button setImage:UIImageForName(checkedDotImageName) forState:UIControlStateSelected];
        [button setFrame:CGRectMake((dotImageWidth +  PAGE_VIEW_SPACE_BETWEEN_DOTS) * i, 0, dotImageWidth, dotImageHeight)];
        button.tag = i + 1;
        [self addSubview:button];
    }

    return self;

}

- (void)setCurrentPage:(int)currentPage
{
    _currentPage = currentPage;
    for (int i = 0; i< _pageNum; i ++)
    {
        UIButton *button  = (UIButton *)[self viewWithTag:i + 1];
        button.selected = i == currentPage;
    }
}

@end
