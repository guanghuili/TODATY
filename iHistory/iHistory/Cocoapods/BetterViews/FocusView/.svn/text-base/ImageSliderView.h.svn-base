//
//  ImageSliderView.h
//  WSJJ_iPad
//
//  Created by lian jie on 2/12/11.
//  Copyright 2011 2009-2010 , Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ImageSliderViewDelegate <NSObject>

@optional
- (void)imageClickedWithIndex:(int)imageIndex;
- (void)imageDidEndDeceleratingWithIndex:(int)imageIndex;

@end

@interface ImageSliderView : UIView <UIScrollViewDelegate>
{
    
}

@property  (nonatomic,assign) IBOutlet id<ImageSliderViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame;
- (void)setImageUrls:(NSArray*)imagesUrls;
- (void)updateFrame;
-(void) autoPlay:(NSTimeInterval ) interval;

-(void) disableBounces;

@end
