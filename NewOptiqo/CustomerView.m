//
//  CustomerView.m
//  NewOptiqo
//
//  Created by Umapathi on 8/21/14.
//  Copyright (c) 2014 Umapathi. All rights reserved.
//

#import "CustomerView.h"
#import "ViewController.h"
#import "AppDelegate.h"

@implementation CustomerView
@synthesize customerName,customerEmail,customerCountryCode,customerPhonenumber,customerAddress,chooseLanguage,chooseType,saveButton,cancelButton,customerStreet,customerCity,customerCountry,currentTextField,customerMapView,languageSearchList,typeSearchList;
@synthesize dg = _dg;

//initialize the view
- (id)initWithFrame:(CGRect)frame viewDelegate:(id) delg
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self setBackgroundColor:[UIColor whiteColor]];
        [self registerForKeyboardNotifications];
        
        ViewController *vc = [ViewController sharedInstance];
        
        customer_name = @"";
        
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
        
        
        [self drawView];
        
        
        _dg = delg;
        
        //"http://maps.googleapis.com/maps/api/geocode/json?address=";
        //SE&sensor=false;
        
        NSString *str=@"http://maps.googleapis.com/maps/api/geocode/json?address=Linkoping&SE&sensor=false";
        NSURL *url=[NSURL URLWithString:str];
        NSData *data=[NSData dataWithContentsOfURL:url];

        NSError *error=nil;
        if(data!=nil)
        {
            
            id response=[NSJSONSerialization JSONObjectWithData:data options:
                     NSJSONReadingMutableContainers error:&error];
        
        
            NSMutableDictionary *jsonContent = [response objectForKey:@"results"];
        
            //NSLog(@" location %@ ",jsonContent);
        
            if([jsonContent valueForKey:@"geometry"] != [NSNull null]) {
            
                NSMutableDictionary *geo = [jsonContent valueForKey:@"geometry"];
            
                NSMutableDictionary *coords = [geo valueForKey:@"location"];
            
                NSString *lat = [coords valueForKey:@"lat"];
                NSString *lng = [coords valueForKey:@"lng"];
            
                //NSLog(@"coords %@,%@",lat,lng);
            
                NSArray *latArray = (NSArray *)lat;
                NSArray *lngArray = (NSArray *)lng;
            
                lat = [latArray objectAtIndex:0];
                lng = [lngArray objectAtIndex:0];
            
                latitude = [lat floatValue];
                longitude = [lng floatValue];
            
            
                [self reloadMapView];
            }
            
            canChangeType  = YES;
            
            
            
        }

        
        //NSArray *numViews = [[self superview] subviews];
        
        //NSLog(@"num views %d",[numViews count]);
        
        self.userInteractionEnabled = YES;
        self.exclusiveTouch = YES;
        
        self.canCancelContentTouches = YES;
        self.delaysContentTouches = NO;
        
        //self.frame = CGRectMake(0, 0, 320.0, 1000.0);
        
        [self setContentSize:CGSizeMake(320.0, 1200.0)];
        
        
        
    }
    return self;
}

//initialize the view and only for viewing customer data
- (id)initWithCustomerName:(NSString *)name withFrame:(CGRect)frame viewDelegate:(id) delg
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        ViewController *vc = [ViewController sharedInstance];
        

        [self setBackgroundColor:[UIColor whiteColor]];
        [self registerForKeyboardNotifications];
        
        customer_name = name;
        
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
        
        _dg = delg;
        
        //[self drawView];
        
        [self getData:name];

        
        self.userInteractionEnabled = YES;
        self.exclusiveTouch = YES;
        
        self.canCancelContentTouches = YES;
        self.delaysContentTouches = NO;
        
        //self.frame = CGRectMake(0, 0, 320.0, 1000.0);
        [self setContentSize:CGSizeMake(320.0, 850.0)];
        
    }
    return self;
}

//initializing the view for editing customer data
- (id)initWithEditCustomerName:(NSString *)name withFrame:(CGRect)frame viewDelegate:(id) delg
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        ViewController *vc = [ViewController sharedInstance];
        
        
        [self setBackgroundColor:[UIColor whiteColor]];
        [self registerForKeyboardNotifications];
        
        customer_name = name;
        
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
        
        
        _dg = delg;
        
        //NSLog(@"entered customer edit view");
        
        
        [self drawView];
        
        [self getData];
        
        //[self getCustomerRooms];
        
        
        self.userInteractionEnabled = YES;
        self.exclusiveTouch = YES;
        
        self.canCancelContentTouches = YES;
        self.delaysContentTouches = NO;
        
        //self.frame = CGRectMake(0, 0, 320.0, 1000.0);
        [self setContentSize:CGSizeMake(320.0, 1200.0)];
        
    }
    return self;
}

//reloads the map
-(void) reloadMapView {
    
    
    customerMapView.centerCoordinate = CLLocationCoordinate2DMake(latitude, longitude);
    customerMapView.mapType = MKMapTypeStandard;
    
    
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = latitude;
    zoomLocation.longitude= longitude;
    
    
    // 2
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 1500, 1500);
    
    // 3
    [customerMapView setRegion:viewRegion animated:YES];
    
    [customerMapView.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    
    [customerMapView.layer setBorderWidth:0.5];
    
    point = [[MKPointAnnotation alloc] init];
    point.coordinate = zoomLocation;
    point.title = [labels valueForKey:@"message"];
    point.subtitle = [NSString stringWithFormat:@"%@,%@",self.customerAddress.text,self.customerCity.text];
    
    [customerMapView addAnnotation:point];
    
    [customerMapView reloadInputViews];
    
    MKMapSnapshotOptions *options = [[MKMapSnapshotOptions alloc] init];
    options.region = customerMapView.region;
    options.scale = [UIScreen mainScreen].scale;
    options.size = customerMapView.frame.size;
    
    MKMapSnapshotter *snapshotter = [[MKMapSnapshotter alloc] initWithOptions:options];
    [snapshotter startWithQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) completionHandler:^(MKMapSnapshot *snapshot, NSError *error) {
        
        /*UIImage *image = snapshot.image;
         NSData *data = UIImagePNGRepresentation(image);*/
        
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
            CGPoint imagePoint = [snapshot pointForCoordinate:annotation.coordinate];
            if (CGRectContainsPoint(finalImageRect, imagePoint)) // this is too conservative, but you get the idea
            {
                CGPoint pinCenterOffset = pin.centerOffset;
                imagePoint.x -= pin.bounds.size.width / 2.0;
                imagePoint.y -= pin.bounds.size.height / 2.0;
                imagePoint.x += pinCenterOffset.x;
                imagePoint.y += pinCenterOffset.y;
                
                [pinImage drawAtPoint:imagePoint];
            }
        }
        
        // grab the final image
        
        UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        NSData *data = UIImagePNGRepresentation(finalImage);
        
        
        NSString *imagePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:[NSString stringWithFormat:@"/%@/%@",@"Optiqo",customerName.text]];
        
        if([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"custMap"]]]) {
            
            [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"custMap"]] error:nil];
            
           // NSLog(@"cutomer data %@",customerName.text);
        }
        
        [[NSFileManager defaultManager] createDirectoryAtPath:imagePath withIntermediateDirectories:YES attributes:nil error:nil];
        
        //NSLog(@" image path %@",imagePath);
        
        [data writeToFile:[NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"custMap"]] atomically:YES];
        
        //NSLog(@"data %@",data);
        
        
    }];

}

