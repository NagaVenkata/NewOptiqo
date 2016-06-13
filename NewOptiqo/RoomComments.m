//
//  RoomComments.m
//  NewOptiqo
//
//  Created by Umapathi on 8/24/14.
//  Copyright (c) 2014 Umapathi. All rights reserved.
//

#import "RoomComments.h"
#import "ViewController.h"
#import "AppDelegate.h"

@implementation RoomComments
@synthesize approveRoom,nextRoom,commentRoom,currentTimeString,doneTimeString,roomName,roomNameKey,isRoomApproved,reportsListView,commentsRoom;

/*- (id)initWithFrame:(CGRect)frame
{
    self = [super init];
    if (self) {
        // Initialization code
    }
    return self;
}*/


//view used for commenting the room or the status of the rooms

- (id)initWithFrame:(CGRect)frame withCustomerName:(NSString *) name withRoomName:(NSString *)roomname
{
    self = [super init];
    if (self) {
        // Initialization code
        
        
        /*if(vc.cleaningType == 1) {
            
            color = [vc.colorArray objectAtIndex:1];
        }
        
        if(vc.cleaningType == 2) {
            
            color = [vc.colorArray objectAtIndex:0];
        }*/
        
        self.view.frame = frame;
        
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
        
        color = [UIColor blackColor];
        
        font = [UIFont fontWithName:@"Avenir-Medium" size:16.0];
        
        vc.currentTime = [NSDate date];
        

        
        
        //count = [vc.customerList.roomListView.roomsList count];
        
        /*locationManager = [[CLLocationManager alloc] init];
        
        locationManager.delegate = self;
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        [locationManager startUpdatingLocation];*/
        
        customerName = name;
        
        self.roomName = roomname;
        
        [self getCustomerCount];
        
        //NSLog(@"num of rooms %d,%d",count,[vc.customerList.roomListView.roomsList count]);

        
        [self.view setBackgroundColor:[UIColor whiteColor]];
        
        /*currentTime = [NSDate date];
        
        currentDateFormatter = [[NSDateFormatter alloc] init];
        currentDateFormatter.dateFormat = @"hh:mm:ss";
        [currentDateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
        
        self.currentTimeString = [currentDateFormatter stringFromDate:currentTime];*/
        
        /*NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *components = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:[NSDate date]];
        currentHour = [components hour];
        currentMinute = [components minute];
        currentSec = [components second];*/
        
        //ViewController *vc = [ViewController sharedInstance];
        
        [self addRoom];
        
        [self drawView];
        
        /*label = [[UILabel alloc] initWithFrame:CGRectMake(100, 20, 200, 32)];
        
        [label setBackgroundColor:[UIColor whiteColor]];
        
        [label setText:@"Comments"];
        [label setTextColor:color];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setFont:[UIFont fontWithName:@"Avenir-Medium" size:24]];
        
        [vc.barView addSubview:label];
        
        
        backView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 25, 40, 40)];
        
        backView.image = [UIImage imageNamed:@"back.png"];
        
        [backView setUserInteractionEnabled:YES];
        
        backTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backToRoomListView:)];
        
        [backView addGestureRecognizer:backTap];
        
        [vc.barView addSubview:backView];*/
        
        
        
        [self setViewTitle];
        
        //NSLog(@"selected room %@",vc.selectedRoomName);
       
        
        [vc.rightmenuView.customerInfoView setHidden:NO];
        
        
        

    }
    return self;
}

