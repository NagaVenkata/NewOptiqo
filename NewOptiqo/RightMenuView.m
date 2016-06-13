//
//  RightMenuView.m
//  NewOptiqo
//
//  Created by Umapathi on 9/22/14.
//  Copyright (c) 2014 Umapathi. All rights reserved.
//

#import "RightMenuView.h"
#import "ViewController.h"
#import "AppDelegate.h"


@implementation RightMenuView
@synthesize infolabel,customerInfoView,currentView,custView,oldReports,reports,reportsView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super init];
    if (self) {
        // Initialization code
        ViewController *vc = [ViewController sharedInstance];
        
        UIColor *color = NULL;
        
        if(vc.cleaningType == 1) {
            color = [vc.colorArray objectAtIndex:1];
        }
        
        if(vc.cleaningType == 2) {
            color = [vc.colorArray objectAtIndex:0];
        }
        
        //NSLog(@"cleaning type %d,%@",vc.cleaningType,vc.userLanguageSelected);
        
        if([vc.userLanguageSelected isEqualToString:@"Swedish"]) {
            
            labels = [vc.englishLabels valueForKey:@"userswedishlabels"];
        }
        
        if([vc.userLanguageSelected isEqualToString:@"German"]) {
            
            labels = [vc.englishLabels valueForKey:@"usergermanlabels"];
        }
        
        if([vc.userLanguageSelected isEqualToString:@"English"]) {
            
            labels = [vc.englishLabels valueForKey:@"userenglishlabels"];
        }
        
        self.view.frame = frame;
        
        //[self setBackgroundColor:color];
        
        /*float redColor,greenColor,blueColor,alpha;
        
        [color getRed:&redColor green:&greenColor blue:&blueColor alpha:&alpha];
        
        NSLog(@"cleaning type %f,%f,%f",redColor,greenColor,blueColor);*/
        
        [self.view setBackgroundColor:[UIColor colorWithRed:41.0/255.0 green:41.0/255.0 blue:42.0/255.0 alpha:1.0]];
        
        //draws the right menu
        [self showRightMenuView];
        
    }
    return self;
}

//resets user labels
-(void) setUserLanguage {
    
    //NSLog(@"entered data user language");
    
    ViewController *vc = [ViewController sharedInstance];
    
    if([vc.userLanguageSelected isEqualToString:@"Swedish"]) {
        
        labels = [vc.englishLabels valueForKey:@"userswedishlabels"];
    }
    
    if([vc.userLanguageSelected isEqualToString:@"German"]) {
        
        labels = [vc.englishLabels valueForKey:@"usergermanlabels"];
    }
    
    if([vc.userLanguageSelected isEqualToString:@"English"]) {
        
        labels = [vc.englishLabels valueForKey:@"userenglishlabels"];
    }

    [mainMenu setText:[labels valueForKey:@"menu"]];
    
    UIButton *homelabel = (UIButton *) [[homeView subviews] objectAtIndex:1];
    
    [homelabel setTitle:[labels valueForKey:@"home"] forState:UIControlStateNormal];
    
    [self.oldReports setTitle:[labels valueForKey:@"overview"] forState:UIControlStateNormal];
    
   
    [self.infolabel setText:@"Info"];
    
    //[self showRightMenuView];
    
    
}