//set view labels
-(void) setViewTitle {
    
    
    ViewController *vc = [ViewController sharedInstance];
    
    //NSLog(@"labels count %ld ",(long)[[vc.barView subviews] count]);
    
    //NSLog(@"customer data %@ ", ((UILabel *)[[vc.barView subviews] objectAtIndex:2]).text);
    
    //storing pervious view label
    pervCustLabel = ((UILabel *)[[vc.barView subviews] objectAtIndex:2]).text;
    
    //gets keys from the dictinoary
    NSString *knownObject = pervCustLabel;
    NSArray *temp = [labels allKeysForObject:knownObject];
    pervCustLabel = [temp lastObject];
    
    //NSLog(@" data %@",pervCustLabel);
    
    for(unsigned long i=[[vc.barView subviews] count]-1;i>=1;i--) {
        
        id viewItem = [[vc.barView subviews] objectAtIndex:i];
        [viewItem removeFromSuperview];
    }
    
    [vc drawRightMenuView];
    
    UILabel *cust_label = [[UILabel alloc] initWithFrame:CGRectMake(50, 25, 200, 32)];
    
    [cust_label setBackgroundColor:[UIColor clearColor]];
    
    [cust_label setText:[labels valueForKey:@"customerinfo"]];
    [cust_label setTextColor:[UIColor whiteColor]];
    [cust_label setTextAlignment:NSTextAlignmentCenter];
    [cust_label setFont:[UIFont fontWithName:@"Avenir-Medium" size:18]];
    
    [vc.barView addSubview:cust_label];
    
    UIImageView *backImage = (UIImageView *)[[vc.barView subviews] objectAtIndex:0];
    
    backImage.image = [UIImage imageNamed:@"back.png"];
    
    UITapGestureRecognizer *backTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backToCustomerView:)];
    
    [backImage addGestureRecognizer:backTap];
    
}

//gets data from databse
-(void) getData {
    
    
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *dataContext = [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchData = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Customer" inManagedObjectContext:dataContext];
    
    [fetchData setEntity:entity];
    
    
    
    //NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData error:&error];
    
    NSManagedObject *userData = nil;
    
    NSPredicate *pred =[NSPredicate predicateWithFormat:@"(name = %@)",customer_name];
    
    [fetchData setPredicate:pred];
    //NSManagedObject *matches = nil;
    
    NSError *error;
    NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData
                                                       error:&error];
    
    
    
    if(fetchObjects) {
    
        //NSLog(@"entered get data records count %d",(int)[fetchObjects count]);
        for(int i=0;i<[fetchObjects count];i++) {
            userData = [fetchObjects objectAtIndex:i];
            
            
            [self.customerName setText:[userData valueForKey:@"name"]];
            
            [self.customerEmail setText:[userData valueForKey:@"email"]];
            
            [self.customerAddress setText:[userData valueForKey:@"address"]];
            
            [self.customerCity setText:[userData valueForKey:@"city"]];
            
            [self.customerCountry setText:[userData valueForKey:@"country"]];
            
            [self.customerPhonenumber setText:[userData valueForKey:@"phone"]];
            
            
            UILabel *custLang = (UILabel *) [[self.chooseLanguage subviews] objectAtIndex:0];
            
            [custLang setText:[userData valueForKey:@"language"]];
            [custLang setTextColor:color];
            [custLang setFont:font];
            
            
            
            UILabel *custType = (UILabel *) [[self.chooseType subviews] objectAtIndex:0];
            
            
            
            NSNumber *num = (NSNumber *) [userData valueForKey:@"type"];
            
            
            
            if([num intValue]==1) {
                
                [custType setText:[labels valueForKey:@"homecleaning"]];
            }
            
            if([num intValue]==2) {
                
                [custType setText:[labels valueForKey:@"officecleaning"]];
            }
            
            [custType setTextColor:color];
            [custType setFont:font];
            
            [self.chooseType setHidden:YES];
            
            [self setViewTitle];
            
            
            latitude = [[userData valueForKey:@"latitude"] floatValue];
            longitude = [[userData valueForKey:@"longitude"] floatValue];
            
            //NSLog(@"latitude,longitude %f,%f",latitude,longitude);
            
            [self reloadMapView];
            
        }
    }
    
    
    
}


//gets data from databse and show to user no editing
-(void) getData:(NSString *)name {
    
    ViewController *vc = [ViewController sharedInstance];
    
    UIImageView  *backImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width,self.contentSize.height)];
    
    backImg.image = [UIImage imageNamed:@"view_background.png"];
    
    [backImg setUserInteractionEnabled:YES];
    
    [self addSubview:backImg];
    
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *dataContext = [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchData = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Customer" inManagedObjectContext:dataContext];
    
    [fetchData setEntity:entity];
    

    
    //NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData error:&error];
    
    NSManagedObject *userData = nil;
    
    NSPredicate *pred =[NSPredicate predicateWithFormat:@"(name = %@)",name];
    
    [fetchData setPredicate:pred];
    //NSManagedObject *matches = nil;
    
    NSError *error;
    NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData
                                              error:&error];
    
    //NSLog(@"entered get data");
    
    if(fetchObjects) {
        
        for(int i=0;i<[fetchObjects count];i++) {
            userData = [fetchObjects objectAtIndex:i];
            
            UILabel *customerLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 25, vc.deviceWidth-100, 20)];
            
            [customerLabel setText:[userData valueForKey:@"name"]];
            [customerLabel setTextColor:color];
            [customerLabel setFont:font];
            [self addSubview:customerLabel];
            
            
            UILabel *emailLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 75, vc.deviceWidth-100, 20)];
            
            [emailLabel setText:[userData valueForKey:@"email"]];
            [emailLabel setTextColor:color];
            [emailLabel setFont:font];
            
            [self addSubview:emailLabel];
            
            customer_email = emailLabel.text;
            
            CGSize textSize = [emailLabel.text sizeWithAttributes:@{NSFontAttributeName:font}];
            
            //info image
            UIImageView *email_message = [[UIImageView alloc] initWithFrame:CGRectMake(50+(textSize.width)+10, 73, 20, 20)];
            
            email_message.image = [UIImage imageNamed:@"message.png"];
            
            [email_message setContentMode:UIViewContentModeScaleAspectFill];
            
            [email_message setUserInteractionEnabled:YES];
            
            UITapGestureRecognizer *addImagetap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sendMessage:)];
            
            [email_message addGestureRecognizer:addImagetap];
            
            [self addSubview:email_message];

            
            UILabel *custAddressLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 125, vc.deviceWidth-100, 20)];
            
            [custAddressLabel setText:[userData valueForKey:@"address"]];
            [custAddressLabel setTextColor:color];
            [custAddressLabel setFont:font];
            
            [self addSubview:custAddressLabel];
            
            
            UILabel *custCityLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 175, vc.deviceWidth-100, 20)];
            
            [custCityLabel setText:[userData valueForKey:@"city"]];
            [custCityLabel setTextColor:color];
            [custCityLabel setFont:font];
            [self addSubview:custCityLabel];
            
            UILabel *custCountryLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 225, vc.deviceWidth-100, 20)];
            
            [custCountryLabel setText:[userData valueForKey:@"country"]];
            [custCountryLabel setTextColor:color];
            [custCountryLabel setFont:font];
            [self addSubview:custCountryLabel];
            
            
            
            UILabel *custPhonenumber = [[UILabel alloc] initWithFrame:CGRectMake(50, 275, 125, 20)];
            
            [custPhonenumber setText:[userData valueForKey:@"phone"]];
            [custPhonenumber setTextColor:color];
            [custPhonenumber setFont:font];
            
            [self addSubview:custPhonenumber];
            
            customer_phone = custPhonenumber.text;
            
            textSize = [custPhonenumber.text sizeWithAttributes:@{NSFontAttributeName:font}];
            
            if([custPhonenumber.text length]!=0)
            {
                //info image
                UIImageView *custCall = [[UIImageView alloc] initWithFrame:CGRectMake(50+(textSize.width)+10, 273, 20, 20)];
            
                custCall.image = [UIImage imageNamed:@"cellPhone.png"];
            
                [custCall setContentMode:UIViewContentModeScaleAspectFill];
            
                [custCall setUserInteractionEnabled:YES];
            
                UITapGestureRecognizer *addCustCallImagetap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(callCustomer:)];
            
                [custCall addGestureRecognizer:addCustCallImagetap];
            
                [self addSubview:custCall];
            }

            
            
            customerMapView = [[MKMapView alloc] initWithFrame:CGRectMake(50, 325, vc.deviceWidth-100, 250)];
            
            customerMapView.delegate = _dg;
            
            [self addSubview:customerMapView];
            
            UILabel *custLang = [[UILabel alloc] initWithFrame:CGRectMake(50, 625, 125, 20)];
            
            [custLang setText:[userData valueForKey:@"language"]];
            [custLang setTextColor:color];
            [custLang setFont:font];
            
            [self addSubview:custLang];
            
            UILabel *custType = [[UILabel alloc] initWithFrame:CGRectMake(50, 700, 200, 20)];
            
            
            
            NSNumber *num = (NSNumber *) [userData valueForKey:@"type"];
            
            
            
            if([num intValue]==1) {
                
                [custType setText:[labels valueForKey:@"homecleaning"]];
            }
            
            if([num intValue]==2) {
                
                [custType setText:[labels valueForKey:@"officecleaning"]];
            }

            [custType setTextColor:color];
            [custType setFont:font];
            
            [self addSubview:custType];

            
            
            [self setViewTitle];
            
            
            latitude = [[userData valueForKey:@"latitude"] floatValue];
            longitude = [[userData valueForKey:@"longitude"] floatValue];
            
            //NSLog(@"latitude,longitude %f,%f",latitude,longitude);
            
            [self reloadMapView];
            
        }
    }
    
    
    
}