//gets the customer count
-(void) getCustomerCount {
    
    //ViewController *vc = [ViewController sharedInstance];
    
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *dataContext = [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchData = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CustomerRooms" inManagedObjectContext:dataContext];
    
    [fetchData setEntity:entity];
    
    
    
    //NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData error:&error];
    
    //NSLog(@"customer name %@",customerName);
    NSPredicate *pred =[NSPredicate predicateWithFormat:@"(customerName =%@)" ,customerName];
    
    [fetchData setPredicate:pred];
    //NSManagedObject *matches = nil;
    
    /*NSError *error;
    NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData
                                                       error:&error];
    count=[fetchObjects count];*/

}

//sets the view title and icons
-(void) setViewTitle {
    
    ViewController *vc = [ViewController sharedInstance];
    
    for(unsigned long i=[[vc.barView subviews] count]-1;i>=1;i--) {
        
        id viewItem = [[vc.barView subviews] objectAtIndex:i];
        [viewItem removeFromSuperview];
    }
    
    [vc drawRightMenuView];
    
    UILabel *cust_label = [[UILabel alloc] initWithFrame:CGRectMake(85, 25, 150, 32)];
    
    [cust_label setBackgroundColor:[UIColor clearColor]];
    
    //[cust_label setText:[labels valueForKey:@"comments"]];
    [cust_label setText:@"Status"];
    [cust_label setTextColor:[UIColor whiteColor]];
    [cust_label setTextAlignment:NSTextAlignmentCenter];
    [cust_label setFont:[UIFont fontWithName:@"Avenir-Medium" size:18]];
    [cust_label setTextAlignment:NSTextAlignmentCenter];
    
    [vc.barView addSubview:cust_label];
    
    UIImageView *backImage = (UIImageView *)[[vc.barView subviews] objectAtIndex:0];
    
    backImage.image = [UIImage imageNamed:@"back.png"];
    
    UITapGestureRecognizer *backTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backToRoomListView:)];
    
    [backImage addGestureRecognizer:backTap];
}

//back to previous view
-(void) backToRoomListView:(id) sender  {
    
    
    ViewController *vc = [ViewController sharedInstance];
    
    RoomsListView *roomList = vc.customerList.roomListView;

    
    [roomList setViewTitle];
    

    
    id animation = ^{
      
        self.view.transform = CGAffineTransformMakeTranslation(320, 0);
        
    };
    
    id completion = ^(BOOL finished) {
       
       [roomList.roomComments.view removeFromSuperview];
       [roomList.roomComments removeFromParentViewController];
       [self removeFromParentViewController];

       roomList.roomComments = nil;
    
    };
    
    [UIView animateWithDuration:0.5 animations:animation completion:completion];
    
}

//adds a room
-(void) addRoom {
    
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *dataContext = [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchData = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CustomerRooms" inManagedObjectContext:dataContext];
    
    [fetchData setEntity:entity];
    
    
    
    //NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData error:&error];
    
    //NSManagedObject *userData = nil;
    
    //NSLog(@"customer name %@",customerName);
    NSPredicate *pred =[NSPredicate predicateWithFormat:@"(customerName =%@) AND (room = %@)",customerName,self.roomName];
    
    [fetchData setPredicate:pred];
    //NSManagedObject *matches = nil;
    
    NSError *error;
    NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData
                                                       error:&error];
    
    int roomCount = 0;
    
    if(fetchObjects) {
        roomCount = (int)[fetchObjects count];
    }
    
    /*NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSManagedObject *newContact;
    newContact = [NSEntityDescription
                  insertNewObjectForEntityForName:@"CustomerRooms"
                  inManagedObjectContext:context]; */
    
    //NSLog(@"room count %d",roomCount);
    
    NSString *room = [NSString stringWithFormat:@"%@_%d",self.roomName,(roomCount+1)];
    
    ViewController *vc = [ViewController sharedInstance];
    
    vc.selectedRoomName = room;
    
    /*NSLog(@" customer name %@,%@ ",customerName,self.roomName);
    
    [newContact setValue:customerName forKey:@"customerName"];
    [newContact setValue:self.roomName forKey:@"room"];
    [newContact setValue:room forKey:@"roomName"];
    
    [context save:&error];*/

}

