//
//  EditImage.h
//  Optiqo Inspect
//
//  Created by Umapathi on 10/9/14.
//  Copyright (c) 2014 Umapathi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "MarkImages.h"

@interface EditImage : UIView {
    
    NSString *imageFileName;
    UIImageView *imageView;
    UIImage *editimage;

    NSDictionary *labels;
    
    CGPoint myPoint;
    
}

@property(strong,nonatomic) UIImage *signImage;
@property(strong,nonatomic) UIBezierPath *signPath;
@property(strong,nonatomic) UIImage *retImage;

-(id) initWithFrame:(CGRect)frame withImage:(UIImage *) image;
//-(void) drawSignImage;
//-(void) clearView;
//-(void) editImage;
-(void) setViewTitle;

@end
