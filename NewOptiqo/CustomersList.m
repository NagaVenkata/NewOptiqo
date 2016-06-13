//
//  CustomersList.m
//  NewOptiqo
//
//  Created by Umapathi on 8/20/14.
//  Copyright (c) 2014 Umapathi. All rights reserved.
//

#import "CustomersList.h"
#import "ViewController.h"
#import "AppDelegate.h"

@implementation CustomersList
@synthesize customersListView,customersList,addCustomers,customerView,showCustomerView,roomListView,customer_view,editCustomer_view;

//initilalize the view
- (id)initWithFrame:(CGRect)frame
{
    self = [super init];
    if (self) {
        // Initialization code
        
        ViewController *vc = [ViewController sharedInstance];
        
        //self.view.frame = CGRectMake(0, 70, vc.deviceWidth, vc.startView.frame.size.height);
        
        [self.view setBackgroundColor:[UIColor whiteColor]];
        
        UIImageView  *backImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height-140)];
        
        backImg.image = [UIImage imageNamed:@"view_background.png"];
        
        [self.view addSubview:backImg];
        
        font = [UIFont fontWithName:@"Avenir-Medium" size:16];
        
        [self getData];
        
        /*self.customersList = [[NSMutableArray alloc] initWithObjects:@"Customer1",
         @"Customer2",@"Customer3",@"Customer4",@"Customer5",@"Customer6",nil];*/
        
        
        
        
        
        color = [[UIColor alloc] init];
        
        if(vc.cleaningType == 1) {
            
            color = [vc.colorArray objectAtIndex:1];
            
        }
        
        if(vc.cleaningType == 2) {
            
            color = [vc.colorArray objectAtIndex:0];
        }
        
        color = [UIColor blackColor];
        
        //sets the view labels to user selected language
        
        if([vc.userLanguageSelected isEqualToString:@"Swedish"]) {
            
            labels = [vc.englishLabels valueForKey:@"userswedishlabels"];
        }
        
        if([vc.userLanguageSelected isEqualToString:@"German"]) {
            
            labels = [vc.englishLabels valueForKey:@"usergermanlabels"];
        }
        
        if([vc.userLanguageSelected isEqualToString:@"English"]) {
            
            labels = [vc.englishLabels valueForKey:@"userenglishlabels"];
        }
        
        self.view.frame = frame;
        
        [self showCustomersListView];
        
        
        
        //shows the report overview icon on right menu
        [vc.rightmenuView.reportsView setHidden:NO];
        [vc.rightmenuView.oldReports setHidden:NO];
        
        self.customer_view = NULL;
        
        
        /*for(unsigned long i=[[vc.barView subviews] count]-1;i>=1;i--) {
         
         id viewItem = [[vc.barView subviews] objectAtIndex:i];
         [viewItem removeFromSuperview];
         }
         
         [vc drawRightMenuView];
         
         UILabel *cust_label = [[UILabel alloc] initWithFrame:CGRectMake(75, 25, 150, 32)];
         
         [cust_label setBackgroundColor:[UIColor clearColor]];
         
         [cust_label setText:@"Customers"];
         [cust_label setTextColor:[UIColor whiteColor]];
         [cust_label setTextAlignment:NSTextAlignmentCenter];
         [cust_label setFont:[UIFont fontWithName:@"Avenir-Medium"  size:24]];
         
         [vc.barView addSubview:cust_label];
         
         UIImageView *backImage = (UIImageView *)[[vc.barView subviews] objectAtIndex:0];
         
         backImage.image = [UIImage imageNamed:@"back.png"];
         
         UITapGestureRecognizer *backTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backToMainView:)];
         
         [backImage addGestureRecognizer:backTap];*/
        
        //draws view title and labels
        [self setViewTitle];

        
        

    }
    return self;
}

