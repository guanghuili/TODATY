//
//  ShareView.h
//  Carte
//
//  Created by ligh on 14-4-16.
//
//

#import "AnimationPicker.h"

/**
 *  分享
 */
@interface ShareView : AnimationPicker

-(void) showInView:(UIView *) inView shareContent:(NSString *) shareContent title:(NSString *) title;
-(void) showInView:(UIView *) inView shareContent:(NSString *) shareContent;

@property (retain,nonatomic) NSString *shareContent;

@end