//sends mail to customer
-(void) sendMessage:(id) sender {
    
    ViewController *vc = [ViewController sharedInstance];
    
    [vc sendEmail:customer_email];
    
    
}

//calls a customer
-(void) callCustomer:(id) sender {
    
    //ViewController *vc = [ViewController sharedInstance];
    
    //[vc sendEmail:customer_email];
    
    NSString *phoneNumber = [@"telprompt://" stringByAppendingString:customer_phone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
    
    
}

//draw view contents to fill the customer information
-(void) drawView {
    
    ViewController *vc = [ViewController sharedInstance];
    
    UIImageView  *backImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width,self.contentSize.height)];
    
    backImg.image = [UIImage imageNamed:@"view_background.png"];
    
    [backImg setUserInteractionEnabled:YES];
    
    [self addSubview:backImg];
    
    //NSLog(@"font %@",font);
    
    UILabel *customerLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 25, vc.deviceWidth-100, 20)];
    
    [customerLabel setText:[labels valueForKey:@"customername"]];
    [customerLabel setTextColor:color];
    [customerLabel setFont:font];
    [self addSubview:customerLabel];
    
    self.customerName = [[UITextField alloc] initWithFrame:CGRectMake(50, 50, vc.deviceWidth-100, 50)];
    //[self.customerName setLeftViewMode:UITextFieldViewModeAlways];
    
    
    //self.customerName.leftView = [self getImage];
    self.customerName.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    [self.customerName setDelegate:_dg];
    [self.customerName setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.5]];
    //[self.customerName setText:@"Name"];
    [self.customerName setFont:font];
    [self.customerName setTextColor:color];
    
    [self.customerName.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.customerName.layer setBorderWidth:0.5];
    
    [self.customerName resignFirstResponder];
    self.customerName.autocorrectionType = UITextAutocorrectionTypeNo;
    
    self.customerName.returnKeyType = UIReturnKeyDone;
    
    [self addSubview:self.customerName];
    
    [self.customerName addTarget:self action:@selector(textFieldEdit:) forControlEvents:UIControlEventEditingDidBegin];
    
    UILabel *emailLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 125, vc.deviceWidth-100, 20)];
    
    [emailLabel setText:[labels valueForKey:@"customeremail"]];
    [emailLabel setTextColor:color];
    [emailLabel setFont:font];
    
    [self addSubview:emailLabel];
    
    self.customerEmail = [[UITextField alloc] initWithFrame:CGRectMake(50, 150, vc.deviceWidth-100, 50)];
    //[self.customerEmail setLeftViewMode:UITextFieldViewModeAlways];
    //self.customerEmail.leftView = [self getImage];
    self.customerEmail.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    [self.customerEmail setDelegate:_dg];
    [self.customerEmail setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.5]];
    //[self.customerEmail setText:@"Email"];
    [self.customerEmail setFont:font];
    [self.customerEmail setTextColor:color];
    
    [self.customerEmail.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.customerEmail.layer setBorderWidth:0.5];
    
    [self.customerEmail resignFirstResponder];
    
    [self.customerEmail setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    self.customerEmail.returnKeyType = UIReturnKeyDone;
    self.customerEmail.autocorrectionType = UITextAutocorrectionTypeNo;
    
    [self addSubview:self.customerEmail];
    
    [self.customerEmail addTarget:self action:@selector(textFieldEdit:) forControlEvents:UIControlEventEditingDidBegin];
    
    
    UILabel *custAddressLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 225, vc.deviceWidth-100, 20)];
    
    [custAddressLabel setText:[labels valueForKey:@"customeraddress"]];
    [custAddressLabel setTextColor:color];
    [custAddressLabel setFont:font];
    
    [self addSubview:custAddressLabel];
    
    self.customerAddress = [[UITextField alloc] initWithFrame:CGRectMake(50, 250, vc.deviceWidth-100, 50)];
    //[self.customerAddress setLeftViewMode:UITextFieldViewModeAlways];
    //self.customerAddress.leftView = [self getImage];
    self.customerAddress.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    [self.customerAddress setDelegate:_dg];
    [self.customerAddress setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.5]];
    //[self.customerAddress setText:@"Address"];
    [self.customerAddress setFont:font];
    [self.customerAddress setTextColor:color];
    
    [self.customerAddress.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.customerAddress.layer setBorderWidth:0.5];
    
    [self.customerAddress resignFirstResponder];
    
    self.customerAddress.returnKeyType = UIReturnKeyDone;
    self.customerAddress.autocorrectionType = UITextAutocorrectionTypeNo;
    
    [self addSubview:self.customerAddress];
    
    [self.customerAddress addTarget:self action:@selector(textFieldEdit:) forControlEvents:UIControlEventEditingDidBegin];
    
    /*UILabel *custStreetLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 325, vc.deviceWidth-100, 20)];
    
    [custStreetLabel setText:[labels valueForKey:@"customerstreet"]];
    [custStreetLabel setTextColor:color];
    [custStreetLabel setFont:font];
    [self addSubview:custStreetLabel];
    
    self.customerStreet = [[UITextField alloc] initWithFrame:CGRectMake(50, 350, vc.deviceWidth-100, 50)];
    //[self.customerStreet setLeftViewMode:UITextFieldViewModeAlways];
    //self.customerStreet.leftView = [self getImage];
    self.customerStreet.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    [self.customerStreet setDelegate:_dg];
    [self.customerStreet setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.5]];
    //[self.customerStreet setText:@"Street"];
    [self.customerStreet setFont:font];
    [self.customerStreet setTextColor:color];
    
    [self.customerStreet.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.customerStreet.layer setBorderWidth:0.5];
    
    [self.customerStreet resignFirstResponder];
    
    self.customerStreet.returnKeyType = UIReturnKeyDone;
    self.customerStreet.autocorrectionType = UITextAutocorrectionTypeNo;
    
    [self addSubview:self.customerStreet];
    
    [self.customerStreet addTarget:self action:@selector(textFieldEdit:) forControlEvents:UIControlEventEditingDidBegin];*/
    
    
    UILabel *custCityLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 325, vc.deviceWidth-100, 20)];
    
    [custCityLabel setText:[labels valueForKey:@"customercity"]];
    [custCityLabel setTextColor:color];
    [custCityLabel setFont:font];
    [self addSubview:custCityLabel];
    
    self.customerCity = [[UITextField alloc] initWithFrame:CGRectMake(50, 350, vc.deviceWidth-100, 50)];
    //[self.customerCity setLeftViewMode:UITextFieldViewModeAlways];
    //self.customerCity.leftView = [self getImage];
    self.customerCity.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    [self.customerCity setDelegate:_dg];
    [self.customerCity setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.5]];
    //[self.customerCity setText:@"City"];
    [self.customerCity setFont:font];
    [self.customerCity setTextColor:color];
    
    [self.customerCity.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.customerCity.layer setBorderWidth:0.5];
    
    [self.customerCity resignFirstResponder];
    
    self.customerCity.returnKeyType = UIReturnKeyDone;
    self.customerCity.autocorrectionType = UITextAutocorrectionTypeNo;
    
    [self addSubview:self.customerCity];
    
    [self.customerCity addTarget:self action:@selector(textFieldEdit:) forControlEvents:UIControlEventEditingDidBegin];

    UILabel *custCountryLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 425, vc.deviceWidth-100, 20)];
    
    [custCountryLabel setText:[labels valueForKey:@"customercountry"]];
    [custCountryLabel setTextColor:color];
    [custCountryLabel setFont:font];
    [self addSubview:custCountryLabel];
    
    self.customerCountry = [[UITextField alloc] initWithFrame:CGRectMake(50, 450, vc.deviceWidth-100, 50)];
    //[self.customerCity setLeftViewMode:UITextFieldViewModeAlways];
    //self.customerCity.leftView = [self getImage];
    self.customerCountry.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    [self.customerCountry setDelegate:_dg];
    [self.customerCountry setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.5]];
    //[self.customerCity setText:@"City"];
    [self.customerCountry setFont:font];
    [self.customerCountry setTextColor:color];
    
    [self.customerCountry.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.customerCountry.layer setBorderWidth:0.5];
    
    [self.customerCountry resignFirstResponder];
    
    self.customerCountry.returnKeyType = UIReturnKeyDone;
    self.customerCountry.autocorrectionType = UITextAutocorrectionTypeNo;
    
    [self addSubview:self.customerCountry];
    
    [self.customerCountry addTarget:self action:@selector(textFieldEdit:) forControlEvents:UIControlEventEditingDidBegin];
    
    
    /*UILabel *custCountryCode = [[UILabel alloc] initWithFrame:CGRectMake(50, 625, 50, 20)];
    
    [custCountryCode setText:[labels valueForKey:@"customercountrycode"]];
    [custCountryCode setTextColor:color];
    [custCountryCode setFont:font];
    
    [self addSubview:custCountryCode];
    
    self.customerCountryCode = [[UITextField alloc] initWithFrame:CGRectMake(50, 650, 50, 50)];
    //[self.customerAddress setLeftViewMode:UITextFieldViewModeAlways];
    //self.customerAddress.leftView = [self getImage];
    self.customerCountryCode.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    [self.customerCountryCode setDelegate:_dg];
    [self.customerCountryCode setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.5]];
    //[self.customerAddress setText:@"Address"];
    [self.customerCountryCode setFont:font];
    [self.customerCountryCode setTextColor:color];
    
    [self.customerCountryCode.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.customerCountryCode.layer setBorderWidth:0.5];
    
    [self.customerCountryCode resignFirstResponder];
    
    self.customerCountryCode.keyboardType = UIKeyboardTypeDecimalPad;
    self.customerCountryCode.returnKeyType = UIReturnKeyDone;
    self.customerCountryCode.autocorrectionType = UITextAutocorrectionTypeNo;
    
    [self addSubview:self.customerCountryCode];
    
    [self.customerCountryCode addTarget:self action:@selector(textFieldEdit:) forControlEvents:UIControlEventEditingDidBegin];*/
    
    
    UILabel *custPhonenumber = [[UILabel alloc] initWithFrame:CGRectMake(50, 525, 125, 20)];
    
    [custPhonenumber setText:[labels valueForKey:@"customerphonenumber"]];
    [custPhonenumber setTextColor:color];
    [custPhonenumber setFont:font];
    
    [self addSubview:custPhonenumber];
    
    self.customerPhonenumber = [[UITextField alloc] initWithFrame:CGRectMake(50, 550, vc.deviceWidth-100, 50)];
    //[self.customerAddress setLeftViewMode:UITextFieldViewModeAlways];
    //self.customerAddress.leftView = [self getImage];
    self.customerPhonenumber.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    [self.customerPhonenumber setDelegate:_dg];
    [self.customerPhonenumber setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.5]];
    //[self.customerAddress setText:@"Address"];
    [self.customerPhonenumber setFont:font];
    [self.customerPhonenumber setTextColor:color];
    
    [self.customerPhonenumber.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.customerPhonenumber.layer setBorderWidth:0.5];
    
    
    [self.customerPhonenumber resignFirstResponder];
    
    self.customerPhonenumber.returnKeyType = UIReturnKeyDone;
    self.customerPhonenumber.autocorrectionType = UITextAutocorrectionTypeNo;
    
    [self addSubview:self.customerPhonenumber];
    
    [self.customerPhonenumber addTarget:self action:@selector(textFieldEdit:) forControlEvents:UIControlEventEditingDidBegin];
    
    
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldEdit:) name:@"UITextFieldTextDidBeginEditingNotification" object:nil];

    
    
    customerMapView = [[MKMapView alloc] initWithFrame:CGRectMake(50, 625, vc.deviceWidth-100, 250)];
    
    customerMapView.delegate = _dg;

    [self addSubview:customerMapView];

    
    
    /*
    self.customerLanguage = [[UITextField alloc] initWithFrame:CGRectMake(50, 225, vc.deviceWidth-100, 50)];
    [self.customerLanguage setDelegate:self];
    [self.customerLanguage setBackgroundColor:[UIColor whiteColor]];
    [self.customerLanguage setText:@"Language"];
    [self.customerLanguage setTextColor:[UIColor colorWithRed:0.0 green:191.0/255.0 blue:1.0 alpha:1.0]];
    
    [self.customerLanguage.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.customerLanguage.layer setBorderWidth:0.5];
    
    [self.customerLanguage resignFirstResponder];
    
    self.customerLanguage.returnKeyType = UIReturnKeyDone;
    self.customerLanguage.autocorrectionType = UITextAutocorrectionTypeNo;
    
    [self addSubview:self.customerLanguage]; */
    

    
    self.chooseLanguage = [[UIView alloc] initWithFrame:CGRectMake(50, 900, vc.deviceWidth-100, 50)];
    [self.chooseLanguage setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.5]];
    
    [self.chooseLanguage.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    
    [self.chooseLanguage.layer setBorderWidth:0.5];
    
    [self.chooseLanguage.layer setCornerRadius:5.0];
    
    [self.chooseLanguage setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *languageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseLang:)];
    
    [self.chooseLanguage addGestureRecognizer:languageTap];
    
    [self addSubview:self.chooseLanguage];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, vc.deviceWidth-100, 45)];
    
    if([[labels valueForKey:@"customerlanguage"] isEqualToString:@"Swedish"])
        [label setText:[labels valueForKey:@"swedish"]];
    else
        [label setText:[labels valueForKey:@"english"]];


    
    if([vc.userLanguageSelected isEqualToString:@"Swedish"])
        [label setText:[labels valueForKey:@"swedish"]];
    else
        [label setText:[labels valueForKey:@"english"]];
    
    
    //[label setText:[labels valueForKey:@"customerlanguage"]];
    
    
    
    [label setTextAlignment:NSTextAlignmentCenter];
    
    [label setTextColor:color];
    [label setFont:font];
    
    
    [self.chooseLanguage addSubview:label];
    
    self.chooseType = [[UIView alloc] initWithFrame:CGRectMake(50, 975, vc.deviceWidth-100, 50)];
    
    [self.chooseType setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.5]];
    
    [self.chooseType.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    
    [self.chooseType.layer setBorderWidth:0.5];
    
    [self.chooseType.layer setCornerRadius:5.0];
    
    [self.chooseType setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *typeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(choosetype:)];
    
    [self.chooseType addGestureRecognizer:typeTap];
    
    [self addSubview:self.chooseType];
    
    UILabel *typelabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, vc.deviceWidth-100, 45)];
    
    [typelabel setText:[labels valueForKey:@"customertype"]];
    
    [typelabel setTextAlignment:NSTextAlignmentCenter];
    
    
    [typelabel setTextColor:color];
    
    [typelabel setFont:font];
    
    [self.chooseType addSubview:typelabel];
    
    //NSLog(@"entered data ");
    
    [self setViewTitle];
    
    
    /*UIImageView *saveImage = [[UIImageView alloc] initWithFrame:CGRectMake(vc.deviceWidth-50, 25, 32, 32)];
    
    saveImage.image = [UIImage imageNamed:@"save.png"];
    
    [saveImage setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *saveTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(saveData:)];
    
    [saveImage addGestureRecognizer:saveTap];
    
    [vc.barView addSubview:saveImage];*/
    
    UIView *saveView = [[UIView alloc] initWithFrame:CGRectMake(50, 1050, 200, 50)];
    
    [saveView setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.5]];
    [saveView.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [saveView.layer setBorderWidth:0.5];
    
    [saveView setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *saveTap = saveTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:(@selector(saveData:))];
    
    
    
    
    [saveView addGestureRecognizer:saveTap];
    
    UILabel *saveLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 190, 40)];
    
    [saveLabel setText:[labels valueForKey:@"save"]];
    [saveLabel setTextColor:color];
    [saveLabel setFont:font];
    [saveLabel setTextAlignment:NSTextAlignmentCenter];
    
    [saveView addSubview:saveLabel];
    
    //[self addSubview:saveView];


    
    self.saveButton = [[UIButton alloc] initWithFrame:CGRectMake(50, 1050, vc.deviceWidth-100, 50)];
    
    [self.saveButton setBackgroundColor:[UIColor colorWithRed:0.0 green:180.0/255.0 blue:0.0 alpha:0.95]];
    [self.saveButton.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.saveButton.layer setBorderWidth:0.5];
    
    [self.saveButton setUserInteractionEnabled:YES];
    
    [self.saveButton setTitle:[labels valueForKey:@"save"] forState:UIControlStateNormal];
    [self.saveButton.titleLabel setFont:font];
    
    [self.saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.saveButton addTarget:self action:@selector(saveData:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.saveButton];
    
    
    /*self.cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(175, 925, 100, 50)];
    
    [self.cancelButton setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.5]];
    
    [self.cancelButton.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.cancelButton.layer setBorderWidth:0.5];
    
    [self.cancelButton setUserInteractionEnabled:YES];
    
    [self.cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [self.cancelButton.titleLabel setFont:font];
    
    [self.cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.cancelButton addTarget:self action:@selector(cancelView:) forControlEvents:UIControlEventTouchUpInside];
    
    //[self addSubview:self.cancelButton];
    
    
    UIImageView *backImage = (UIImageView *)[[vc.barView subviews] objectAtIndex:0];
    
    backImage.image = [UIImage imageNamed:@"back.png"];
    
    UITapGestureRecognizer *backTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backToCustomerView:)];
    
    [backImage addGestureRecognizer:backTap];*/
    
    
    
}