//draws the main view to decide the status of the rooms
-(void) drawView {
    
    
    UIImageView  *backImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height)];
    
    backImg.image = [UIImage imageNamed:@"view_background.png"];
    
    [self.view addSubview:backImg];
    
    self.approveRoom = [[UIImageView alloc] initWithFrame:CGRectMake(85, 25, 150,self.view.frame.size.height*0.6)];
    
    //[self.approveRoom.layer setCornerRadius:75.0];
    
    //self.approveRoom.layer.masksToBounds = YES;
    
    self.approveRoom.image = [UIImage imageNamed:@"approved.png"];
    //[self.approveRoom.layer  setBorderColor:[[UIColor lightGrayColor] CGColor]];
    //[self.approveRoom.layer setBorderWidth:0.5];
    
    [self.approveRoom setContentMode:UIViewContentModeScaleAspectFit];
    
    [self.approveRoom setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *approveTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(approve_room:)];
    
    [self.approveRoom addGestureRecognizer:approveTap];
    
    [self.view addSubview:self.approveRoom];
    
    
    
    self.commentRoom = [[UIButton alloc] initWithFrame:CGRectMake(50, self.view.frame.size.height*0.8, 100, 50)];
    
    [self.commentRoom setBackgroundColor:[UIColor lightTextColor]];
    [self.commentRoom.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    
    [self.commentRoom.layer setBorderWidth:0.5];
    
    
    [self.commentRoom setTitle:[labels valueForKey:@"comments"] forState:UIControlStateNormal];
    
    [self.commentRoom.titleLabel setFont:font];
    
    [self.commentRoom setTitleColor:color forState:UIControlStateNormal];
    
    [self.commentRoom addTarget:self action:@selector(comment_room:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.commentRoom];
    
    //[self bringSubviewToFront:self.commentRoom];
    
    
    
    self.nextRoom = [[UIButton alloc] initWithFrame:CGRectMake(175, self.view.frame.size.height*0.8, 100,50)];
    
    [self.nextRoom setBackgroundColor:[UIColor colorWithRed:0.0 green:180.0/255.0 blue:0.0 alpha:0.95]];
    [self.nextRoom.layer  setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.nextRoom.layer setBorderWidth:0.5];
    
    [self.nextRoom setTitle:[labels valueForKey:@"next"] forState:UIControlStateNormal];
    
    [self.nextRoom.titleLabel setFont:font];
    
    [self.nextRoom setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.nextRoom addTarget:self action:@selector(disapprove_room:) forControlEvents:UIControlEventTouchUpInside];

    
    
    [self.view addSubview:self.nextRoom];
    
    //[self bringSubviewToFront:self.nextRoom];
    
    
    customerMapView = [[MKMapView alloc] initWithFrame:CGRectMake(50, 100, 200, 250)];
    
    customerMapView.delegate = self;
    
    [self.view addSubview:customerMapView];
    
    customerMapView.mapType = MKMapTypeStandard;
    
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 0.0;
    zoomLocation.longitude= 0.0;
    
    
    
    // 2
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 1500, 1500);
    
    [customerMapView setRegion:[customerMapView regionThatFits:viewRegion] animated:YES];
    
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = zoomLocation;
    point.title = @"Where am I?";
    point.subtitle = @"I'm here!!!";
    
    [customerMapView addAnnotation:point];
    
    [customerMapView setHidden:YES];

    
    
}


//approve that room is cleaned
-(void) approve_room:(id) sender {
    
    
    [locationManager stopUpdatingLocation];
    
    
    self.isRoomApproved = !self.isRoomApproved;
    
    ViewController *vc = [ViewController sharedInstance];
    
    if(vc.cleaningType == 1) {
        
        if(self.isRoomApproved)
            self.approveRoom.image = [UIImage imageNamed:@"approve.png"];
        else
            self.approveRoom.image = [UIImage imageNamed:@"approved.png"];
        
    }
    
    if(vc.cleaningType == 2) {
        
        //self.approveRoom.image = [UIImage imageNamed:@"green_approve.png"];
        
        if(self.isRoomApproved)
            self.approveRoom.image = [UIImage imageNamed:@"approve.png"];
        else
            self.approveRoom.image = [UIImage imageNamed:@"approved.png"];
        
    }
    
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *dataContext = [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchData = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CustomerRooms" inManagedObjectContext:dataContext];
    
    [fetchData setEntity:entity];
    
    
    
    //NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData error:&error];
    
    NSManagedObject *userData = nil;
    
    //NSLog(@"customer name in approve room %@",customerName);
    NSPredicate *pred =[NSPredicate predicateWithFormat:@"(customerName =%@) AND (roomName = %@)",customerName,vc.selectedRoomName];
    
    [fetchData setPredicate:pred];
    //NSManagedObject *matches = nil;
    
    NSError *error;
    NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData
                                                       error:&error];
    
    if(fetchObjects) {
        if([fetchObjects count]!=0) {
            for(int i=0;i<[fetchObjects count];i++) {
                userData = [fetchObjects objectAtIndex:i];
                if(self.isRoomApproved) {
                    
                    NSNumber *num = [[NSNumber alloc] initWithBool:YES];
                    //NSNumber *marked = [[NSNumber alloc] initWithBool:YES];
                    
                    [userData setValue:num forKey:@"approved"];
                    //[userData setValue:marked forKey:@"marked"];
                }
                [dataContext save:&error];
               // NSLog(@"error %@",error.description);
            }
        } else {
            
            NSManagedObjectContext *context = [appDelegate managedObjectContext];
            
            NSManagedObject *newContact;
            newContact = [NSEntityDescription
                          insertNewObjectForEntityForName:@"CustomerRooms"
                          inManagedObjectContext:context];
            
            
            
            ViewController *vc = [ViewController sharedInstance];
            
            
            
            //NSLog(@" customer name %@,%@ ",customerName,self.roomName);
            
            [newContact setValue:customerName forKey:@"customerName"];
            [newContact setValue:self.roomName forKey:@"room"];
            [newContact setValue:self.roomNameKey forKey:@"roomKey"];
            [newContact setValue:vc.selectedRoomName forKey:@"roomName"];
            
            if(self.isRoomApproved) {
                
                NSNumber *num = [[NSNumber alloc] initWithBool:YES];
                //NSNumber *marked = [[NSNumber alloc] initWithBool:YES];
                NSNumber *custReportSent = [[NSNumber alloc] initWithBool:NO];
                NSNumber *employerReportSent = [[NSNumber alloc] initWithBool:NO];
                
                [newContact setValue:num forKey:@"approved"];
                //[newContact setValue:marked forKey:@"marked"];
                [newContact setValue:custReportSent forKey:@"customerReportSent"];
                [newContact setValue:employerReportSent forKey:@"employerReportSent"];
            }
            
            [context save:&error];

        }
    }
    

}

