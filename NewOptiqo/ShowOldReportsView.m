//
//  ShowOldReportsView.m
//  NewOptiqo
//
//  Created by Umapathi on 9/15/14.
//  Copyright (c) 2014 Umapathi. All rights reserved.
//

#import "ShowOldReportsView.h"
#import "ViewController.h"
#import "AppDelegate.h"

@implementation ShowOldReportsView
@synthesize customersListView,customersList,customersRoom,reportListView;

//initilization of view
- (id)initWithFrame:(CGRect)frame
{
    self = [super init];
    if (self) {
        // Initialization code
        ViewController *vc = [ViewController sharedInstance];
        
        //self.frame = CGRectMake(0, 50, vc.deviceWidth, vc.deviceHeight);
        
        if([vc.userLanguageSelected isEqualToString:@"Swedish"]) {
            
            labels = [vc.englishLabels valueForKey:@"userswedishlabels"];
        }
        
        if([vc.userLanguageSelected isEqualToString:@"German"]) {
            
            labels = [vc.englishLabels valueForKey:@"usergermanlabels"];
        }
        
        if([vc.userLanguageSelected isEqualToString:@"English"]) {
            
            labels = [vc.englishLabels valueForKey:@"userenglishlabels"];
        }
        
        [self.view setBackgroundColor:[UIColor whiteColor]];
        
        self.customersList = [[NSMutableArray alloc] init];
        self.customersRoom = [[NSMutableArray alloc] init];
        customersTimeDate = [[NSMutableArray alloc] init];
        
        [self getData];
        
        /*self.customersList = [[NSMutableArray alloc] initWithObjects:@"Customer1",
         @"Customer2",@"Customer3",@"Customer4",@"Customer5",@"Customer6",nil];*/
        
        //initialCustomersList = [[NSMutableArray alloc] initWithArray:self.customersList];
        
        
        
        
        color = [[UIColor alloc] init];
        
        if(vc.cleaningType == 1) {
            
            color = [vc.colorArray objectAtIndex:1];
            
        }
        
        if(vc.cleaningType == 2) {
            
            color = [vc.colorArray objectAtIndex:0];
        }
        
        color = [UIColor blackColor];
        font = [UIFont fontWithName:@"Avenir-Medium" size:16.0];
        
        
        

        self.view = [[UIView alloc] initWithFrame:frame];
        
        //shows the report view
        [self showCustomersListView];
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame rightMenu:(BOOL)menu
{
    self = [super init];
    if (self) {
        // Initialization code
        ViewController *vc = [ViewController sharedInstance];
        
        //self.frame = CGRectMake(0, 50, vc.deviceWidth, vc.deviceHeight);
        
        isRightMenu = menu;
        
        if([vc.userLanguageSelected isEqualToString:@"Swedish"]) {
            
            labels = [vc.englishLabels valueForKey:@"userswedishlabels"];
        }
        
        if([vc.userLanguageSelected isEqualToString:@"German"]) {
            
            labels = [vc.englishLabels valueForKey:@"usergermanlabels"];
        }
        
        if([vc.userLanguageSelected isEqualToString:@"English"]) {
            
            labels = [vc.englishLabels valueForKey:@"userenglishlabels"];
        }
        
        [self.view setBackgroundColor:[UIColor whiteColor]];
        
        self.customersList = [[NSMutableArray alloc] init];
        self.customersRoom = [[NSMutableArray alloc] init];
        customersTimeDate = [[NSMutableArray alloc] init];
        
        [self getData];
        
        /*self.customersList = [[NSMutableArray alloc] initWithObjects:@"Customer1",
         @"Customer2",@"Customer3",@"Customer4",@"Customer5",@"Customer6",nil];*/
        
        //initialCustomersList = [[NSMutableArray alloc] initWithArray:self.customersList];
        
        
        
        
        color = [[UIColor alloc] init];
        
        if(vc.cleaningType == 1) {
            
            color = [vc.colorArray objectAtIndex:1];
            
        }
        
        if(vc.cleaningType == 2) {
            
            color = [vc.colorArray objectAtIndex:0];
        }
        
        color = [UIColor blackColor];
        font = [UIFont fontWithName:@"Avenir-Medium" size:16.0];
        
        
        
        
        self.view = [[UIView alloc] initWithFrame:frame];
        
        [self showCustomersListView];
        
    }
    return self;
}

#pragma mark-- back to main view

-(void) backToMainView:(id) sender {
    
    ViewController *vc = [ViewController sharedInstance];
    
    for(unsigned long i=[[vc.startView subviews] count]-1;i>=2;i--) {
        
        id viewItem = [[vc.startView subviews] objectAtIndex:i];
        [viewItem removeFromSuperview];
    }
    
    for(unsigned long i=[[vc.barView subviews] count]-1;i>=1;i--) {
        
        id viewItem = [[vc.barView subviews] objectAtIndex:i];
        [viewItem removeFromSuperview];
    }
    
}

#pragma mark--fetches data from database

-(void) getData {
    
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *dataContext = [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchData = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CustomerRooms" inManagedObjectContext:dataContext];
    
    [fetchData setEntity:entity];
    
    
    //NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData error:&error];
    
    NSManagedObject *userData = nil;
    
    NSNumber *marked = [[NSNumber alloc] initWithBool:YES];
    
    //NSLog(@"customer name %@",customerName);
    NSPredicate *pred =[NSPredicate predicateWithFormat:@"(marked =%@)",marked];
    
    [fetchData setPredicate:pred];
    //NSManagedObject *matches = nil;
    
    NSError *error;
    NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData
                                                       error:&error];
    NSDate *prevDate;
    NSString *prevStrDate;
    
    if(fetchObjects) {
        if([fetchObjects count]!=0) {
            //NSLog(@" records count %d ",(int)[fetchObjects count]);
            for(int i=0;i<[fetchObjects count];i++) {
                userData = [fetchObjects objectAtIndex:i];
                NSNumber *num = [userData valueForKey:@"marked"];
                if([num boolValue]) {
                    //self.content = [[RoomListContent alloc] init];
                    
                    NSString *cust_name = [userData valueForKey:@"customerName"];
                    NSString *cust_room = [userData valueForKey:@"room"];
                    NSDate *cust_timedate = nil;
                    if([userData valueForKey:@"reportSentTime"])
                    {
                        //NSLog(@"entered data");
                        cust_timedate = [userData valueForKey:@"reportSentTime"];
                    
                        NSNumber *count = [userData valueForKey:@"numReportSent"];
                    
                        NSCalendar * mycalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
                    
                        NSCalendarUnit units = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
                    
                        NSDateComponents * myComponents  = [mycalendar components:units fromDate:cust_timedate];

                    
                    
                        NSInteger day;
                    

                    
                    
                        int repotCount;
                    
                        NSString *dateString = [NSDateFormatter localizedStringFromDate:cust_timedate
                                                                          dateStyle:NSDateFormatterShortStyle
                                                                          timeStyle:NSDateFormatterFullStyle];

                    
                    
                        if(i==0) {
                            [self.customersList addObject:cust_name];
                            [customersTimeDate addObject:cust_timedate];
                            prevDate = cust_timedate;
                        
                            prevStrDate = [NSDateFormatter localizedStringFromDate:prevDate
                                                                     dateStyle:NSDateFormatterShortStyle
                                                                     timeStyle:NSDateFormatterFullStyle];

                        
                            day =  myComponents.day;
                            repotCount = [count intValue];
                        
                            //NSLog(@"customer time  %@,%@",dateString,prevStrDate);

                        
                        }
                        else if(/*![customersTimeDate containsObject:cust_timedate] day!=myComponents.day && repotCount !=[count intValue]*/ ![dateString isEqualToString:prevStrDate]) {
                            [self.customersList addObject:cust_name];
                            [customersTimeDate addObject:cust_timedate];
                            day=myComponents.day;
                            repotCount = [count intValue];
                            prevDate = cust_timedate;
                        
                            prevStrDate = [NSDateFormatter localizedStringFromDate:prevDate
                                                                    dateStyle:NSDateFormatterShortStyle
                                                                    timeStyle:NSDateFormatterFullStyle];
                        
                            //NSLog(@"customer time taken %@,%@",dateString,prevStrDate);
                        }
                        
                        [self.customersRoom addObject:cust_room];
                    
                        //NSLog(@"customer time taken %@,%@",dateString,prevStrDate);
                    }
                    //NSLog(@"customer name %d",[self.customersList count]);
                    
                }
            }
        }
        
        if([self.customersRoom count]==0)
        {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[labels valueForKey:@"message"] message:[labels valueForKey:@"noreports"] delegate:self cancelButtonTitle:[labels valueForKey:@"ok"] otherButtonTitles:nil, nil];
            
            [alert show];
        }
    }

}

#pragma --mark alertview delegate function
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    //if clicked ok the start view is shown
    if([title isEqualToString:[labels valueForKey:@"ok"]] && !isRightMenu)
    {
        ViewController *vc = [ViewController sharedInstance];
        
        // NSLog(@"num views %d",[[vc.startView subviews] count]);
        
        for(unsigned long i=[[vc.startView subviews] count]-1;i>=4;i--) {
            
            id viewItem = [[vc.startView subviews] objectAtIndex:i];
            [viewItem removeFromSuperview];
        }
        
        for(unsigned long i=[[vc.barView subviews] count]-1;i>=1;i--) {
            
            id viewItem = [[vc.barView subviews] objectAtIndex:i];
            [viewItem removeFromSuperview];
        }
        
        //[vc drawRightMenuView];
        [vc setViewTitle];
        
        
        
        id animation = ^{
            
            self.view.transform = CGAffineTransformMakeTranslation(320, 0);
            
        };
        
        id complete = ^(BOOL finished){
            
            
            [self removeFromParentViewController];
        };
        
        [UIView animateWithDuration:0.5 animations:animation completion:complete];
        
        
        
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
            
            
        }
        
        vc.toggleMenu = YES;
        
        if(vc.toggleMenu) {
            
            id animation = ^{
                
                
                vc.startView.transform = CGAffineTransformMakeTranslation(vc.deviceWidth*0.75, 0);
                vc.menuView.transform = CGAffineTransformMakeTranslation(0, 0);
            };
            
            [UIView animateWithDuration:0.5 animations:animation];
            
            //[self showMenu:nil];
            
        }
    }
}

