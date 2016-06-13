//
//  RoomsListView.m
//  NewOptiqo
//
//  Created by Umapathi on 8/24/14.
//  Copyright (c) 2014 Umapathi. All rights reserved.
//

#import "RoomsListView.h"
#import "ViewController.h"
#import "AppDelegate.h"

@implementation RoomsListView

@synthesize roomsViews,roomsList,addRoomButton,customerName,roomComments,deleteRooms,searchList;

//initialize the view
- (id)initWithFrame:(CGRect)frame
{
    self = [super init];
    if (self) {
        // Initialization code
        
        self.view.frame = frame;
        [self.view setBackgroundColor:[UIColor whiteColor]];
        
        self.roomsList = [[NSMutableArray alloc] init];
        
        ViewController *vc = [ViewController sharedInstance];
        
        
        cleaningType = vc.cleaningType;
        
        //NSLog(@" data %d ",[vc.colorArray count]);
        
        if(vc.cleaningType == 1) {
            
            color = [vc.colorArray objectAtIndex:1];
        }
        
        if(vc.cleaningType == 2) {
            
            color = [vc.colorArray objectAtIndex:0];
        }
        
        color = [UIColor blackColor];
        
        font = [UIFont fontWithName:@"Avenir-Medium" size:16.0];
        
        delete_room = NO;
        
       //sets the labels according to user language
        
        if([vc.userLanguageSelected isEqualToString:@"Swedish"]) {
            
            labels = [vc.englishLabels valueForKey:@"userswedishlabels"];
        }
        
        if([vc.userLanguageSelected isEqualToString:@"German"]) {
            
            labels = [vc.englishLabels valueForKey:@"usergermanlabels"];
        }
        
        if([vc.userLanguageSelected isEqualToString:@"English"]) {
            
            labels = [vc.englishLabels valueForKey:@"userenglishlabels"];
        }
        


        
        //gets data from database
        [self getData];
        
        //add the view contents
        [self addView];
        
        
        vc.currentTime = [NSDate date];
        
        
        
        
        predefinedRoomIndex = [[NSMutableArray alloc] init];
        
        [self addPredefinedHRooms];
        
        
        isSaved = NO;
        
        isAddRoomViewShown = NO;
        
        self.view.userInteractionEnabled = YES;
        
    }
    return self;
}

//initialize the view with customer name
- (id)initWithFrame:(CGRect)frame withString:(NSString *) custName
{
    self = [super init];
    if (self) {
        // Initialization code
        
        self.view.frame = frame;
        [self.view setBackgroundColor:[UIColor whiteColor]];
        
        self.roomsList = [[NSMutableArray alloc] init];
        
        self.customerName = custName;
        
        
        ViewController *vc = [ViewController sharedInstance];
        
        //NSLog(@"cleaning type %d",vc.cleaningType);
        
        cleaningType = vc.cleaningType;
        
        
        
        //NSLog(@"customer name %@,%@",vc.customerList.roomListView.customerName,self.customerName);
        
        //NSLog(@" data %d ",[vc.colorArray count]);
        
        if(vc.cleaningType == 1) {
            
            color = [vc.colorArray objectAtIndex:1];
        }
        
        if(vc.cleaningType == 2) {
            
            color = [vc.colorArray objectAtIndex:0];
        }
        
        color = [UIColor blackColor];
        font = [UIFont fontWithName:@"Avenir-Medium" size:16.0];
        
        delete_room = NO;
        
        //sets the labels according to user language
        
        if([vc.userLanguageSelected isEqualToString:@"Swedish"]) {
            
            labels = [vc.englishLabels valueForKey:@"userswedishlabels"];
            
            //NSLog(@"user sel lang %@",vc.userLanguageSelected);
        }
        
        if([vc.userLanguageSelected isEqualToString:@"German"]) {
            
            labels = [vc.englishLabels valueForKey:@"usergermanlabels"];
        }
        
        if([vc.userLanguageSelected isEqualToString:@"English"]) {
            
            labels = [vc.englishLabels valueForKey:@"userenglishlabels"];
        }

        
        //gets the data from database
        [self getData];
        
        //draws the view contents
        [self addView];
        
        vc.currentTime = [NSDate date];
        
        //adds a seperate list for deleted rooms
        [self getDeleteItemsView];
        
        //NSLog(@"rooms %d",delete_room);
        
        //initialize the array for perdefined rooms
        predefinedRoomIndex = [[NSMutableArray alloc] init];
        
        currentRooms = [[NSMutableArray alloc] initWithArray:self.roomsList];
        
        //adds predefined house cleaning rooms
        if(vc.cleaningType == 1)
            [self addPredefinedHRooms];
        
        //adds predefined office cleaning rooms
        if(vc.cleaningType == 2)
            [self addPredefinedORooms];

        //NSLog(@"customer name %@",vc.customerList.roomListView.customerName);
        
        //shows customer info icon on right menu
        [vc.rightmenuView showCustomer:vc.customerName];
        
        if(vc.rightmenuView.customerInfoView.isHidden) {
            
            [vc.rightmenuView.customerInfoView setHidden:NO];
        }
        
        isSaved = NO;
        
        isAddRoomViewShown = NO;
        
        self.view.userInteractionEnabled = YES;
    }
    return self;
}

//gets data from database
-(void) getData {
    
    
    //ViewController *vc = [ViewController sharedInstance];
    
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *dataContext = [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchData = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CustomerRoomsTypes" inManagedObjectContext:dataContext];
    
    [fetchData setEntity:entity];
    
    
    
    
    
    //NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData error:&error];
    
    NSManagedObject *userData = nil;
    
    //NSLog(@"customer name %@",self.customerName);
    NSPredicate *pred =[NSPredicate predicateWithFormat:@"(customer = %@)",self.customerName];
    
    [fetchData setPredicate:pred];
    //NSManagedObject *matches = nil;
    
    NSError *error;
    NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData
                                                       error:&error];
    
    //NSLog(@"fetch objects count %d",[fetchObjects count]);
    
    if(fetchObjects) {
        if([fetchObjects count]!=0) {
            for(int i=0;i<[fetchObjects count];i++) {
                isSaved = YES;
                userData = [fetchObjects objectAtIndex:i];
                self.customerName = [userData valueForKey:@"customer"];
                NSString *roomname =[userData valueForKey:@"roomtype"];
                
                //NSLog(@"room name,room name %@,%@",roomname,[labels valueForKey:roomname]);
                if(![self.roomsList containsObject:[labels valueForKey:roomname]])
                {
                    if([labels valueForKey:roomname])
                        [self.roomsList addObject:[self getView:[labels valueForKey:roomname]]];
                    else
                        [self.roomsList addObject:[self getView:roomname]];
                }
            }
        }
        else  {
            isSaved = NO;
            [self add_newRoom];
            isSaved = YES;
            
        }

    }
    
    
    
    
    
}

#pragma mark--adds predefine house cleaning rooms
-(void) addPredefinedHRooms {
    
    predefinedRooms = [[NSMutableArray alloc] init];
    
    isSaved = YES;
    
    [predefinedRooms addObject:[self getView:[labels valueForKey:@"livingroom"]]];
    
    [predefinedRooms addObject:[self getView:[labels valueForKey:@"studyroom"]]];
    
    [predefinedRooms addObject:[self getView:[labels valueForKey:@"kitchen"]]];
    
    [predefinedRooms addObject:[self getView:[labels valueForKey:@"bedroom"]]];
    
    [predefinedRooms addObject:[self getView:[labels valueForKey:@"dressingroom"]]];
    
    [predefinedRooms addObject:[self getView:[labels valueForKey:@"toilet"]]];
    
    [predefinedRooms addObject:[self getView:[labels valueForKey:@"washingroom"]]];
    
    
    isSaved = YES;
    
}

