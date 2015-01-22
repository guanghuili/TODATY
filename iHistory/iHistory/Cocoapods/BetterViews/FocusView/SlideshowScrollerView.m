//
//  SlideshowScrollerView
//
//  Created by sprint on 12-11-24.
//
//

#import "SlideshowScrollerView.h"

@implementation SlideshowScrollerView
@synthesize delegate;

- (void)dealloc
{
	[scrollView release];
	delegate=nil;

    if (imageArray) {
        [imageArray release];
        imageArray=nil;
    }

    [super dealloc];
}


-(void)setImageUrlArray:(NSArray *)imgArr
{
    [self stopSlideshow];
    
    if (imgArr.count == 0)
    {
        return;
    }
  
    self.userInteractionEnabled=YES;
    NSMutableArray *tempArray=[NSMutableArray arrayWithArray:imgArr];
    [tempArray insertObject:[imgArr objectAtIndex:([imgArr count]-1)] atIndex:0];
    [tempArray addObject:[imgArr objectAtIndex:0]];
    imageArray=[[NSArray arrayWithArray:tempArray] retain];
    NSUInteger pageCount=[imageArray count];
    
    if (!scrollView)
    {
        scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.size.width, self.size.height)];
        scrollView.pagingEnabled = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.scrollsToTop = NO;
        scrollView.delegate = self;
         [self addSubview:scrollView];
    }
    
    for (int i=0; i<pageCount; i++)
    {
        NSString *imgURL=[imageArray objectAtIndex:i];
        WebImageView *imgView = [[[WebImageView alloc] init] autorelease];
        imgView.contentMode = UIViewContentModeScaleToFill;
        if ([imgURL hasPrefix:@"http://"])
        {
       
            imgView.backgroundColor = [UIColor clearColor];
            [imgView setImageWithURLString:imgURL placeholderImage:BigPlaceHolderImage];
        }
        else
        {
            
            UIImage *img=[UIImage imageNamed:[imageArray objectAtIndex:i]];
            [imgView setImage:img];
        }
        
        [imgView setFrame:CGRectMake(self.size.width*i, 0,self.size.width, self.size.height)];
        imgView.tag= i ;
        UITapGestureRecognizer *Tap =[[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imagePressed:)] autorelease];
        [Tap setNumberOfTapsRequired:1];
        [Tap setNumberOfTouchesRequired:1];
        imgView.userInteractionEnabled=YES;
        [imgView addGestureRecognizer:Tap];
        [imgView setClipsToBounds:YES];
        [scrollView setClipsToBounds:YES];
        [scrollView addSubview:imgView];
    }
    
    
    scrollView.contentSize = CGSizeMake(self.size.width * pageCount, self.size.height);
    [scrollView setContentOffset:CGPointMake(pageCount > 1 ?  self.size.width : 0, 0)];

    

}

-(void)playSlideshow
{
    [UIView animateWithDuration:0.3 animations:^{
        
        //如果用户手指已放到scrollView上则不进行播放动画
        if(!scrollView.tracking)
        {
            [scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x + scrollView.width, 0)];
        }
    
    } completion:^(BOOL finished) {

        [self scrollViewDidEndDecelerating:scrollView];
        [self performSelector:@selector(playSlideshow) withObject:nil afterDelay:5];
    }];
}


-(void)stopSlideshow
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *) sender
{
    CGFloat pageWidth = scrollView.width;
    currentPageIndex = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    if (currentPageIndex==0) {
      
        [scrollView setContentOffset:CGPointMake(([imageArray count]-2)*self.width, 0)];
    }
    if (currentPageIndex==([imageArray count]-1)) {
       
        [scrollView setContentOffset:CGPointMake(self.width, 0)];
        
    }
    
    if ([delegate respondsToSelector:@selector(slideshowScrollerViewPlayingPageIndex:)])
    {
        [delegate slideshowScrollerViewPlayingPageIndex:(scrollView.contentOffset.x/scrollView.bounds.size.width)-1];
    }

}

- (void)imagePressed:(UITapGestureRecognizer *)sender
{

    if ([delegate respondsToSelector:@selector(slideshowScrollerViewDidClickPageIndex:)])
    {
        [delegate slideshowScrollerViewDidClickPageIndex:sender.view.tag-1];
    }
}

@end