//shows the customer list in a table view
-(void) showCustomersListView {
    
    
    ViewController *vc = [ViewController sharedInstance];
    
    backImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, vc.deviceWidth,vc.startView.frame.size.height)];
    
    backImg.image = [UIImage imageNamed:@"view_background.png"];
    
    [self.view addSubview:backImg];
    
    //[self scalefarward];
    
    self.customersListView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, vc.deviceWidth,vc.startView.frame.size.height*0.75) style:UITableViewStyleGrouped];
    
    [self.customersListView setDelegate:self];
    [self.customersListView setDataSource:self];
    
    self.customersListView.allowsMultipleSelection = NO;
    
    [self.customersListView setBackgroundColor:[UIColor clearColor]];
    
    //[self.customersListView.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    //[self.customersListView.layer setBorderWidth:0.5];
    
    
    [self.view addSubview:self.customersListView];
    
    
    cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(50, vc.startView.frame.size.height*0.78, 225, 50)];
    
    [cancelButton.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [cancelButton.layer setBorderWidth:0.5];
    
    [cancelButton setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.5]];
    
    [cancelButton setTitle:[labels valueForKey:@"cancel"] forState:UIControlStateNormal];
    
    [cancelButton setTitleColor:color forState:UIControlStateNormal];
    
    [cancelButton.titleLabel setFont:font];
    
    [cancelButton addTarget:self action:@selector(cancelView:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:cancelButton];


    [self setViewTitle];

    
}