-(void) textFieldEdit:(id) sender {
    
    self.currentTextField = sender;

}


-(UIImageView *) getImage {
    
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"transparent.png"]];
    
    image.frame = CGRectMake(0, 0, 8, 8);
    
    [image setContentMode:UIViewContentModeScaleAspectFit];
    
    return image;
}

//back to pervious view
-(void) backToCustomerView:(id) sender {
    
    
    ViewController *vc = [ViewController sharedInstance];

    
    if([customer_name length]==0) {
    
        id animation = ^{
        
            self.transform = CGAffineTransformMakeTranslation(320, 0);
            //goes back to pervious view
            if([pervCustLabel isEqualToString:[labels valueForKey:@"customerrooms"]])
            {
                
                [vc.customerList setViewTitle];
                vc.customerList.customer_view = NULL;
            }
            
            if([pervCustLabel isEqualToString:[labels valueForKey:@"status"]])
            {
                
                [vc.customerList.roomListView.roomComments setViewTitle];
                vc.customerList.customer_view = NULL;
            }
            
            if([pervCustLabel isEqualToString:[labels valueForKey:@"addcomments"]])
            {
                
                [vc.customerList.roomListView.roomComments.commentsRoom setViewTitle];
                vc.customerList.customer_view = NULL;
            }
            
            if([pervCustLabel isEqualToString:[labels valueForKey:@"overview"]])
            {
                [vc.customerList.roomListView.roomComments.reportsListView setViewTitle];
                vc.customerList.customer_view = NULL;
            }
            
            
        };
    
        id complete = ^(BOOL finished){
        
        
            [self removeFromSuperview];
        };
    
        [UIView animateWithDuration:0.5 animations:animation completion:complete];
        
    } else {
        
        id animation = ^{
            
            self.transform = CGAffineTransformMakeTranslation(320, 0);
            
        };
        
        id complete = ^(BOOL finished){
            
            //RoomsListView *roomListView = (RoomsListView *)[self superview];
            ViewController *vc = [ViewController sharedInstance];
            
            if([pervCustLabel isEqualToString:[labels valueForKey:@"customerrooms"]])
            {
                
                [vc.customerList.roomListView setViewTitle];
                vc.customerList.customer_view = NULL;
            }
            else if([pervCustLabel isEqualToString:[labels valueForKey:@"status"]])
            {
                
                [vc.customerList.roomListView.roomComments setViewTitle];
                vc.customerList.customer_view = NULL;
            }
            else if([pervCustLabel isEqualToString:[labels valueForKey:@"addcomments"]])
            {
                
                [vc.customerList.roomListView.roomComments.commentsRoom setViewTitle];
                vc.customerList.customer_view = NULL;
            }
            else if([pervCustLabel isEqualToString:[labels valueForKey:@"overview"]])
            {
                [vc.customerList.roomListView.roomComments.reportsListView setViewTitle];
                vc.customerList.customer_view = NULL;
            }
            else
            {
                [self removeFromSuperview];
                [vc.customerList setViewTitle];
            }
            
            [self removeFromSuperview];
        };
        
        [UIView animateWithDuration:0.5 animations:animation completion:complete];
    }
    

    
    
    
}

