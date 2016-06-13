//
//  ReportsListView.m
//  NewOptiqo
//
//  Created by Umapathi on 9/9/14.
//  Copyright (c) 2014 Umapathi. All rights reserved.
//

#import "ReportsListView.h"
#import "ViewController.h"
#import "AppDelegate.h"

@implementation ReportsListView

@synthesize scrollView,reportsList,reportsListView,reportView,sendButton,content,room_content,commentRooms,roomReport,pieChart,reportChart,scoreChart;

/*- (id)initWithFrame:(CGRect)frame
{
    self = [super init];
    if (self) {
        // Initialization code
    }
    return self;
}*/

//view to show overview of the reports this room shows the report stauts weather they are approved or not and a pie chart to show in chart representation of the room status. Table view is used to show the room stauts

-(void) viewDidLoad {
    
    [self.view setNeedsDisplay];
    [self.view setNeedsLayout];
    
    [self.reportsListView setNeedsLayout];
    
    [self.reportsListView setNeedsDisplay];
}

-(void) viewWillAppear:(BOOL)animated {
    
    
    //re draws the pie chart view
    
    [self.view setNeedsDisplay];
    [self.view setNeedsLayout];
    
    if(self.reportsListView)
    {
        
        [self.reportsListView.tableFooterView removeFromSuperview];
        [self.pieChart removeFromSuperview];
        [self calculateRating];
        for (UIView *pieView in [self.reportsListView.tableFooterView subviews]) {
            [pieView removeFromSuperview];
        }
        
        for (UIView *piechartView in [self.pieChart subviews]) {
            [piechartView removeFromSuperview];
        }
        
        self.pieChart = nil;
        
        self.pieChart = [[PieChartView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height*0.7, 300, 300) initWithRate:rating withOptions:1 withApproveCount:approvedCount numReports:(int)(self.reportsList.count) chartStyle:1];
        
        
        self.reportsListView.tableFooterView = nil;
        self.reportsListView.tableFooterView = self.pieChart;

        [self.reportsListView setNeedsLayout];
        
        [self.reportsListView setNeedsDisplay];
        
    }
    
}

//initialize the view with customer name and room name and buttons to send report
-(id) initWithFrame:(CGRect)frame withCustomerName:(NSString *)customer_name withRoom:(NSString *)room_name showOtherButtons:(BOOL) show_buttons
{
    
    self = [super init];
    if (self) {
        // Initialization code
        
        self.view.frame = frame;
        [self.view setBackgroundColor:[UIColor whiteColor]];
        
        
        locationManager = [[CLLocationManager alloc] init];
        
        locationManager.delegate = self;
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        //NSString *deviceVersion  =  [[UIDevice currentDevice] systemVersion];
        
        if(floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_7_1)
            [locationManager requestWhenInUseAuthorization];
        
        [locationManager startUpdatingLocation];
        
        //draws a map taking the gps location
        
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
        
        
        ViewController *vc = [ViewController sharedInstance];
        
        
        //NSLog(@"entered report list view %d,%d",vc.isCustomer,isEmployerReportSend);
        
        /*self.scrollView = [[UIScrollView alloc] initWithFrame:frame];
        
        [self.view addSubview:self.scrollView];
        
        [self.scrollView setUserInteractionEnabled:YES];*/
        

        
        if(vc.cleaningType == 1) {
            
            color = [vc.colorArray objectAtIndex:1];
        }
        
        if(vc.cleaningType == 2) {
            
            color = [vc.colorArray objectAtIndex:0];
        }
        
        color = [UIColor blackColor];
        
        font = [UIFont fontWithName:@"Avenir-Medium" size:16.0];
        
        if([vc.userLanguageSelected isEqualToString:@"Swedish"]) {
            
            labels = [vc.englishLabels valueForKey:@"userswedishlabels"];
        }
        
        if([vc.userLanguageSelected isEqualToString:@"German"]) {
            
            labels = [vc.englishLabels valueForKey:@"usergermanlabels"];
        }
        
        if([vc.userLanguageSelected isEqualToString:@"English"]) {
            
            labels = [vc.englishLabels valueForKey:@"userenglishlabels"];
        }

        
        customerName = customer_name;
        roomName = room_name;
        
        showButtons = show_buttons;
        
        self.commentRooms = [[NSMutableArray alloc] init];
        
        
        
        [self.view setBackgroundColor:[UIColor whiteColor]];
        
        self.reportsList = [[NSMutableArray alloc] init];
        
        emailAttrs = [[NSMutableArray alloc] init];
        
        //gets data from database
        if(show_buttons)
            [self getData];
        
        //gets employer information
        [self getEmployer];
        
        //shows the reports
        [self showReportsListView];
        
        
        //[self.scrollView setContentSize:CGSizeMake(320.0, 700.0)];
        
        //pie chart view and calulating in percentage
        [self calculateRating];
        
        vc.isCustomer = NO;
        isEmployerReportSend = NO;
        
    }
    return self;
}


//initialize the view for old reports
-(id) initWithFrame:(CGRect)frame withCustomerName:(NSString *)customer_name withRoom:(NSString *)room_name showOtherButtons:(BOOL) show_buttons withDate:(NSDate *)date
{
    
    self = [super init];
    if (self) {
        // Initialization code
        
        self.view.frame = frame;
        [self.view setBackgroundColor:[UIColor whiteColor]];
        
        /*self.scrollView = [[UIScrollView alloc] initWithFrame:frame];
        
        [self.view addSubview:self.scrollView];*/
        
        ViewController *vc  = [ViewController sharedInstance];
        
        if(vc.cleaningType == 1) {
            
            color = [vc.colorArray objectAtIndex:1];
        }
        
        if(vc.cleaningType == 2) {
            
            color = [vc.colorArray objectAtIndex:0];
        }
        
        color = [UIColor blackColor];
        
        font = [UIFont fontWithName:@"Avenir-Medium" size:16.0];
        
        if([vc.userLanguageSelected isEqualToString:@"Swedish"]) {
            
            labels = [vc.englishLabels valueForKey:@"userswedishlabels"];
        }
        
        if([vc.userLanguageSelected isEqualToString:@"German"]) {
            
            labels = [vc.englishLabels valueForKey:@"usergermanlabels"];
        }
        
        if([vc.userLanguageSelected isEqualToString:@"English"]) {
            
            labels = [vc.englishLabels valueForKey:@"userenglishlabels"];
        }
        
        
        customerName = customer_name;
        roomName = room_name;
        
        showButtons = show_buttons;
        
        self.commentRooms = [[NSMutableArray alloc] init];
        
        
        
        [self.view setBackgroundColor:[UIColor whiteColor]];
        
        self.reportsList = [[NSMutableArray alloc] init];
        
        emailAttrs = [[NSMutableArray alloc] init];
        
        reportSentDate = date;
        
        vc.reportSentDate = date;
        
        [self getOldReportsData];
        [self getEmployer];
        
        
              
        [self showReportsListView];
        
        
        
        //[self.scrollView setContentSize:CGSizeMake(320.0, 700.0)];
        
        [self calculateRating];
        
        showOldReports = YES;
        
        
    }
    return self;
}


//sets views titles

-(void) setViewTitle {
    
   
    
    ViewController *vc = [ViewController sharedInstance];
    
    //NSLog(@"sub views count %d",(int)[[vc.barView subviews] count]);
    
    //stores the pervious label
    pervCustLabel = ((UILabel *)[[vc.barView subviews] objectAtIndex:2]).text;
    
    //NSLog(@"pervious label %@",pervCustLabel);
    
    for(unsigned long i=[[vc.barView subviews] count]-1;i>=1;i--) {
        
        id viewItem = [[vc.barView subviews] objectAtIndex:i];
        [viewItem removeFromSuperview];
    }
    
    [vc drawRightMenuView];
    
    UILabel *cust_label = [[UILabel alloc] initWithFrame:CGRectMake(85, 25, 150, 32)];
    
    [cust_label setBackgroundColor:[UIColor clearColor]];
    
    [cust_label setText:[labels valueForKey:@"overview"]];
    [cust_label setTextColor:[UIColor whiteColor]];
    [cust_label setTextAlignment:NSTextAlignmentCenter];
    [cust_label setFont:[UIFont fontWithName:@"Avenir-Medium" size:18]];
    [cust_label setTextAlignment:NSTextAlignmentCenter];
    
    [vc.barView addSubview:cust_label];
    
    UIImageView *backImage = (UIImageView *)[[vc.barView subviews] objectAtIndex:0];
    
    backImage.image = [UIImage imageNamed:@"back.png"];
    
    UITapGestureRecognizer *backTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backToRoomCommentsView:)];
    
    [backImage addGestureRecognizer:backTap];

    
}