//sets the title of the view
-(void) setViewTitle {
    
    if(!isRightMenu)
    {
        ViewController *vc = [ViewController sharedInstance];
    
        UIImageView *homeImage = [[UIImageView alloc] initWithFrame:CGRectMake(vc.deviceWidth-50, 15, 32, 32)];
    
        homeImage.image = [UIImage imageNamed:@"home.png"];
    
        [homeImage setUserInteractionEnabled:YES];
    
        UITapGestureRecognizer *homeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backToMainView:)];
    
        [homeImage addGestureRecognizer:homeTap];

    
        [vc.barView addSubview:homeImage];
    
        for(unsigned long i=[[vc.barView subviews] count]-1;i>=1;i--) {
        
            id viewItem = [[vc.barView subviews] objectAtIndex:i];
            [viewItem removeFromSuperview];
        }
    
        [vc drawRightMenuView];
        //[vc resetMenuView];
    
        UILabel *cust_label = [[UILabel alloc] initWithFrame:CGRectMake(75, 25, 150, 32)];
    
        [cust_label setBackgroundColor:[UIColor clearColor]];
    
        [cust_label setText:[labels valueForKey:@"reports"]];
        [cust_label setTextColor:[UIColor whiteColor]];
        [cust_label setTextAlignment:NSTextAlignmentCenter];
        [cust_label setFont:[UIFont fontWithName:@"Avenir-Medium"  size:24]];
    
        [vc.barView addSubview:cust_label];
        
        
    }
    else
    {
        ViewController *vc = [ViewController sharedInstance];
        
        //NSLog(@"labels count %ld ",(long)[[vc.barView subviews] count]);
        
        //NSLog(@"customer data %@ ", ((UILabel *)[[vc.barView subviews] objectAtIndex:2]).text);
        
        
        
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
        
        [vc resetMenuView];
        
        /*UIImageView *backImage = (UIImageView *)[[vc.barView subviews] objectAtIndex:0];
        
        backImage.image = [UIImage imageNamed:@"back.png"];
        
        UITapGestureRecognizer *backTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backToCustomerView:)];
        
        [backImage addGestureRecognizer:backTap];*/
        
    }
    
}