//reloads the map

-(void) mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    
    ViewController *vc = [ViewController sharedInstance];
    
    //MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
    //[customerMapView setRegion:[customerMapView regionThatFits:region] animated:YES];
    
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = vc.lat;
    zoomLocation.longitude= vc.lan;
    
    
    // 2
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 1500, 1500);
    
    [customerMapView setRegion:[customerMapView regionThatFits:viewRegion] animated:YES];
    
    point = [[MKPointAnnotation alloc] init];
    point.coordinate = zoomLocation;
    point.title = [labels valueForKey:@"message"];
    point.subtitle = point.subtitle = [NSString stringWithFormat:@"%@,%@",self.customerAddress.text,self.customerCity.text];;
    
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
            CGPoint imagePoint = [snapshot pointForCoordinate:annotation.coordinate];
            if (CGRectContainsPoint(finalImageRect, imagePoint)) // this is too conservative, but you get the idea
            {
                CGPoint pinCenterOffset = pin.centerOffset;
                imagePoint.x -= pin.bounds.size.width / 2.0;
                imagePoint.y -= pin.bounds.size.height / 2.0;
                imagePoint.x += pinCenterOffset.x;
                imagePoint.y += pinCenterOffset.y;
                
                [pinImage drawAtPoint:imagePoint];
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

//choose the language for customer
-(void) chooseLang:(id) sender {
    
   
    if(!typeSearchList.view.isHidden)
        [typeSearchList.view setHidden:YES];
    
    self.languageSearchList = [[SearchList alloc] initWithFrame:CGRectMake(self.chooseLanguage.frame.origin.x, self.chooseLanguage.frame.origin.y+self.chooseLanguage.frame.size.height, self.chooseLanguage.frame.size.width, 100)];
    
    [self.languageSearchList.view.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    
    [self.languageSearchList.view.layer setBorderWidth:0.5];
    
    [self.languageSearchList setDelegate:self];
    
    [self addSubview:self.languageSearchList.view];
    
    isLanguageSelected = YES;
    
}

//choose the cleaning type for customer
-(void) choosetype:(id) sender {
    
    if(canChangeType)
    {
    
        NSMutableArray *types = [[NSMutableArray alloc] initWithObjects:[labels valueForKey:@"homecleaning"],[labels valueForKey:@"officecleaning"], nil];
    
        if(!self.languageSearchList.view.isHidden)
        [self.languageSearchList.view setHidden:YES];
    
    
        self.typeSearchList = [[SearchList alloc] initWithFrame:CGRectMake(self.chooseType.frame.origin.x, self.chooseType.frame.origin.y+self.chooseType.frame.size.height, self.chooseType.frame.size.width, 100) withArray:types];
    
        [self.typeSearchList.view.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    
        [self.typeSearchList.view.layer setBorderWidth:0.5];
    
        [self.typeSearchList setDelegate:self];
    
        [self addSubview:self.typeSearchList.view];
    
        isTypeSelected = YES;
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[labels valueForKey:@"message"] message:[labels valueForKey:@"delete_rooms"] delegate:nil cancelButtonTitle:[labels valueForKey:@"ok"] otherButtonTitles:nil, nil];
        [alert show];
    }
}


//gets the approiate selection to choose language and type for customer
-(void) getSelectedString:(NSString *) searchString {
    
    if([searchString length]!=0 && isLanguageSelected && self.languageSearchList.isChoosen) {
        
        UILabel *label = [[self.chooseLanguage subviews] objectAtIndex:0];
        
        [label setText:searchString];
        isLanguageSelected = NO;
        
        self.languageSearchList.isChoosen = NO;
    }
    
    if([searchString length]!=0 && isTypeSelected && self.typeSearchList.isChoosen) {
        
        UILabel *label = [[self.chooseType subviews] objectAtIndex:0];
        
        [label setText:searchString];
        
        ViewController *vc = [ViewController sharedInstance];
        
        //NSLog(@"search string %@",searchString);
        
        if([searchString isEqualToString:[labels valueForKey:@"homecleaning"]]) {
            
            vc.cleaningType = 1;
        }
        
        if([searchString isEqualToString:[labels valueForKey:@"officecleaning"]]) {
            
            vc.cleaningType = 2;
        }
        self.typeSearchList.isChoosen = NO;
        //isTypeSelected = NO;
        //typeSearchList = NO;
    }
    
}

#pragma mark --saveData  and cancelview functions

-(void) saveData:(id) sender {
    
    BOOL isValid = NO;
    
    //NSLog(@"text lenght %d",[self.customerName.text length]);
    
    if([self.customerName.text length]==0) {
        
        isValid = NO;
        
        [self.customerName becomeFirstResponder];
        
        return;
        
    }
    else if([self.customerName.text length]==1) {
        
        //NSLog(@"text lenght %d",[self.customerName.text length]);
        isValid = NO;
        [self.customerName becomeFirstResponder];
        
    }
    else {
        
        isValid = YES;
    }
    
    if(![self.customerEmail.text isEqualToString:@"Email"]) {
        
        if([self validateEmail]) {
            
            isValid = YES;
        }
        else {
            
            isValid = NO;
            [self.customerEmail becomeFirstResponder];
            return;
        }
    }
    
    if([self.customerAddress.text length]!=0 && [self.customerCity.text length]==0)
    {
        isValid = NO;
        [self.customerCity becomeFirstResponder];
        return;
    }
    else
        isValid = YES;
    
    UILabel *langText = [[self.chooseLanguage subviews] objectAtIndex:0];
    
    UILabel *typeText = [[self.chooseType subviews] objectAtIndex:0];
    
    if([langText.text isEqualToString:@"Language"]) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[labels valueForKey:@"customer"] message:@"Select customer language" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        
        [alert show];
        
        isValid = NO;
        
        return;
    }

    if([typeText.text isEqualToString:[labels valueForKey:@"customertype"]]) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[labels valueForKey:@"customer"] message:[labels valueForKey:@"selectcustomertype"] delegate:nil cancelButtonTitle:[labels valueForKey:@"ok"] otherButtonTitles:nil, nil];
        
        [alert show];
        
        isValid = NO;
        return;
    }

    
    
    if(isValid) {
        
        if ([customer_name length]==0) {
            [self saveCustomerData];
        } else {
            
            [self saveCustomerEditData];
        }
        
        
    }
   
}

