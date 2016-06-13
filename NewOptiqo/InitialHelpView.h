//
//  InitialHelpView.h
//  Optiqo Inspect
//
//  Created by Umapathi on 10/26/14.
//  Copyright (c) 2014 Umapathi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InitialHelpView : UIScrollView<UIScrollViewDelegate> {
    
    NSMutableArray *helpPages;
    
    UIScrollView *scrollView;
    
    UIColor *color;
    UIFont *font;
    
    UIImageView *checkedImage;
}

@property (nonatomic,strong) UIPageControl *pageController;

@property (nonatomic,strong) NSMutableArray *pages;

@property (nonatomic,strong) NSMutableArray *pageViews;

-(UIView *) addView;

-(void) loadCurrentView;
- (void)loadPage:(NSInteger)page;
- (void)purgePage:(NSInteger)page;


@end