#pragma mark--adds predefine office cleaning rooms
-(void) addPredefinedORooms {
    
    predefinedRooms = [[NSMutableArray alloc] init];
    
    isSaved = YES;
    
    
    [predefinedRooms addObject:[self getView:[labels valueForKey:@"reception"]]];
    
    [predefinedRooms addObject:[self getView:[labels valueForKey:@"hallway"]]];
    
    [predefinedRooms addObject:[self getView:[labels valueForKey:@"officeroom"]]];
    
    [predefinedRooms addObject:[self getView:[labels valueForKey:@"grouproom"]]];
    
    [predefinedRooms addObject:[self getView:[labels valueForKey:@"conferenceroom"]]];
    
    [predefinedRooms addObject:[self getView:[labels valueForKey:@"kitchen"]]];
    
    [predefinedRooms addObject:[self getView:[labels valueForKey:@"lift"]]];
    
    [predefinedRooms addObject:[self getView:[labels valueForKey:@"exculator"]]];
    
    [predefinedRooms addObject:[self getView:[labels valueForKey:@"stairs"]]];
    
    [predefinedRooms addObject:[self getView:[labels valueForKey:@"storeroom"]]];
    
    [predefinedRooms addObject:[self getView:[labels valueForKey:@"wherehouse"]]];
    
    [predefinedRooms addObject:[self getView:[labels valueForKey:@"washroom"]]];
    
    [predefinedRooms addObject:[self getView:[labels valueForKey:@"shower"]]];
    
    [predefinedRooms addObject:[self getView:[labels valueForKey:@"toilet"]]];
    
    [predefinedRooms addObject:[self getView:[labels valueForKey:@"wasteroom"]]];
    
    [predefinedRooms addObject:[self getView:[labels valueForKey:@"gym"]]];
    
    [predefinedRooms addObject:[self getView:[labels valueForKey:@"mall"]]];
    
    [predefinedRooms addObject:[self getView:[labels valueForKey:@"parking"]]];
    
    isSaved = YES;
    

    
}

//adds a new rooom
-(void) add_newRoom {
    
    
    //NSLog(@"cleaning type in add view %d",cleaningType);

    if(cleaningType == 1) {
        
        [self.roomsList addObject:[self getView:[labels valueForKey:@"livingroom"]]];
        
        [self.roomsList addObject:[self getView:[labels valueForKey:@"studyroom"]]];
        
        [self.roomsList addObject:[self getView:[labels valueForKey:@"kitchen"]]];
        
        [self.roomsList addObject:[self getView:[labels valueForKey:@"bedroom"]]];
        
        [self.roomsList addObject:[self getView:[labels valueForKey:@"dressingroom"]]];
        
        [self.roomsList addObject:[self getView:[labels valueForKey:@"toilet"]]];
        
        [self.roomsList addObject:[self getView:[labels valueForKey:@"washingroom"]]];
    }
    
    if(cleaningType == 2) {
        
        
        
        [self.roomsList addObject:[self getView:[labels valueForKey:@"reception"]]];
        
        [self.roomsList addObject:[self getView:[labels valueForKey:@"hallway"]]];
        
        [self.roomsList addObject:[self getView:[labels valueForKey:@"officeroom"]]];
        
        [self.roomsList addObject:[self getView:[labels valueForKey:@"grouproom"]]];
        
        [self.roomsList addObject:[self getView:[labels valueForKey:@"conferenceroom"]]];
        
        [self.roomsList addObject:[self getView:[labels valueForKey:@"kitchen"]]];
        
        [self.roomsList addObject:[self getView:[labels valueForKey:@"lift"]]];
        
        [self.roomsList addObject:[self getView:[labels valueForKey:@"exculator"]]];
        
        [self.roomsList addObject:[self getView:[labels valueForKey:@"stairs"]]];
        
        [self.roomsList addObject:[self getView:[labels valueForKey:@"storeroom"]]];
        
        [self.roomsList addObject:[self getView:[labels valueForKey:@"wherehouse"]]];
        
        [self.roomsList addObject:[self getView:[labels valueForKey:@"washroom"]]];
        
        [self.roomsList addObject:[self getView:[labels valueForKey:@"shower"]]];
        
        [self.roomsList addObject:[self getView:[labels valueForKey:@"toilet"]]];
        
        [self.roomsList addObject:[self getView:[labels valueForKey:@"wasteroom"]]];
        
        [self.roomsList addObject:[self getView:[labels valueForKey:@"gym"]]];
        
        [self.roomsList addObject:[self getView:[labels valueForKey:@"mall"]]];
        
        [self.roomsList addObject:[self getView:[labels valueForKey:@"parking"]]];
        
        
    }
    
    //NSLog(@"num rooms list %d",[self.roomsList count]);
}

//shows all the rooms according to room type
-(void) addView {
    
    
    ViewController *vc = [ViewController sharedInstance];
    
    UIImageView  *backImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height)];
    
    backImg.image = [UIImage imageNamed:@"view_background.png"];
    
    [self.view addSubview:backImg];
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    
    self.roomsViews = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:layout];
    
    [self.roomsViews setBackgroundColor:[UIColor clearColor]];
    
    [self.roomsViews setDelegate:self];
    [self.roomsViews setDataSource:self];
    
    [self.roomsViews registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    

    
    [layout setHeaderReferenceSize:CGSizeMake(self.view.frame.size.width, 50)];
    
    [self.roomsViews registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    
    [self.view addSubview:self.roomsViews];
    
    self.addRoomButton = [[UIView alloc] initWithFrame:CGRectMake(50, self.view.frame.size.height*0.8, 200, 50)];
    
    [self.addRoomButton setBackgroundColor:[UIColor whiteColor]];
    [self.addRoomButton.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.addRoomButton.layer setBorderWidth:0.5];
    [self.addRoomButton setUserInteractionEnabled:YES];
    
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 150, 40)];
    [label setText:[labels valueForKey:@"addroom"]];
    [label setFont:[UIFont fontWithName:@"Avenir-Medium" size:18]];
    
    
    if(vc.cleaningType == 1) {
        
        color = [vc.colorArray objectAtIndex:1];
    }
    
    if(vc.cleaningType == 2) {
        
        color = [vc.colorArray objectAtIndex:0];
    }
    
    [label setTextColor:color];
    
    [self.addRoomButton addSubview:label];
   
    UITapGestureRecognizer *addRoomTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addNewRoom:)];
    
    [self.addRoomButton addGestureRecognizer:addRoomTap];
    
    
    //[self addSubview:self.addRoomButton];
    
    [self setViewTitle];
    
    //[self addBackView];
    
    /*UILabel *rooms_label = [[UILabel alloc] initWithFrame:CGRectMake(50, 25, 200, 32)];
    
    [rooms_label setBackgroundColor:[UIColor clearColor]];
    
    [rooms_label setText:@"Rooms"];
    [rooms_label setTextColor:[UIColor whiteColor]];
    [rooms_label setTextAlignment:NSTextAlignmentCenter];
    [rooms_label setFont:[UIFont fontWithName:@"Avanir-Roman"  size:24]];
    
    [vc.barView addSubview:rooms_label];
    
    
    UIImageView *backImage = (UIImageView *)[[vc.barView subviews] objectAtIndex:0];
    
    backImage.image = [UIImage imageNamed:@"back.png"];
    
    UITapGestureRecognizer *backTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backToCustomerView:)];
    
    [backImage addGestureRecognizer:backTap];*/

    
}

-(void) setViewTitle {
    
    
    ViewController *vc = [ViewController sharedInstance];
    
    for(unsigned long i=[[vc.barView subviews] count]-1;i>=1;i--) {
        
        id viewItem = [[vc.barView subviews] objectAtIndex:i];
        [viewItem removeFromSuperview];
    }
    
    [vc drawRightMenuView];
    [vc.rightmenuView showCustomer:@""];
    
    cust_label = [[UILabel alloc] initWithFrame:CGRectMake(85, 25, 150, 32)];
    
    [cust_label setBackgroundColor:[UIColor clearColor]];
    
    [cust_label setText:[labels valueForKey:@"customerrooms"]];
    [cust_label setTextColor:[UIColor whiteColor]];
    [cust_label setTextAlignment:NSTextAlignmentCenter];
    [cust_label setFont:[UIFont fontWithName:@"Avenir-Medium" size:18]];
    
    [cust_label setTextAlignment:NSTextAlignmentCenter];
    
    [vc.barView addSubview:cust_label];
    
    UIImageView *backImage = (UIImageView *)[[vc.barView subviews] objectAtIndex:0];
    
    backImage.image = [UIImage imageNamed:@"back.png"];
    
    UITapGestureRecognizer *backTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backToCustomerView:)];
    
    [backImage addGestureRecognizer:backTap];
    
     //NSLog(@"entered data set view");
    
    if(vc.rightmenuView.customerInfoView.isHidden) {
        
        [vc.rightmenuView.customerInfoView setHidden:NO];
    }

    
}