//back to pervious view
-(void) backToRoomCommentsView:(id) sender {
    
    ViewController *vc = [ViewController sharedInstance];
    
    
    if(showButtons) {
    
        [self checkReportStatus];
        
        if(isCustomerReportSend && !isEmployerReportSend) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:[labels valueForKey:@"report_sent"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            
            [alert show];
            
        }
        else if(isEmployerReportSend && !isCustomerReportSend) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:[labels valueForKey:@"report_sent"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            
            [alert show];
        }
        else if(!isCustomerReportSend && !isEmployerReportSend) {
            
            id animation = ^{
        
                self.view.transform = CGAffineTransformMakeTranslation(vc.deviceWidth, 0);
        
            };
    
            id completion = ^(BOOL finshed) {
                
                //go back to pervious view
                if([pervCustLabel isEqualToString:[labels valueForKey:@"customerrooms"]])
                {
                    [vc.customerList setViewTitle];
                    //vc.customerList.customer_view = NULL;
                }
                else if([pervCustLabel isEqualToString:[labels valueForKey:@"status"]])
                {
                    //NSLog(@"entered status view when sent back %@",pervCustLabel);
                    [vc.customerList.roomListView.roomComments setViewTitle];
                    //vc.customerList.customer_view = NULL;
                }
                else if([pervCustLabel isEqualToString:[labels valueForKey:@"addcomments"]])
                {
                    
                    [vc.customerList.roomListView.roomComments.commentsRoom setViewTitle];
                    //vc.customerList.customer_view = NULL;
                }
                else {
                    
                    
                      [self backToRoomListView:nil];
                }
        
                /*if([reportsList count]!=0) {

                    RoomComments *roomComments = vc.customerList.roomListView.roomComments;
        
                    [roomComments setViewTitle];
        
                    [self removeFromParentViewController];
                }
                else {
                
                    [self backToRoomListView:nil];
                }*/
            
        
            };
    
    
            [UIView animateWithDuration:0.5 animations:animation completion:completion];
        
        }
        else {
            
            [self backToMainView:nil];
        }
    }
    else  {
        
        id animation = ^{
            
            self.view.transform = CGAffineTransformMakeTranslation(vc.deviceWidth, 0);
            
        };
        
        id completion = ^(BOOL finshed) {
            
            
            ViewController *vc = [ViewController sharedInstance];
            
            
            ShowOldReportsView *oldReports = vc.reports;
            
            [oldReports setTitleViewWithLeftMenu];
            
            [self removeFromParentViewController];
            
        };
        
        
        [UIView animateWithDuration:0.5 animations:animation completion:completion];
    }

    
}

