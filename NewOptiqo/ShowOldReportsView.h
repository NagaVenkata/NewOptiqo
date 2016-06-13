//
//  ShowOldReportsView.h
//  NewOptiqo
//
//  Created by Umapathi on 9/15/14.
//  Copyright (c) 2014 Umapathi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoomsListView.h"

@interface ShowOldReportsView : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate> {
    
    UIColor *color;
    UIFont *font;
    
    CABasicAnimation *anim,*anim1;
    
    BOOL isforwardScale;
    
    UIImageView *backImg;
    
    NSMutableArray *customersTimeDate;
    
    UIButton *cancelButton;
    
    NSDictionary *labels;
    
    BOOL isRightMenu;
    
    NSString *pervCustLabel;
}

@property(nonatomic,strong) UITableView *customersListView;
@property(nonatomic,strong) NSMutableArray *customersList;
@property(nonatomic,strong) NSMutableArray *customersRoom;
@property(nonatomic,strong) ReportsListView  *reportListView;


/*@property(nonatomic,strong) CustomerView *customerView;
@property(nonatomic,strong) CustomerView *showCustomerView;
@property(nonatomic,strong) RoomsListView *roomListView;*/

//initial the view
-(id) initWithFrame:(CGRect) frame;
-(id) initWithFrame:(CGRect) frame rightMenu:(BOOL) menu;
//shows the reports views
-(void) showCustomersListView;
//get data from database
-(void) getData;


-(void) changeType;
-(BOOL) customerFound:(NSString *)string;
-(void) setViewTitle;
-(void) setTitleViewWithLeftMenu;


@end