//adds views to go back to previous views from add new room
-(void) addBackView {
    
    ViewController *vc = [ViewController sharedInstance];
    
    UIImageView *backView = [[UIImageView alloc] initWithFrame:CGRectMake(vc.deviceWidth-75, 15, 32, 32)];
    
    backView.image = [UIImage imageNamed:@"back.png"];
    
    [backView setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *backTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backToCustomerView:)];
    
    [backView addGestureRecognizer:backTap];
    
    [vc.barView addSubview:backView];
    
    
    UIImageView *deleteView = [[UIImageView alloc] initWithFrame:CGRectMake(vc.deviceWidth-125, 15, 32, 32)];
    
    deleteView.image = [UIImage imageNamed:@"delete.png"];
    
    [deleteView setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *deleteTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deleteRooms:)];
    
    [deleteView addGestureRecognizer:deleteTap];
    
    [vc.barView addSubview:deleteView];
    
    
}

//goes back to customer view
-(void) backToCustomerView:(id) sender {
    
    
    if(!isAddRoomViewShown) {
        ViewController *vc = [ViewController sharedInstance];
        
        [vc.customerList setViewTitle];
        
        
        id animation = ^{
            
            self.view.transform = CGAffineTransformMakeTranslation(320, 0);
            
        };
        
        id completion = ^(BOOL finshed) {
            
            
            [self removeFromParentViewController];
            vc.customerList.roomListView = NULL;
            
        };
        
        
        [UIView animateWithDuration:0.5 animations:animation completion:completion];
    

    
        
    }
    else {
        
        
        [self.roomsViews setHidden:NO];
        [self setViewTitle];
        
        id animation = ^{
            
            addNewRoomsView.transform = CGAffineTransformMakeTranslation(320, 0);
            
        };
        
        id completion = ^(BOOL finshed) {
            
            
            [addNewRoomsView removeFromSuperview];
            
            isAddRoomViewShown = NO;
            
            addNewRoomsView = nil;
            
            [cust_label setText:[labels valueForKey:@"customerrooms"]];
            
            isRoomListShow = NO;
            
        };
        
        
        [UIView animateWithDuration:0.5 animations:animation completion:completion];
    }
}

//delete a specific room
-(void) deleteRooms:(id) sender {
    
    
    
    delete_room  = !delete_room;
    
    
    
    if(!delete_room) {
        
        [self.roomsList removeAllObjects];
        
        self.roomsList = [[NSMutableArray alloc] initWithArray:currentRooms copyItems:NO];
        
        [self.roomsViews reloadInputViews];
        
        //self.roomsList = [[NSMutableArray alloc] initWithArray:currentRooms];
        /*for(int i=0;i<[deleteRooms count]; i++) {
            
            UIView *deleteViewRoom = [deleteRooms objectAtIndex:i];
            [deleteViewRoom setHidden:YES];
            
        }
        
        for(int i=0;i<[self.roomsList count]; i++) {
            
            UIView *currViewRoom = [self.roomsList objectAtIndex:i];
            [currViewRoom setHidden:NO];
            
        }*/
        
        

    }
    
    [self.roomsViews reloadData];
    
    if(delete_room) {
        
        [self.roomsList removeAllObjects];
        self.roomsList = [[NSMutableArray alloc] initWithArray:deleteRooms];
        
        /*for(int i=0;i<[deleteRooms count]; i++) {
            
            UIView *deleteViewRoom = [deleteRooms objectAtIndex:i];
            [deleteViewRoom setHidden:NO];
            
        }
        
        for(int i=0;i<[self.roomsList count]; i++) {
            
            UIView *currViewRoom = [self.roomsList objectAtIndex:i];
            [currViewRoom setHidden:YES];
            
        }*/
    }
    
    //[self.roomsViews reloadItemsAtIndexPaths:[self.roomsViews indexPathsForVisibleItems]];
    
    [self.roomsViews reloadData];
    
    

}

//refresh the rooms view list
-(void) refreshRooms {
    
    
    if(!delete_room) {
        
        for(int i=0;i<[deleteRooms count]; i++) {
            
            UIView *deleteViewRoom = [deleteRooms objectAtIndex:i];
            [deleteViewRoom setHidden:YES];
            
        }
        
        for(int i=0;i<[self.roomsList count]; i++) {
            
            UIView *currViewRoom = [self.roomsList objectAtIndex:i];
            [currViewRoom setHidden:NO];
            
        }
        
        
        
    }
    
    if(delete_room) {
        
        for(int i=0;i<[deleteRooms count]; i++) {
            
            UIView *deleteViewRoom = [deleteRooms objectAtIndex:i];
            [deleteViewRoom setHidden:NO];
            
        }
        
        for(int i=0;i<[self.roomsList count]; i++) {
            
            UIView *currViewRoom = [self.roomsList objectAtIndex:i];
            [currViewRoom setHidden:YES];
            
        }
    }
    
    //[self.roomsViews reloadItemsAtIndexPaths:[self.roomsViews indexPathsForVisibleItems]];
    
    [self.roomsViews reloadData];
    
}

//delete current room and update to database
-(void) deleteCurrentRoom:(int)room_num {
    
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *dataContext = [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchData = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CustomerRooms" inManagedObjectContext:dataContext];
    
    [fetchData setEntity:entity];
    
    
    
    //NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData error:&error];
    
    NSManagedObject *userData = nil;
    
    //NSLog(@"customer name %@",self.customerName);
    NSPredicate *pred =[NSPredicate predicateWithFormat:@"(customerName = %@)",self.customerName];
    
    [fetchData setPredicate:pred];
    //NSManagedObject *matches = nil;
    
    NSError *error;
    NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData
                                                       error:&error];
    
    if(fetchObjects) {
        if([fetchObjects count]!=0) {
            userData = [fetchObjects objectAtIndex:room_num];
            [dataContext deleteObject:userData];
            
            NSError *error;
            [dataContext save:&error];
       }
    }
}

#pragma mark--add a new room view