//shows the report list and draws icons to send reports and add rooms and pie chart
-(void) showReportsListView {
    
    
    ViewController *vc = [ViewController sharedInstance];
    
    UIImageView  *backImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height)];
    
    backImg.image = [UIImage imageNamed:@"view_background.png"];
    
    [self.view addSubview:backImg];
    
    
    self.reportsListView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height) style:UITableViewStyleGrouped];
    
    [self.reportsListView setDelegate:self];
    [self.reportsListView setDataSource:self];
    
    self.reportsListView.allowsMultipleSelection = NO;
    
    
    [self.reportsListView setBackgroundColor:[UIColor clearColor]];
    
    [self.reportsListView.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.reportsListView.layer setBorderWidth:0.5];
    
    
    [self.view addSubview:self.reportsListView];
    
    //self.reportsListView.sectionFooterHeight = 300;
    
    /*self.reportView = [[UITextView alloc] initWithFrame:CGRectMake(25, self.frame.size.height*0.75, self.frame.size.width-100, 100)];
    
    [self.reportView setEditable:NO];
    
    [self.reportView.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    
    [self.reportView.layer setBorderWidth:0.5];
    
    [self addSubview:reportView];*/
    
    [self calculateRating];
    
    self.pieChart = [[PieChartView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height*0.7, 300, 300) initWithRate:rating withOptions:1 withApproveCount:approvedCount numReports:(int)(self.reportsList.count) chartStyle:1];
    
    self.reportChart = [[PieChartView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height*0.7, 300, 300) initWithRate:rating withOptions:1 withApproveCount:approvedCount numReports:(int)(self.reportsList.count) chartStyle:2];
    
    self.scoreChart = [[PieChartView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height*0.7, 300, 300) initWithRate:rating withOptions:1 withApproveCount:approvedCount numReports:(int)(self.reportsList.count) chartStyle:3];
    
    //[pieChart setNeedsDisplay];
    
    self.reportsListView.tableFooterView = self.pieChart;
    
    //[self.scrollView addSubview:pieChart];
    
    
    
    if(showButtons) {
        
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, vc.deviceWidth, 90)];
        
        [headerView setBackgroundColor:[UIColor clearColor]];
        
        [headerView.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        [headerView.layer setBorderWidth:0.5];
        
        [headerView.layer setShadowColor:[[UIColor blackColor] CGColor]];
        [headerView.layer setShadowOffset:CGSizeMake(-2, 2)];
    
        //self.sendButton = [[UIButton alloc] initWithFrame:CGRectMake(25, 5, 100, 40)];
        
        //[self.sendButton setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.5]];
    
        //[self.sendButton.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        //[self.sendButton.layer setBorderWidth:0.5];
        
        //customer send report view
        UIImage *messageImage = [UIImage imageNamed:@"message.png"];
        
        UIView *sendView = [[UIView alloc] initWithFrame:CGRectMake(0, 2, 100, 85)];
        
        [sendView setUserInteractionEnabled:YES];
        
        UITapGestureRecognizer *customerSendTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sendCustomerReport:)];
        
        [sendView addGestureRecognizer:customerSendTap];
        
        //[sendView.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        //[sendView.layer setBorderWidth:0.5];
        
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(25, 5, 50, 50)];
        
        imgView.image = messageImage;
        
        [imgView setContentMode:UIViewContentModeScaleAspectFit];
        
        [sendView addSubview:imgView];
        
        UILabel *customerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, 100, 20)];
        
        [customerLabel setBackgroundColor:[UIColor clearColor]];
        
        [customerLabel setText:[labels valueForKey:@"sendcustomerreport"]];
        
        [customerLabel setTextColor:color];
        
        [customerLabel setFont:[UIFont fontWithName:@"Avenir-Medium" size:16.0]];
        
        [customerLabel setTextAlignment:NSTextAlignmentCenter];
        
        [sendView addSubview:customerLabel];
        
        
        [headerView addSubview:sendView];

        
        //employer report view
        UIView *employerSendView = [[UIView alloc] initWithFrame:CGRectMake(115, 2, 100, 85)];
        
        [employerSendView setUserInteractionEnabled:YES];
        
        UITapGestureRecognizer *employerSendTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sendEmployerReport:)];
        
        [employerSendView addGestureRecognizer:employerSendTap];
        
        //[sendView.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        //[sendView.layer setBorderWidth:0.5];
        
        
        UIImageView *employerImgView = [[UIImageView alloc] initWithFrame:CGRectMake(25, 5, 50, 50)];
        
        employerImgView.image = messageImage;
        
        [employerImgView setContentMode:UIViewContentModeScaleAspectFit];

        
        [employerSendView addSubview:employerImgView];
        
        UILabel *employerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, 100, 20)];
        
        [employerLabel setBackgroundColor:[UIColor clearColor]];
        
        [employerLabel setText:[labels valueForKey:@"sendemployerreport"]];
        
        [employerLabel setTextColor:color];
        
        [employerLabel setFont:[UIFont fontWithName:@"Avenir-Medium" size:16.0]];
        
        [employerLabel setTextAlignment:NSTextAlignmentCenter];
        
        [employerSendView addSubview:employerLabel];
        
        
        [headerView addSubview:employerSendView];

        //add rooms view
        UIView *roomsAddView = [[UIView alloc] initWithFrame:CGRectMake(225, 2, 75, 85)];
        
        [roomsAddView setUserInteractionEnabled:YES];
        
        
        
        //NSLog(@" entered data1 ");
            
        UITapGestureRecognizer *roomsSendTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backToRoomListView:)];
            
        [roomsAddView addGestureRecognizer:roomsSendTap];
        
        
        //[sendView.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        //[sendView.layer setBorderWidth:0.5];
        
        
        UIImageView *roomsImgView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 5, 50, 50)];
        
        roomsImgView.image = [UIImage imageNamed:@"add.png"];
        
        [roomsImgView setContentMode:UIViewContentModeScaleAspectFit];
        
        
        [roomsAddView addSubview:roomsImgView];
        
        UILabel *roomsLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 60, 100, 20)];
        
        [roomsLabel setBackgroundColor:[UIColor clearColor]];
        
        [roomsLabel setText:[labels valueForKey:@"addnewroom"]];
        
        [roomsLabel setTextColor:color];
        
        [roomsLabel setFont:[UIFont fontWithName:@"Avenir-Medium" size:16.0]];
        
        [roomsLabel setTextAlignment:NSTextAlignmentCenter];
        
        [roomsAddView addSubview:roomsLabel];
        
        
        [headerView addSubview:roomsAddView];
        
    
        //[self.sendButton setTitle:@"Customer" forState:UIControlStateNormal];
        
        //[self.sendButton setImage:messageImage forState:UIControlStateNormal];
    
        //[self.sendButton setTitleColor:color forState:UIControlStateNormal];
        //[self.sendButton.titleLabel setFont:font];
    
        //[self.sendButton addTarget:self action:@selector(sendCustomerReport:) forControlEvents:UIControlEventTouchUpInside];
    
        //[headerView addSubview:self.sendButton];
        
        //self.reportsListView.tableHeaderView  = self.sendButton;
    
        /*UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(150, 5, 100, 40)];
    
        [backButton setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.5]];
        [backButton.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        [backButton.layer setBorderWidth:0.5];
    
        [backButton setTitle:@"Employer" forState:UIControlStateNormal];
    
        [backButton setTitleColor:color forState:UIControlStateNormal];
        [backButton.titleLabel setFont:font];
    
        [backButton addTarget:self action:@selector(sendEmployerReport:) forControlEvents:UIControlEventTouchUpInside];
    
        //[self addSubview:backButton];
        
        [headerView addSubview:backButton];*/
        
        
        
        /*UIImageView *addRoomView = [[UIImageView alloc] initWithFrame:CGRectMake(275, 5, 40, 40)];
        
        addRoomView.image = [UIImage imageNamed:@"add.png"];
        
        [addRoomView setUserInteractionEnabled:YES];
        
        [addRoomView setContentMode:UIViewContentModeScaleAspectFit];
        
        UITapGestureRecognizer *roomTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backToRoomListView:)];
            
            [addRoomView addGestureRecognizer:roomTap];*/
        
        
        
        
        //[headerView addSubview:addRoomView];
        
        
        self.reportsListView.tableHeaderView  = headerView;
        
        
    }
    else
    {
        //NSLog(@"entered data no buttons shown");
        [self checkReportStatus];
        
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, vc.deviceWidth, 90)];
        
        [headerView setBackgroundColor:[UIColor clearColor]];
        
        [headerView.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        [headerView.layer setBorderWidth:0.5];
        
        [headerView.layer setShadowColor:[[UIColor blackColor] CGColor]];
        [headerView.layer setShadowOffset:CGSizeMake(-2, 2)];
        
        //self.sendButton = [[UIButton alloc] initWithFrame:CGRectMake(25, 5, 100, 40)];
        
        //[self.sendButton setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.5]];
        
        //[self.sendButton.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        //[self.sendButton.layer setBorderWidth:0.5];
        
        //customer send report view
        UIImage *messageImage = [UIImage imageNamed:@"message.png"];
        
        UIView *sendView = [[UIView alloc] initWithFrame:CGRectMake(0, 2, 100, 85)];
        
        [sendView setUserInteractionEnabled:YES];
        

        
        if(!isCustomerReportSend)
        {
            UITapGestureRecognizer *customerSendTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sendCustomerReport:)];
        
            [sendView addGestureRecognizer:customerSendTap];
        
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(25, 5, 50, 50)];
        
            imgView.image = messageImage;
        
            [imgView setContentMode:UIViewContentModeScaleAspectFit];
        
            [sendView addSubview:imgView];
        
            UILabel *customerLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 60, 100, 20)];
        
            [customerLabel setBackgroundColor:[UIColor clearColor]];
        
            [customerLabel setText:[labels valueForKey:@"sendcustomerreport"]];
        
            [customerLabel setTextColor:color];
        
            [customerLabel setFont:[UIFont fontWithName:@"Avenir-Medium" size:16.0]];
        
            [sendView addSubview:customerLabel];
            
            [headerView addSubview:sendView];
            self.reportsListView.tableHeaderView  = headerView;
        
        }
        
        if(!isEmployerReportSend)
        {
            UITapGestureRecognizer *customerSendTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sendEmployerReport:)];
            
            [sendView addGestureRecognizer:customerSendTap];
            
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(25, 5, 50, 50)];
            
            imgView.image = messageImage;
            
            [imgView setContentMode:UIViewContentModeScaleAspectFit];
            
            [sendView addSubview:imgView];
            
            UILabel *customerLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 60, 100, 20)];
            
            [customerLabel setBackgroundColor:[UIColor clearColor]];
            
            [customerLabel setText:[labels valueForKey:@"sendemployerreport"]];
            
            [customerLabel setTextColor:color];
            
            [customerLabel setFont:[UIFont fontWithName:@"Avenir-Medium" size:16.0]];
            
            [sendView addSubview:customerLabel];
            
            [headerView addSubview:sendView];
            self.reportsListView.tableHeaderView  = headerView;
        }
        

    }
    
    /*UIImageView *homeImage = [[UIImageView alloc] initWithFrame:CGRectMake(vc.deviceWidth-32, 15, 32, 32)];
    
    homeImage.image = [UIImage imageNamed:@"home.png"];
    
    [homeImage setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *homeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backToMainView:)];
    
    [homeImage addGestureRecognizer:homeTap];
    
    [vc.barView addSubview:homeImage];
    
    UIImageView *messageImage = [[UIImageView alloc] initWithFrame:CGRectMake(vc.deviceWidth-65, 15, 32, 32)];
    
    messageImage.image = [UIImage imageNamed:@"message.png"];
    
    [messageImage setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *messageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sendCustomerReport:)];
    
    [messageImage addGestureRecognizer:messageTap];
    
    [vc.barView addSubview:messageImage];
    
    
    UIImageView *employerMessageImage = [[UIImageView alloc] initWithFrame:CGRectMake(vc.deviceWidth-100, 15, 32, 32)];
    
    employerMessageImage.image = [UIImage imageNamed:@"message.png"];
    
    [employerMessageImage setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *employermessageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sendEmployerReport:)];
    
    [employerMessageImage addGestureRecognizer:employermessageTap];
    
    [vc.barView addSubview:employerMessageImage];*/
    
    

    
    /*UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 20, 200, 32)];
    
    [label setBackgroundColor:[UIColor whiteColor]];
    
    [label setText:@"Reports"];
    [label setTextColor:[UIColor colorWithRed:0.0 green:191.0/255.0 blue:1.0 alpha:1.0]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:[UIFont fontWithName:@"Helvetica" size:24]];
    
    [vc.barView addSubview:label];*/
    
    [self setViewTitle];
    


    
}



#pragma mark--back to room list view 

-(void) backToRoomListView:(id) sender {
    
    
    ViewController *vc = [ViewController sharedInstance];
    
    
    if(showButtons) {
        
        //NSLog(@" customer %d,%d ",vc.isCustomer,isEmployerReportSend);
        
        if(vc.isCustomer || isEmployerReportSend) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:[labels valueForKey:@"newinspection"] delegate:self cancelButtonTitle:[labels valueForKey:@"no"] otherButtonTitles:[labels valueForKey:@"yes"], nil];
        
            [alert show];
        }
            //[self backToMainView:nil];
        
        /*if(isCustomerReportSend || isEmployerReportSend)
            [self backToMainView:nil];
        
        if(isCustomerReportSend && !isEmployerReportSend) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:[labels valueForKey:@"employerMailNotSent"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            
            [alert show];
            
        }
        else if(isEmployerReportSend && !isCustomerReportSend) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:[labels valueForKey:@"customerMailNotSent"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            
            [alert show];
        }
        else if(isCustomerReportSend && isEmployerReportSend) {
            
            [self backToMainView:nil];
            
        }*/
        else {
            
            [self back_addRoom];
            
            /*UIViewController *commentView = vc.customerList.roomListView.roomComments;
        
            id animation = ^{
                
                [commentView.view removeFromSuperview];
      
                self.view.transform = CGAffineTransformMakeTranslation(vc.deviceWidth, 0);



            };
    
            id complete = ^(BOOL finished) {
            

            
                //RoomsListView *roomList = (RoomsListView *) [commentView superview];
      

                [commentView removeFromParentViewController];
                
                [self removeFromParentViewController];
        
                vc.customerList.roomListView.roomComments = NULL;
                [vc.customerList.roomListView setViewTitle];
        
            };
    
            [UIView animateWithDuration:0.5 animations:animation completion:complete];*/
        }
        
    } else {
        

        
        id animation = ^{
            
            self.view.transform = CGAffineTransformMakeTranslation(vc.deviceWidth, 0);
        };
        
        id complete = ^(BOOL finished) {
            
            ViewController *vc = [ViewController sharedInstance];
            
            vc.reports = (ShowOldReportsView *) [self.view superview];
            
            [self removeFromParentViewController];
            
            [vc.reports setTitleViewWithLeftMenu];
            
        };
        
        [UIView animateWithDuration:0.5 animations:animation completion:complete];

        
    }
    
    
    
    
}

