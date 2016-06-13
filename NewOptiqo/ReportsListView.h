//
//  ReportsListView.h
//  NewOptiqo
//
//  Created by Umapathi on 9/9/14.
//  Copyright (c) 2014 Umapathi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <MapKit/MKAnnotation.h>
#import <MapKit/MKMapSnapshotOptions.h>
#import  "RoomListContent.h"
#import "CreatePdfReport.h"
#import "Reportview.h"
#import "PieChartView.h"

@interface ReportsListView : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,CLLocationManagerDelegate,MKMapViewDelegate> {
    
    NSString *customerName;
    NSString *roomName;
    
    UIColor *color;
    UIFont *font;
    
    BOOL showButtons;
    
    BOOL showOldReports;

    int percentRate;
    
    NSString *customerEmail;
    

    NSString *employeeEmail;
    NSString *emailSubject;
    
    NSMutableArray *emailAttrs;
    
    NSDictionary *labels;
    
    float rating;
    
    
    int approvedCount;
    
    
    BOOL isCustomerReportSend,isEmployerReportSend;
    
    NSDate *reportSentDate;
    
    RoomListContent  *roomList;
    
    CLLocationManager *locationManager;
    
    MKMapView *customerMapView;
    
    float lat,lang;
    
    NSString *pervCustLabel;
    
}

@property(nonatomic,strong) UIScrollView *scrollView;
@property(nonatomic,strong) UITableView *reportsListView;
@property(nonatomic,strong) NSMutableArray *reportsList;
@property(nonatomic,strong) UIView *addCustomers;
@property(nonatomic,strong) UITextView *reportView;
@property(nonatomic,strong) UIButton *sendButton;
@property(nonatomic,strong) RoomListContent *content;
@property(nonatomic,strong) RoomListContent *room_content;
@property(nonatomic,strong) NSMutableArray *commentRooms;
@property(nonatomic,strong) Reportview *roomReport;
@property(nonatomic,strong) PieChartView *pieChart;
@property(nonatomic,strong) PieChartView *reportChart;
@property(nonatomic,strong) PieChartView *scoreChart;



-(id) initWithFrame:(CGRect)frame withCustomerName:(NSString *) customerName withRoom:(NSString *) roomName showOtherButtons:(BOOL) showButtons;
-(id) initWithFrame:(CGRect)frame withCustomerName:(NSString *) customerName withRoom:(NSString *) roomName showOtherButtons:(BOOL) showButtons withDate:(NSDate*) date;

-(void) showReportsListView;
-(void) getData;
-(void) getOldReportsData;
-(void) calculateRating;
-(void) getEmployer;
-(void) setViewTitle;

-(void) resetImagesDirectories:(int) index;

//checks the customer and employer report status
-(void) checkReportStatus;

//resets the customer and employer report status
-(void) resetReportsStatus;

-(void) back_addRoom;

//check both the reports
-(void) checkReports;

//draws a map when customer report sent
-(void) drawMap;

-(void) setReportsSent;

-(void) updateCustomerTotalTime;

@end