-(void) addNewRoom:(id) sender {
    
    
    ViewController *vc = [ViewController sharedInstance];
    
    delete_room = NO;
    
    isAddRoomViewShown = YES;
    
    UIFont *addRoomFont = [UIFont fontWithName:@"Avenir-Medium" size:16.0];
    
    //[self.roomsViews setHidden:YES];
    
    for(unsigned long i=[[vc.barView subviews] count]-1;i>=1;i--) {
        
        id viewItem = [[vc.barView subviews] objectAtIndex:i];
        [viewItem removeFromSuperview];
    }
    
    [vc drawRightMenuView];
    
    addNewRoomsView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width,self.view.frame.size.height)];
    
    [addNewRoomsView setBackgroundColor:[UIColor clearColor]];
    
    UIImageView  *backImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height)];
    
    backImg.image = [UIImage imageNamed:@"view_background.png"];
    
    [addNewRoomsView addSubview:backImg];
    
    [addNewRoomsView setUserInteractionEnabled:YES];
    
    
    UILabel *addRoomLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 25, vc.deviceWidth-100, 20)];
    
    [addRoomLabel setText:[labels valueForKey:@"new_room"]];
    [addRoomLabel setTextColor:color];
    [addRoomLabel setFont:addRoomFont];
    [addNewRoomsView addSubview:addRoomLabel];

    
    UITextField *addTextField = [[UITextField alloc] initWithFrame:CGRectMake(50, 50, 225, 50)];
    [addTextField setLeftViewMode:UITextFieldViewModeAlways];
    addTextField.leftView = [self getImage];
    //[addTextField setText:@"Add Room"];
    [addTextField setDelegate:self];
    //[addTextField setTextAlignment:NSTextAlignmentCenter];
    [addTextField setTextColor:color];
    [addTextField.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [addTextField.layer setBorderWidth:0.5];
    
    [addNewRoomsView addSubview:addTextField];
    
    //if any standrard rooms are deleted those are added to this list to add back to in rooms view
    predefineRooms = [[UIView alloc] initWithFrame:(CGRectMake(50,125,225,50))];
    
    [predefineRooms setBackgroundColor:[UIColor lightTextColor]];
    [predefineRooms.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [predefineRooms.layer setBorderWidth:0.5];
    
    [predefineRooms setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *roomsTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(select_room:)];
    
    [predefineRooms addGestureRecognizer:roomsTap];
    
    [addNewRoomsView addSubview:predefineRooms];
    
    NSMutableArray *cust_labels = [[NSMutableArray alloc] init];
    
    //NSLog(@"customer data %ld",(long)[self.roomsList count]);
    
    for(int i=0;i<[self.roomsList count];i++) {
        
        
        NSString *label = ((UILabel *)[[[self.roomsList objectAtIndex:i] subviews] objectAtIndex:1]).text;
        
        [cust_labels addObject:label];
        
    }

    [predefinedRoomIndex removeAllObjects];
    
    if(vc.cleaningType == 1)
    {
        

    
        if([cust_labels indexOfObject:[labels valueForKey:@"livingroom"]]==NSNotFound)
            [predefinedRoomIndex  addObject:[predefinedRooms objectAtIndex:0]];
    
        if([cust_labels indexOfObject:[labels valueForKey:@"studyroom"]]==NSNotFound)
            [predefinedRoomIndex  addObject:[predefinedRooms objectAtIndex:1]];
        
        if([cust_labels indexOfObject:[labels valueForKey:@"kitchen"]]==NSNotFound)
            [predefinedRoomIndex  addObject:[predefinedRooms objectAtIndex:2]];

    
        if([cust_labels indexOfObject:[labels valueForKey:@"bedroom"]]==NSNotFound)
            [predefinedRoomIndex  addObject:[predefinedRooms objectAtIndex:3]];
    
        if([cust_labels indexOfObject:[labels valueForKey:@"dressingroom"]]==NSNotFound)
            [predefinedRoomIndex  addObject:[predefinedRooms objectAtIndex:4]];
        
    
        if([cust_labels indexOfObject:[labels valueForKey:@"toilet"]]==NSNotFound)
            [predefinedRoomIndex  addObject:[predefinedRooms objectAtIndex:5]];
    
        if([cust_labels indexOfObject:[labels valueForKey:@"washingroom"]]==NSNotFound)
            [predefinedRoomIndex  addObject:[predefinedRooms objectAtIndex:6]];
    }
    
    
    if(vc.cleaningType == 2)
    {
        

        
        if([cust_labels indexOfObject:[labels valueForKey:@"reception"]]==NSNotFound)
            [predefinedRoomIndex  addObject:[predefinedRooms objectAtIndex:0]];
        
        if([cust_labels indexOfObject:[labels valueForKey:@"hallway"]]==NSNotFound)
            [predefinedRoomIndex  addObject:[predefinedRooms objectAtIndex:1]];
        
        if([cust_labels indexOfObject:[labels valueForKey:@"officeroom"]]==NSNotFound)
            [predefinedRoomIndex  addObject:[predefinedRooms objectAtIndex:2]];
        
        
        if([cust_labels indexOfObject:[labels valueForKey:@"grouproom"]]==NSNotFound)
            [predefinedRoomIndex  addObject:[predefinedRooms objectAtIndex:3]];
        
        if([cust_labels indexOfObject:[labels valueForKey:@"conferenceroom"]]==NSNotFound)
            [predefinedRoomIndex  addObject:[predefinedRooms objectAtIndex:4]];
        
        
        if([cust_labels indexOfObject:[labels valueForKey:@"kitchen"]]==NSNotFound)
            [predefinedRoomIndex  addObject:[predefinedRooms objectAtIndex:5]];
        
        
        if([cust_labels indexOfObject:[labels valueForKey:@"lift"]]==NSNotFound)
            [predefinedRoomIndex  addObject:[predefinedRooms objectAtIndex:6]];
        
        if([cust_labels indexOfObject:[labels valueForKey:@"exculator"]]==NSNotFound)
            [predefinedRoomIndex  addObject:[predefinedRooms objectAtIndex:7]];
        
        if([cust_labels indexOfObject:[labels valueForKey:@"stairs"]]==NSNotFound)
            [predefinedRoomIndex  addObject:[predefinedRooms objectAtIndex:8]];
        
        if([cust_labels indexOfObject:[labels valueForKey:@"storeroom"]]==NSNotFound)
            [predefinedRoomIndex  addObject:[predefinedRooms objectAtIndex:9]];
        
        if([cust_labels indexOfObject:[labels valueForKey:@"wherehouse"]]==NSNotFound)
            [predefinedRoomIndex  addObject:[predefinedRooms objectAtIndex:10]];
        
        if([cust_labels indexOfObject:[labels valueForKey:@"washroom"]]==NSNotFound)
            [predefinedRoomIndex  addObject:[predefinedRooms objectAtIndex:11]];
        
        if([cust_labels indexOfObject:[labels valueForKey:@"shower"]]==NSNotFound)
            [predefinedRoomIndex  addObject:[predefinedRooms objectAtIndex:12]];
        
        if([cust_labels indexOfObject:[labels valueForKey:@"toilet"]]==NSNotFound)
            [predefinedRoomIndex  addObject:[predefinedRooms objectAtIndex:13]];
        
        if([cust_labels indexOfObject:[labels valueForKey:@"wasteroom"]]==NSNotFound)
            [predefinedRoomIndex  addObject:[predefinedRooms objectAtIndex:14]];
        
        if([cust_labels indexOfObject:[labels valueForKey:@"gym"]]==NSNotFound)
            [predefinedRoomIndex  addObject:[predefinedRooms objectAtIndex:15]];
        
        if([cust_labels indexOfObject:[labels valueForKey:@"mall"]]==NSNotFound)
            [predefinedRoomIndex  addObject:[predefinedRooms objectAtIndex:16]];
        
        if([cust_labels indexOfObject:[labels valueForKey:@"parking"]]==NSNotFound)
            [predefinedRoomIndex  addObject:[predefinedRooms objectAtIndex:17]];
        
    }

    
    /*for(int i=0;i<[self.roomsList count];i++) {
        
        UIView *roomview = (UIView *)[self.roomsList objectAtIndex:i];
        
        NSString *label = ((UILabel *)[[roomview subviews] objectAtIndex:1]).text;
        
        if(![label isEqualToString:@"Living Room"] && i==0) {
    
            [predefinedRoomIndex  addObject:[predefinedRooms objectAtIndex:0]];
        }
        
        if(![label isEqualToString:@"Study Room"] && i==1) {
            
            [predefinedRoomIndex  addObject:[predefinedRooms objectAtIndex:1]];
        }
        
        if(![label isEqualToString:@"Bed Room"] && i==2) {
            
            [predefinedRoomIndex  addObject:[predefinedRooms objectAtIndex:2]];
        }
        
        if(![label isEqualToString:@"Dressing Room"] && i==3) {
            
            [predefinedRoomIndex  addObject:[predefinedRooms objectAtIndex:3]];
        }
        
        if(![label isEqualToString:@"Toilet"] && i==4) {
            
            [predefinedRoomIndex  addObject:[predefinedRooms objectAtIndex:4]];
        }
        
        if(![label isEqualToString:@"Washing Room"] && i==5) {
            
            [predefinedRoomIndex  addObject:[predefinedRooms objectAtIndex:5]];
        }
    }*/
    
    
    
    /*if([self.roomsList count]==0) {
        
        for(int i=0;i<[predefinedRooms count];i++) {
            
            [predefinedRoomIndex  addObject:[predefinedRooms objectAtIndex:i]];
        }
    }*/
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 225, 45)];
    
    //standard rooms
    [label setText:[labels valueForKey:@"defaultrooms"]];
    
    [label setTextAlignment:NSTextAlignmentCenter];
    
    [label setTextColor:color];
    
    [label setFont:addRoomFont];
    
    [predefineRooms addSubview:label];
    
    
    UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(50, 200, 225, 50)];
    [addButton setTitle:[labels valueForKey:@"add"] forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addButton.titleLabel setFont:addRoomFont];
    [addButton setBackgroundColor:[UIColor colorWithRed:0.0 green:180.0/255.0 blue:0.0 alpha:0.95]];
    
    
    [addButton.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [addButton.layer setBorderWidth:0.5];
    
    [addButton addTarget:self action:@selector(newRoom:) forControlEvents:UIControlEventTouchUpInside];
    
    [addNewRoomsView addSubview:addButton];
    

    UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(175, 200, 100, 50)];
    [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelButton setTitleColor:color forState:UIControlStateNormal];
    
    [cancelButton.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [cancelButton.layer setBorderWidth:0.5];
    
    [cancelButton addTarget:self action:@selector(cancelRoom:) forControlEvents:UIControlEventTouchUpInside];
    
    //[addNewRoomsView addSubview:cancelButton];
    
    cust_label = [[UILabel alloc] initWithFrame:CGRectMake(85, 25, 150, 32)];
    
    [cust_label setBackgroundColor:[UIColor clearColor]];
    
    [cust_label setText:[labels valueForKey:@"addroom"]];
    [cust_label setTextColor:[UIColor whiteColor]];
    [cust_label setTextAlignment:NSTextAlignmentCenter];
    [cust_label setFont:[UIFont fontWithName:@"Avenir-Medium" size:18]];
    
    [vc.barView addSubview:cust_label];

    
    addNewRoomsView.transform = CGAffineTransformMakeTranslation(320, 0);
    
    [self.view addSubview:addNewRoomsView];
    
    id animation = ^{
        
        addNewRoomsView.transform = CGAffineTransformMakeTranslation(0, 0);
        
    };


    [UIView animateWithDuration:0.5 animations:animation];


    


}