//sets the title of the view

-(void) setTitleViewWithLeftMenu
{
    
    [self.reportListView.view removeFromSuperview];
    [self.reportListView removeFromParentViewController];
    
    
    ViewController *vc = [ViewController sharedInstance];
            
    /*UIImageView *homeImage = [[UIImageView alloc] initWithFrame:CGRectMake(vc.deviceWidth-50, 15, 32, 32)];
            
    homeImage.image = [UIImage imageNamed:@"home.png"];
            
    [homeImage setUserInteractionEnabled:YES];
            
    UITapGestureRecognizer *homeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backToMainView:)];
            
    [homeImage addGestureRecognizer:homeTap];
            
            
    [vc.barView addSubview:homeImage];*/
            
    for(unsigned long i=[[vc.barView subviews] count]-1;i>=1;i--) {
                
         id viewItem = [[vc.barView subviews] objectAtIndex:i];
         [viewItem removeFromSuperview];
    }
            
    [vc drawRightMenuView];
    [vc resetMenuView];
            
    UILabel *cust_label = [[UILabel alloc] initWithFrame:CGRectMake(75, 25, 150, 32)];
            
    [cust_label setBackgroundColor:[UIColor clearColor]];
            
    [cust_label setText:[labels valueForKey:@"reports"]];
    [cust_label setTextColor:[UIColor whiteColor]];
    [cust_label setTextAlignment:NSTextAlignmentCenter];
    [cust_label setFont:[UIFont fontWithName:@"Avenir-Medium"  size:24]];
            
    [vc.barView addSubview:cust_label];
            
            
    

}

//goes back to respective previous view.

-(void) backToCustomerView:(id) sender {
    
    id animation = ^{
        
        self.view.transform = CGAffineTransformMakeTranslation(320, 0);
        
    };
    
    id complete = ^(BOOL finished){
        
        //RoomsListView *roomListView = (RoomsListView *)[self superview];
        ViewController *vc = [ViewController sharedInstance];
        
        if([pervCustLabel isEqualToString:@"customerrooms"])
        {
            
            [vc.customerList.roomListView setViewTitle];
            vc.customerList.customer_view = NULL;
        }
        else if([pervCustLabel isEqualToString:@"status"])
        {
            
            [vc.customerList.roomListView.roomComments setViewTitle];
            vc.customerList.customer_view = NULL;
        }
        else if([pervCustLabel isEqualToString:@"addcomments"])
        {
            
            [vc.customerList.roomListView.roomComments.commentsRoom setViewTitle];
            vc.customerList.customer_view = NULL;
        }
        else if([pervCustLabel isEqualToString:@"overview"])
        {
            [vc.customerList.roomListView.roomComments.reportsListView setViewTitle];
            vc.customerList.customer_view = NULL;
        }
        else
        {
            [self.view removeFromSuperview];
            [vc.customerList setViewTitle];
        }
        
        [self.view removeFromSuperview];
    };
    
    [UIView animateWithDuration:0.5 animations:animation completion:complete];
}

