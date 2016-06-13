//
//  Reportview.m
//  NewOptiqo
//
//  Created by Umapathi on 9/11/14.
//  Copyright (c) 2014 Umapathi. All rights reserved.
//

#import "Reportview.h"
#import "ViewController.h"

@implementation Reportview

@synthesize scrollView,roomsViews,roomsList;

/*- (id)initWithFrame:(CGRect)frame
{
    self = [super init];
    if (self) {
        // Initialization code
    }
    return self;
}*/

//shows the overview of each rooom in user selected language

-(id) initWithFrame:(CGRect)frame withRoomComment:(RoomListContent *)reportView withIndex:(int)reportIndex {
    
    self = [super init];
    if (self) {
        // Initialization code
        
        self.view.frame = frame;
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:frame];
        
        [self.view addSubview:self.scrollView];
        
        [self.view setBackgroundColor:[UIColor whiteColor]];
        
        ViewController *vc = [ViewController sharedInstance];
        
        
        
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
        
        if(vc.cleaningType == 1) {
            
            roomType = [labels valueForKey:@"homecleaning"];
            
            
        }
        
        if(vc.cleaningType == 2) {
            
            roomType = [labels valueForKey:@"officecleaning"];
            
        }
        
        customerName = reportView.customerName;
        
        customerRoom = reportView.customerRoom;
        
        customerRoomName = reportView.customerRoomName;
        
        
        roomImageView = reportView.customerRoomImage;
        
        roomDescription = reportView.roomComents;
        
        endTime = reportView.endDate;
        
        index  = reportIndex;
        
        [self.scrollView setContentSize:CGSizeMake(320.0, 500.0)];
        
        backImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,500.0)];
        
        backImg.image = [UIImage imageNamed:@"view_background.png"];
        
        [self.scrollView addSubview:backImg];
        
        [self setViewTitle];
        
        /*UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(75, 20, 200, 32)];
        
        [label setBackgroundColor:[UIColor clearColor]];
        
        [label setText:reportView.customerRoom];
        [label setTextColor:color];
        [label setFont:[UIFont fontWithName:@"Avenir-Medium" size:24.0]];
        [label setTextColor:[UIColor colorWithRed:0.0 green:191.0/255.0 blue:1.0 alpha:1.0]];
        [label setTextAlignment:NSTextAlignmentCenter];
        
        [vc.barView addSubview:label];*/
        
        self.roomsList = [[NSMutableArray alloc] init];
        
        [self drawImages];

        
        [self showData];
        
    }
    return self;
}

//sets the title view

-(void) setViewTitle {
    
    ViewController *vc = [ViewController sharedInstance];
    
    for(unsigned long i=[[vc.barView subviews] count]-1;i>=1;i--) {
        
        id viewItem = [[vc.barView subviews] objectAtIndex:i];
        [viewItem removeFromSuperview];
    }
    
    [vc drawRightMenuView];
    
    UILabel *cust_label = [[UILabel alloc] initWithFrame:CGRectMake(60, 25, 200, 32)];
    
    [cust_label setBackgroundColor:[UIColor clearColor]];
    
    [cust_label setText:[labels valueForKey:@"roominfo"]];
    [cust_label setTextColor:[UIColor whiteColor]];
    [cust_label setTextAlignment:NSTextAlignmentCenter];
    [cust_label setFont:[UIFont fontWithName:@"Avenir-Medium" size:24]];
    
    [vc.barView addSubview:cust_label];
    
    UIImageView *backImage = (UIImageView *)[[vc.barView subviews] objectAtIndex:0];
    
    backImage.image = [UIImage imageNamed:@"back.png"];
    
    UITapGestureRecognizer *backTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backToReportsListView:)];
    
    [backImage addGestureRecognizer:backTap];
}

//back to pervious room
-(void) backToReportsListView:(id) sender {
    
    ViewController *vc = [ViewController sharedInstance];
    
    
    
    ReportsListView *reportList = vc.customerList.roomListView.roomComments.reportsListView;
    
    [reportList setViewTitle];
    
    id animation = ^{
        
        self.view.transform = CGAffineTransformMakeTranslation(320, 0);
        
    };
    
    id completion = ^(BOOL finshed) {
        
        //ReportsListView *reportView = (ReportsListView *) self.view.superview;
        
        [reportList.scrollView setContentSize:CGSizeMake(320, 700)];
        
        [self removeFromParentViewController];
        
        
    };
    
    
    [UIView animateWithDuration:0.5 animations:animation completion:completion];
    
}

