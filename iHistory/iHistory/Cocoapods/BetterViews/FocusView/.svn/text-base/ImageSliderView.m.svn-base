//
//  ImageSliderView.m
//  WSJJ_iPad
//
//  Created by lian jie on 2/12/11.
//  Copyright 2011 2009-2010 Dow Jones & Company, Inc. All rights reserved.
//

#import "ImageSliderView.h"

#import "WebImageView.h"

@interface ImageSliderView()<UIGestureRecognizerDelegate>
{
    id<ImageSliderViewDelegate> _delegate;
    UIScrollView    *_scrollView;
    NSArray         *_imageUrls;           //image urls
    NSMutableSet    *_recycledPages;
    NSMutableSet    *_visiblePages;
    // these values are stored off before we start rotation so we adjust our content offset appropriately during rotation
    int             firstVisiblePageIndexBeforeRotation;
    CGFloat         percentScrolledIntoFirstVisiblePage;
    
    
    NSTimeInterval             autoPalyAfterDelay ;
  
    int currentPageIndex;
    
}

- (void)configurePage:(WebImageView *)page forIndex:(NSInteger)index;
- (BOOL)isDisplayingPageForIndex:(NSInteger)index;

- (CGRect)frameForPageAtIndex:(NSInteger)index;
- (CGSize)contentSizeForPagingScrollView;

- (void)tilePages;
- (void)clearPages;
- (WebImageView *)dequeueRecycledPageForIndex:(NSInteger)index;

@end


@implementation ImageSliderView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self configSliderView];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configSliderView];
    }
    return self;
}


-(void) configSliderView
{
    _recycledPages = [[NSMutableSet alloc] init];
    _visiblePages  = [[NSMutableSet alloc] init];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self addSubview:_scrollView];
    
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.clipsToBounds = NO;
    _scrollView.delegate = self;
    //        _scrollView.backgroundColor = UIColorFromRGB(245, 245, 245);
    _scrollView.alpha = 0;
    
    autoPalyAfterDelay = 3;
    
    _scrollView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
    // self.backgroundColor = UIColorFromRGB(245, 245, 245);
    
    

}

-(void)disableBounces
{
    [_scrollView setBounces:NO];
    
//    if (_scrollView.gestureRecognizers.count > 0)
//    {
//        return;
//    }
    
    AppDelegate *appDelegate = KAPP_Delegate;
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:appDelegate.mMDrawerController action:@selector(panGesture:)];
        
    panGestureRecognizer.delegate = self;
    panGestureRecognizer.maximumNumberOfTouches = 1;
    [_scrollView addGestureRecognizer:panGestureRecognizer];
    [panGestureRecognizer release];
    
}

- (void)setImageUrls:(NSArray*)imageUrls
{

    [self clearPages];
    RELEASE_SAFELY(_imageUrls);
    _imageUrls = [imageUrls retain];

    _scrollView.alpha = 1;
    _scrollView.contentSize = [self contentSizeForPagingScrollView];
    
    [_scrollView setContentOffset:CGPointZero];
    if ([_delegate respondsToSelector:@selector(imageDidEndDeceleratingWithIndex:)]) {
        [_delegate imageDidEndDeceleratingWithIndex:_scrollView.contentOffset.x/_scrollView.bounds.size.width];
    }
    [self tilePages];
    
    
}



-(void)autoPlay:(NSTimeInterval)interval
{
    
    autoPalyAfterDelay = interval;
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(startAutoSwitchPageAnimation) object:nil];
    [self performSelector:@selector(startAutoSwitchPageAnimation) withObject:nil afterDelay:autoPalyAfterDelay];
    
}

-(void) stopAutoSwithcPageAnimation
{
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(startAutoSwitchPageAnimation) object:nil];
}

-(void) startAutoSwitchPageAnimation
{
    
    float offsetX = _scrollView.contentOffset.x + self.width;
    
    offsetX =offsetX >= _scrollView.contentSize.width ? 0 :offsetX;
    
    int pageIndex =  offsetX / self.width;
    
    [_scrollView setContentOffset:CGPointMake(MIN(offsetX,_scrollView.contentSize.width - self.width), 0) animated:offsetX!=0];
    
    [self tilePages];
    
    if ([_delegate respondsToSelector:@selector(imageDidEndDeceleratingWithIndex:)])
    {
        [_delegate imageDidEndDeceleratingWithIndex:pageIndex];
    }
    
    [self performSelector:@selector(startAutoSwitchPageAnimation) withObject:nil afterDelay:autoPalyAfterDelay];
    
    
}

- (void)dealloc
{
    _delegate = nil;
    RELEASE_SAFELY(_scrollView);
    RELEASE_SAFELY(_recycledPages);
    RELEASE_SAFELY(_visiblePages);
    RELEASE_SAFELY(_imageUrls);
	[super dealloc];
}