#pragma mark--add new rooms functions

-(void) newRoom:(id) sender {
    
    //NSLog(@" super views %d",[[[sender superview] subviews] count]);
    
    UITextField *text = [[[sender superview] subviews] objectAtIndex:2];
    
    //NSLog(@"perdefine room index %d,%d",[predefinedRoomIndex count],[text.text length]);
    
    [self.roomsViews setHidden:NO];
    
    if([text.text length]!=0 /*&& [predefinedRoomIndex count]==0*/) {
        //NSLog(@" added  room name %@",text.text);
        isSaved = NO;
        [self.roomsList addObject:[self getView:text.text]];
        isSaved = YES;
        [currentRooms addObject:[self getView:text.text]];
        [self getDeleteItemsView];
        [self.roomsViews reloadData];
        isSaved = YES;
        UIView *senderView = [sender superview];
        
        
        id animation = ^{
            
            senderView.transform = CGAffineTransformMakeTranslation(320, 0);
            
        };
        
        
        [UIView animateWithDuration:0.5 animations:animation];
        
        [senderView removeFromSuperview];
    }
    
    if([predefinedRoomIndex count]!=0) {
        isSaved = NO;
        
        UILabel *label = [[predefineRooms subviews] objectAtIndex:0];
        
        for(int i=0;i<[predefinedRoomIndex count];i++) {
            
            UIView *room_view = [predefinedRoomIndex objectAtIndex:i];
           
            
            UILabel *roomLabel = [[room_view subviews] objectAtIndex:1];
            
            //NSLog(@"rooms count before %d",[self.roomsList count]);
            
            if([roomLabel.text isEqualToString:label.text]) {
                
                //[self.roomsViews reloadItemsAtIndexPaths:[self.roomsViews indexPathsForVisibleItems]];
                
                [predefinedRoomIndex removeObjectAtIndex:i];
                
                
                [self.roomsViews reloadData];
                
                [self.roomsList addObject:[self getView:label.text]];
                isSaved = YES;
                [currentRooms addObject:[self getView:label.text]];
                [self getDeleteItemsView];
                
                [self.roomsViews reloadData];
                
                //NSLog(@"rooms count after %d",[self.roomsList count]);
                
                break;
            }
        }
        
        
        
        isSaved = YES;
        UIView *senderView = [sender superview];
        
        id animation = ^{
            
            senderView.transform = CGAffineTransformMakeTranslation(320, 0);
            
        };
        
        id complete = ^{
        
            [senderView removeFromSuperview];
            
            [self.roomsViews reloadData];
            
            //[self.roomsViews reloadItemsAtIndexPaths:[self.roomsViews indexPathsForVisibleItems]];
            
            //[self.roomsViews reloadData];
        };
        
        [UIView animateWithDuration:0.5 animations:animation completion:complete];
        
        
        
    }
    
    //[self addBackView];
    

    
    
}