#pragma mark-- alertview delegate

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if([title isEqualToString:[labels valueForKey:@"yes"]])
    {
        [self back_addRoom];
    }
}

-(void) back_addRoom {
    
    ViewController *vc = [ViewController sharedInstance];
    
    UIViewController *commentView = vc.customerList.roomListView.roomComments;
    
    id animation = ^{
        
        [commentView.view removeFromSuperview];
        
        self.view.transform = CGAffineTransformMakeTranslation(vc.deviceWidth, 0);
        
        
        
    };
    
    id complete = ^(BOOL finished) {
        
        
        
        //RoomsListView *roomList = (RoomsListView *) [commentView superview];
        
        
        [commentView removeFromParentViewController];
        
        [self removeFromParentViewController];
        
        vc.customerList.roomListView.roomComments = NULL;
        [vc.customerList.roomListView setViewTitle];
        
    };
    
    [UIView animateWithDuration:0.5 animations:animation completion:complete];
}

#pragma mark-- back to main view

-(void) backToMainView:(id) sender {
    
    ViewController *vc = [ViewController sharedInstance];
    
    for(unsigned long i=[[vc.startView subviews] count]-1;i>=4;i--) {
        
        id viewItem = [[vc.startView subviews] objectAtIndex:i];
        [viewItem removeFromSuperview];
    }
    
    for(unsigned long i=[[vc.barView subviews] count]-1;i>=1;i--) {
        
        id viewItem = [[vc.barView subviews] objectAtIndex:i];
        [viewItem removeFromSuperview];
    }
    
    //[self resetReportsStatus];
    
    [vc drawRightMenuView];
    [vc resetMenuView];
    [vc setViewTitle];
    vc.customerList = nil;
    
}

#pragma mark--send customer report
-(void) sendCustomerReport:(id) sender {
    
    if([reportsList count]==0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[labels valueForKey:@"message"] message:[labels valueForKey:@"addReports"] delegate:nil cancelButtonTitle:[labels valueForKey:@"ok"] otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        ViewController *vc = [ViewController sharedInstance];
    
        vc.customerEndTime = [NSDate date];
    
        [self updateCustomerTotalTime];
    
        vc.activityView = [[UIView alloc] initWithFrame:CGRectMake(vc.deviceWidth/2-82, vc.deviceHeight/2-25, 150, 50)];
    
        [vc.activityView setBackgroundColor:[UIColor whiteColor]];
    
        [self.view addSubview:vc.activityView];
    
        UILabel *activityLable = [[UILabel alloc] initWithFrame:CGRectMake(25, 0, 150, 25)];
    
        [activityLable setBackgroundColor:[UIColor clearColor]];
    
        [activityLable setText:[labels valueForKey:@"reportProcess"]];
    
        [activityLable setFont:font];
    
        [vc.activityView addSubview:activityLable];
    
        UIActivityIndicatorView *reportActivity = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(65, 25, 25, 25)];
    
        //[reportActivity setBackgroundColor:[UIColor clearColor]];
    
        reportActivity.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    
        [vc.activityView addSubview:reportActivity];
    
    
        [reportActivity startAnimating];
    
        CreatePdfReport *createPdfReport = [[CreatePdfReport alloc] init];
    
        createPdfReport.customerName = customerName;
        createPdfReport.reports = self.reportsList;
    
        [self.pieChart drawReportImage];
    
        [self.reportChart drawReportImage];
    
        [self.scoreChart drawReportImage];
    
        NSArray *images = [NSArray arrayWithObjects:self.reportChart.reportImage,self.scoreChart.scoreImage, nil];
    
        [createPdfReport setReportImage:images];
    
        [createPdfReport generatePDF];
    

    
        //NSLog(@"email attrs count %d",[emailAttrs count]);
    
        if([emailAttrs count]==3)
            [emailAttrs removeObjectAtIndex:1];
    
        if([emailAttrs count]==2) {
            [emailAttrs removeObjectAtIndex:0];
            [emailAttrs insertObject:customerEmail atIndex:0];
            [emailAttrs insertObject:customerName atIndex:2];
        }
    
        //NSLog(@"email attrs count %d",[emailAttrs count]);
    
        vc.isCustomer = YES;
    
        NSArray *filenames = [NSArray arrayWithObjects:createPdfReport.filename,createPdfReport.pdfFilename, nil];
    
    
    
        //[self checkReportStatus];
    
        //if(!isCustomerReportSend)
            [vc sendEmail:filenames withPercent:percentRate withMailAttrs:emailAttrs];
        /*else {
        
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mail Message" message:[labels valueForKey:@"mailSent"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    
         [alert show];
         }*/

    
        if(!showButtons)
        {
            self.reportsListView.tableHeaderView = nil;
            [self.reportsListView.tableHeaderView setHidden:YES];
        }
    
        [self.view setNeedsDisplay];
        [self.view setNeedsLayout];
        
        [self.reportsListView setNeedsLayout];
        
        [self.reportsListView setNeedsDisplay];
    }
    
}

#pragma mark--send employer report
-(void) sendEmployerReport:(id) sender {
    
    
    if([reportsList count]==0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[labels valueForKey:@"message"] message:[labels valueForKey:@"addReports"] delegate:nil cancelButtonTitle:[labels valueForKey:@"ok"] otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        ViewController *vc = [ViewController sharedInstance];
    
        vc.customerEndTime = [NSDate date];
    
        [self updateCustomerTotalTime];
    
        vc.activityView = [[UIView alloc] initWithFrame:CGRectMake(vc.deviceWidth/2-82, vc.deviceHeight/2-25, 150, 50)];
    
        [vc.activityView setBackgroundColor:[UIColor whiteColor]];
    
        [self.view addSubview:vc.activityView];
    
        UILabel *activityLable = [[UILabel alloc] initWithFrame:CGRectMake(25, 0, 150, 25)];
    
        [activityLable setBackgroundColor:[UIColor clearColor]];
    
        [activityLable setText:[labels valueForKey:@"reportProcess"]];
    
        [activityLable setFont:font];
    
        [vc.activityView addSubview:activityLable];
    
        UIActivityIndicatorView *reportActivity = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(65, 25, 25, 25)];
    
        //[reportActivity setBackgroundColor:[UIColor clearColor]];
    
        reportActivity.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    
        [vc.activityView addSubview:reportActivity];
    
    
        [reportActivity startAnimating];

    
        [locationManager stopUpdatingLocation];
    
        [self drawMap];
    
        [self performSelector:@selector(sendEmployerReportAfterSaveMap) withObject:nil afterDelay:2.0];
    }
    
    
}

#pragma mark --sends employer report after a delay

-(void) sendEmployerReportAfterSaveMap {
    
    CreatePdfReport *createPdfReport = [[CreatePdfReport alloc] init];
    
    createPdfReport.customerName = customerName;
    createPdfReport.reports = self.reportsList;
    
    [self.pieChart drawReportImage];
    
    [self.reportChart drawReportImage];
    
    [self.scoreChart drawReportImage];
    
    NSArray *images = [NSArray arrayWithObjects:self.reportChart.reportImage,self.scoreChart.scoreImage, nil];
    
    [createPdfReport setReportImage:images];
    
    [createPdfReport generateEmployerPDF];
    
    ViewController *vc = [ViewController sharedInstance];
    
    
    
    if([emailAttrs count]==3)
        [emailAttrs removeObjectAtIndex:0];
    
    if([emailAttrs count]==2) {
        [emailAttrs removeObjectAtIndex:0];
        [emailAttrs insertObject:employeeEmail atIndex:0];
        [emailAttrs insertObject:customerName atIndex:2];
    }
    
    vc.isCustomer = NO;
    
    isEmployerReportSend = YES;
    
    //[self checkReportStatus];
    
    NSArray *filenames = [NSArray arrayWithObjects:createPdfReport.filename,createPdfReport.pdfFilename, nil];
    
    
    //if(!isEmployerReportSend)
    [vc sendEmail:filenames withPercent:percentRate withMailAttrs:emailAttrs];
    /*else {
     
     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mail Message" message:[labels valueForKey:@"mailSent"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
     
     [alert show];
     }*/
    
    if(!showButtons)
    {
        self.reportsListView.tableHeaderView = nil;
        [self.reportsListView.tableHeaderView setHidden:YES];
    }
    
    [self.view setNeedsDisplay];
    [self.view setNeedsLayout];
    
    [self.reportsListView setNeedsLayout];
    
    [self.reportsListView setNeedsDisplay];
}



