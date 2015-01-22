//
//  SloppySwiperNavigationController.m
//  PMS
//
//  Created by ligh on 14/11/11.
//
//

#import "SloppySwiperNavigationController.h"


@interface SloppySwiperNavigationController ()
{


}
@end

@implementation SloppySwiperNavigationController

-(void)dealloc
{
    
    [super dealloc];
}

-(instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    if (self = [super initWithRootViewController:rootViewController])
    {
        SloppySwiper *swiper = [[SloppySwiper alloc] initWithNavigationController:self];
        [self setSloopySwiper:swiper];
        [swiper release];
    }
    
    return self;
}

-(void)setSloopySwiper:(SloppySwiper *)sloopySwiper
{
    if (_sloopySwiper!=sloopySwiper)
    {
        RELEASE_SAFELY(_sloopySwiper);
        _sloopySwiper = [sloopySwiper retain];
 
        self.delegate = _sloopySwiper;
    }
}



@end