//select a room
-(void) select_room:(id) sender {
    
    
    //NSLog(@"entered data %d",[predefinedRoomIndex count]);
    
    isRoomListShow = !isRoomListShow;
    
    if([predefinedRoomIndex count]!=0) {
        
        NSMutableArray *types = [[NSMutableArray alloc] init];
        
        for(int i=0;i<[predefinedRoomIndex count];i++) {
        
            UIView *roomView = [predefinedRoomIndex objectAtIndex:i];
            
            UILabel *label = [[roomView subviews] objectAtIndex:1];
            
            [types addObject:label.text];
        }
        
        
        
        //NSLog(@" rooms view show %d ",isRoomListShow);
    
        if(!self.searchList && isRoomListShow)
        {
            self.searchList = [[SearchList alloc] initWithFrame:CGRectMake(predefineRooms.frame.origin.x, predefineRooms.frame.origin.y+predefineRooms.frame.size.height, predefineRooms.frame.size.width, 100) withArray:types];
    
            [self.searchList.view.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    
            [self.searchList.view.layer setBorderWidth:0.5];
    
            [self.searchList setDelegate:self];
        
        
    
            [[predefineRooms superview] addSubview:self.searchList.view];
            
            
        }

    }
    else
    {
        [self.searchList.view removeFromSuperview];
        [self.searchList removeFromParentViewController];
        self.searchList = nil;
        //isRoomListShow = NO;
    }
}


//cancel a room
-(void) cancelRoom:(id) sender {
    
    UIView *senderView = [sender superview];
    
    isAddRoomViewShown = NO;
    
    [self.roomsViews setHidden:NO];
    
    id animation = ^{
        
        senderView.transform = CGAffineTransformMakeTranslation(320, 0);
        
    };
    
    id completion = ^(BOOL finshed) {
        

        [senderView removeFromSuperview];
        
    };
    
    
    [UIView animateWithDuration:0.5 animations:animation completion:completion];
    

    
    //[self addBackView];
}

#pragma mark--searchlist delegate function

-(void) getSelectedString:(NSString *)searchString {
    
    UILabel *label = [[predefineRooms subviews] objectAtIndex:0];
    
    [label setText:searchString];
    
    [label setTextColor:color];
    
    [self.searchList.view removeFromSuperview];
    [self.searchList removeFromParentViewController];
    self.searchList = nil;
    
    isRoomListShow = NO;
}

//returns a view according to roomlabel
-(UIView *) getView:(NSString *)roomLabel {
    
    //NSLog(@"entered data %@",roomLabel);
    
    ViewController *vc = [ViewController sharedInstance];
    
    UIView *roomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
    [roomView setBackgroundColor:[UIColor clearColor]];
    //roomView.layer.cornerRadius = 75.0;
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(25, 5, 100, 100)];
    //[imgView.layer setCornerRadius:50.0];
    //imgView.layer.masksToBounds = YES;
    
    imgView.image = NULL;
    
    //stores room type key
    NSString *roomTypeKey;
    
    if(vc.cleaningType == 1) {
        
        //NSLog(@"room label %@,%@",roomLabel,[labels valueForKey:@"livingroom"]);
        if([roomLabel isEqualToString:[labels valueForKey:@"livingroom"]]) {
            imgView.image = [UIImage imageNamed:@"living_room.png"];
            //NSLog(@"living room label %@,%@",roomLabel,[labels valueForKey:@"livingroom"]);
            
            roomTypeKey = @"livingroom";
        }
        else if([roomLabel isEqualToString:[labels valueForKey:@"studyroom"]])
        {
            imgView.image = [UIImage imageNamed:@"study_room.png"];
            roomTypeKey = @"studyroom";
        }
        else if([roomLabel isEqualToString:[labels valueForKey:@"kitchen"]])
        {
            imgView.image = [UIImage imageNamed:@"coffee_room.png"];
            roomTypeKey = @"kitchen";
        }
        else if([roomLabel isEqualToString:[labels valueForKey:@"bedroom"]])
        {
            imgView.image = [UIImage imageNamed:@"bed_room.png"];
            roomTypeKey = @"bedroom";
        }
        else if([roomLabel isEqualToString:[labels valueForKey:@"dressingroom"]])
        {
            imgView.image = [UIImage imageNamed:@"dressing_room.png"];
            roomTypeKey = @"dressingroom";
        }
        else if([roomLabel isEqualToString:[labels valueForKey:@"toilet"]])
        {
            imgView.image = [UIImage imageNamed:@"toilet_room.png"];
            roomTypeKey = @"toilet";
        }
        else if([roomLabel isEqualToString:[labels valueForKey:@"washingroom"]])
        {
            imgView.image = [UIImage imageNamed:@"wash_room.png"];
            roomTypeKey = @"washingroom";
        }
        else{
                imgView.image = [UIImage imageNamed:@"generic_room.png"];
            //NSLog(@"generic room label %@,%@",roomLabel,[labels valueForKey:@"generic_room"]);
            roomTypeKey = roomLabel;
        }
    }
    
    if(vc.cleaningType == 2) {
        
        //imgView.image = [UIImage imageNamed:@"menu2.png"];
        
        if([roomLabel isEqualToString:[labels valueForKey:@"reception"]]) {
            imgView.image = [UIImage imageNamed:@"reception.png"];
            //NSLog(@"living room label %@,%@",roomLabel,[labels valueForKey:@"reception"]);
            roomTypeKey = @"reception";
        }
        else if([roomLabel isEqualToString:[labels valueForKey:@"hallway"]])
        {
            imgView.image = [UIImage imageNamed:@"hallway.png"];
            roomTypeKey = @"hallway";
        }
        else if([roomLabel isEqualToString:[labels valueForKey:@"officeroom"]])
        {
            imgView.image = [UIImage imageNamed:@"office_room.png"];
            roomTypeKey = @"officeroom";
        }
        else if([roomLabel isEqualToString:[labels valueForKey:@"grouproom"]])
        {
            imgView.image = [UIImage imageNamed:@"entrance.png"];
            roomTypeKey = @"grouproom";
        }
        else if([roomLabel isEqualToString:[labels valueForKey:@"conferenceroom"]])
        {
            imgView.image = [UIImage imageNamed:@"conference_room.png"];
            roomTypeKey = @"conferenceroom";
        }
        else if([roomLabel isEqualToString:[labels valueForKey:@"kitchen"]])
        {
            imgView.image = [UIImage imageNamed:@"coffee_room.png"];
            roomTypeKey = @"kitchen";
        }
        else if([roomLabel isEqualToString:[labels valueForKey:@"lift"]])
        {
            imgView.image = [UIImage imageNamed:@"lift.png"];
            roomTypeKey = @"lift";
        }
        else if([roomLabel isEqualToString:[labels valueForKey:@"exculator"]])
        {
            imgView.image = [UIImage imageNamed:@"exculator.png"];
            roomTypeKey = @"exculator";
        }
        else if([roomLabel isEqualToString:[labels valueForKey:@"stairs"]])
        {
            imgView.image = [UIImage imageNamed:@"stairs.png"];
            roomTypeKey = @"stairs";
        }
        else if([roomLabel isEqualToString:[labels valueForKey:@"storeroom"]])
        {
            imgView.image = [UIImage imageNamed:@"store_room.png"];
            roomTypeKey = @"storeroom";
        }
        else if([roomLabel isEqualToString:[labels valueForKey:@"wherehouse"]])
        {
            imgView.image = [UIImage imageNamed:@"wherehouse.png"];
            roomTypeKey = @"wherehouse";
        }
        else if([roomLabel isEqualToString:[labels valueForKey:@"washroom"]])
        {
            imgView.image = [UIImage imageNamed:@"washroom.png"];
            roomTypeKey = @"washroom";
        }
        else if([roomLabel isEqualToString:[labels valueForKey:@"shower"]])
        {
            imgView.image = [UIImage imageNamed:@"shower.png"];
            roomTypeKey = @"shower";
        }
        else if([roomLabel isEqualToString:[labels valueForKey:@"toilet"]])
        {
            imgView.image = [UIImage imageNamed:@"toilet.png"];
            roomTypeKey = @"toilet";
        }
        else if([roomLabel isEqualToString:[labels valueForKey:@"wasteroom"]])
        {
            imgView.image = [UIImage imageNamed:@"wasteroom.png"];
            roomTypeKey = @"wasteroom";
        }
        else if([roomLabel isEqualToString:[labels valueForKey:@"parking"]])
        {
            imgView.image = [UIImage imageNamed:@"parking.png"];
            roomTypeKey = @"parking";
        }
        else if([roomLabel isEqualToString:[labels valueForKey:@"gym"]]) {
            imgView.image = [UIImage imageNamed:@"gym.png"];
            roomTypeKey = @"gym";
        }
        else if([roomLabel isEqualToString:[labels valueForKey:@"mall"]]) {
            imgView.image = [UIImage imageNamed:@"mall.png"];
            roomTypeKey = @"mall";
        }
        else{
            imgView.image = [UIImage imageNamed:@"generic_room.png"];
            //NSLog(@"generic room label %@,%@",roomLabel,[labels valueForKey:@"generic_room"]);
            roomTypeKey = roomLabel;
        }
    }
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 125, 150, 25)];
    
    [label setBackgroundColor:[UIColor clearColor]];
    [label setText:@""];
    [label setText:roomLabel];
    [label setTextColor:color];
    [label setFont:font];
    [label setTextAlignment:NSTextAlignmentCenter];
    [roomView addSubview:imgView];
    [roomView addSubview:label];
    
    
    
    if(!isSaved) {
        
        //NSLog(@"room label not  saved %@",roomLabel);
        
        AppDelegate *appDelegate =
        [[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *context =
        [appDelegate managedObjectContext];
    
        NSFetchRequest *fetchData = [[NSFetchRequest alloc] init];
    
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"CustomerRoomsTypes" inManagedObjectContext:context];
    
        [fetchData setEntity:entity];
    
        NSError *error;
    
        NSManagedObject *newContact;
        newContact = [NSEntityDescription
                  insertNewObjectForEntityForName:@"CustomerRoomsTypes"
                  inManagedObjectContext:context];
    
        [newContact setValue: self.customerName forKey:@"customer"];
        [newContact setValue: roomTypeKey forKey:@"roomtype"];
        [newContact setValue:[[NSNumber alloc] initWithInt:vc.cleaningType] forKey:@"type"];
        [newContact setValue:[[NSNumber alloc] initWithBool:YES]  forKey:@"isEdited"];
    
        [context save:&error];
    
        NSLog(@"error %@",error.description);
        
        //isSaved = YES;
    }
    


    return roomView;
}

#pragma mark--add delete items view

