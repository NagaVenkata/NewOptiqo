//
//  UIView+MarkImages.h
//  Optiqo Inspect
//
//  Created by Umapathi on 30/03/15.
//  Copyright (c) 2015 Umapathi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


@interface MarkImages:UIView  {
    
    
}

@property(strong,nonatomic) UIBezierPath *signPath;

-(void) drawSignImage;

@end