#pragma mark--animation background

-(void) scalefarward {
    
    
    
    isforwardScale = YES;
    
    anim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    anim.delegate = self;
    
    anim.fromValue = [NSNumber numberWithFloat:1.0f];
    anim.toValue = [NSNumber numberWithFloat:2.0f];
    anim.duration = 5.5; // Speed
    
    
    anim.removedOnCompletion = NO;
    
    anim.fillMode = kCAFillModeBoth;
    
    [backImg.layer addAnimation:anim forKey:@"scale"];
}


-(void) scalebackward {
    
    isforwardScale = NO;
    anim1 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anim1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    anim1.fromValue = [NSNumber numberWithFloat:2.0f];
    anim1.toValue = [NSNumber numberWithFloat:1.0f];
    anim1.duration = 5.5; // Speed
    anim1.delegate = self;
    
    anim1.removedOnCompletion = NO;
    
    anim1.fillMode = kCAFillModeBoth;
    
    [backImg.layer addAnimation:anim1 forKey:@"scale"];
    
}


-(void) changeType {
    
    
}

-(BOOL) customerFound:(NSString *)string {
    
    return NO;
}

#pragma mark--tableview delegate functions

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //if(tableView == searchDisplayController.searchResultsTableView) {
    
    return [self.customersList count];
    /*}
     else {
     
     return [initialCustomersList count];
     }*/
    
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
    
    
    text = [self.customersList objectAtIndex:indexPath.row];
    NSDate *time_date = [customersTimeDate objectAtIndex:indexPath.row];
    
    NSString *dateString = [NSDateFormatter localizedStringFromDate:time_date
                                                          dateStyle:NSDateFormatterShortStyle
                                                          timeStyle:NSDateFormatterShortStyle];
    
    NSString *dateTime = [NSString stringWithFormat:@"%@",dateString];

    
    NSString *customer_text = [NSString stringWithFormat:@"%ld  %@     %@",(long)(indexPath.row+1),text,dateTime];
    
    [cell setBackgroundColor:[UIColor clearColor]];
    
    [cell.textLabel setText:customer_text];
    [cell.textLabel setTextColor:color];
    [cell.textLabel setFont:font];
    
    return cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int cellHeight = 75;
    
    /*if(tableView == searchDisplayController.searchResultsTableView) {
     
     tableView.rowHeight = cellHeight;
     
     }
     else {
     
     tableView.rowHeight = cellHeight;
     
     }*/
    
    return cellHeight;
    
    
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //self.searchedString = [self.filterList objectAtIndex:indexPath.row];
    
    ViewController *vc = [ViewController sharedInstance];
    
    NSString *str = NULL;
    
    //NSNumber *num = NULL;
    
    //if(tableView == searchDisplayController.searchResultsTableView) {
    
    str = [self.customersList objectAtIndex:indexPath.row];
    
    NSDate *date = [customersTimeDate objectAtIndex:indexPath.row];
    
    /*}
     else {
     
     str = [initialCustomersList objectAtIndex:indexPath.row];
     
     
     }*/
    
    //num = [self.customersType objectAtIndex:indexPath.row];
    
    
    //vc.cleaningType = [num intValue];
    
    /*self.showCustomerView = [[CustomerView alloc] initWithCustomerName:str withFrame:CGRectMake(0, 0,
     vc.deviceWidth, vc.deviceHeight)];
     
     self.showCustomerView.transform = CGAffineTransformMakeTranslation(0, -500);
     
     [self addSubview:showCustomerView];
     
     
     id animation = ^{
     
     self.showCustomerView.transform = CGAffineTransformMakeTranslation(0, 0);
     
     
     };
     
     
     [UIView animateWithDuration:0.25 animations:animation];*/
    
    
    
    
    self.reportListView = [[ReportsListView alloc] initWithFrame:CGRectMake(0, 0, vc.deviceWidth, vc.deviceHeight) withCustomerName:str withRoom:[self.customersRoom objectAtIndex:indexPath.row] showOtherButtons:NO withDate:date];

    
    self.reportListView.view.transform = CGAffineTransformMakeTranslation(vc.deviceWidth, 0);
    
    [self.view addSubview:self.reportListView.view];
    
    id animation = ^{
        
        self.reportListView.view.transform = CGAffineTransformMakeTranslation(0, 0);
        
    };
    
    [UIView animateWithDuration:0.5 animations:animation];
    
    /*self.roomListView = [[RoomsListView alloc] initWithFrame:CGRectMake(0, 0,vc.deviceWidth, vc.deviceHeight) withString:str];
    [self.view addSubview:self.roomListView];*/
    
    [tableView reloadData];
    
}

