//
//  BannerView.m
//  Carte
//
//  Created by ligh on 14-3-24.
//
//

#import "BannerView.h"

#import "SlideshowScrollerView.h"
#import "PageDotView.h"

@interface BannerView()<SlideshowScrollerViewDelegate>
{

    //图片轮回view
    IBOutlet SlideshowScrollerView      *_slideshowScrollerView;
    IBOutlet UIImageView                *_placeHolderImageView;
    PageDotView                         *_pageDotView;

}
@end
    
@implementation BannerView

- (void)dealloc
{
    _slideshowScrollerView.delegate = nil;
    RELEASE_SAFELY(_slideshowScrollerView);
    RELEASE_SAFELY(_pageDotView);
    RELEASE_SAFELY(_dataArray);
    RELEASE_SAFELY(_placeHolderImageView);
    [super dealloc];
}


-(void)awakeFromNib
{
    [super awakeFromNib];
    
    _slideshowScrollerView.delegate = self;
    _slideshowScrollerView.backgroundColor = UIColorFromRGB(239,239,244);

}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    _slideshowScrollerView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
}


-(void)setDataArray:(NSMutableArray *)dataArray
{
    
    if (_dataArray!=dataArray)
    {
        RELEASE_SAFELY(_dataArray);
        _dataArray = [dataArray retain];
    }
    
    
    if (_pageDotView)
    {
        [_pageDotView removeFromSuperview];
        RELEASE_SAFELY(_pageDotView);
    }

    if (dataArray.count > 1)
    {
        _pageDotView  = [[PageDotView alloc] initWithPageNum:dataArray.count];
        _pageDotView.top = self.height - MARGIN_L;
        _pageDotView.left = (self.width - _pageDotView.width)/2;
        [self addSubview:_pageDotView];
        
    }
    
    _placeHolderImageView.hidden = dataArray.count > 0;
    
    [_slideshowScrollerView setImageUrlArray:dataArray];
 
    
    //5秒之后执行幻灯片
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [_slideshowScrollerView playSlideshow];
        
    });
    
    
}

#pragma mark - ImageSliderViewDelegate

- (void)slideshowScrollerViewDidClickPageIndex:(NSUInteger)index
{
    if (_delegate)
    {
        [_delegate imageClickedWithIndex:index];
    }
}

- (void)slideshowScrollerViewPlayingPageIndex:(NSUInteger)index
{
    [_pageDotView setCurrentPage:index];
}


@end