-(void) showRightMenuView {
    
    
    
    UIView *barView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 140)];
    
    [barView setBackgroundColor:[UIColor colorWithRed:41.0/255.0 green:41.0/255.0 blue:42.0/255.0 alpha:1.0]];
    
    //sets title for right menu view
    mainMenu = [[UILabel alloc] initWithFrame:CGRectMake(10, 85, self.view.frame.size.width, 50)];
    
    [mainMenu setBackgroundColor:[UIColor colorWithRed:41.0/255.0 green:41.0/255.0 blue:42.0/255.0 alpha:0.75]];
    
    
    [mainMenu setText:[labels valueForKey:@"menu"]];
    [mainMenu setTextAlignment:NSTextAlignmentCenter];
    
    
    [mainMenu setFont:[UIFont fontWithName:@"Avenir-Medium" size:24]];
    
    [mainMenu setTextColor:[UIColor whiteColor]];
    
    [barView addSubview:mainMenu];
    
    [self.view addSubview:barView];
    
    //view to go back to home view  when cliked on home view. Shows the home icon ands its label.
    homeView = [[UIView alloc] initWithFrame:CGRectMake(0, 140, self.view.frame.size.width, 125)];
    
    [homeView setBackgroundColor:[UIColor colorWithRed:41.0/255.0 green:41.0/255.0 blue:42.0/255.0 alpha:0.75]];
    //[homeView setBackgroundColor:[UIColor blackColor]];

    /*[homeView.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    
    [homeView.layer setBorderWidth:0.5];
    [homeView.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [homeView.layer setShadowOffset:CGSizeMake(-2, 2)];*/
    
    UIImageView *homeViewImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 15,self.view.frame.size.width,50)];
    [homeViewImage.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    
    
    homeViewImage.image = [UIImage imageNamed:@"home.png"];
    
    [homeViewImage setContentMode:UIViewContentModeScaleAspectFit];
    
    [homeView addSubview:homeViewImage];

    
    CALayer *bottomBorder = [CALayer layer];
    
    bottomBorder.frame = CGRectMake(0.0f, 122.0f, self.view.frame.size.width, 1.0f);
    
    bottomBorder.backgroundColor = [UIColor lightGrayColor].CGColor;
    [bottomBorder setShadowColor:[[UIColor blackColor] CGColor]];
    [bottomBorder setShadowOffset:CGSizeMake(-2, 2)];

    //[homeView.layer addSublayer:bottomBorder];
    
    UIButton *homelabel = [[UIButton alloc] initWithFrame:CGRectMake(5, 70, self.view.frame.size.width, 50)];
    
    //[self.infolabel setBackgroundColor:[UIColor clearColor]];
    [homelabel setTitle:[labels valueForKey:@"home"] forState:UIControlStateNormal];
    [homelabel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //[self.infolabel setTextAlignment:NSTextAlignmentCenter];
    [homelabel.titleLabel setFont:[UIFont fontWithName:@"Avenir-Medium" size:24]];
    
    [homelabel.titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    [homeView setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *homeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backToMainView:)];
    
    [homeView addGestureRecognizer:homeTap];
    
    [homeView addSubview:homelabel];
    
    [self.view addSubview:homeView];
    
    
    //[self.view addSubview:infoView];
    
    
    
    //view to show the overview of reports. Shows the report icon ands its label.
    self.reportsView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 265,self.view.frame.size.width,50)];
    [self.reportsView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    
    [self.reportsView setUserInteractionEnabled:YES];
    
    
    self.reportsView.image = [UIImage imageNamed:@"reports.png"];
    
    
    UITapGestureRecognizer *reportTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showReportsOverview:)];
    
    [self.reportsView addGestureRecognizer:reportTap];
    
    [self.reportsView setContentMode:UIViewContentModeScaleAspectFit];
    
    [self.view addSubview:self.reportsView];
    
    [self.reportsView setHidden:YES];
    
    self.oldReports = [[UIButton alloc] initWithFrame:CGRectMake(5, 285, self.view.frame.size.width, 125)];
    
    [self.oldReports setBackgroundColor:[UIColor clearColor]];
    
    [self.oldReports setTitle:[labels valueForKey:@"overview"] forState:UIControlStateNormal];
    
    
    [self.oldReports.titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    [self.oldReports.titleLabel setFont:[UIFont fontWithName:@"Avenir-Medium"  size:24]];
    
    [self.oldReports setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.oldReports setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *oldReportsTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showReportsOverview:)];
    
    [self.oldReports addGestureRecognizer:oldReportsTap];
    
    
    [self.view addSubview:self.oldReports];
    
    [self.oldReports setHidden:YES];

    //view to show user info. Shows the info icon ands its label.
    infoView = [[UIView alloc] initWithFrame:CGRectMake(0, 375, self.view.frame.size.width, 125)];
    
    //[infoView.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    
    //[infoView.layer setBorderWidth:0.5];
    
    [infoView setBackgroundColor:[UIColor colorWithRed:41.0/255.0 green:41.0/255.0 blue:42.0/255.0 alpha:0.75]];
    //[infoView setBackgroundColor:[UIColor blackColor]];
    
    UIImageView *infoViewImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 15,self.view.frame.size.width,50)];
    [infoViewImage.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    
    
    infoViewImage.image = [UIImage imageNamed:@"info.png"];
    
    [infoViewImage setContentMode:UIViewContentModeScaleAspectFit];
    
    [infoView addSubview:infoViewImage];
    
    
    self.infolabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 70, self.view.frame.size.width, 50)];
    
    //[self.infolabel setBackgroundColor:[UIColor clearColor]];
    [self.infolabel setText:@"Info"];
    [self.infolabel setTextColor:[UIColor whiteColor]];
    //[self.infolabel setTextAlignment:NSTextAlignmentCenter];
    [self.infolabel setFont:[UIFont fontWithName:@"Avenir-Medium" size:24]];
    
    [self.infolabel setTextAlignment:NSTextAlignmentCenter];
    
    CALayer *infoBottomBorder = [CALayer layer];
    
    infoBottomBorder.frame = CGRectMake(0.0f, 122.0f, self.view.frame.size.width, 1.0f);
    
    infoBottomBorder.backgroundColor = [UIColor lightGrayColor].CGColor;
    [infoBottomBorder setShadowColor:[[UIColor blackColor] CGColor]];
    [infoBottomBorder setShadowOffset:CGSizeMake(-2, 2)];
    
    
    //[infoView.layer addSublayer:infoBottomBorder];
    
    [infoView addSubview:infolabel];
    
    //[self showCustomer];
    
}