#pragma mark--CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    //NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    //NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    
    if (currentLocation != nil) {
        //longitudeLabel.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        //latitudeLabel.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
        //NSLog(@"Entered");
        lat = currentLocation.coordinate.latitude;
        lang = currentLocation.coordinate.longitude;
        
        
        
        
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

//reloads the map and stored as image
-(void) mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    
    
    
    //NSLog(@"entered data %f,%f",lat,lang);
    
    //MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
    //[customerMapView setRegion:[customerMapView regionThatFits:region] animated:YES];
    
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = lat;
    zoomLocation.longitude= lang;
    
    
    
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
     
     NSString *imagePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:[NSString stringWithFormat:@"/%@/%@",@"Optiqo",customerName]];
     
     if([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"currentLocMap"]]]) {
     
     [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"currentLocMap"]] error:nil];
     }
     
     [[NSFileManager defaultManager] createDirectoryAtPath:imagePath withIntermediateDirectories:YES attributes:nil error:nil];
     
     [data writeToFile:[NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"currentLocMap"]] atomically:YES];
     
     //NSLog(@"data %@",data);
     }];
    
}

//draw map
-(void) drawMap {
    
    
    
    
    
    //NSLog(@"entered data drawMap %f,%f",lat,lang);
    
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = lat;
    zoomLocation.longitude= lang;
    
    
    
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
     [snapshotter startWithQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) completionHandler:^(MKMapSnapshot *snapshot, NSError *error) {
     
         NSLog(@" error %@",error.description);
         
     UIImage *image = snapshot.image;
     NSData *data = UIImagePNGRepresentation(image);
     
     // get the image associated with the snapshot
     
     image = snapshot.image;
     
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
     
     data = UIImagePNGRepresentation(finalImage);
     
     
     NSString *imagePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:[NSString stringWithFormat:@"/%@/%@",@"Optiqo",customerName]];
     
     if([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"currentMapLoc"]]]) {
     
     [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"currentMapLoc"]] error:nil];
     
     //NSLog(@"cutomer data %@",customerName);
     }
     
     [[NSFileManager defaultManager] createDirectoryAtPath:imagePath withIntermediateDirectories:YES attributes:nil error:nil];
     
     //NSLog(@" image path %@",imagePath);
     
     [data writeToFile:[NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"currentMapLoc"]] atomically:YES];
     
     //NSLog(@"data %@",data);
     
     
     }];
}


//gets the data from database
-(void) getData {
    
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *dataContext = [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchData = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CustomerRooms" inManagedObjectContext:dataContext];
    
    [fetchData setEntity:entity];
    
    
    //NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData error:&error];
    
    NSManagedObject *userData = nil;
    
    //NSLog(@"customer name in roooms list get data %@",customerName);
    NSPredicate *pred =[NSPredicate predicateWithFormat:@"(customerName =%@)",customerName];
    
    [fetchData setPredicate:pred];
    //NSManagedObject *matches = nil;
    
    NSError *error;
    NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData
                                                       error:&error];
    
    if(fetchObjects) {
        if([fetchObjects count]!=0) {
            for(int i=0;i<[fetchObjects count];i++) {
                userData = [fetchObjects objectAtIndex:i];
                NSNumber *num = [userData valueForKey:@"marked"];
                NSNumber *custReportSent = [userData valueForKey:@"customerReportSent"];
                NSNumber *empReportsent = [userData valueForKey:@"employerReportSent"];
                
               // NSLog(@"report value %d,%d,%@,%d",[custReportSent boolValue],[empReportsent boolValue],[userData valueForKey:@"room"],[num boolValue]);
                
                if([num boolValue] && (![custReportSent boolValue] &&![empReportsent boolValue])) {
                    self.content = [[RoomListContent alloc] init];
                    
                    NSString *cust_name = [userData valueForKey:@"customerName"];
                    
                    NSString *cust_room = [userData valueForKey:@"room"];
                    
                    NSString *cust_roomKey = [userData valueForKey:@"roomKey"];
                    
                    NSString *cust_roomName = [userData valueForKey:@"roomName"];
                    
                   // NSLog(@"cust name %@,%@",cust_roomName,cust_room);
                    
                    NSNumber *approve = [userData valueForKey:@"approved"];
                    
                    NSString *description = [userData valueForKey:@"room_description"];
                    
                    NSNumber *imagesPresent = [userData valueForKey:@"containImages"];
                    
                    NSDate *startDate = [userData valueForKey:@"startTime"];
                    
                    NSDate *endDate = [userData valueForKey:@"endTime"];
                    
                    UIImage *approveImage = NULL;
                    
                    NSString *roomComments = NULL;
                    
                    if([approve boolValue]) {
                        
                        approveImage = [UIImage imageNamed:@"approve.png"];
                        approvedCount++;
                    }
                    else {
                        
                        approveImage = [UIImage imageNamed:@"close_icon.png"];
                    }
                    
                    
                    NSString *descp = [userData valueForKey:@"room_description"];
                    
                    UIImage *descpImage = NULL;
                    
                    if([descp length]!=0) {
                        
                        descpImage = [UIImage imageNamed:@"EditView.png"];
                        roomComments = description;
                    }
                    else {
                        
                        //descpImage = [UIImage imageNamed:@"EditView.png"];
                        //roomComments = [labels valueForKey:@"nocomments"];
                        roomComments = @"-";
                    }
                    
                    UIImage *images = NULL;
                    
                    //NSLog(@"images present %d",[imagesPresent boolValue]);
                    
                    if([imagesPresent boolValue]) {
                        
                        images = [UIImage imageNamed:@"camera.png"];
                    }
                    
                    
                    [content initWithData:cust_name withRoom:cust_room withApproved:approveImage withDescription:descpImage withApproveRoom:approve withDescription:description withRoomKey:cust_roomKey];
                    [content set_images:images];
                    [content set_startTime:startDate];
                    [content set_endTime:endDate];
                    [content setRoomComments:roomComments];
                    [content setCustomer_RoomName:cust_roomName];
                    content.roomContainsImages = imagesPresent;
                    content.customerRoomNameKey = cust_roomKey;
                    [self.reportsList addObject:content];
                    
                }
            }
        }
    }
    
    
    dataContext = [appDelegate managedObjectContext];
    
    fetchData = [[NSFetchRequest alloc] init];
    
    entity = [NSEntityDescription entityForName:@"Customer" inManagedObjectContext:dataContext];
    
    [fetchData setEntity:entity];
    
    
    //NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData error:&error];
    
    userData = nil;
    
    //NSLog(@"customer name %@",customerName);
    pred =[NSPredicate predicateWithFormat:@"(name =%@)",customerName];
    
    [fetchData setPredicate:pred];
    //NSManagedObject *matches = nil;
    
    
    fetchObjects = [dataContext executeFetchRequest:fetchData
                                                       error:&error];
    
    if(fetchObjects) {
        if([fetchObjects count]!=0) {
            for(int i=0;i<[fetchObjects count];i++) {
                userData = [fetchObjects objectAtIndex:i];
                customerEmail = [userData valueForKey:@"email"];
                [emailAttrs addObject:customerEmail];
            }
        }
    }
    
    //NSLog(@"approved count in data %d",approvedCount);
    
}

