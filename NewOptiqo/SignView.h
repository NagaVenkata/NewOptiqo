//
//  SignView.h
//  NewOptiqo
//
//  Created by Umapathi on 9/5/14.
//  Copyright (c) 2014 Umapathi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignatureView.h"
@interface SignView : UIViewController<UIActionSheetDelegate> {
    
    UIColor *color;
    UIFont *font;
    
    UIScrollView *scrollView;
    
     NSDictionary *labels;
}

@property(strong,nonatomic) SignatureView *signatureView;
@property(strong,nonatomic) UIButton *save;
@property(strong,nonatomic) UIButton *clear;
@property(strong,nonatomic) UIImageView *signImage;

//draw the view
-(void) drawView;
//draw the view contents
-(void) getSignImage;
//draws the view titles
-(void) setTitleView;


@end