/*-(void) viewDidLoad {

    ViewController *vc = [ViewController sharedInstance];
    
    self.view.frame = CGRectMake(0, 70, vc.deviceWidth, vc.startView.frame.size.height);
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UIImageView  *backImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height)];
    
    backImg.image = [UIImage imageNamed:@"view_background.png"];
    
    [self.view addSubview:backImg];
    
    font = [UIFont fontWithName:@"Avenir-Medium" size:16];
    
    [self getData];
    
     self.customersList = [[NSMutableArray alloc] initWithObjects:@"Customer1",
     @"Customer2",@"Customer3",@"Customer4",@"Customer5",@"Customer6",nil];
    
    initialCustomersList = [[NSMutableArray alloc] initWithArray:self.customersList];
    

    color = [[UIColor alloc] init];
    
    if(vc.cleaningType == 1) {
        
        color = [vc.colorArray objectAtIndex:1];
        
    }
    
    if(vc.cleaningType == 2) {
        
        color = [vc.colorArray objectAtIndex:0];
    }
    
    [self showCustomersListView];
    
    
    for(unsigned long i=[[vc.barView subviews] count]-1;i>=1;i--) {
        
        id viewItem = [[vc.barView subviews] objectAtIndex:i];
        [viewItem removeFromSuperview];
    }
    
    [vc drawRightMenuView];
    
    UILabel *cust_label = [[UILabel alloc] initWithFrame:CGRectMake(75, 25, 150, 32)];
    
    [cust_label setBackgroundColor:[UIColor clearColor]];
    
    [cust_label setText:@"Customers"];
    [cust_label setTextColor:[UIColor whiteColor]];
    [cust_label setTextAlignment:NSTextAlignmentCenter];
    [cust_label setFont:[UIFont fontWithName:@"Avenir-Medium"  size:24]];
    
    [vc.barView addSubview:cust_label];
    
    UIImageView *backImage = (UIImageView *)[[vc.barView subviews] objectAtIndex:0];
    
    backImage.image = [UIImage imageNamed:@"back.png"];
    
    UITapGestureRecognizer *backTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backToMainView:)];
    
    [backImage addGestureRecognizer:backTap];

    [self setViewTitle];
    
}*/

#pragma mark--go back to main view

-(void) backToMainView:(id) sender {
    
    ViewController *vc = [ViewController sharedInstance];
    
    id animation = ^{
        
        self.view.transform = CGAffineTransformMakeTranslation(320, 0);
        

        
        for(unsigned long i=[[vc.barView subviews] count]-1;i>=1;i--) {
            
            id viewItem = [[vc.barView subviews] objectAtIndex:i];
            [viewItem removeFromSuperview];
        }
        
        [vc.rightmenuView.reportsView setHidden:YES];
        [vc.rightmenuView.oldReports setHidden:YES];
        
        

        //if(vc.toggleMenu)
        //vc.toggleMenu = !vc.toggleMenu;
        //[vc drawRightMenuView];
        [vc resetMenuView];
        [vc setViewTitle];
        //vc.customerList = nil;
        
        
    };
    
    id complete = ^(BOOL finished) {
        
        [vc.customerList.view removeFromSuperview];
        [self.view removeFromSuperview];
        [vc.customerList removeFromParentViewController];
        [self removeFromParentViewController];
        //vc.customerList = nil;
    };
    
    [UIView animateWithDuration:0.5 animations:animation completion:complete];
    
}

//gets the customer from the databse Customer table
-(void) getData {
    
    self.customersList = [[NSMutableArray alloc] init];
    self.customersType = [[NSMutableArray alloc] init];
    cutomerLanguage = [[NSMutableArray alloc] init];
    
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *dataContext = [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchData = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Customer" inManagedObjectContext:dataContext];
    
    [fetchData setEntity:entity];
    
    NSError *error;
    
    NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData error:&error];
    
    NSManagedObject *userData = nil;
    

    
    if(fetchObjects) {
        
        for(int i=0;i<[fetchObjects count];i++) {
            userData = [fetchObjects objectAtIndex:i];
            [self.customersList addObject:[userData valueForKey:@"name"]];
            [cutomerLanguage addObject:[userData valueForKey:@"language"]];
            
            NSNumber *num = (NSNumber *) [userData valueForKey:@"type"];
            
            [self.customersType addObject:num];
        }
    }
    
   
    initialCustomersList = [[NSMutableArray alloc] initWithArray:self.customersList];
}