//shows the customer view
-(void) showCustomer:(NSString *) custName {
    
    if(self.customerInfoView == nil) {
        self.customerInfoView = [[UIView alloc] initWithFrame:CGRectMake(0, 375, self.view.frame.size.width, 125)];
        [self.view addSubview:self.customerInfoView];
    }
     
     //[infoView.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
     
     //[infoView.layer setBorderWidth:0.5];
    
    UIImageView *infoViewImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 15,self.view.frame.size.width,50)];
    [infoViewImage.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    
    
    infoViewImage.image = [UIImage imageNamed:@"info.png"];
    
    [infoViewImage setContentMode:UIViewContentModeScaleAspectFit];
    
    [self.customerInfoView addSubview:infoViewImage];

    
    [self.customerInfoView setBackgroundColor:[UIColor colorWithRed:41.0/255.0 green:41.0/255.0 blue:42.0/255.0 alpha:0.75]];
    //[self.customerInfoView setBackgroundColor:[UIColor blackColor]];
     
     UILabel *custLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 70, self.view.frame.size.width, 50)];
     
     //[self.infolabel setBackgroundColor:[UIColor clearColor]];
     [custLabel setText:[labels valueForKey:@"customerinfo"]];
     [custLabel setTextColor:[UIColor whiteColor]];
     //[self.infolabel setTextAlignment:NSTextAlignmentCenter];
     [custLabel setFont:[UIFont fontWithName:@"Avenir-Medium" size:24]];
     [custLabel setTextAlignment:NSTextAlignmentCenter];
    
    //NSLog(@" cutomer labels %@,%@ ",custLabel,custLabel.font.fontName);
    
    CALayer *bottomBorder = [CALayer layer];
    
    bottomBorder.frame = CGRectMake(0.0f, 122.0f, self.view.frame.size.width, 1.0f);
    
    bottomBorder.backgroundColor = [UIColor lightGrayColor].CGColor;
    
    [bottomBorder setShadowColor:[[UIColor blackColor] CGColor]];
    [bottomBorder setShadowOffset:CGSizeMake(-2, 2)];
    
    //[self.customerInfoView.layer addSublayer:bottomBorder];
     
    [self.customerInfoView addSubview:custLabel];
    
    [self.customerInfoView setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *infoTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(custInfoView:)];
    
    [self.customerInfoView addGestureRecognizer:infoTap];
    
    ViewController *vc = [ViewController sharedInstance];
     
    customerName = vc.customerName;
    
    [self.customerInfoView setHidden:YES];
   
    
}