-(void) getDeleteItemsView {
    
    ViewController *vc = [ViewController sharedInstance];
    
    self.deleteRooms = [[NSMutableArray alloc] init];
    
    [self.deleteRooms removeAllObjects];
    
    for(int i=0;i<[self.roomsList count];i++) {
        
        UIView *roomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
        [roomView setBackgroundColor:[UIColor clearColor]];
        
        //roomView.layer.cornerRadius = 75.0;
        
        
        UIView *roomsView = (UIView *)[self.roomsList objectAtIndex:i];
        
        NSString *roomLabel = ((UILabel *)[[roomsView subviews] objectAtIndex:1]).text;
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(25, 5, 100, 100)];
        
        imgView.image = NULL;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 125, 150, 25)];
        [label setBackgroundColor:[UIColor clearColor]];
        
        if(vc.cleaningType == 1) {
            
            if([roomLabel isEqualToString:[labels valueForKey:@"livingroom"]]) {
                imgView.image = [UIImage imageNamed:@"living_room.png"];
                [label setText:[labels valueForKey:@"livingroom"]];
            } else if([roomLabel isEqualToString:[labels valueForKey:@"studyroom"]]) {
                imgView.image = [UIImage imageNamed:@"study_room.png"];
                [label setText:[labels valueForKey:@"studyroom"]];
            } else if([roomLabel isEqualToString:[labels valueForKey:@"kitchen"]]) {
                imgView.image = [UIImage imageNamed:@"coffee_room.png"];
                [label setText:[labels valueForKey:@"Kitchen"]];
            } else if([roomLabel isEqualToString:[labels valueForKey:@"bedroom"]]) {
                imgView.image = [UIImage imageNamed:@"bed_room.png"];
                [label setText:[labels valueForKey:@"bedroom"]];
            } else if([roomLabel isEqualToString:[labels valueForKey:@"dressingroom"]]) {
                imgView.image = [UIImage imageNamed:@"dressing_room.png"];
                [label setText:[labels valueForKey:@"dressingroom"]];
            } else if([roomLabel isEqualToString:[labels valueForKey:@"toilet"]]) {
                imgView.image = [UIImage imageNamed:@"toilet_room.png"];
                [label setText:[labels valueForKey:@"toilet"]];
            } else if([roomLabel isEqualToString:[labels valueForKey:@"washingroom"]]) {
                imgView.image = [UIImage imageNamed:@"wash_room.png"];
                [label setText:[labels valueForKey:@"washingroom"]];
            }
            else {
                
                imgView.image = [UIImage imageNamed:@"generic_room.png"];
                [label setText:roomLabel];
            }
        }
        
        if(vc.cleaningType == 2) {
            
            //imgView.image = [UIImage imageNamed:@"menu2.png"];
            if([roomLabel isEqualToString:[labels valueForKey:@"reception"]]) {
                imgView.image = [UIImage imageNamed:@"reception.png"];
                //NSLog(@"living room label %@,%@",roomLabel,[labels valueForKey:@"reception"]);
                label.text = [labels valueForKey:@"reception"];
            }
            else if([roomLabel isEqualToString:[labels valueForKey:@"hallway"]]) {
                imgView.image = [UIImage imageNamed:@"hallway.png"];
                label.text = [labels valueForKey:@"hallway"];
            }
            else if([roomLabel isEqualToString:[labels valueForKey:@"officeroom"]]) {
                imgView.image = [UIImage imageNamed:@"office_room.png"];
                label.text = [labels valueForKey:@"officeroom"];
            }
            else if([roomLabel isEqualToString:[labels valueForKey:@"grouproom"]]) {
                imgView.image = [UIImage imageNamed:@"entrance.png"];
                label.text = [labels valueForKey:@"grouproom"];
            }
            else if([roomLabel isEqualToString:[labels valueForKey:@"conferenceroom"]]) {
                imgView.image = [UIImage imageNamed:@"conference_room.png"];
                label.text = [labels valueForKey:@"conferenceroom"];
            }
            else if([roomLabel isEqualToString:[labels valueForKey:@"kitchen"]]) {
                imgView.image = [UIImage imageNamed:@"coffee_room.png"];
                label.text = [labels valueForKey:@"kitchen"];
            }
            else if([roomLabel isEqualToString:[labels valueForKey:@"lift"]]) {
                imgView.image = [UIImage imageNamed:@"lift.png"];
                label.text = [labels valueForKey:@"lift"];
            }
            else if([roomLabel isEqualToString:[labels valueForKey:@"exculator"]]) {
                imgView.image = [UIImage imageNamed:@"exculator.png"];
                label.text = [labels valueForKey:@"exculator"];
            }
            else if([roomLabel isEqualToString:[labels valueForKey:@"stairs"]]) {
                imgView.image = [UIImage imageNamed:@"stairs.png"];
                label.text = [labels valueForKey:@"stairs"];
            }
            else if([roomLabel isEqualToString:[labels valueForKey:@"storeroom"]]) {
                imgView.image = [UIImage imageNamed:@"store_room.png"];
                label.text = [labels valueForKey:@"storeroom"];
            }
            else if([roomLabel isEqualToString:[labels valueForKey:@"wherehouse"]]) {
                imgView.image = [UIImage imageNamed:@"wherehouse.png"];
                label.text = [labels valueForKey:@"wherehouse"];
            }
            else if([roomLabel isEqualToString:[labels valueForKey:@"washroom"]]) {
                imgView.image = [UIImage imageNamed:@"washroom.png"];
                label.text = [labels valueForKey:@"washroom"];
            }
            else if([roomLabel isEqualToString:[labels valueForKey:@"shower"]]) {
                imgView.image = [UIImage imageNamed:@"shower.png"];
                label.text = [labels valueForKey:@"shower"];
            }
            else if([roomLabel isEqualToString:[labels valueForKey:@"toilet"]]) {
                imgView.image = [UIImage imageNamed:@"toilet.png"];
                label.text = [labels valueForKey:@"toilet"];
            }
            else if([roomLabel isEqualToString:[labels valueForKey:@"wasteroom"]]) {
                imgView.image = [UIImage imageNamed:@"wasteroom.png"];
                label.text = [labels valueForKey:@"wasteroom"];
            }
            else if([roomLabel isEqualToString:[labels valueForKey:@"parking"]]) {
                imgView.image = [UIImage imageNamed:@"parking.png"];
                label.text = [labels valueForKey:@"parking"];
            }
            else if([roomLabel isEqualToString:[labels valueForKey:@"gym"]]) {
                imgView.image = [UIImage imageNamed:@"gym.png"];
                label.text = [labels valueForKey:@"gym"];
            }
            else if([roomLabel isEqualToString:[labels valueForKey:@"mall"]]) {
                imgView.image = [UIImage imageNamed:@"mall.png"];
                label.text = [labels valueForKey:@"mall"];
            }
            else{
                imgView.image = [UIImage imageNamed:@"generic_room.png"];
                //NSLog(@"generic room label %@,%@",roomLabel,[labels valueForKey:@"generic_room"]);
                label.text = roomLabel;
            }
        }
        
        UIImageView *deleteView = [[UIImageView alloc] initWithFrame:CGRectMake(95, 5, 32, 32)];
        
        deleteView.image = [UIImage imageNamed:@"close_icon.png"];
        
        [imgView addSubview:deleteView];
        
        [roomView addSubview:imgView];
        
        
        [label setTextAlignment:NSTextAlignmentCenter];
        color = [UIColor blackColor];
        [label setTextColor:color];
        [label setFont:font];
        
        [roomView addSubview:label];
        
        [self.deleteRooms addObject:roomView];
        
    }
    
    /*for(int i=0;i<[deleteRooms count];i++) {
        
        NSString *label = ((UILabel *)[[[deleteRooms objectAtIndex:i] subviews] objectAtIndex:1]).text;
        
        NSString *label1 = ((UILabel *)[[[self.roomsList objectAtIndex:i] subviews] objectAtIndex:1]).text;
        
        //NSLog(@" label %@,%d,%@",label,i,label1);
    }*/
    
    
    

}

#pragma mark--collectionview delegate functions


-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    NSInteger num = 0;
    
    //if(!deleteRooms)
        num =  [self.roomsList count];
    /*if(deleteRooms)
        num =  [self.deleteRooms count];*/
    
    //NSLog(@"delete rooms %d",num);
    
    return num;
}

-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSString *cellIdentifier = @"cellIdentifier";
    
    cell = nil;
    
    
    
    [cell removeFromSuperview];
    
    //UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 45, 45)];
    
    //NSString *text = ((UploadContentView *)[self.itemsInformation objectAtIndex:indexPath.row]).uploadItemTypeText.text;
    
    
    
    /*UIImageView *imgView = NULL;
    imgView = [[UIImageView alloc] initWithFrame:CGRectMake(5,5, 75, 75)];
    
    imgView.image = [UIImage imageNamed:@"menu1.png"];*/
    
    
    
    //if(!delete_room) {
        
        
        
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
        
        /*[cell setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:1.0]];
        [cell.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        //[cell.layer setCornerRadius:75.0];
        //cell.layer.masksToBounds = YES;
        [cell.layer setBorderWidth:0.5];
        [cell.layer setShadowColor:[[UIColor lightGrayColor] CGColor]];
        [cell.layer setShadowOffset:CGSizeMake(-10, 10)];
        [cell.layer setShadowRadius:5.0];
        [cell.layer setShadowOpacity:0.0];*/
    
        //NSLog(@"num rooms %d",[[cell subviews] count]);
    
        /*if(!delete_room)*/ {
            for(unsigned long i=[[cell subviews] count]-1;i==0;i--) {
        
                id viewItem = [[cell subviews] objectAtIndex:i];
                [viewItem removeFromSuperview];
            }
        }
    
        //NSLog(@"num rooms after %d",[[cell subviews] count]);

    
    
        [cell addSubview:[self.roomsList objectAtIndex:indexPath.row]];
        
        [cell reloadInputViews];
    
        //NSLog(@"num rooms after %d",[[cell subviews] count]);
    //}
    
    /*if(delete_room) {
        
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
        
        [cell setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:1.0]];
        [cell.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        //[cell.layer setCornerRadius:75.0];
        //cell.layer.masksToBounds = YES;
        [cell.layer setBorderWidth:0.5];
        [cell.layer setShadowColor:[[UIColor lightGrayColor] CGColor]];
        [cell.layer setShadowOffset:CGSizeMake(-10, 10)];
        [cell.layer setShadowRadius:5.0];
        [cell.layer setShadowOpacity:0.0];
        
        [cell addSubview:[self.deleteRooms objectAtIndex:indexPath.row]];
        
        [cell reloadInputViews];
    }*/
    
    //[cell addSubview:imgView];
    
    //[label setText:text];
    
    //[cell addSubview:label];
    
    
    return cell;
    
    
}

-(CGSize) collectionView:(UICollectionView *) collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(150, 150);
    
}

- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(5, 5, 5, 5);
    
}