//shows old reports data
-(void) getOldReportsData {
    
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *dataContext = [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchData = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CustomerRooms" inManagedObjectContext:dataContext];
    
    [fetchData setEntity:entity];
    
    
    //NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData error:&error];
    
    NSManagedObject *userData = nil;
    
    //NSLog(@"customer name in roooms list get data %@",customerName);
    NSPredicate *pred =[NSPredicate predicateWithFormat:@"(customerName =%@)",customerName];
    
    [fetchData setPredicate:pred];
    //NSManagedObject *matches = nil;
    
    NSError *error;
    NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData
                                                       error:&error];
    
    if(fetchObjects) {
        if([fetchObjects count]!=0) {
            for(int i=0;i<[fetchObjects count];i++) {
                userData = [fetchObjects objectAtIndex:i];
                NSNumber *num = [userData valueForKey:@"marked"];
                
                NSDate *date = [userData valueForKey:@"reportSentTime"];
                
                NSString *dateString = [NSDateFormatter localizedStringFromDate:date
                                                                      dateStyle:NSDateFormatterShortStyle
                                                                      timeStyle:NSDateFormatterFullStyle];
                
                NSString *reportDateString = [NSDateFormatter localizedStringFromDate:reportSentDate
                                                                      dateStyle:NSDateFormatterShortStyle
                                                                      timeStyle:NSDateFormatterFullStyle];

                
                
                if([num boolValue] && [dateString isEqualToString:reportDateString]) {
                    
                    self.content = [[RoomListContent alloc] init];
                    
                    NSString *cust_name = [userData valueForKey:@"customerName"];
                    
                    NSString *cust_room = [userData valueForKey:@"room"];
                    
                    NSString *cust_roomKey = [userData valueForKey:@"roomKey"];
                    
                    NSString *cust_roomName = [userData valueForKey:@"roomName"];
                    
                    //NSLog(@"cust name %@",cust_roomName);
                    
                    NSNumber *approve = [userData valueForKey:@"approved"];
                    
                    NSString *description = [userData valueForKey:@"room_description"];
                    
                    NSNumber *imagesPresent = [userData valueForKey:@"containImages"];
                    
                    NSDate *startDate = [userData valueForKey:@"startTime"];
                    
                    NSDate *endDate = [userData valueForKey:@"endTime"];
                    
                    UIImage *approveImage = NULL;
                    
                    NSString *roomComments = NULL;
                    
                    if([approve boolValue]) {
                        
                        approveImage = [UIImage imageNamed:@"approve.png"];
                        approvedCount++;
                    }
                    else {
                        
                        approveImage = [UIImage imageNamed:@"close_icon.png"];
                    }
                    
                    
                    NSString *descp = [userData valueForKey:@"room_description"];
                    
                    UIImage *descpImage = NULL;
                    
                    if([descp length]!=0) {
                        
                        descpImage = [UIImage imageNamed:@"EditView.png"];
                        roomComments = description;
                    }
                    else {
                        
                        //descpImage = [UIImage imageNamed:@"EditView.png"];
                        roomComments = @"-";
                    }
                    
                    UIImage *images = NULL;
                    
                    //NSLog(@"images present %d",[imagesPresent boolValue]);
                    
                    if([imagesPresent boolValue]) {
                        
                        images = [UIImage imageNamed:@"camera.png"];
                    }
                    
                    
                    [content initWithData:cust_name withRoom:cust_room withApproved:approveImage withDescription:descpImage withApproveRoom:approve withDescription:description withRoomKey:cust_roomKey];
                    [content set_images:images];
                    [content set_startTime:startDate];
                    [content set_endTime:endDate];
                    [content setRoomComments:roomComments];
                    [content setCustomer_RoomName:cust_roomName];
                    content.roomContainsImages = imagesPresent;
                    [self.reportsList addObject:content];
                    
                }
            }
        }
    }
    
    
    dataContext = [appDelegate managedObjectContext];
    
    fetchData = [[NSFetchRequest alloc] init];
    
    entity = [NSEntityDescription entityForName:@"Customer" inManagedObjectContext:dataContext];
    
    [fetchData setEntity:entity];
    
    
    //NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData error:&error];
    
    userData = nil;
    
    //NSLog(@"customer name %@",customerName);
    pred =[NSPredicate predicateWithFormat:@"(name =%@)",customerName];
    
    [fetchData setPredicate:pred];
    //NSManagedObject *matches = nil;
    
    
    fetchObjects = [dataContext executeFetchRequest:fetchData
                                              error:&error];
    
    if(fetchObjects) {
        if([fetchObjects count]!=0) {
            for(int i=0;i<[fetchObjects count];i++) {
                userData = [fetchObjects objectAtIndex:i];
                customerEmail = [userData valueForKey:@"email"];
                [emailAttrs addObject:customerEmail];
            }
        }
    }
    

    
    //NSLog(@"approved count in data %d",approvedCount);
    
}


#pragma mark--employer information

-(void) getEmployer {
    
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *dataContext = [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchData = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Employee" inManagedObjectContext:dataContext];
    
    [fetchData setEntity:entity];
    
    NSError *error;
    
    NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData error:&error];
    
    NSManagedObject *userData = nil;
    
    if(fetchObjects) {
        
        for(int i=0;i<[fetchObjects count];i++) {
            
            userData = [fetchObjects objectAtIndex:i];
            
            employeeEmail = [userData valueForKey:@"email"];
            emailSubject = [userData valueForKey:@"emailSubject"];
            
            [emailAttrs addObject:employeeEmail];
            [emailAttrs addObject:emailSubject];
            
        }
    }
    
}

#pragma mark--calculates the room done rating

-(void) calculateRating {
    
    NSString *reportText = @"Number of rooms inspected";
    
    int numRums = (int)[self.reportsList count];
    
    reportText = [NSString stringWithFormat:@"%@:%d",reportText,numRums];
    

    int approveCount = 0;
    
    for(int i=0;i<[self.reportsList count];i++) {
        
        NSNumber *num = ((RoomListContent *)[self.reportsList objectAtIndex:i]).approveRoom;
        
        if([num boolValue]) {
            
            approveCount++;
        }
    }
    
    rating = approveCount*1.0/numRums*1.0;
    
    percentRate = rating*100;
    
    reportText = [NSString stringWithFormat:@"%@\n%@%d%%",reportText,@"rating:",percentRate];
    

    [self.reportView setText:reportText];
    

    
    
    
}

//send email to customer and employer
-(void) sendEmail:(id) sender {
    
    CreatePdfReport *createPdfReport = [[CreatePdfReport alloc] init];
    
    createPdfReport.reports = self.reportsList;
    
    [createPdfReport generatePDF];
    
    ViewController *vc = [ViewController sharedInstance];
    
    if([emailAttrs count]==3)
        [emailAttrs removeObjectAtIndex:1];
    
    if([emailAttrs count]==2) {
        [emailAttrs removeObjectAtIndex:0];
        [emailAttrs insertObject:customerEmail atIndex:0];
    }
    
    NSArray *filenames = [NSArray arrayWithObjects:createPdfReport.filename,createPdfReport.pdfFilename,nil];
    
    //NSLog(@"file name %@",createPdfReport.filename);
    
    [vc sendEmail:filenames withPercent:percentRate withMailAttrs:emailAttrs];
    
}

//back to pervious view

-(void) backView:(id) sender {
    
    
    ViewController *vc = [ViewController sharedInstance];
    
    
    for(unsigned long i=[[vc.barView subviews] count]-1;i>=2;i--) {
        
        id viewItem = [[vc.barView subviews] objectAtIndex:i];
        [viewItem removeFromSuperview];
    }

    
    RoomComments *roomComment = (RoomComments *) [self.view superview];
    RoomsListView *roomListView = (RoomsListView*)[roomComment.view superview];
    
    [self removeFromParentViewController];
    [roomComment removeFromParentViewController];
    [roomListView addBackView];
    
    
}

#pragma mark--tableview delegate functions

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
   
    return [self.reportsList count];
   
    
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //ViewController *vc = [ViewController sharedInstance];
    
    //NSLog(@" clean type  %d",vc.cleaningType);
    
    
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView  dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithFrame:CGRectZero];
    }
    
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    
    NSString *text = NULL;
    
    self.room_content = [self.reportsList objectAtIndex:indexPath.row];
    
    text = self.room_content.customerRoom;
    
    UIImageView *approveView = self.room_content.roomApproved;
    
    approveView.frame = CGRectMake(200, 5, 32, 32);
    
    UIImageView *descpView = self.room_content.roomDescription;
    
    descpView.frame = CGRectMake(240, 7, 32, 32);
    
    UIImageView *images = self.room_content.images;
    
    images.frame = CGRectMake(280, 5, 32, 32);

    
    NSString *customer_text = [NSString stringWithFormat:@"%ld. %@",(long)(indexPath.row+1),text];
    
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell.textLabel setText:customer_text];
    [cell.textLabel setTextColor:color];
    [cell.textLabel setFont:font];
    
    [cell addSubview:approveView];
    [cell addSubview:descpView];
    [cell addSubview:images];
    
    
    return cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int cellHeight = 50;
    
    tableView.rowHeight = cellHeight;
    return cellHeight;
   
    
    
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
        //self.searchedString = [self.filterList objectAtIndex:indexPath.row];
    
    /*ViewController *vc = [ViewController sharedInstance];
    
    NSString *str = NULL;
    
    NSNumber *num = NULL;
    
    if(tableView == searchDisplayController.searchResultsTableView) {
        
        str = [self.customersList objectAtIndex:indexPath.row];
        
    }
    else {
        
        str = [initialCustomersList objectAtIndex:indexPath.row];
        
        
    }
    
    num = [self.customersType objectAtIndex:indexPath.row];
    
    
    vc.cleaningType = [num intValue];
    
    self.showCustomerView = [[CustomerView alloc] initWithCustomerName:str withFrame:CGRectMake(0, 0,
     vc.deviceWidth, vc.deviceHeight)];
     
     self.showCustomerView.transform = CGAffineTransformMakeTranslation(0, -500);
     
     [self addSubview:showCustomerView];
     
     
     id animation = ^{
     
     self.showCustomerView.transform = CGAffineTransformMakeTranslation(0, 0);
     
     
     };
     
     
     [UIView animateWithDuration:0.25 animations:animation];
    
    self.roomListView = [[RoomsListView alloc] initWithFrame:CGRectMake(0, 0,vc.deviceWidth, vc.deviceHeight) withString:str];
    [self addSubview:self.roomListView];
    
    [tableView reloadData];*/
    
    if(showButtons) {
    
        //ViewController *vc = [ViewController sharedInstance];
        

    
       [self.scrollView setContentSize:CGSizeMake(320, 500)];
    
       roomList = [self.reportsList objectAtIndex:indexPath.row];
    
        self.roomReport = [[Reportview alloc] initWithFrame:self.view.frame withRoomComment:roomList withIndex:(int)(indexPath.row+1)];
    
        self.roomReport.view.transform = CGAffineTransformMakeTranslation(320, 0);
        
        [self.view addSubview:self.roomReport.view];
        
        id aimation = ^{
          
           self.roomReport.view.transform = CGAffineTransformMakeTranslation(0, 0);
            
        };
        
        [UIView animateWithDuration:0.5 animations:aimation];
    
        [tableView reloadData];
    }
}