//disapprove the status of the room
-(void) disapprove_room:(id) sender {
    
    
    //NSCalendar *calendar = [NSCalendar currentCalendar];
    //NSDateComponents *components = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:[NSDate date]];
    /*NSInteger hour = [components hour];
    NSInteger minute = [components minute];
    NSInteger sec = [components second];*/
    
    
    ViewController *vc = [ViewController sharedInstance];
    
    
    vc.doneTime = [NSDate date];
    
    doneDateFormatter = [[NSDateFormatter alloc] init];
    doneDateFormatter.dateFormat = @"hh:mm:ss";
    [doneDateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    //NSLog(@"The Current Time is %@",[doneDateFormatter stringFromDate:vc.doneTime]);
    
    //NSLog(@"customer room in dissapprove %@",vc.selectedRoomName);
    
    
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *dataContext = [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchData = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CustomerRooms" inManagedObjectContext:dataContext];
    
    [fetchData setEntity:entity];
    
    
    
    //NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData error:&error];
    
    NSManagedObject *userData = nil;
    
   // NSLog(@"customer name in dissapprove %@",customerName);
    NSPredicate *pred =[NSPredicate predicateWithFormat:@"(customerName =%@) AND (roomName = %@)",customerName,vc.selectedRoomName];
    
    [fetchData setPredicate:pred];
    //NSManagedObject *matches = nil;
    
    NSError *error;
    NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData
                                                       error:&error];
    
    if(fetchObjects) {
        if([fetchObjects count]!=0) {
            
                        for(int i=0;i<[fetchObjects count];i++) {
                userData = [fetchObjects objectAtIndex:i];
                NSNumber *num1 = [userData valueForKeyPath:@"containImages"];
                //NSLog(@"fetch objects %lu,%d,%@,%@",(unsigned long)[fetchObjects count],[num1 boolValue],[userData valueForKey:@"roomName"],[userData valueForKey:@"customerName"]);

                            
                NSNumber *num = NULL;
                NSNumber *marked = NULL;
                
                if(!self.isRoomApproved) {
                    num = [[NSNumber alloc] initWithBool:NO];
                    
                }
                else {
                    
                    num = [[NSNumber alloc] initWithBool:YES];
                }
                    
                
                
                marked = [[NSNumber alloc] initWithBool:YES];
                    
                [userData setValue:num forKey:@"approved"];
                [userData setValue:marked forKey:@"marked"];
                [userData setValue:vc.currentTime forKey:@"startTime"];
                [userData setValue:vc.doneTime forKey:@"endTime"];
                [userData setValue:num1 forKey:@"containImages"];
                    
                
                [dataContext save:&error];
                //NSLog(@"error %@",error.description);
            }
        } else {
            
            
            NSManagedObjectContext *context = [appDelegate managedObjectContext];
            
            NSManagedObject *newContact;
            newContact = [NSEntityDescription
                          insertNewObjectForEntityForName:@"CustomerRooms"
                          inManagedObjectContext:context];
            
            //NSLog(@"entered room %@",vc.selectedRoomName);
            
            ViewController *vc = [ViewController sharedInstance];
            
            NSNumber *marked  = [[NSNumber alloc] initWithBool:YES];
            
            //NSLog(@" customer name %@,%@ ",customerName,self.roomName);
            
            [newContact setValue:customerName forKey:@"customerName"];
            [userData setValue:marked forKey:@"marked"];
            [newContact setValue:self.roomName forKey:@"room"];
            [newContact setValue:self.roomNameKey forKey:@"roomKey"];
            [newContact setValue:vc.selectedRoomName forKey:@"roomName"];
            
            
            NSNumber *num = NULL;
            //NSNumber *marked = NULL;
            
            NSNumber *custReportSent = [[NSNumber alloc] initWithBool:NO];
            NSNumber *employerReportSent = [[NSNumber alloc] initWithBool:NO];
            
            if(!self.isRoomApproved) {
                num = [[NSNumber alloc] initWithBool:NO];
                
            }
            else {
                
                num = [[NSNumber alloc] initWithBool:YES];
            }
            
            
            
            marked = [[NSNumber alloc] initWithBool:YES];
            
            [newContact setValue:num forKey:@"approved"];
            [newContact setValue:marked forKey:@"marked"];
            [newContact setValue:vc.currentTime forKey:@"startTime"];
            [newContact setValue:vc.doneTime forKey:@"endTime"];
            
            [newContact setValue:custReportSent forKey:@"customerReportSent"];
            [newContact setValue:employerReportSent forKey:@"employerReportSent"];
            
            [context save:&error];

        }
        
    }

    

    [self showReport];
}

//comment room to add the photos and add comments to  room
-(void) comment_room:(id) sender {
    
    
    
    //[locationManager stopUpdatingLocation];
    
    //ViewController *vc = [ViewController sharedInstance];
    
    /*id animation = ^{
        
        [self drawMap];
    };*/
    
    id complete = ^{
        
        
        self.commentsRoom = [[CommentsRoom alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) roomName:self.roomName withCustomerCount:count];
        
        self.commentsRoom.customerName = customerName;
        
        [self.view addSubview:self.commentsRoom.view];
        
        self.commentsRoom.view.transform = CGAffineTransformMakeTranslation(320, 0);
        
        [self.commentsRoom getData];
        
        id animation  = ^{
            
            self.commentsRoom.view.transform = CGAffineTransformMakeTranslation(0, 0);
        };
        
        [UIView animateWithDuration:0.5 animations:animation];
        
    };
    
    [UIView animateWithDuration:0.5 animations:nil completion:complete];
}

-(void) showReport {
    
    /*UIView *reportView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [reportView setBackgroundColor:[UIColor whiteColor]];
    
    [reportView.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [reportView.layer setBorderWidth:0.5];
    [reportView.layer setShadowColor:[[UIColor lightGrayColor] CGColor]];
    [reportView.layer setShadowOffset:CGSizeMake(-10, 10)];
    [reportView.layer setShadowRadius:5.0];
    [reportView.layer setShadowOpacity:0.5];
    
    UITextView *reportTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 300)];
    
    [reportTextView setText:@"Title"];
    [reportView addSubview:reportTextView];
    
    reportView.transform = CGAffineTransformMakeTranslation(0, -500);
    
    [self addSubview:reportView];
    
    id animation = ^{
        
            reportView.transform = CGAffineTransformMakeTranslation(0, 0);
        
    };
    
    [UIView animateWithDuration:0.25 animations:animation];

    UIButton *closeButton = [[UIButton alloc] initWithFrame:CGRectMake(50, 350, 200, 50)];
    
    [closeButton setTitle:@"Close" forState:UIControlStateNormal];
    
    [closeButton setTitleColor:color forState:UIControlStateNormal];
    
    [closeButton.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    
    [closeButton.layer setBorderWidth:0.5];
    
    
    
    [closeButton addTarget:self action:@selector(closeView:) forControlEvents:UIControlEventTouchUpInside];
    
    [reportView addSubview:closeButton];
    
    [locationManager stopUpdatingLocation];*/
    
    
    
    //ViewController *vc = [ViewController sharedInstance];
    
    id animation = ^{
      
        [self drawMap];
        
    };
    
    id complete = ^{
        
       
        self.reportsListView = [[ReportsListView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) withCustomerName:customerName withRoom:self.roomName showOtherButtons:YES];
        
        [self.view addSubview:self.reportsListView.view];
        
        self.reportsListView.view.transform = CGAffineTransformMakeTranslation(320, 0);
        
        
        id animation = ^{
            
            self.reportsListView.view.transform = CGAffineTransformMakeTranslation(0, 0);
            
        };
        
        
        [UIView animateWithDuration:0.5 animations:animation];
        
    };
    
    
    //MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
    //[customerMapView setRegion:[customerMapView regionThatFits:region] animated:YES];
    
    
    
    
    [UIView animateWithDuration:0.5 animations:animation completion:complete];
    
    
}

//closes the view
-(void) closeView:(id) sender {
    
    
    [self removeFromParentViewController];
}

#pragma mark--CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    //NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    ViewController *vc = [ViewController sharedInstance];
    
    if (currentLocation != nil) {
        //longitudeLabel.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        //latitudeLabel.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
        //NSLog(@"Entered");
        vc.lat = currentLocation.coordinate.latitude;
        vc.lan = currentLocation.coordinate.longitude;
        
        
        /*NSLog(@"entered data %f,%f",vc.lat,vc.lan);
        
        //MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
        //[customerMapView setRegion:[customerMapView regionThatFits:region] animated:YES];
        
        CLLocationCoordinate2D zoomLocation;
        zoomLocation.latitude = vc.lat;
        zoomLocation.longitude= vc.lan;
        
        
        
        // 2
        MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 1500, 1500);
        
        [customerMapView setRegion:[customerMapView regionThatFits:viewRegion] animated:YES];
        
        MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
        point.coordinate = zoomLocation;
        point.title = @"Where am I?";
        point.subtitle = @"I'm here!!!";
        
        [customerMapView addAnnotation:point];
        
        
        
        MKMapSnapshotOptions *options = [[MKMapSnapshotOptions alloc] init];
        options.region = customerMapView.region;
        options.scale = [UIScreen mainScreen].scale;
        options.size = customerMapView.frame.size;
        
        MKMapSnapshotter *snapshotter = [[MKMapSnapshotter alloc] initWithOptions:options];
        [snapshotter startWithCompletionHandler:^(MKMapSnapshot *snapshot, NSError *error) {
            UIImage *image = snapshot.image;
            [image drawInRect:CGRectMake(50, 50, 200, 200)];
            NSData *data = UIImagePNGRepresentation(image);
            
            NSString *imagePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:[NSString stringWithFormat:@"/%@",@"Optiqo"]];
            
            if([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"custMap"]]]) {
                
                [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"profileImage"]] error:nil];
            }
            
            [[NSFileManager defaultManager] createDirectoryAtPath:imagePath withIntermediateDirectories:YES attributes:nil error:nil];
            
            [data writeToFile:[NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"custMap"]] atomically:YES];
            
            NSLog(@"data %@",data);
        }];
        
        [locationManager stopUpdatingLocation];*/
        
    }
}

