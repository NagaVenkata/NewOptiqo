//
//  InitialHelpView.m
//  Optiqo Inspect
//
//  Created by Umapathi on 10/26/14.
//  Copyright (c) 2014 Umapathi. All rights reserved.
//

#import "InitialHelpView.h"
#import "ViewController.h"

@implementation InitialHelpView

@synthesize pageController,pages,pageViews;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self setBackgroundColor:[UIColor orangeColor]];
        scrollView  = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height*0.95)];
        scrollView.delegate = self;
        self.pageController = [[UIPageControl alloc] initWithFrame:CGRectMake(150, self.frame.size.height*0.75, 50, 25)];
        [self.pageController setBackgroundColor:[UIColor clearColor]];
        
        
        
        color = [UIColor blackColor];
        
        font = [UIFont fontWithName:@"Avenir-Medium" size:16];

        
        helpPages = [[NSMutableArray alloc] init];
        
        [helpPages addObject:[self addView]];
        [helpPages addObject:[self addView]];
        

        
        NSInteger imageCount = [helpPages count];
        
        self.pageController.currentPage = 0;
        self.pageController.numberOfPages = imageCount;
        
        self.pageViews = [[NSMutableArray alloc] init];
        
        for(NSInteger i=0;i<imageCount;i++) {
            
            [self.pageViews addObject:[NSNull null]];
            
        }
        
        CGSize pagesScrollViewSize = self.frame.size;
        
        
        scrollView.contentSize = CGSizeMake(pagesScrollViewSize.width * helpPages.count, 400);
        
        UIView *checkedView = [[UIView alloc] initWithFrame:CGRectMake(50, self.frame.size.height*0.85, 300, 50)];
        
        [checkedView setBackgroundColor:[UIColor whiteColor]];
        
        UILabel *checkedLabel = [[UILabel alloc] initWithFrame:CGRectMake(checkedView.frame.origin.x, self.frame.size.height*0.85, checkedView.frame.size.width*0.5, checkedView.frame.size.height)];
        
        [checkedLabel setBackgroundColor:[UIColor clearColor]];
        
        [checkedLabel setText:@"Dont show help"];
        
        [checkedLabel setTextColor:color];
        
        [checkedLabel setFont:font];
        
        [checkedView addSubview:checkedLabel];
        
        checkedImage = [[UIImageView alloc] initWithFrame:CGRectMake(checkedView.frame.size.width*0.7, 200, 50, 25)];

        checkedImage.image = [UIImage imageNamed:@"checkbox.png"];
        
        [checkedImage setContentMode:UIViewContentModeScaleAspectFit];
        
        [checkedImage setUserInteractionEnabled:YES];
        
        UITapGestureRecognizer *imageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeHelpView:)];
        
        [checkedImage addGestureRecognizer:imageTap];
        
        [self loadCurrentView];
        
        [self addSubview:scrollView];
        [self addSubview:self.pageController];
        [self addSubview:checkedLabel];
        [self addSubview:checkedImage];
        

        
    }
    return self;
}

#pragma mark--close help view

-(void) closeHelpView:(id) sender {
    
    id animation = ^{
      
        checkedImage.image = [UIImage imageNamed:@"checkbox_checked.png"];
        self.transform = CGAffineTransformMakeTranslation(320, 0);
        
    };
    
    id complete = ^(BOOL finished) {
        
        [self removeFromSuperview];
        
    };
    
    [UIView animateWithDuration:0.5 animations:animation completion:complete];
    
}

-(UIView *) addView {
    
    UIView *helpView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height*0.75)];
    
    [helpView setBackgroundColor:[UIColor orangeColor]];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2-20, self.frame.size.height/2-5, 100, 50)];
    
    [label setBackgroundColor:[UIColor clearColor]];
    
    [label setText:@"Help View"];
    
    [label setTextColor:color];
    
    [label setFont:font];
    
    [helpView addSubview:label];
    
    return helpView;
}

//loads the current view
-(void) loadCurrentView {
    
    CGFloat pageWidth = self.frame.size.width;
    NSInteger page = (NSInteger)floor((scrollView.contentOffset.x * 2.0f + pageWidth) / (pageWidth * 2.0f));
    
    // Update the page control
    self.pageController.currentPage = page;
    
    [self.pageController setPageIndicatorTintColor:[UIColor blueColor]];
    
    // Work out which pages you want to load
    NSInteger firstPage = page - 1;
    NSInteger lastPage = page + 1;
    
    
    // Purge anything before the first page
    for (NSInteger i=0; i<firstPage; i++) {
        [self purgePage:i];
    }
    for (NSInteger i=firstPage; i<=lastPage; i++) {
        [self loadPage:i];
    }
    for (NSInteger i=lastPage+1; i<helpPages.count; i++) {
        [self purgePage:i];
    }
    
    
}

- (void)loadPage:(NSInteger)page {
    if (page < 0 || page >= helpPages.count) {
        // If it's outside the range of what we have to display, then do nothing
        return;
    }
    
    // Load an individual page, first checking if you've already loaded it
    UIView *pageView = [self.pageViews objectAtIndex:page];
    if ((NSNull*)pageView == [NSNull null]) {
        CGRect frame = self.bounds;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0.0f;
        frame = CGRectInset(frame, 1.0f, 0.0f);
        
        UIView *newPageView = [helpPages objectAtIndex:page];
        newPageView.contentMode = UIViewContentModeScaleAspectFit;
        newPageView.frame = frame;
        [scrollView addSubview:newPageView];
        [self.pageViews replaceObjectAtIndex:page withObject:newPageView];
    }
}

- (void)purgePage:(NSInteger)page {
    if (page < 0 || page >= helpPages.count) {
        // If it's outside the range of what you have to display, then do nothing
        return;
    }
    
    // Remove a page from the scroll view and reset the container array
    UIView *pageView = [self.pageViews objectAtIndex:page];
    if ((NSNull*)pageView != [NSNull null]) {
        [pageView removeFromSuperview];
        [self.pageViews replaceObjectAtIndex:page withObject:[NSNull null]];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // Load the pages that are now on screen
    [self loadCurrentView];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