#pragma mark - Tiling and page configuration
- (void)updateFrame
{
    [_scrollView setContentSize:[self contentSizeForPagingScrollView]];
    CGFloat offsetX = floorf(_scrollView.contentOffset.x/_scrollView.width)*_scrollView.width;
    [_scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

- (void)tilePages
{
	int firstIndex = 0;
	int lastIndex = [_imageUrls count] - 1;
	// Calculate which pages are visible
	CGRect visibleBounds = _scrollView.bounds;
	int currentIndex = floorf(CGRectGetMinX(visibleBounds) / CGRectGetWidth(visibleBounds));
	currentIndex = MAX(currentIndex,0);
	currentIndex = MIN(currentIndex,[_imageUrls count] + 1);
    
	int previousPageIndex = currentIndex - 2;
	int nextPageIndex = currentIndex + 2;
	
	previousPageIndex = MAX(previousPageIndex,firstIndex);
	nextPageIndex  = MIN(nextPageIndex,lastIndex);
	
    NSMutableArray *visibleIndexes = [NSMutableArray array];
    for (int i = previousPageIndex; i<=nextPageIndex; i++) {
        [visibleIndexes addObject:@(i)];
    }
	// Recycle no-longer-visible pages
	for (WebImageView *page in _visiblePages) {
		int indexInImages = [_imageUrls indexOfObject:page.urlString];
        if (indexInImages < previousPageIndex || indexInImages > nextPageIndex){
			[_recycledPages addObject:page];
			[page removeFromSuperview];
			ITTDINFO(@"image at index %d is recycled",indexInImages);
		}
	}
	[_visiblePages minusSet:_recycledPages];
	
	// add missing pages
	for (int i = 0; i < [visibleIndexes count]; i++) {
		int index = [(NSNumber*)visibleIndexes[i] intValue];
		if (![self isDisplayingPageForIndex:index]) {
			WebImageView *page = [self dequeueRecycledPageForIndex:index];
			if (page == nil) {
				page = [[[WebImageView alloc] initWithFrame:_scrollView.bounds] autorelease];
                page.userInteractionEnabled = YES;
                page.backgroundColor = [UIColor clearColor];
            
                
                UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClicked:)];
                [page addGestureRecognizer:tapGestureRecognizer];
                [tapGestureRecognizer release];
                
                page.contentMode = UIViewContentModeScaleToFill;
                [page setClipsToBounds:YES];
    
      
			}
			
		[self configurePage:page forIndex:index];
			[_scrollView addSubview:page];
			[_visiblePages addObject:page];
		}
	}
    for (WebImageView *page in _visiblePages) {
        int indexInImages = [_imageUrls indexOfObject:page.urlString];
        if (indexInImages!=NSNotFound) {
            [self configurePage:page forIndex:indexInImages];
        }
	}
}

- (void)clearPages
{
    for (WebImageView *page in _visiblePages) {
        [_recycledPages addObject:page];
        [page removeFromSuperview];
	}
	[_visiblePages minusSet:_recycledPages];
}

- (WebImageView *)dequeueRecycledPageForIndex:(int)index
{
    WebImageView *page = [_recycledPages anyObject];
    if (page) {
        [[page retain] autorelease];
        [_recycledPages removeObject:page];
    }
    return page;
}

- (BOOL)isDisplayingPageForIndex:(NSInteger)index
{
	BOOL foundPage = NO;
	for (WebImageView *page in _visiblePages) {
		int indexInImages = [_imageUrls indexOfObject:page.urlString];
		if (indexInImages == index) {
			foundPage = YES;
			break;
		}
	}
	return foundPage;
}

- (void)configurePage:(WebImageView *)page forIndex:(NSInteger)index
{
    page.tag = index;
    [page setImageWithURLString:_imageUrls[index] placeholderImage:BigPlaceHolderImage];
    page.frame = [self frameForPageAtIndex:index];
}


#pragma mark - ScrollView delegate methods

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self tilePages];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([_delegate respondsToSelector:@selector(imageDidEndDeceleratingWithIndex:)]) {
        [_delegate imageDidEndDeceleratingWithIndex:scrollView.contentOffset.x/scrollView.bounds.size.width];
    }
}


#pragma mark - Frame calculations

- (CGRect)frameForPageAtIndex:(NSInteger)index
{
	CGRect bounds = _scrollView.bounds;
	CGRect pageFrame = bounds;
	pageFrame.origin.x = (bounds.size.width * index);
	return pageFrame;
}

- (CGSize)contentSizeForPagingScrollView
{
	return CGSizeMake(_scrollView.bounds.size.width * [_imageUrls count] , _scrollView.bounds.size.height);
}

- (void)clearCache
{
	[_recycledPages removeAllObjects];
}

#pragma mark - WebImageView delegate
- (void)imageClicked:(UITapGestureRecognizer *)recognizer
{
    WebImageView *imageView = (WebImageView *)recognizer.view;

    if (_delegate && [_delegate respondsToSelector:@selector(imageClickedWithIndex:)])
    {
        [_delegate imageClickedWithIndex:imageView.tag];
    }
}

//监听手势事件
-(BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer
{
    
    CGPoint translation = [gestureRecognizer translationInView:_scrollView];
    
    //如果是水平滑动
    BOOL gestureHorizontal = (fabs(translation.x / translation.y) > 5.0 );
    
    if (gestureHorizontal && translation.x > 0.0 )//向右滑动
    {
        //向右滑动时如果x的坐标为
        if (_scrollView.contentOffset.x <=0)
        {
            return YES;
        }
        
    }
    //    else if(gestureHorizontal && translation.x < 0.0)//向左滑动
    //    {
    //        if ((_scrollView.contentOffset.x + _scrollView.width) >= _scrollView.contentSize.width )
    //        {
    //            return YES;
    //        }
    //    }
    
    
    //默认所有滑动事件都有scrollView处理
    return NO;
}


@end