-(BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    

    //[self checkReportStatus];
    if(showButtons && (!showOldReports))  {
        //isEmployerReportSend = NO;
        return YES;
    } else {
        //isEmployerReportSend = NO;
        return NO;
    }
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //NSLog(@"show buttons %d",showButtons);
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        AppDelegate *appDelegate =
        [[UIApplication sharedApplication] delegate];
        
        NSManagedObjectContext *dataContext = [appDelegate managedObjectContext];
        
        NSFetchRequest *fetchData = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"CustomerRooms" inManagedObjectContext:dataContext];
        
        [fetchData setEntity:entity];
        
        
        //NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData error:&error];
        
        NSManagedObject *userData = nil;
        
        //NSLog(@"customer name %@",customerName);
        NSPredicate *pred =[NSPredicate predicateWithFormat:@"(customerName =%@)",customerName];
        
        [fetchData setPredicate:pred];
        //NSManagedObject *matches = nil;
        
        NSError *error;
        NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData
                                                           error:&error];
        
        //ViewController *vc = [ViewController sharedInstance];
        
        NSString *custRoomName;
        
        if(fetchObjects) {
            
            //userData = [fetchObjects objectAtIndex:indexPath.row];
            //[dataContext deleteObject:userData];
            for(int i=0;i<[fetchObjects count];i++) {
             userData = [fetchObjects objectAtIndex:i];
                NSString *custName = ((RoomListContent *) [self.reportsList objectAtIndex:indexPath.row]).customerName;
                //NSString *custRoom = ((RoomListContent *) [self.reportsList objectAtIndex:indexPath.row]).customerRoom;
                custRoomName = ((RoomListContent *) [self.reportsList objectAtIndex:indexPath.row]).customerRoomName;
                
                NSNumber *approve = ((RoomListContent *) [self.reportsList objectAtIndex:indexPath.row]).approveRoom;
                
                
                //NSLog(@"customer %@,%@, roomname:%@,%@",custName,[userData valueForKey:@"customerName"],custRoomName,[userData valueForKey:@"roomName"]);
                
                if([custName isEqualToString:[userData valueForKey:@"customerName"]] && [custRoomName isEqualToString:[userData valueForKey:@"roomName"]]) {
                    
                    //NSLog(@"Entered deleted room ");
                    NSNumber *marked = [[NSNumber alloc] initWithBool:NO];
                    
                    [userData setValue:marked forKey:@"marked"];
                    
                    [dataContext deleteObject:userData];
                    
                    
                    if([approve boolValue] && approvedCount>0)
                        approvedCount--;
                    
                    NSError *error = nil;
                    if (![dataContext save:&error])
                    {
                        NSLog(@"Error deleting move, %@", [error userInfo]);
                    }
                }
            }
            
        }
        
        /*for(int i=indexPath.row+1;i<[self.reportsList count];i++) {
            
            [self resetImagesDirectories:i];
        }*/
        

       
        
        NSString *imagePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:[NSString stringWithFormat:@"/%@/%@/%@",@"Optiqo",customerName,custRoomName]];
        
        //NSLog(@"image path %@",imagePath);
        
        //if(indexPath.row==0)
        {
            NSString *path = [NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"image1"]];
            [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
        }
        
        //if(indexPath.row==1)
        {
            NSString *path = [NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"image2"]];
            [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
        }
        
        //if(indexPath.row==2)
        {
            NSString *path = [NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"image3"]];
            [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
        }
        
        //if(indexPath.row==3)
        {
            NSString *path = [NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"image4"]];
            [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
        }
        
        //if(indexPath.row==4)
        {
            NSString *path = [NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"image5"]];
            [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
        }

        NSString *path = [NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"image6"]];
        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];

        
        [self.reportView setText:@""];

        
        
        self.pieChart = nil;
        self.reportChart = nil;
        self.scoreChart = nil;
        
        //[pieChart setNeedsDisplay];
        
        //[self.scrollView addSubview:pieChart];
        
        
        
        [self.reportsListView beginUpdates];
        
        [self.reportsListView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.reportsList removeObjectAtIndex:indexPath.row];
        [self.reportsListView.tableFooterView removeFromSuperview];
        [self.pieChart removeFromSuperview];
        [self calculateRating];
        for (UIView *pieView in [self.reportsListView.tableFooterView subviews]) {
            [pieView removeFromSuperview];
        }
        
        for (UIView *piechartView in [self.pieChart subviews]) {
            [piechartView removeFromSuperview];
        }
        
        self.pieChart = nil;
        
        self.pieChart = [[PieChartView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height*0.7, 300, 300) initWithRate:rating withOptions:1 withApproveCount:approvedCount numReports:(int)(self.reportsList.count) chartStyle:1];

        
        self.reportsListView.tableFooterView = nil;
        self.reportsListView.tableFooterView = self.pieChart;
        
        
        self.reportChart = [[PieChartView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height*0.7, 300, 300) initWithRate:rating withOptions:1 withApproveCount:approvedCount numReports:(int)(self.reportsList.count) chartStyle:2];
        
        self.scoreChart = [[PieChartView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height*0.7, 300, 300) initWithRate:rating withOptions:1 withApproveCount:approvedCount numReports:(int)(self.reportsList.count) chartStyle:3];

    
        
        [self.reportsListView endUpdates];
        
        //NSLog(@"num sub views %ld",(long)[self.reportsListView.tableFooterView subviews]);
        
   
    }
    
    //NSLog(@"data after edit %ld",(long)[self.reportsList count]);
    
    [self.reportsListView reloadData];
    
    //[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [tableView reloadData];
  
}



//resets image directrioes
-(void) resetImagesDirectories:(int) index {
    
    NSString *custRoomName = ((RoomListContent *) [self.reportsList objectAtIndex:index]).customerRoom;

    NSMutableArray *images = [[NSMutableArray alloc] init];
    
    NSString *imagePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:[NSString stringWithFormat:@"/%@/%@/%@/%d",@"Optiqo",customerName,custRoomName,index]];

    NSString *path = [NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"image1"]];
    
    //NSLog(@"path %@,%d",path,[[NSFileManager defaultManager] fileExistsAtPath:path]);
    
    if([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        
        NSData *data = [NSData dataWithContentsOfFile:path];
        
        [images addObject:data];
        
        path = [NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"image2"]];
        if([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            
            NSData *data = [NSData dataWithContentsOfFile:path];
            [images addObject:data];
        }
        
        path = [NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"image3"]];
        if([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            
            NSData *data = [NSData dataWithContentsOfFile:path];
            [images addObject:data];
        }
        
        path = [NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"image4"]];
        if([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            
            NSData *data = [NSData dataWithContentsOfFile:path];
            [images addObject:data];
        }
        
        path = [NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"image5"]];
        if([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            
            NSData *data = [NSData dataWithContentsOfFile:path];
            [images addObject:data];
        }
        
        //NSLog(@"image data %@",data);
    }
    
    
    //NSLog(@"images count %d",[images count]);
}

