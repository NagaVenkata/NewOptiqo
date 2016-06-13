//
//  CustomersList.h
//  NewOptiqo
//
//  Created by Umapathi on 8/20/14.
//  Copyright (c) 2014 Umapathi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerView.h"
#import "RoomsListView.h"


@interface CustomersList : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UISearchBarDelegate,UISearchDisplayDelegate,UIScrollViewDelegate,MKMapViewDelegate>{
    
    UITableViewCell *cell;
    
    UIColor *color;
    
    UIFont *font;
    
    NSMutableArray *initialCustomersList;

    
    UISearchBar *searchBar;
    UISearchDisplayController *searchDisplayController;
    
    CustomerView *customer_view;
    
    NSMutableArray *cutomerLanguage;
    
    NSDictionary *labels;
    
    NSString *customerName;
    
    
}

@property(nonatomic,strong) UITableView *customersListView;
@property(nonatomic,strong) NSMutableArray *customersList;
@property(nonatomic,strong) NSMutableArray *customersType;
@property(nonatomic,strong) UIView *addCustomers;
@property(nonatomic,strong) CustomerView *customerView;
@property(nonatomic,strong) CustomerView *showCustomerView;
@property(nonatomic,strong) RoomsListView *roomListView;
@property(nonatomic,strong) CustomerView *customer_view;
@property(nonatomic,strong) CustomerView *editCustomer_view;


//initialize the view
- (id)initWithFrame:(CGRect)frame;
//shows customers list
-(void) showCustomersListView;
//gets customer from database
-(void) getData;

-(void) changeType;
//search for a customer
-(BOOL) customerFound:(NSString *)string;
//sets the title for the view and icons
-(void) setViewTitle;

//check if user or employer info is avaliable
-(BOOL) IsUser_EmployerInfoPresent;
//delete rooms
-(void) deleteRoomType;
//delete customer
-(void) deleteCustomerRooms;

@end