//draws the list of customers
-(void) showCustomersListView {
    
    ViewController *vc = [ViewController sharedInstance];
    

    
    self.customersListView = [[UITableView alloc] initWithFrame:CGRectMake(5, 0, 310, self.view.frame.size.height*0.75) style:UITableViewStyleGrouped];
    
    [self.customersListView setDelegate:self];
    [self.customersListView setDataSource:self];
    
    self.customersListView.allowsMultipleSelection = NO;
    
    [self.customersListView setBackgroundColor:[UIColor clearColor]];
    
    [self.customersListView.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.customersListView.layer setBorderWidth:0.5];
    
    
    [self.view addSubview:self.customersListView];
    
    //view to add a customer
    self.addCustomers = [[UIView alloc] initWithFrame:CGRectMake(5, self.view.frame.size.height*0.78, 310, 50)];
    
    [self.addCustomers setBackgroundColor:[UIColor clearColor]];
    
    [self.addCustomers.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    
    [self.addCustomers.layer setBorderWidth:0.5];
    
    [self.addCustomers setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *customerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addCustomer:)];
    
    [self.addCustomers addGestureRecognizer:customerTap];
    
    
    UILabel *customerText = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 310, 50)];
    
    [customerText setText:[labels valueForKey:@"addcustomers"]];
    [customerText setTextColor:[UIColor blackColor]];
    [customerText setFont:[UIFont fontWithName:@"Avenir-Medium" size:18]];
    
    [self.addCustomers addSubview:customerText];
    
    UIImageView *addIamge = [[UIImageView alloc] initWithFrame:CGRectMake(265, 10, 32, 32)];
    
    addIamge.image = [UIImage imageNamed:@"add.png"];
    
    [addIamge setContentMode:UIViewContentModeScaleAspectFit];
    
    [self.addCustomers addSubview:addIamge];
    
    [self.view addSubview:self.addCustomers];
    
    
    /*searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    
    searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    searchDisplayController.delegate = self;
    searchDisplayController.searchResultsDataSource = self;
    
    
    
    [searchBar setBackgroundColor:[UIColor clearColor]];*/
    //self.customersListView.tableHeaderView = searchBar;
    

    
    /*UIImageView *searchView = [[UIImageView alloc] initWithFrame:CGRectMake(vc.deviceWidth-50, 15, 32, 32)];
    
    searchView.image = [UIImage imageNamed:@"blue_search.png"];
    
    [searchView setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *searchTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showSearchView:)];
    
    [searchView addGestureRecognizer:searchTap];*/
    
    UIView *searchView = [[UIView alloc] initWithFrame:CGRectMake(5, 0, vc.deviceWidth-5, 50)];
    
    [searchView setBackgroundColor:[UIColor clearColor]];
    
    [searchView.layer  setBorderColor:[[UIColor lightGrayColor] CGColor]];
    
    [searchView.layer setBorderWidth:0.5];
    [searchView.layer setCornerRadius:0.5];
    
    //[searchView.layer setShadowOffset:CGSizeMake(-10, 10)];
    //[searchView.layer setShadowRadius:5.0];
    //[searchView.layer setShadowOpacity:0.5];
    
    //[self.view addSubview:searchView];
    
    //adding a search view at top of table view to search for a customer
    self.customersListView.tableHeaderView = searchView;
    
    UITextField *searchField = [[UITextField alloc] initWithFrame:CGRectMake(5, 5, searchView.frame.size.width-75, 40)];
    
    [searchField.layer  setBorderColor:[[UIColor lightGrayColor] CGColor]];
    
    
    [searchField.layer setBorderWidth:0.5];
    [searchField.layer setCornerRadius:5.0];
    
    [searchField setTextColor:color];
    [searchField setFont:font];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
    
    imageView.image = [UIImage imageNamed:@"customer_search.png"];
    
    [imageView setContentMode:UIViewContentModeScaleAspectFit];
    
    [searchField setLeftViewMode:UITextFieldViewModeAlways];
    
    searchField.leftView = imageView;
    
    [searchField setDelegate:self];
    
    searchField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    
    searchField.returnKeyType = UIReturnKeySearch;
    
    [searchView addSubview:searchField];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(searchField.frame.size.width+15, 0, 100, 50)];
    
    [label setText:[labels valueForKey:@"clear"]];
    
    [label setTextColor:color];
    [label setFont:font];
    
    [label setUserInteractionEnabled:YES];
    
    [searchView addSubview:label];
    
    UITapGestureRecognizer *clearTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clearCurrentText:)];
    
    [label addGestureRecognizer:clearTap];
    

    
    //[vc.barView addSubview:searchView];
    
    //[self setViewTitle];
    
}

