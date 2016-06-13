//
//  RoomComments.h
//  NewOptiqo
//
//  Created by Umapathi on 8/24/14.
//  Copyright (c) 2014 Umapathi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentsRoom.h"
#import "ReportsListView.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <MapKit/MKAnnotation.h>
#import <MapKit/MKMapSnapshotOptions.h>



@interface RoomComments : UIViewController<CLLocationManagerDelegate,MKMapViewDelegate> {
    
    NSString *customerName;
    NSDate *currentTime,*doneTime;
    NSDateFormatter *currentDateFormatter,*doneDateFormatter;

    
    NSInteger currentHour,currentMinute,currentSec;
    NSInteger doneHour,doneMinute,doneSec;
    
    CLLocationManager *locationManager;
    
    UIColor *color;
    
    UIFont *font;
    
    MKMapView *customerMapView;
    
    NSDictionary *labels;
    
    int count;
}

@property (nonatomic,strong) UIImageView *approveRoom;
@property (nonatomic,strong) UIButton *nextRoom;
@property (nonatomic,strong) UIButton *commentRoom;
@property (nonatomic,strong) NSString *roomName;
@property (nonatomic,strong) NSString *roomNameKey;

@property (nonatomic,strong) NSString *currentTimeString;
@property (nonatomic,strong) NSString *doneTimeString;

@property (nonatomic,strong) ReportsListView *reportsListView;
@property (nonatomic,strong) CommentsRoom *commentsRoom;

@property (readwrite) BOOL isRoomApproved;

- (id)initWithFrame:(CGRect)frame withCustomerName:(NSString *) name withRoomName:(NSString *)roomname;

-(void) drawView;
-(void) setViewTitle;
//-(void) reportView;
-(void) drawMap;

-(void) addRoom;

-(void) getCustomerCount;

@end