//cancels the current view
-(void) cancelView:(id) sender {
    
    ViewController *vc = [ViewController sharedInstance];
    
    //NSLog(@"view pressed");
    
    if([customer_name length]==0) {
    
        id animation = ^{
        
            self.transform = CGAffineTransformMakeTranslation(320, 0);
            [vc.customerList setViewTitle];
        
        };
    
        id complete = ^(BOOL finished){
        
        
            [self removeFromSuperview];
        };
    
        [UIView animateWithDuration:0.5 animations:animation completion:complete];
    } else {
        
        [self removeFromSuperview];
        
    }
    


}



/*- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    UITextPosition *beginning = [textField beginningOfDocument];
    
    [textField setSelectedTextRange:[textField textRangeFromPosition:beginning toPosition:beginning]];
    
    //textField.placeholder = nil;
    //textField.text = @"";
    
    currentTextField = textField;
}

-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    
    return YES;
}



- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if([textField.text length]==0)
        currentTextField = nil;
}
 
 - (BOOL)textFieldShouldReturn:(UITextField *)textField
 {
 
 [textField resignFirstResponder];
 
 
 
 return YES;
 }
*/

//sets the map location according to the address entered by the customer
-(void) setMapLocation:(UITextField*) textField {
    
    //NSLog(@"entered data");
    if([textField.text length]!=0 && [self.customerCity.text length]!=0) {
        
        
        NSString *address = [self.customerAddress.text stringByReplacingOccurrencesOfString:@" " withString:@""];
 
        NSString *str1 = @"ä";
        NSString *str2 = @"å";
        NSString *str3 = @"ö";
        
        address = [address stringByAppendingString:[NSString stringWithFormat:@",%@",self.customerCity.text]];
        
        
        address = [address stringByReplacingOccurrencesOfString:str1 withString:@"a"];
        address = [address stringByReplacingOccurrencesOfString:str2 withString:@"a"];
        address = [address stringByReplacingOccurrencesOfString:str3 withString:@"o"];
        
        
        //NSLog(@" str %@",address);
        
        
        NSString *str=@"http://maps.googleapis.com/maps/api/geocode/json?address=";
        str = [NSString stringWithFormat:@"%@%@%@",str,address,@"&SE&sensor=false"];
        
        
        //NSLog(@" str %@",str);
        
        
        NSURL *url=[NSURL URLWithString:str];
        NSData *data=[NSData dataWithContentsOfURL:url];
        
        //NSLog(@" str %@",data);
        
        if(data!=nil)
        {
            NSError *error=nil;
            id response=[NSJSONSerialization JSONObjectWithData:data options:
                     NSJSONReadingMutableContainers error:&error];
        
            NSMutableDictionary *jsonContent = [response objectForKey:@"results"];
        
            if([jsonContent valueForKey:@"geometry"] != [NSNull null]) {
            
                NSMutableDictionary *geo = [jsonContent valueForKey:@"geometry"];
            
                NSMutableDictionary *coords = [geo valueForKey:@"location"];
            
                NSString *lat = [coords valueForKey:@"lat"];
                NSString *lng = [coords valueForKey:@"lng"];
            
                //NSLog(@"coords %@,%@",lat,lng);
            
                NSArray *latArray = (NSArray *)lat;
                NSArray *lngArray = (NSArray *)lng;
            
                if([latArray count]!=0 && [lngArray count]!=0)
                {
                    lat = [latArray objectAtIndex:0];
                    lng = [lngArray objectAtIndex:0];
            
                    latitude = [lat floatValue];
                    longitude = [lng floatValue];
            
                    [self reloadMapView];
                }
                else
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[labels valueForKey:@"message"] message:[labels valueForKey:@"lat_lan_error"] delegate:nil cancelButtonTitle:[labels valueForKey:@"ok"] otherButtonTitles:nil, nil];
                    
                    [alert show];
                }
            
            }
        }
        
    }
    
}