#pragma mark--set current view title 
-(void) setViewTitle {
    
    ViewController *vc = [ViewController sharedInstance];
    
    for(unsigned long i=[[vc.barView subviews] count]-1;i>=1;i--) {
        
        id viewItem = [[vc.barView subviews] objectAtIndex:i];
        [viewItem removeFromSuperview];
    }
    
    [vc drawRightMenuView];
    
    UILabel *cust_label = [[UILabel alloc] initWithFrame:CGRectMake(85, 25, 150, 32)];
    
    [cust_label setBackgroundColor:[UIColor clearColor]];
    
    [cust_label setText:[labels valueForKey:@"customers"]];
    [cust_label setTextColor:[UIColor whiteColor]];
    [cust_label setTextAlignment:NSTextAlignmentCenter];
    [cust_label setFont:[UIFont fontWithName:@"Avenir-Medium"  size:18]];
    
    [cust_label setTextAlignment:NSTextAlignmentCenter];
    
    [vc.barView addSubview:cust_label];
    
    UIImageView *backImage = (UIImageView *)[[vc.barView subviews] objectAtIndex:0];
    
    backImage.image = [UIImage imageNamed:@"back.png"];
    
    UITapGestureRecognizer *backTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backToMainView:)];
    
    [backImage addGestureRecognizer:backTap];
    
    if(vc.rightmenuView.customerInfoView) {
        
        //NSLog(@"Entered data");
        [vc.rightmenuView.customerInfoView setHidden:YES];
    }
}

#pragma mark--shows a search view
-(void) showSearchView:(id) sender {
    
    ViewController *vc = [ViewController sharedInstance];
    
    UIView *searchView = [[UIView alloc] initWithFrame:CGRectMake(5, 0, vc.deviceWidth-5, 50)];
    
    [searchView setBackgroundColor:[UIColor whiteColor]];
    
    [searchView.layer  setBorderColor:[[UIColor lightGrayColor] CGColor]];
    
    [searchView.layer setBorderWidth:0.5];
    [searchView.layer setCornerRadius:5.0];
    
    /*[searchView.layer setShadowOffset:CGSizeMake(-10, 10)];
    [searchView.layer setShadowRadius:5.0];
    [searchView.layer setShadowOpacity:0.5];*/
    
    //[self.view addSubview:searchView];
    
    self.customersListView.tableHeaderView = searchView;
    
    UITextField *searchField = [[UITextField alloc] initWithFrame:CGRectMake(15, 5, searchView.frame.size.width-100, 40)];
    
    [searchField.layer  setBorderColor:[[UIColor lightGrayColor] CGColor]];
    
    [searchField.layer setBorderWidth:0.5];
    
    [searchField setDelegate:self];
    
    searchField.returnKeyType = UIReturnKeySearch;
    
    [searchView addSubview:searchField];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(searchField.frame.size.width+45, 5, 100, 50)];
    
    [label setText:@"Cancel"];
    
    [label setTextColor:color];
    
    [searchView addSubview:label];
    
    //self.customersListView.tableHeaderView = searchView;
    
    /*id animation = ^{
      
        searchView.transform = CGAffineTransformMakeTranslation(0, 30);
        
    };
    
    [UIView animateWithDuration:0.25 animations:animation];*/
    
}

