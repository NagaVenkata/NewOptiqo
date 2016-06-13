//
//  SignatureView.h
//  NewOptiqo
//
//  Created by Umapathi on 8/27/14.
//  Copyright (c) 2014 Umapathi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface SignatureView : UIView {
    
    CGPoint pnts[5];
    
    uint ctr;
}

@property(strong,nonatomic) UIImage *signImage;
@property(strong,nonatomic) UIBezierPath *signPath;

//draws the curves used as signature
-(void) drawSignImage;
//clear signature
-(void) clearView;

@end
