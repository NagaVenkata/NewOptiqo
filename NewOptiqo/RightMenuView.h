//
//  RightMenuView.h
//  NewOptiqo
//
//  Created by Umapathi on 9/22/14.
//  Copyright (c) 2014 Umapathi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerView.h"
#import "ReportsListView.h"
#import "ShowOldReportsView.h"

@interface RightMenuView : UIViewController<UIAlertViewDelegate> {
    
    NSString *customerName;
    
    NSDictionary *labels;
    
    UILabel *mainMenu;
    
    UIView *homeView;
    
    UIView *infoView;
}

//profile view image
@property (nonatomic,strong) UILabel *infolabel;
@property (nonatomic,strong) UILabel *profileView;
//@property (nonatomic,strong) UILabel *oldReports;
@property (nonatomic,strong) UIView *customerInfoView;
@property (nonatomic,strong) UIView *currentView;
@property (nonatomic,strong) CustomerView *custView;
@property (nonatomic,strong) UIImageView *reportsView;
@property (nonatomic,strong) UIButton *oldReports;
@property (nonatomic,strong) ReportsListView *reports;


//draws the right main view
- (id)initWithFrame:(CGRect)frame;
//shows the right menu
-(void) showRightMenuView;
//shows  the customer view
-(void) showCustomer:(NSString *) custName;
//resets the user labels
-(void) setUserLanguage;


@end