-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPat
{
    
    //ViewController *vc = [ViewController sharedInstance];
    
    currentIndex = indexPat;
    

    
    if(!delete_room) {
        
        //NSLog(@"number of rooms %d,%@",[self.roomsList count],self.customerName);
        
        delete_room = NO;
        
        [self.roomsViews reloadData];
        
        
        UIView *roomView = (UIView *)[self.roomsList objectAtIndex:indexPat.row];
        
        
        UILabel *label = [[roomView subviews] objectAtIndex:1];
        
        
        NSString *knownObject = label.text;
        NSArray *temp = [labels allKeysForObject:knownObject];
        NSString *key = [temp lastObject];
        
        //NSLog(@"last object %@,%@",key,label.text);
        
        
        if(self.roomComments == NULL) {
            self.roomComments = [[RoomComments alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) withCustomerName:self.customerName withRoomName:label.text];
            self.roomComments.roomNameKey = key;
            self.roomComments.view.transform = CGAffineTransformMakeTranslation(320, 0);
            
            
            [self.view addSubview:self.roomComments.view];
        }
        
        
        
        id animation = ^{
            
            self.roomComments.view.transform = CGAffineTransformMakeTranslation(0, 0);
        };
        
        [UIView animateWithDuration:0.5 animations:animation];
        
       
    
        /*for(unsigned long i=[[vc.barView subviews] count]-1;i>=1;i--) {
        
            id viewItem = [[vc.barView subviews] objectAtIndex:i];
            [viewItem removeFromSuperview];
        }
        
        [vc drawRightMenuView];*/
    }
    
    if(delete_room) {
        
        //NSLog(@"number of rooms %d",[self.roomsList count]);
        
        
        
        /*if(currentIndex.row<4) {
            
            UIView *currentRoom = [self.roomsList objectAtIndex:currentIndex.row];
            
            UILabel *label = [[currentRoom subviews] objectAtIndex:1];
            
            if([label.text isEqualToString:@"Room1"] ||[label.text isEqualToString:@"Room2"]||[label.text isEqualToString:@"Room3"]||[label.text isEqualToString:@"Room4"]) {
            
                [predefinedRoomIndex  addObject:[self.roomsList objectAtIndex:currentIndex.row]];
            }
            
        }*/
        
        UIView *currentRoom = [self.roomsList objectAtIndex:currentIndex.row];
        
        UILabel *label = [[currentRoom subviews] objectAtIndex:1];
        
        //NSLog(@" selected text %@ ",label.text);
        
        roomName = label.text;
        
        AppDelegate *appDelegate =
        [[UIApplication sharedApplication] delegate];
        
        NSManagedObjectContext *dataContext = [appDelegate managedObjectContext];
        
        NSFetchRequest *fetchData = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"CustomerRoomsTypes" inManagedObjectContext:dataContext];
        
        [fetchData setEntity:entity];
        
        
        
        //NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData error:&error];
        
        NSManagedObject *userData = nil;
        
        //NSLog(@"customer name %@",self.customerName);
        NSPredicate *pred =[NSPredicate predicateWithFormat:@"(customer = %@)",self.customerName];
        
        [fetchData setPredicate:pred];
        //NSManagedObject *matches = nil;
        
        NSError *error;
        NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData
                                                           error:&error];
        
       // NSLog(@"fetch objects count %d,%d",[fetchObjects count],currentIndex.row);
        
        if(fetchObjects) {
            if([fetchObjects count]!=0) {
                userData = [fetchObjects objectAtIndex:currentIndex.row];
                [dataContext deleteObject:userData];
                
            }
            
            NSError *error = nil;
            if (![dataContext save:&error])
            {
                NSLog(@"Error deleting movie, %@", [error userInfo]);
            }
        }
        
        
        id complete = ^(BOOL finised){
            
            [self deleteRooms:nil];
        };
        
        
        [self.roomsViews performBatchUpdates:^{
            
            //NSLog(@"delete romms count %d",[self.deleteRooms count]);
            [self.deleteRooms removeObjectAtIndex:currentIndex.row];
            [self.roomsList removeAllObjects];
            self.roomsList = [[NSMutableArray alloc] initWithArray:self.deleteRooms];
            //[self.roomsList removeObjectAtIndex:currentIndex.row];
            [currentRooms removeObjectAtIndex:currentIndex.row];
            [self.roomsViews reloadData];
            [self.roomsViews deleteItemsAtIndexPaths:[NSArray arrayWithObject:currentIndex]];
            [self getDeleteItemsView];
            [self.roomsViews reloadData];
            
        } completion:complete];

        
        
        //[self.roomsList removeObjectAtIndex:currentIndex.row];
        //[self.deleteRooms removeObjectAtIndex:currentIndex.row];
        //[self.roomsViews deleteItemsAtIndexPaths:[NSArray arrayWithObject:currentIndex]];
        
        //[self.roomsViews reloadItemsAtIndexPaths:[self.roomsViews indexPathsForVisibleItems]];
        
        

        
        //[self deleteCurrentRoom:currentIndex.row];
        
        [self deleteCustomerRooms];
        
        //[self refreshRooms];
        
        
        
        /*if([self.roomsList count]==0) {
            
            [predefinedRoomIndex removeAllObjects];
            
            predefinedRoomIndex = [[NSMutableArray alloc] initWithArray:predefinedRooms];
            
        }*/

    }
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        
        UICollectionReusableView *reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        
        if (reusableview==nil) {
            reusableview=[[UICollectionReusableView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        }
        
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
        
        /*UIImageView *backView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 40, 40)];
        
        backView.image = [UIImage imageNamed:@"back.png"];
        
        [backView setUserInteractionEnabled:YES];
        
        UITapGestureRecognizer *backTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backToCustomerView:)];
        
        [backView addGestureRecognizer:backTap];
        
        [headerView addSubview:backView];*/
        
        
        UIImageView *deleteView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 40, 40)];
        
        deleteView.image = [UIImage imageNamed:@"delete.png"];
        
        [deleteView setContentMode:UIViewContentModeScaleAspectFit];
        
        [deleteView setUserInteractionEnabled:YES];
        
        UITapGestureRecognizer *deleteTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deleteRooms:)];
        
        [deleteView addGestureRecognizer:deleteTap];
        
        [headerView addSubview:deleteView];
        
        
        UIImageView *addRoomView = [[UIImageView alloc] initWithFrame:CGRectMake(270, 5, 40, 40)];
        
        addRoomView.image = [UIImage imageNamed:@"add.png"];
        
        [addRoomView setContentMode:UIViewContentModeScaleAspectFit];
        
        [addRoomView setUserInteractionEnabled:YES];
        
        UITapGestureRecognizer *roomTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addNewRoom:)];
        
        [addRoomView addGestureRecognizer:roomTap];
        
        [headerView addSubview:addRoomView];
        
        
        /*CALayer *bottomBorder = [CALayer layer];
        
        bottomBorder.frame = CGRectMake(0.0f, 0.0f, self.frame.size.width, 50.0f);
        
        bottomBorder.backgroundColor = [UIColor lightGrayColor].CGColor;
        
        [bottomBorder setShadowColor:[[UIColor blackColor] CGColor]];
        [bottomBorder setShadowOffset:CGSizeMake(-2, 2)];*/
        
        [headerView.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        [headerView.layer setBorderWidth:0.5];
        [headerView.layer setShadowColor:[[UIColor blackColor] CGColor]];
        [headerView.layer setShadowOffset:CGSizeMake(-2, 2)];

        //[headerView.layer addSublayer:bottomBorder];
        

        
        //UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        //label.text=@"label";
        [reusableview addSubview:headerView];
        return reusableview;
    }
    return nil;
}

#pragma --mark textfield delgate functions

-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    
    
    [self.searchList.view removeFromSuperview];
    [self.searchList removeFromParentViewController];
    self.searchList = nil;
    
    UITouch *touch = [[event allTouches] anyObject];
    
    if([touch view]!=predefineRooms)
    {
        isRoomListShow = NO;
    }
}

-(UIImageView *) getImage {
    
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"transparent.png"]];
    
    image.frame = CGRectMake(0, 0, 8, 8);
    
    [image setContentMode:UIViewContentModeScaleAspectFit];
    
    return image;
}

//deletes a customer room
-(void) deleteCustomerRooms {
    
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *dataContext = [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchData = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CustomerRooms" inManagedObjectContext:dataContext];
    
    [fetchData setEntity:entity];
    
    
    //NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData error:&error];
    
    NSManagedObject *userData = nil;
    
    //NSLog(@"customer name in delete customer rooms %@",roomName);
    NSPredicate *pred =[NSPredicate predicateWithFormat:@"(customerName =%@) AND (room = %@)",customerName, roomName];
    
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


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