//back to main view
-(void) backToMainView:(id) sender {
    
    
    
    ViewController *vc = [ViewController sharedInstance];
    
    if(vc.customerList)
    {
    
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[labels valueForKey:@"message"] message:[labels valueForKey:@"homeview"] delegate:self cancelButtonTitle:[labels valueForKey:@"no"] otherButtonTitles:[labels valueForKey:@"yes"], nil];
        [alert show];
    }
    else
    {
    
    
        for(unsigned long i=[[vc.startView subviews] count]-1;i>=4;i--) {
        
            id viewItem = [[vc.startView subviews] objectAtIndex:i];
            [viewItem removeFromSuperview];
        }
    
        for(unsigned long i=[[vc.barView subviews] count]-1;i>=1;i--) {
            
            id viewItem = [[vc.barView subviews] objectAtIndex:i];
            [viewItem removeFromSuperview];
        }
    

    
        if(vc.toggleRightMenu) {
        
            id animation = ^{
            
                vc.startView.transform = CGAffineTransformMakeTranslation(0, 0);
                vc.rightmenuView.view.transform = CGAffineTransformMakeTranslation(vc.deviceWidth, 0);
            
            };
        
            [UIView animateWithDuration:0.5 animations:animation];
        
            //[vc drawRightMenuView];
            [vc resetMenuView];
            [vc setViewTitle];
            vc.toggleRightMenu = NO;
        
            [vc.customerList.view removeFromSuperview];
            [vc.customerList removeFromParentViewController];
            vc.toggleMenu = !vc.toggleMenu;
        }
    }
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    ViewController *vc = [ViewController sharedInstance];
    
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if([title isEqualToString:[labels valueForKey:@"yes"]])
    {
        
        [vc.rightmenuView.reportsView setHidden:YES];
        [vc.rightmenuView.oldReports setHidden:YES];
        
        [self.customerInfoView removeFromSuperview];
        self.customerInfoView = nil;

        
        ReportsListView *current_reports = nil;
        
        //gets back to its original view on which this view is shown.
        
        if(vc.customerList.roomListView.roomComments.reportsListView)
        {
            current_reports = vc.customerList.roomListView.roomComments.reportsListView;
            [current_reports checkReports];
        }
        
        if(vc.customerList.roomListView.roomComments.commentsRoom.reportsListView)
        {
            current_reports = vc.customerList.roomListView.roomComments.commentsRoom.reportsListView;
            [current_reports checkReports];
        }
        
        
        ViewController *vc = [ViewController sharedInstance];
        
        for(unsigned long i=[[vc.startView subviews] count]-1;i>=4;i--) {
            
            id viewItem = [[vc.startView subviews] objectAtIndex:i];
            [viewItem removeFromSuperview];
        }
        
        for(unsigned long i=[[vc.barView subviews] count]-1;i>=1;i--) {
            
            id viewItem = [[vc.barView subviews] objectAtIndex:i];
            [viewItem removeFromSuperview];
        }
        
        
        
        if(vc.toggleRightMenu) {
            
            id animation = ^{
                
                vc.startView.transform = CGAffineTransformMakeTranslation(0, 0);
                vc.rightmenuView.view.transform = CGAffineTransformMakeTranslation(vc.deviceWidth, 0);
                
            };
            
            [UIView animateWithDuration:0.5 animations:animation];
            
            //[vc drawRightMenuView];
            [vc resetMenuView];
            [vc setViewTitle];
            vc.toggleRightMenu = NO;
            
            [vc.customerList.view removeFromSuperview];
            [vc.customerList removeFromParentViewController];
            //vc.customerList = nil;
        }
    }
}

//shows the customer info view
-(void) custInfoView:(id) sender {
    
    
    ViewController *vc = [ViewController sharedInstance];
    
    self.custView = [[CustomerView alloc] initWithCustomerName:customerName withFrame:CGRectMake(0, 0, vc.customerList.roomListView.view.frame.size.width, vc.customerList.roomListView.view.frame.size.height) viewDelegate:vc.customerList.roomListView];
    
    [vc.customerList.roomListView.view addSubview:self.custView];
    
    if(vc.toggleRightMenu) {
        
        id animation = ^{
            
            vc.startView.transform = CGAffineTransformMakeTranslation(0, 0);
            vc.rightmenuView.view.transform = CGAffineTransformMakeTranslation(vc.deviceWidth, 0);
            
        };
        
        [UIView animateWithDuration:0.5 animations:animation];
        
        [vc drawRightMenuView];
        vc.toggleRightMenu = NO;
        
    }
}

#pragma mark--shows reports overview

-(void) showReportsOverview:(id) sender {
    
    ViewController *vc = [ViewController sharedInstance];

    //[vc showOldReports];
    
    self.reports = [[ReportsListView alloc] initWithFrame:CGRectMake(0, 0, vc.customerList.roomListView.view.frame.size.width, vc.customerList.roomListView.view.frame.size.height) withCustomerName:customerName withRoom:nil showOtherButtons:YES];
    
    
    [vc.customerList.roomListView.view addSubview:reports.view];
    
    if(vc.toggleRightMenu) {
        
        id animation = ^{
            
            vc.startView.transform = CGAffineTransformMakeTranslation(0, 0);
            vc.rightmenuView.view.transform = CGAffineTransformMakeTranslation(vc.deviceWidth, 0);
            
        };
        
        [UIView animateWithDuration:0.5 animations:animation];
        
        [vc drawRightMenuView];
        vc.toggleRightMenu = NO;
        
    }
    
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