//shows a view to add the customer
-(void) addCustomer:(id) sender {
    
    //ViewController *vc = [ViewController sharedInstance];
    
    

    if(self.customer_view == NULL) {
        self.customer_view = [[CustomerView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) viewDelegate:self];
    
        [self.view addSubview:self.customer_view];
        
        self.customer_view.customerName.delegate = self;
        [self.customer_view.customerEmail setDelegate:self];
        [self.customer_view.customerAddress setDelegate:self];
        [self.customer_view.customerStreet setDelegate:self];
        [self.customer_view.customerCity setDelegate:self];
        [self.customer_view.customerCountry setDelegate:self];
        [self.customer_view.customerPhonenumber setDelegate:self];
        self.customer_view.customerMapView.delegate = self;
        
        
    }
    
    customer_view.transform = CGAffineTransformMakeTranslation(320, 0);
    
    id animation = ^{

        customer_view.transform = CGAffineTransformMakeTranslation(0,0);
        //customer_view.transform = CGAffineTransformMakeTranslation(0, 25);
        
    };
    
    
    [UIView animateWithDuration:0.5 animations:animation];
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
    cell = [tableView  dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithFrame:CGRectZero];
    }
    
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    
    NSString *text = NULL;
    
    //if(tableView == searchDisplayController.searchResultsTableView) {
    
        text = [self.customersList objectAtIndex:indexPath.row];
    /*}
    else {
        
        text = [initialCustomersList objectAtIndex:indexPath.row];
     
     
    }*/
    
    [cell setBackgroundColor:[UIColor clearColor]];
     
    NSString *customer_text = [NSString stringWithFormat:@"%ld. %@",(long)(indexPath.row+1),text];
    
    [cell.textLabel setText:customer_text];
    [cell.textLabel setTextColor:[UIColor blackColor]];
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
    
    NSNumber *num = NULL;
    
    [self getData];
    
    //if(tableView == searchDisplayController.searchResultsTableView) {
    
    str = [self.customersList objectAtIndex:indexPath.row];
    
    vc.customerLanguageSelected = [cutomerLanguage objectAtIndex:indexPath.row];
    
    //NSLog(@"cust lang %@",vc.customerLanguageSelected);
    
    /*}
    else {
        
        str = [initialCustomersList objectAtIndex:indexPath.row];
        
        
    }*/
    
    //NSLog(@"Entered");
    
    num = [self.customersType objectAtIndex:indexPath.row];
    
    //NSLog(@"Entered cust type %d",[num intValue]);
    
    
    vc.cleaningType = [num intValue];
    
    vc.customerStartTime = [NSDate date];
    
    /*self.showCustomerView = [[CustomerView alloc] initWithCustomerName:str withFrame:CGRectMake(0, 0,
                                                                                                vc.deviceWidth, vc.deviceHeight)];
    
    self.showCustomerView.transform = CGAffineTransformMakeTranslation(0, -500);
    
    [self addSubview:showCustomerView];
    
    
    id animation = ^{
        
        self.showCustomerView.transform = CGAffineTransformMakeTranslation(0, 0);
        
        
    };
    
    
    [UIView animateWithDuration:0.25 animations:animation];*/
    

    
    /*for(unsigned long i=[[vc.barView subviews] count]-3;i>=1;i--) {
        
        id viewItem = [[vc.barView subviews] objectAtIndex:i];
        [viewItem removeFromSuperview];
    }*/
    
    vc.customerName = str;
    
    //NSLog(@"str %@",str);
    
    if(self.roomListView==NULL && [self IsUser_EmployerInfoPresent]) {
        self.roomListView = [[RoomsListView alloc] initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, self.view.frame.size.height) withString:str];
        [self.view addSubview:self.roomListView.view];
    }
    else {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:[labels valueForKey:@"user_employer_information"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    
    self.roomListView.view.transform = CGAffineTransformMakeTranslation(320, 0);
    
    id animation = ^{
        
        self.roomListView.view.transform = CGAffineTransformMakeTranslation(0, 0);
        
    };
    
    [UIView animateWithDuration:0.5 animations:animation];
    
    
    [tableView reloadData];

}

-(BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return  YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        
        NSString *searchItem = [self.customersList objectAtIndex:indexPath.row];
        
        customerName = searchItem;

        
        NSUInteger currentIndex = [initialCustomersList indexOfObjectIdenticalTo:searchItem];
        
        //NSLog(@"data %@,%d,%d",searchItem,indexPath.row,currentIndex);

        
        AppDelegate *appDelegate =
        [[UIApplication sharedApplication] delegate];

        
        NSManagedObjectContext *dataContext = [appDelegate managedObjectContext];
        
        NSFetchRequest *fetchData = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Customer" inManagedObjectContext:dataContext];
        
        [fetchData setEntity:entity];
        
        NSError *error;
        
        NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData error:&error];
        
        NSManagedObject *userData = nil;
        
        //ViewController *vc = [ViewController sharedInstance];
        
        if(fetchObjects) {
            
            userData = [fetchObjects objectAtIndex:currentIndex];
            [dataContext deleteObject:userData];
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
        [initialCustomersList removeObjectAtIndex:currentIndex];
        
        if([self.customersList count]==0) {
            
            self.customersList = [[NSMutableArray alloc] initWithArray:initialCustomersList];
            
            UITextField *searchTextField = (UITextField *)[[self.customersListView.tableHeaderView subviews] objectAtIndex:0];
            [searchTextField setText:@""];
        }
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [tableView reloadData];
        
        [self deleteRoomType];
        [self deleteCustomerRooms];
    }
}



