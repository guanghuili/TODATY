//
//  BannerView.h
//  Carte
//
//  Created by ligh on 14-3-24.
//
//

#import "XibView.h"

#import "ImageSliderView.h"

/**
 *  轮播view
 */
@interface BannerView : XibView

@property (nonatomic,assign)id<ImageSliderViewDelegate> delegate;
@property (retain,nonatomic) NSMutableArray *dataArray;

@end