#pragma mark--fetches images the rooms have
-(void) drawImages {
    
    
    
    NSString *imagePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:[NSString stringWithFormat:@"/%@/%@/%@",@"Optiqo",customerName,customerRoomName]];


    
    
    NSString *path = [NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"image1"]];
    
    //NSLog(@"room type %@,%@,%@,%d",roomType,customerRoom,path,[[NSFileManager defaultManager] fileExistsAtPath:path]);
    
    if([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        
        UIImage *image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"image1"]]];
        
        UIImageView *roomView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
        [roomView setBackgroundColor:[UIColor whiteColor]];
        roomView.image = image;

        
        [self.roomsList addObject:roomView];
        
        
    }
    
    
    
    path = [NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"image2"]];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        
        UIImage *image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"image2"]]];
        
        UIImageView *roomView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
        [roomView setBackgroundColor:[UIColor whiteColor]];
        roomView.image = image;
        
        
        [self.roomsList addObject:roomView];

        
        
    }
    

    
    path = [NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"image3"]];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        
        UIImage *image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"image3"]]];
        
        UIImageView *roomView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
        [roomView setBackgroundColor:[UIColor whiteColor]];
        roomView.image = image;
        
        
        [self.roomsList addObject:roomView];

        
        
    }
    

    
    path = [NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"image4"]];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        
        UIImage *image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"image4"]]];
        
        UIImageView *roomView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
        [roomView setBackgroundColor:[UIColor whiteColor]];
        roomView.image = image;
        
        
        [self.roomsList addObject:roomView];

        
    }
    

    
    path = [NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"image5"]];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        
        UIImage *image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"image5"]]];
        
        UIImageView *roomView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
        [roomView setBackgroundColor:[UIColor whiteColor]];
        roomView.image = image;
        
        
        [self.roomsList addObject:roomView];

        
        
    }
    
    
    path = [NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"image6"]];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        
        UIImage *image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"image6"]]];
        
        UIImageView *roomView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
        [roomView setBackgroundColor:[UIColor whiteColor]];
        roomView.image = image;
        
        
        [self.roomsList addObject:roomView];
        
        
        
    }
    
    
}