//keyboard notifications

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    self.contentSize = CGSizeMake(320.0,1200.0);
    
    //NSLog(@"Entered keybord");
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    /*UIEdgeInsets contentInsets = UIEdgeInsetsZero;
     self.contentInset = contentInsets;
     self.scrollIndicatorInsets = contentInsets;*/
    
    self.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.contentOffset = offset;
    
}

//moves the keyboard accord the textfield

- (void)keyboardWasShown:(NSNotification*)aNotification {
    //NSLog(@"Entered keyboard show");
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    //NSLog(@"size of keyboard %f,%f",kbSize.width,kbSize.height);
    
    offset = self.contentOffset;
    
    CGRect bkgndRect = currentTextField.frame;
    if((bkgndRect.origin.y)>=150.0) {
        //NSLog(@"current frame pos %f,%f,%f,%f",currentTextField.frame.origin.x,currentTextField.frame.origin.y,currentTextField.frame.size.width,currentTextField.frame.size.height);
        
        //bkgndRect.size.height -= kbSize.height;
        //[currentTextField.superview setFrame:bkgndRect];
        [self setContentOffset:CGPointMake(0.0, ((currentTextField.frame.origin.y+currentTextField.frame.size.height+50.0)-kbSize.height)) animated:YES];
    }
    
    /*CGRect viewFrame = self.scrollView.frame;
     viewFrame.size.height -= kbSize.height;
     self.scrollView.frame = viewFrame;
     
     CGRect textFieldRect = [currentTextField frame];
     textFieldRect.origin.y += 10;
     [scrollView setContentOffset:CGPointMake(0.0,textFieldRect.size.height) animated:YES];*/
    
    
    //[self.scrollView scrollRectToVisible:textFieldRect animated:YES];
}

#pragma mark --pickerview delegate functions
-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
}

#pragma mark --validate the email

-(BOOL) validateEmail {
    
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    
    //NSLog(@" text %@,%@,%d",self.customerEmail.text,emailTest,[emailTest evaluateWithObject:self.customerEmail.text]);
    //Valid email address
    if ([emailTest evaluateWithObject:self.customerEmail.text] == YES)
    {
        //NSLog(@"entered");
        return YES;
    }
    else
    {
        //NSLog(@"entered1");
        return NO;
        
    }
    
}

#pragma mark --save customer data to database