-(BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return  YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        AppDelegate *appDelegate =
        [[UIApplication sharedApplication] delegate];
        
        
        NSManagedObjectContext *dataContext = [appDelegate managedObjectContext];
        
        NSFetchRequest *fetchData = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"CustomerRooms" inManagedObjectContext:dataContext];
        
        [fetchData setEntity:entity];
        
        NSError *error;
        
        NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData error:&error];
        
        NSManagedObject *userData = nil;
        
        //ViewController *vc = [ViewController sharedInstance];
        
        NSString *text = [self.customersList objectAtIndex:indexPath.row];
        NSDate *time_date = [customersTimeDate objectAtIndex:indexPath.row];
        
        NSString *dateString = [NSDateFormatter localizedStringFromDate:time_date
                                                              dateStyle:NSDateFormatterShortStyle
                                                              timeStyle:NSDateFormatterShortStyle];
        
        NSString *dateTime = [NSString stringWithFormat:@"%@",dateString];
        
        
        
        if(fetchObjects) {
            
            for(int i=0;i<[fetchObjects count];i++)
            {
            
                userData = [fetchObjects objectAtIndex:i];
                
                NSString *cust_name = [userData valueForKey:@"customerName"];
                NSDate *cust_date = [userData valueForKey:@"reportSentTime"];
                
                NSString *date_string = [NSDateFormatter localizedStringFromDate:cust_date
                                                                       dateStyle:NSDateFormatterShortStyle
                                                                       timeStyle:NSDateFormatterShortStyle];
                
                NSString *date_time = [NSString stringWithFormat:@"%@",date_string];
                
                if([cust_name isEqualToString:text] && [date_time isEqualToString:dateTime])
                {
                      //NSLog(@"data delete %@",cust_name);
                      [dataContext deleteObject:userData];
                }
            }
            
            /*for(int i=0;i<[fetchObjects count];i++) {
             userData = [fetchObjects objectAtIndex:i];
             [self.customersList addObject:[userData valueForKey:@"name"]];
             
             NSNumber *num = (NSNumber *) [userData valueForKey:@"type"];
             vc.cleaningType = [num intValue];
             
             [self.customersType addObject:num];
             }*/
            
            NSError *error = nil;
            if (![dataContext save:&error])
            {
                NSLog(@"Error deleting movie, %@", [error userInfo]);
            }
        }
        
        [self.customersList removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [tableView reloadData];
    }
}

- (void)animationDidStart:(CAAnimation *)theAnimation {
    
    
}


- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag {
    
    
    if(isforwardScale) {
        
        [self scalebackward];
    }
    else {
        
        [self scalefarward];
    }
}

//cancels the current view 

-(void) cancelView:(id) sender {
    
    if(!isRightMenu)
    {
        ViewController *vc = [ViewController sharedInstance];
    
        // NSLog(@"num views %d",[[vc.startView subviews] count]);
    
        for(unsigned long i=[[vc.startView subviews] count]-1;i>=4;i--) {
        
            id viewItem = [[vc.startView subviews] objectAtIndex:i];
            [viewItem removeFromSuperview];
        }
    
            for(unsigned long i=[[vc.barView subviews] count]-1;i>=1;i--) {
        
                id viewItem = [[vc.barView subviews] objectAtIndex:i];
                [viewItem removeFromSuperview];
            }
    
        //[vc drawRightMenuView];
        [vc setViewTitle];
    
    
    
        id animation = ^{
        
            self.view.transform = CGAffineTransformMakeTranslation(320, 0);
        
        };
    
        id complete = ^(BOOL finished){
        
        
            [self removeFromParentViewController];
        };
    
        [UIView animateWithDuration:0.5 animations:animation completion:complete];
    }
    else
    {
        [self backToCustomerView:nil];
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
