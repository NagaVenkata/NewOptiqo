//
//  CustomerView.h
//  NewOptiqo
//
//  Created by Umapathi on 8/23/14.
//  Copyright (c) 2014 Umapathi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <MapKit/MKAnnotation.h>
#import <MapKit/MKMapSnapshotOptions.h>
#import "SearchList.h"

@interface CustomerView : UIScrollView<CLLocationManagerDelegate,MKMapViewDelegate>{
    

    CGPoint offset;
    
    UIColor *color;
    
    UIFont *font;
    
    
    
    MKPointAnnotation *point;
    
    BOOL isLanguageSelected,isTypeSelected;
    
    NSString *customer_name;
    
    float latitude,longitude;
    
    NSDictionary *labels;
    
    NSString *customer_email;
    
    NSString *customer_phone;
    
    NSString *pervCustLabel;
    
    CLLocationManager *locationManager;
    
    BOOL canChangeType;
    
    
}

@property(nonatomic,strong) UITextField *customerName;
@property(nonatomic,strong) UITextField *customerEmail;
@property(nonatomic,strong) UITextField *customerCountryCode;
@property(nonatomic,strong) UITextField *customerPhonenumber;
@property(nonatomic,strong) UITextField *customerAddress;
@property(nonatomic,strong) UITextField *customerStreet;
@property(nonatomic,strong) UITextField *customerCity;
@property(nonatomic,strong) UITextField *customerCountry;
//@property(nonatomic,strong) UITextField *customerLanguage;
@property(nonatomic,strong) UIView *chooseLanguage;
@property(nonatomic,strong) UIView *chooseType;

@property(nonatomic,strong) UIButton *saveButton;
@property(nonatomic,strong) UIButton *cancelButton;

@property(nonatomic,strong) SearchList *searchList;
@property(nonatomic,assign) id dg;
@property(nonatomic,assign) UITextField *currentTextField;
@property(nonatomic,assign) MKMapView *customerMapView;

@property(nonatomic,strong) SearchList *languageSearchList;
@property(nonatomic,strong) SearchList *typeSearchList;

//initialize the view with delegate
-(id) initWithFrame:(CGRect)frame viewDelegate:(id) delg;
-(id) initWithCustomerName:(NSString *) name withFrame:(CGRect) frame viewDelegate:(id) delg;
-(id) initWithEditCustomerName:(NSString *) name withFrame:(CGRect) frame viewDelegate:(id) delg;

//draw the view contents
-(void) drawView;
//gets the data from databse
-(void) getData;
//gets data from datbase to display
-(void) getData:(NSString *) name;

-(void) registerForKeyboardNotifications;
//email validate
-(BOOL) validateEmail;
//save customer data
-(void) saveCustomerData;
//save edited customer data
-(void) saveCustomerEditData;

-(void) changeType;
//reloads the map
-(void) reloadMapView;
//set view titles
-(void) setViewTitle;

-(UIImageView *) getImage;
//sets the map location according to user entered address
-(void) setMapLocation:(UITextField*) textField;

//gets customer rooms
-(void) getCustomerRooms;


@end