-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewRowAction *editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:[labels valueForKey:@"customer_edit"] handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        
        [self.editCustomer_view removeFromSuperview];
        
        //edit customer information
        
        //NSLog(@"entered edit view option %d",(int)[self.customersList count]);
        
        NSString *searchItem = [self.customersList objectAtIndex:indexPath.row];
        
        customerName = searchItem;

        //NSLog(@"entered edit view option after");
        
        
        self.editCustomer_view = [[CustomerView alloc] initWithEditCustomerName:customerName withFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) viewDelegate:self];
        
        [self.view addSubview:self.editCustomer_view];
        
        [tableView reloadData];
            
        
    }];
    editAction.backgroundColor = [UIColor colorWithRed:0.0 green:180.0/255.0 blue:0.0 alpha:0.95];
    
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:[labels valueForKey:@"delete"]  handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        
            //delete customer
            NSString *searchItem = [self.customersList objectAtIndex:indexPath.row];
        
            customerName = searchItem;
        
        
            NSUInteger currentIndex = [initialCustomersList indexOfObjectIdenticalTo:searchItem];
        
            //NSLog(@"data %@,%d,%d",searchItem,indexPath.row,currentIndex);
        
        
            AppDelegate *appDelegate =
            [[UIApplication sharedApplication] delegate];
        
        
            NSManagedObjectContext *dataContext = [appDelegate managedObjectContext];
        
            NSFetchRequest *fetchData = [[NSFetchRequest alloc] init];
        
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"Customer" inManagedObjectContext:dataContext];
        
            [fetchData setEntity:entity];
        
            NSError *error;
        
            NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData error:&error];
        
            NSManagedObject *userData = nil;
        
            //ViewController *vc = [ViewController sharedInstance];
        
            if(fetchObjects) {
            
                userData = [fetchObjects objectAtIndex:currentIndex];
                [dataContext deleteObject:userData];
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
            [initialCustomersList removeObjectAtIndex:currentIndex];
        
            if([self.customersList count]==0) {
                
                self.customersList = [[NSMutableArray alloc] initWithArray:initialCustomersList];
            
                UITextField *searchTextField = (UITextField *)[[self.customersListView.tableHeaderView subviews] objectAtIndex:0];
                [searchTextField setText:@""];
            }
        
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView reloadData];
        
            [self deleteRoomType];
            [self deleteCustomerRooms];
        }
        
    ];
    
    deleteAction.backgroundColor = [UIColor redColor];
    
    
    return @[deleteAction,editAction];
}


-(void) changeType {
    
    [cell.textLabel setTextColor:color];
    [self.customersListView reloadData];
    
    UILabel *label = [[self.addCustomers subviews] objectAtIndex:0];
    
    [label setTextColor:color];
}

#pragma mark--clear current text in search textfield

-(void) clearCurrentText:(id) sender {
    
    //NSLog(@"current headerview %d",[[self.customersListView.tableHeaderView subviews] count]);
    
    UITextField *searchTextField = (UITextField *) [[self.customersListView.tableHeaderView subviews] objectAtIndex:0];
    if([searchTextField.text length]!=0) {
        
        [searchTextField setText:@""];
        [self customerFound:@""];
    }
    
    [searchTextField resignFirstResponder];
}

#pragma mark--textfield delegate functions

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    UITextPosition *beginning = [textField beginningOfDocument];
    
    if([textField.text length]==0) {
    
        [textField setSelectedTextRange:[textField textRangeFromPosition:beginning toPosition:beginning]];
    }
    
    //textField.placeholder = nil;
    //textField.text = @"";
    
    if(self.customer_view)
        self.customer_view.currentTextField = textField;
    
    
}

-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if(self.customer_view == nil)
        [self customerFound:textField.text];
    return YES;
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    textField = nil;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    //NSLog(@"Entered data");
    
    if(self.customer_view) {
        //NSLog(@"Entered data");
        [self.customer_view setMapLocation:textField];
    }
    
    return YES;
}

//search for a customer in the customer list
-(BOOL) customerFound:(NSString *)string {
    
    //NSLog(@"string %d,%@", [string length],string);
    
    if([string length]>=2) {
        [self.customersList removeAllObjects];
    }
    
    for(int i=0;i<[initialCustomersList count];i++) {
        
        NSString *searchString = [initialCustomersList objectAtIndex:i];
        
        NSRange range = [searchString rangeOfString:string];
        if(range.location!=NSNotFound) {
            [self.customersList addObject:searchString];
        }
    }
    
    if([string length]<=1) {
        
        //NSLog(@"initial count %d",[initialCustomersList count]);
        
        self.customersList = [[NSMutableArray alloc] initWithArray:initialCustomersList];
        
        [self.customersListView reloadData];
        
        return YES;
        
    }
    
    if([self.customersList count]!=0) {
        
        [self.customersListView reloadData];
        return YES;
        
    }
    

    
    
    
    return NO;
}