//cehck report status
-(void) checkReportStatus {
    
    //[self resetReportsStatus];
    
    ViewController *vc = [ViewController sharedInstance];
    
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *dataContext = [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchData = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CustomerRooms" inManagedObjectContext:dataContext];
    
    [fetchData setEntity:entity];
    
    
    
    //NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData error:&error];
    
    NSManagedObject *userData = nil;
    
    NSPredicate *pred =[NSPredicate predicateWithFormat:@"(customerName = %@)",customerName];
    
    [fetchData setPredicate:pred];
    //NSManagedObject *matches = nil;
    
    NSError *error;
    NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData
                                                       error:&error];
    
    isCustomerReportSend = NO;
    isEmployerReportSend = NO;
    
    if(fetchObjects) {
        
        for(int i=0;i<[fetchObjects count];i++) {
            userData = [fetchObjects objectAtIndex:i];
            
            NSDate  *date = [userData valueForKey:@"reportSentTime"];
            
            NSString *date_string = [NSDateFormatter localizedStringFromDate:date
                                                                   dateStyle:NSDateFormatterShortStyle
                                                                   timeStyle:NSDateFormatterShortStyle];
            
            NSString *date_time = [NSString stringWithFormat:@"%@",date_string];
            
            
            NSString *sent_string = [NSDateFormatter localizedStringFromDate:vc.reportSentDate
                                                                   dateStyle:NSDateFormatterShortStyle
                                                                   timeStyle:NSDateFormatterShortStyle];
            
            NSString *sentdate_time = [NSString stringWithFormat:@"%@",sent_string];
            
            if([date_time isEqualToString:sentdate_time])
            {
                //NSLog(@" date %@ ",sentdate_time);
                
                NSNumber *custNum = [userData valueForKey:@"customerReportSent"];
                NSNumber *empNum = [userData valueForKey:@"employerReportSent"];
                
               
                isCustomerReportSend = [custNum boolValue];
                isEmployerReportSend = [empNum boolValue];
                
                //NSLog(@" cust report %d,%d  ",isCustomerReportSend,isEmployerReportSend);
            }
            
        }
    }
    

}

//check reports to done when home button clicked

-(void) checkReports {
    
    //[self resetReportsStatus];
    
    ViewController *vc = [ViewController sharedInstance];
    
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *dataContext = [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchData = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CustomerRooms" inManagedObjectContext:dataContext];
    
    [fetchData setEntity:entity];
    
    
    //NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData error:&error];
    
    NSManagedObject *userData = nil;
    
    //NSLog(@"customer name %@",customerName);
    NSPredicate *pred =[NSPredicate predicateWithFormat:@"(customerName =%@)",customerName];
    
    [fetchData setPredicate:pred];
    //NSManagedObject *matches = nil;
    
    NSError *error;
    NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData
                                                       error:&error];
    
    if(fetchObjects) {
        if([fetchObjects count]!=0) {
            for(int i=0;i<[fetchObjects count];i++) {
                userData = [fetchObjects objectAtIndex:i];
                
                NSNumber *reportSent = [[NSNumber alloc] initWithBool:YES];
                NSDate *date = [NSDate date];
                
                NSNumber *custNum = [userData valueForKey:@"customerReportSent"];
                NSNumber *empNum = [userData valueForKey:@"employerReportSent"];
                
                if(![custNum boolValue] && ![empNum boolValue])
                {
                    
                    NSNumber *count = [userData valueForKey:@"numReportSent"];
                    int reportCount = [count intValue];
                    
                    reportCount++;
                    
                    [userData setValue:reportSent forKey:@"customerReportSent"];
                    [userData setValue:reportSent forKey:@"employerReportSent"];
                    [userData setValue:date forKey:@"reportSentTime"];
                
                    count = [[NSNumber alloc] initWithInt:reportCount];
                
                    [userData setValue:count forKey:@"numReportSent"];
                
                    vc.reportSentDate = date;
                    
                    [self setReportsSent];
                }
                
            }
        }
    }
}


//resets report status
-(void) resetReportsStatus {
    
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *dataContext = [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchData = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Customer" inManagedObjectContext:dataContext];
    
    [fetchData setEntity:entity];
    
    
    //NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData error:&error];
    
    NSManagedObject *userData = nil;
    
    //NSLog(@"customer name %@",customerName);
    NSPredicate *pred =[NSPredicate predicateWithFormat:@"(name =%@)",customerName];
    
    [fetchData setPredicate:pred];
    //NSManagedObject *matches = nil;
    
    NSError *error;
    NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData
                                                       error:&error];
    
    if(fetchObjects) {
        if([fetchObjects count]!=0) {
            for(int i=0;i<[fetchObjects count];i++) {
                userData = [fetchObjects objectAtIndex:i];
                NSNumber *custReport = [userData valueForKey:@"customerReportSent"];
                NSNumber *empReport = [userData valueForKey:@"employerReportSent"];
                
                if([custReport boolValue] && [empReport boolValue]) {
                    
                    custReport = [[NSNumber alloc] initWithBool:NO];
                    empReport = [[NSNumber alloc] initWithBool:NO];
                    
                    [userData setValue:custReport forKey:@"customerReportSent"];
                    [userData setValue:empReport forKey:@"employerReportSent"];
                    
                    [dataContext save:&error];
                }
                
                
                
            }
        }
    }
}

#pragma mark--set report true for customer and employer

//function to set the customer and employer report status to sent when they are disscarded
-(void) setReportsSent {
    
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *dataContext = [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchData = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Customer" inManagedObjectContext:dataContext];
    
    [fetchData setEntity:entity];
    
    
    //NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData error:&error];
    
    NSManagedObject *userData = nil;
    
    //NSLog(@"customer name %@",customerName);
    NSPredicate *pred =[NSPredicate predicateWithFormat:@"(name =%@)",customerName];
    
    [fetchData setPredicate:pred];
    //NSManagedObject *matches = nil;
    
    NSError *error;
    NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData
                                                       error:&error];
    
    if(fetchObjects) {
        if([fetchObjects count]!=0) {
            for(int i=0;i<[fetchObjects count];i++) {
                userData = [fetchObjects objectAtIndex:i];
                
                NSNumber *reportSent = [[NSNumber alloc] initWithBool:YES];
                
                [userData setValue:reportSent forKey:@"customerReportSent"];
                [userData setValue:reportSent forKey:@"employerReportSent"];
                
                [dataContext save:&error];
                
            }
        }
    }
}

//updates total time tken by user to complete the inspections
-(void) updateCustomerTotalTime {
    
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *dataContext = [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchData = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CustomerRooms" inManagedObjectContext:dataContext];
    
    [fetchData setEntity:entity];
    
    
    //NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData error:&error];
    
    NSManagedObject *userData = nil;
    
    //NSLog(@"customer name in roooms list get data %@",customerName);
    NSPredicate *pred =[NSPredicate predicateWithFormat:@"(customerName =%@)",customerName];
    
    [fetchData setPredicate:pred];
    //NSManagedObject *matches = nil;
    
    NSError *error;
    NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData
                                                       error:&error];
    
    ViewController *vc = [ViewController sharedInstance];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSUInteger unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit| NSSecondCalendarUnit;
    
    NSDateComponents *components = [calendar components:unitFlags
                                               fromDate:vc.customerStartTime
                                                 toDate:vc.customerEndTime options:0];
    
    NSInteger hours =components.hour;
    NSInteger minutes=components.minute;
    
    if(minutes>=60) {
        hours+=1;
        minutes = 0;
    }
    
    NSInteger seconds=components.second;
    
    if(seconds>=60) {
        minutes+=1;
        seconds = 0;
    }
    
    
    NSString *str_hours = [NSString stringWithFormat:@"%ld",(long) hours];
    
    if ([str_hours length]!=2) {
        str_hours = [NSString stringWithFormat:@"0%@",str_hours];
    }
    
    NSString *str_minutes = [NSString stringWithFormat:@"%ld",(long) minutes];
    
    if ([str_minutes length]!=2) {
        str_minutes = [NSString stringWithFormat:@"0%@",str_minutes];
    }
    
    NSString *str_seconds = [NSString stringWithFormat:@"%ld",(long) seconds];
    
    if ([str_seconds length]!=2) {
        str_seconds = [NSString stringWithFormat:@"0%@",str_seconds];
    }
    
    
    
    NSString *report_time = [NSString stringWithFormat:@"%@:%@:%@",str_hours,str_minutes,str_seconds];

    
    if(fetchObjects) {
        if([fetchObjects count]!=0) {
            for(int i=0;i<[fetchObjects count];i++) {
                userData = [fetchObjects objectAtIndex:i];
                NSNumber *num = [userData valueForKey:@"marked"];
                NSNumber *custReportSent = [userData valueForKey:@"customerReportSent"];
                NSNumber *empReportsent = [userData valueForKey:@"employerReportSent"];
                
                //NSLog(@"report value %d,%d",[custReportSent boolValue],[empReportsent boolValue]);
                
                if([num boolValue] && (![custReportSent boolValue] &&![empReportsent boolValue])) {
                    if(![userData valueForKey:@"totalTime"])
                    {
                        [userData setValue:report_time forKey:@"totalTime"];
                        [dataContext save:&error];
                    }
                    
                }
            }
        }
    }
    
    for(int i=0;i<[self.reportsList count];i++)
    {
        
        ((RoomListContent *)[self.reportsList objectAtIndex:i]).total_time = report_time;
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