//redraws the map
-(void) mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    
    ViewController *vc = [ViewController sharedInstance];
    
    //sNSLog(@"entered data %f,%f",vc.lat,vc.lan);
    
    //MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
    //[customerMapView setRegion:[customerMapView regionThatFits:region] animated:YES];
    
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = vc.lat;
    zoomLocation.longitude= vc.lan;
    
    
    
    // 2
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 1500, 1500);
    
    [customerMapView setRegion:[customerMapView regionThatFits:viewRegion] animated:YES];
    
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = zoomLocation;
    point.title = @"Where am I?";
    point.subtitle = @"I'm here!!!";
    
    [customerMapView addAnnotation:point];
    
    
    
    /*MKMapSnapshotOptions *options = [[MKMapSnapshotOptions alloc] init];
    options.region = customerMapView.region;
    options.scale = [UIScreen mainScreen].scale;
    options.size = customerMapView.frame.size;
    
    MKMapSnapshotter *snapshotter = [[MKMapSnapshotter alloc] initWithOptions:options];
    [snapshotter startWithCompletionHandler:^(MKMapSnapshot *snapshot, NSError *error) {
        UIImage *image = snapshot.image;
        [image drawInRect:CGRectMake(50, 50, 200, 200)];
        NSData *data = UIImagePNGRepresentation(image);
        
        NSString *imagePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:[NSString stringWithFormat:@"/%@/%@",@"Optiqo",customerName]];
        
        if([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"custMap"]]]) {
            
            [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"profileImage"]] error:nil];
        }
        
        [[NSFileManager defaultManager] createDirectoryAtPath:imagePath withIntermediateDirectories:YES attributes:nil error:nil];
        
        [data writeToFile:[NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"custMap"]] atomically:YES];
        
        NSLog(@"data %@",data);
    }];*/

}