//shows the overview of the room with images and comments
-(void) showData {
    
    roomImageView.frame = CGRectMake(50, 25, 50, 50);
    [self.scrollView addSubview:roomImageView];
    
    UILabel *roomTypeView = [[UILabel alloc] initWithFrame:CGRectMake(125, 25, 275, 50)];
    
    [roomTypeView setBackgroundColor:[UIColor clearColor]];
    
    [roomTypeView setText:customerRoom];
    [roomTypeView setTextColor:color];
    [roomTypeView setFont:[UIFont fontWithName:@"Avenir-Medium" size:24.0]];
    
    [self.scrollView addSubview:roomTypeView];
    
    UILabel *customerTypeView = [[UILabel alloc] initWithFrame:CGRectMake(25, 100, 275, 50)];
    
    [customerTypeView setBackgroundColor:[UIColor clearColor]];
    
    NSString *custName = [NSString stringWithFormat:@"%@:%@",[labels valueForKey:@"overviewDescription"],roomDescription];
    
    [customerTypeView setText:custName];
    [customerTypeView setTextColor:color];
    [customerTypeView setFont:font];
    
    [self.scrollView addSubview:customerTypeView];
    
    if([self.roomsList count]!=0) {
        
        
        //[self setContentSize:CGSizeMake(320.0, 600.0)];
        
        //backImg.frame = CGRectMake(0, 0, self.frame.size.width,600.0);
        
        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
        
        self.roomsViews = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 175, 320,200) collectionViewLayout:layout];
        
        [self.roomsViews setBackgroundColor:[UIColor clearColor]];
        
        [self.roomsViews setDelegate:self];
        [self.roomsViews setDataSource:self];
        [self.roomsViews registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
        
        [self.roomsViews.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        [self.roomsViews.layer setBorderWidth:0.5];
        
        [self.scrollView addSubview:self.roomsViews];
        
         UITextView *customerDescpView = [[UITextView alloc] initWithFrame:CGRectMake(25, 400, 150, 100)];
        
        [customerDescpView setEditable:NO];
        
         UILabel *endTimeView = [[UILabel alloc] initWithFrame:CGRectMake(25, 525, 300, 50)];
        
        if([self.roomsList count]<=2) {
            
            [self.scrollView setContentSize:CGSizeMake(320.0, 700.0)];
            
            backImg.frame = CGRectMake(0, 0, self.view.frame.size.width,700.0);

            self.roomsViews.frame = CGRectMake(0, 175, 329, 200);
            
            customerDescpView.frame = CGRectMake(25, 400, 150, 100);
            
            endTimeView = [[UILabel alloc] initWithFrame:CGRectMake(25, 525, 300, 50)];
        }
        
        if([self.roomsList count]>2 && [self.roomsList count]<=4) {
            
            
            [self.scrollView setContentSize:CGSizeMake(320.0, 900.0)];
            
            backImg.frame = CGRectMake(0, 0, self.view.frame.size.width,900.0);
            
            self.roomsViews.frame = CGRectMake(0, 175, 329, 400);
            
            customerDescpView.frame = CGRectMake(25, 600, 150, 100);
            
            endTimeView = [[UILabel alloc] initWithFrame:CGRectMake(25, 725, 300, 50)];
        }
        
        if([self.roomsList count]>4) {
            
            [self.scrollView setContentSize:CGSizeMake(320.0, 1000.0)];
            
            backImg.frame = CGRectMake(0, 0, self.view.frame.size.width,1000.0);
            
            self.roomsViews.frame = CGRectMake(0, 175, 329, 600);
            
            customerDescpView.frame = CGRectMake(25, 700, 150, 100);
            
            endTimeView = [[UILabel alloc] initWithFrame:CGRectMake(25, 825, 300, 50)];
        }
        
        
        
        
        [customerDescpView setBackgroundColor:[UIColor clearColor]];
        
        [customerDescpView setText:roomDescription];
        [customerDescpView setTextColor:color];
        [customerDescpView setFont:font];
        
        //[self.scrollView addSubview:customerDescpView];
        
       
        
        [endTimeView setBackgroundColor:[UIColor clearColor]];
        
        NSString *dateString = [NSDateFormatter localizedStringFromDate:endTime
                                                              dateStyle:NSDateFormatterShortStyle
                                                              timeStyle:NSDateFormatterShortStyle];
        
        NSString *dateTime = [NSString stringWithFormat:@"%@",dateString];
        
        [endTimeView setText:dateTime];
        [endTimeView setTextColor:color];
        [endTimeView setFont:font];
        
        //[self.scrollView addSubview:endTimeView];
        
        
        
        /*UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(25, 575, 100, 50)];
        
        [backButton.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        
        [backButton.layer setBorderWidth:0.5];
        
        [backButton setTitle:@"Back" forState:UIControlStateNormal];
        [backButton setTitleColor:color forState:UIControlStateNormal];
        [backButton.titleLabel setFont:font];
        [backButton setTitleColor:[UIColor colorWithRed:0.0 green:191.0/255.0 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
        
        [backButton addTarget:self action:@selector(backView:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:backButton];*/

    }
    else {
    
        UITextView *customerDescpView = [[UITextView alloc] initWithFrame:CGRectMake(25, 175, 150, 100)];
        
        [customerDescpView setEditable:NO];
    
        [customerDescpView setBackgroundColor:[UIColor clearColor]];
    
        [customerDescpView setText:roomDescription];
        [customerDescpView setTextColor:color];
        [customerDescpView setFont:font];
    
        //[self.scrollView addSubview:customerDescpView];
    
        UILabel *endTimeView = [[UILabel alloc] initWithFrame:CGRectMake(25, 300, 300, 50)];
    
        [endTimeView setBackgroundColor:[UIColor clearColor]];
    
        NSString *dateString = [NSDateFormatter localizedStringFromDate:endTime
                                                          dateStyle:NSDateFormatterShortStyle
                                                          timeStyle:NSDateFormatterShortStyle];
    
        NSString *dateTime = [NSString stringWithFormat:@"%@",dateString];
    
        [endTimeView setText:dateTime];
        [endTimeView setTextColor:color];
        [endTimeView setFont:font];

    
        //[self.scrollView addSubview:endTimeView];
    
    
    
        /*UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(25, 375, 100, 50)];
    
        [backButton.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    
        [backButton.layer setBorderWidth:0.5];
    
        [backButton setTitle:@"Back" forState:UIControlStateNormal];
        [backButton setTitleColor:color forState:UIControlStateNormal];
        [backButton.titleLabel setFont:font];
        [backButton setTitleColor:[UIColor colorWithRed:0.0 green:191.0/255.0 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
    
        [backButton addTarget:self action:@selector(backView:) forControlEvents:UIControlEventTouchUpInside];
    
        [self addSubview:backButton];*/
    }
    
    
}


#pragma mark--collectionview delegate functions

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [self.roomsList count];
}

-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *cellIdentifier = @"cellIdentifier";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    [cell setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.5]];
    [cell.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [cell.layer setBorderWidth:0.5];
    [cell.layer setShadowColor:[[UIColor lightGrayColor] CGColor]];
    [cell.layer setShadowOffset:CGSizeMake(-10, 10)];
    [cell.layer setShadowRadius:5.0];
    [cell.layer setShadowOpacity:0.5];
    
    
    [cell addSubview:[self.roomsList objectAtIndex:indexPath.row]];
    
    
    
    return cell;
    
    
}

-(CGSize) collectionView:(UICollectionView *) collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(150, 150);
    
}

- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(50, 5, 50, 5);
    
}

-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPat
{
    
    
    
    /*self.currentIndex = indexPat;
    
    
    if(!delete_image) {
        
        [self editUploadImage:nil];
    }
    
    if(delete_image) {
        
        
        
        [self.roomsList removeObjectAtIndex:currentIndex.row];
        [self.roomsViews deleteItemsAtIndexPaths:[NSArray arrayWithObject:currentIndex]];
        
        [self.roomsViews reloadData];
        
        
        
    }*/
    
}



@end