-(void) saveCustomerData {
    
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context =
    [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchData = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Customer" inManagedObjectContext:context];
    
    [fetchData setEntity:entity];
    
    NSError *error;
    
    
    ViewController *vc = [ViewController sharedInstance];
    
    NSManagedObject *newContact;
    newContact = [NSEntityDescription
                  insertNewObjectForEntityForName:@"Customer"
                  inManagedObjectContext:context];
    [newContact setValue: self.customerName.text forKey:@"name"];
    [newContact setValue: self.customerEmail.text forKey:@"email"];
    [newContact setValue: self.customerAddress.text forKey:@"address"];
    UILabel *label = [[self.chooseLanguage subviews] objectAtIndex:0];
    
    [newContact setValue: label.text forKey:@"language"];
    
    vc.customerLanguageSelected = label.text;
    
    UILabel *label1 = [[self.chooseType subviews] objectAtIndex:0];
    
    int i=0;
    
    if([label1.text  isEqualToString:[labels valueForKey:@"homecleaning"]]) {
        
        i=1;
    }
    
    if([label1.text  isEqualToString:[labels valueForKey:@"officecleaning"]]) {
        
        i=2;
    }
    
    NSNumber *num = [[NSNumber alloc] initWithInt:i];
    
    //NSLog(@"int value %d",[num intValue]);
    
    [newContact setValue:num forKey:@"type"];
    
    [newContact setValue:self.customerStreet.text forKey:@"street"];
    [newContact setValue:self.customerCity.text forKey:@"city"];
    [newContact setValue:self.customerCountry.text forKey:@"country"];
    [newContact setValue:self.customerCountryCode.text forKey:@"code"];
    [newContact setValue:self.customerPhonenumber.text forKey:@"phone"];
    [newContact setValue:[NSString stringWithFormat:@"%f",latitude] forKey:@"latitude"];
    [newContact setValue:[NSString stringWithFormat:@"%f",longitude] forKey:@"longitude"];
    
    NSNumber *reportSent = [[NSNumber alloc] initWithBool:NO];
    
    [newContact setValue:reportSent forKey:@"customerReportSent"];
    [newContact setValue:reportSent forKey:@"employerReportSent"];
    
    [context save:&error];
    
    NSLog(@"error %@",error.description);
    
    
    [vc.customerList getData];
    [vc.customerList setViewTitle];
    [vc.customerList.customersListView reloadData];
    vc.customerList.customer_view = NULL;
    //[vc.customerList changeType];
    
    self.transform = CGAffineTransformMakeTranslation(0, 0);
    self.transform = CGAffineTransformMakeTranslation(0, 25);
    
    id animation = ^{
        
        self.transform = CGAffineTransformMakeTranslation(320, 0);
        [self.customerName setText:@"Name"];
        [self.customerName setTextColor:[UIColor colorWithRed:0.0 green:191.0/255.0 blue:1.0 alpha:1.0]];
        [self.customerEmail setText:@"Email"];
        [self.customerEmail setTextColor:[UIColor colorWithRed:0.0 green:191.0/255.0 blue:1.0 alpha:1.0]];
        [self.customerAddress setText:@"Address"];
        [self.customerAddress setTextColor:[UIColor colorWithRed:0.0 green:191.0/255.0 blue:1.0 alpha:1.0]];
        
        //[self.customerLanguage setText:@"Language"];
        //[self.customerLanguage setTextColor:[UIColor colorWithRed:0.0 green:191.0/255.0 blue:1.0 alpha:1.0]];
        
    };
    
    

    
    /*for(unsigned long i=[[vc.barView subviews] count]-1;i>=1;i--) {
        
        id viewItem = [[vc.barView subviews] objectAtIndex:i];
        [viewItem removeFromSuperview];
    }
    
    [self removeFromSuperview];*/
    

    
    id complete = ^(BOOL finished){
    
        [self removeFromSuperview];
    };
    
    
    [UIView animateWithDuration:0.5 animations:animation completion:complete];

}

#pragma mark --save edited customer data to database

-(void) saveCustomerEditData {
    
    
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *dataContext =
    [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchData = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Customer" inManagedObjectContext:dataContext];
    
    [fetchData setEntity:entity];
    
    
    
    //NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData error:&error];
    
    NSManagedObject *customerData = nil;
    
    NSPredicate *pred =[NSPredicate predicateWithFormat:@"(name = %@)",customer_name];
    
    [fetchData setPredicate:pred];
    //NSManagedObject *matches = nil;
    
    NSError *error;
    NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData
                                                       error:&error];
    

    
    if([fetchObjects count] !=0) {
        
        for(int i=0;i<[fetchObjects count];i++) {
            
            customerData = [fetchObjects objectAtIndex:i];
            [customerData setValue: self.customerName.text forKey:@"name"];
            [customerData setValue: self.customerEmail.text forKey:@"email"];
            [customerData setValue: self.customerAddress.text forKey:@"address"];
            
            UILabel *label = [[self.chooseLanguage subviews] objectAtIndex:0];
            
            [customerData setValue: label.text forKey:@"language"];
            
            UILabel *label1 = [[self.chooseType subviews] objectAtIndex:0];
            
            int i=0;
            
            //NSLog(@" cleaning type %@",label1.text);
            
            if([label1.text isEqualToString:[labels valueForKey:@"homecleaning"]]) {
                
                i=1;
            }
            
            if([label1.text isEqualToString:[labels valueForKey:@"officecleaning"]]) {
                
                i=2;
            }
            
            //NSLog(@"num %d ",i);
            
            NSNumber *num = [[NSNumber alloc] initWithInt:i];
            
            [customerData setValue:num forKey:@"type"];
            
            [customerData setValue:self.customerStreet.text forKey:@"street"];
            [customerData setValue:self.customerCity.text forKey:@"city"];
            [customerData setValue:self.customerCountry.text forKey:@"country"];
            [customerData setValue:self.customerCountryCode.text forKey:@"code"];
            [customerData setValue:self.customerPhonenumber.text forKey:@"phone"];
            [customerData setValue:[NSString stringWithFormat:@"%f",latitude] forKey:@"latitude"];
            [customerData setValue:[NSString stringWithFormat:@"%f",longitude] forKey:@"longitude"];


            [dataContext save:&error];
            
            NSLog(@"error %@",error.description);
            

        }
    }
    
    id animation = ^{
        
        self.transform = CGAffineTransformMakeTranslation(320, 0);
    };
    
    id complete = ^(BOOL finished) {
        
        [self removeFromSuperview];
        ViewController *vc = [ViewController sharedInstance];
        [vc.customerList getData];
        [vc.customerList.customersListView reloadData];
        [vc.customerList setViewTitle];
 
    };
    
    [UIView animateWithDuration:0.5 animations:animation completion:complete];
    
    
    
}

//gets the customer rooms

-(void) getCustomerRooms {
    
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *dataContext = [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchData = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CustomerRoomsTypes" inManagedObjectContext:dataContext];
    
    [fetchData setEntity:entity];
    
    
    
    
    
    //NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData error:&error];
    
    //NSManagedObject *userData = nil;
    
    //NSLog(@"customer name %@",self.customerName);
    NSPredicate *pred =[NSPredicate predicateWithFormat:@"(customer = %@)",self.customerName];
    
    [fetchData setPredicate:pred];
    //NSManagedObject *matches = nil;
    
    NSError *error;
    NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData
                                                       error:&error];
    
    UILabel *roomType = [[self.chooseType subviews] objectAtIndex:0];
    
    //NSLog(@"room type %@",roomType.text);
    
    ViewController *vc = [ViewController sharedInstance];
    
    
    //NSLog(@"fetch objects count %d",[fetchObjects count]);
    
    if(fetchObjects) {
        //NSLog(@"rooms count %d",(int)[fetchObjects count]);
        if(([fetchObjects count]==0 || [fetchObjects count]==6) && [roomType.text isEqualToString:[labels valueForKey:@"homecleaning"]]) {
            
            [vc.customerList deleteCustomerRooms];
            canChangeType = YES;
            return;
        }
        else if([roomType.text isEqualToString:[labels valueForKey:@"homecleaning"]])
        {
            canChangeType = NO;
            return;
        }
        
        if(([fetchObjects count]==0 || [fetchObjects count]==14) && [roomType.text isEqualToString:[labels valueForKey:@"officecleaning"]]) {
            //NSLog(@"entered office cleaning");
            canChangeType = YES;
            [vc.customerList deleteCustomerRooms];
            return;
        }
        else if([roomType.text isEqualToString:[labels valueForKey:@"officecleaning"]])
        {
            canChangeType = NO;
            return;
        }
        
    }
}

-(void) changeType {
    
    //ViewController *vc = [ViewController sharedInstance];
    
    /*UIColor *color = [[UIColor alloc] init];
    
    if(vc.cleaningType == 1) {
        
        color = [vc.colorArray objectAtIndex:1];
    }
    
    if(vc.cleaningType == 2) {
        
        color = [vc.colorArray objectAtIndex:0];
    }*/
    
    [self.customerName setTextColor:color];
    [self.customerEmail setTextColor:color];
    [self.customerAddress setTextColor:color];
    
    UILabel *label = [[self.chooseLanguage subviews] objectAtIndex:0];
    
    [label setTextColor:color];
    
    UILabel *labelType = [[self.chooseType subviews] objectAtIndex:0];
    
    [labelType setTextColor:color];
    
    [self.saveButton setTitleColor:color forState:UIControlStateNormal];
    
    [self.cancelButton setTitleColor:color forState:UIControlStateNormal];
    
}

#pragma mark--touch events

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if(!languageSearchList.view.isHidden)
       [languageSearchList.view setHidden:YES];
    
    if(!typeSearchList.view.isHidden)
        [typeSearchList.view setHidden:YES];
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
        
        
        [self reloadMapView];
        
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



-(void) dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