-(void) drawMap {
    
    
    
    ViewController *vc = [ViewController sharedInstance];
    
    //NSLog(@"entered data drawMap %f,%f",vc.lat,vc.lan);
    
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = vc.lat;
    zoomLocation.longitude= vc.lan;
    
    
    
    // 2
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 1500, 1500);
    
    [customerMapView setRegion:[customerMapView regionThatFits:viewRegion] animated:YES];
    
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = zoomLocation;
    point.title = @"Where am I?";
    point.subtitle = @"I'm here!!!";
    
    [customerMapView addAnnotation:point];
    
    
    
    /*MKMapSnapshotOptions *options = [[MKMapSnapshotOptions alloc] init];
    options.region = customerMapView.region;
    options.scale = [UIScreen mainScreen].scale;
    options.size = customerMapView.frame.size;
    
    MKMapSnapshotter *snapshotter = [[MKMapSnapshotter alloc] initWithOptions:options];
    [snapshotter startWithQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) completionHandler:^(MKMapSnapshot *snapshot, NSError *error) {
        
         UIImage *image = snapshot.image;
         NSData *data = UIImagePNGRepresentation(image);
        
        // get the image associated with the snapshot
        
        UIImage *image = snapshot.image;
        
        // Get the size of the final image
        
        CGRect finalImageRect = CGRectMake(0, 0, image.size.width, image.size.height);
        
        // Get a standard annotation view pin. Clearly, Apple assumes that we'll only want to draw standard annotation pins!
        
        MKAnnotationView *pin = [[MKPinAnnotationView alloc] initWithAnnotation:nil reuseIdentifier:@""];
        UIImage *pinImage = pin.image;
        
        // ok, let's start to create our final image
        
        UIGraphicsBeginImageContextWithOptions(image.size, YES, image.scale);
        
        // first, draw the image from the snapshotter
        
        [image drawAtPoint:CGPointMake(0, 0)];
        
        // now, let's iterate through the annotations and draw them, too
        
        for (id<MKAnnotation>annotation in customerMapView.annotations)
        {
            CGPoint point = [snapshot pointForCoordinate:annotation.coordinate];
            if (CGRectContainsPoint(finalImageRect, point)) // this is too conservative, but you get the idea
            {
                CGPoint pinCenterOffset = pin.centerOffset;
                point.x -= pin.bounds.size.width / 2.0;
                point.y -= pin.bounds.size.height / 2.0;
                point.x += pinCenterOffset.x;
                point.y += pinCenterOffset.y;
                
                [pinImage drawAtPoint:point];
            }
        }
        
        // grab the final image
        
        UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        NSData *data = UIImagePNGRepresentation(finalImage);
        
        
        NSString *imagePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:[NSString stringWithFormat:@"/%@/%@",@"Optiqo",customerName]];
        
        if([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"custMap"]]]) {
            
            [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"custMap"]] error:nil];
            
            NSLog(@"cutomer data %@",customerName);
        }
        
        [[NSFileManager defaultManager] createDirectoryAtPath:imagePath withIntermediateDirectories:YES attributes:nil error:nil];
        
        NSLog(@" image path %@",imagePath);
        
        [data writeToFile:[NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"custMap"]] atomically:YES];
        
        //NSLog(@"data %@",data);
        
        
    }];*/
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