//reloads the table view
-(BOOL) searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    
    
    if([self.customersList count]>0)
        [self.customersList removeAllObjects];
    
    for(int i=0;i<[initialCustomersList count];i++) {
        
        NSString *currentString = [initialCustomersList objectAtIndex:i];
        
        NSRange range = [currentString rangeOfString:searchString];
        if(range.location!=NSNotFound) {
            [self.customersList addObject:searchString];

        }
    }
    
    
    /*NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", searchString];
    self.customersList = (NSMutableArray *)[initialCustomersList filteredArrayUsingPredicate:resultPredicate];*/
    
    
    return YES;
}

//check user or employer information present if not a alert is shown to add them
-(BOOL) IsUser_EmployerInfoPresent {
    
    
    BOOL isInfoPresent = NO;
    
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *userDataContext = [appDelegate managedObjectContext];
    
    NSFetchRequest *userFetchData = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:userDataContext];
    
    [userFetchData setEntity:entity];
    
    NSError *error;
    
    NSArray *userFetchObjects = [userDataContext executeFetchRequest:userFetchData error:&error];
    

    
    if(userFetchObjects) {
        
        if([userFetchObjects count]!=0) {
            
            isInfoPresent = YES;
        }
        else
            return NO;
        
    }
    
    
    NSManagedObjectContext *employerDataContext = [appDelegate managedObjectContext];
    
    NSFetchRequest *employerFetchData = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *employerEntity = [NSEntityDescription entityForName:@"Employee" inManagedObjectContext:employerDataContext];
    
    [employerFetchData setEntity:employerEntity];
    
    
    NSArray *employerFetchObjects = [employerDataContext executeFetchRequest:employerFetchData error:&error];
    
    
    if(employerFetchObjects) {
        
        if([employerFetchObjects count]!=0) {
            
            isInfoPresent = YES;
        }
        else
            return NO;
    }
    
    return isInfoPresent;
}

//delete the rooms when the customer is deleted

-(void) deleteRoomType {
    
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *dataContext = [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchData = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CustomerRoomsTypes" inManagedObjectContext:dataContext];
    
    [fetchData setEntity:entity];
    
    
    
    //NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData error:&error];
    
    NSManagedObject *userData = nil;
    
    //NSLog(@"customer name in deleteroom %@",customerName);
    NSPredicate *pred =[NSPredicate predicateWithFormat:@"(customer = %@)",customerName];
    
    [fetchData setPredicate:pred];
    //NSManagedObject *matches = nil;
    
    NSError *error;
    NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData
                                                       error:&error];
    
    //NSLog(@"fetch objects count %d",[fetchObjects count]);
    
    if(fetchObjects) {
        if([fetchObjects count]!=0) {
            for(int i=0;i<[fetchObjects count];i++) {
                userData = [fetchObjects objectAtIndex:i];
                [dataContext deleteObject:userData];
            }
            
        }
        
        NSError *error = nil;
        if (![dataContext save:&error])
        {
            NSLog(@"Error deleting movie, %@", [error userInfo]);
        }
    }
}

//delete the customer

-(void) deleteCustomerRooms {
    
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *dataContext = [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchData = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CustomerRooms" inManagedObjectContext:dataContext];
    
    [fetchData setEntity:entity];
    
    
    //NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData error:&error];
    
    NSManagedObject *userData = nil;
    
    //NSLog(@"customer name in delete customer rooms %@",customerName);
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
                [dataContext deleteObject:userData];
            }
        }
    }
    
    error = nil;
    if (![dataContext save:&error])
    {
        NSLog(@"Error deleting movie, %@", [error userInfo]);
    }
}



-(void) dealloc {
    
    self.customersList = nil;
    self.customersListView = nil;
    self.customersType = nil;
    self.addCustomers = nil;
    self.customerView = nil;
    self.showCustomerView = nil;
    self.roomListView = nil;
    self.customer_view = nil;
    
    cell = nil;
    
    color = nil;
    
    font = nil;
    
    initialCustomersList = nil;
    
    
    searchBar = nil;
    searchDisplayController = nil;
    
    customer_view = nil;
    
    cutomerLanguage = nil;
    
    labels = nil;
    
    customerName = nil;
    
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
