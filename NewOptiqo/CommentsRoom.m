//
//  CommentsRoom.m
//  NewOptiqo
//
//  Created by Umapathi on 8/29/14.
//  Copyright (c) 2014 Umapathi. All rights reserved.
//


#import "ViewController.h"
#import "AppDelegate.h"

@implementation CommentsRoom
@synthesize scrollView,pageController,pageImages,pageViews,commentText,imageView,customerName,roomName,saveButton,cancelButton,currentIndex,reportsListView;

-(void) viewWillAppear:(BOOL)animated {
    
    
    if(self.roomsList)
    {
        if ([self.roomsList count]==6) {
            [camView setHidden:YES];
        }
    }
}

//initialize the room
- (id)initWithFrame:(CGRect)frame
{
    self = [super init];
    if (self) {
        // Initialization code
        
        ViewController *vc = [ViewController sharedInstance];
        
        self.view.frame = frame;
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:frame];
        
        [self.view addSubview:self.scrollView];
        
        if(vc.cleaningType == 1) {
            
            color = [vc.colorArray objectAtIndex:1];
        }
        
        if(vc.cleaningType == 2) {
            
            color = [vc.colorArray objectAtIndex:0];
        }
        
        color = [UIColor blackColor];
        
        font = [UIFont fontWithName:@"Avenir-Medium" size:16.0];
        
        current_index = 0;
        
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
        self.roomsList = [[NSMutableArray alloc] init];
        [self drawView];
    }
    return self;
}

//initialize the comment room withg room name and customer count
- (id)initWithFrame:(CGRect)frame roomName:(NSString *) name withCustomerCount:(int)count
{
    self = [super init];
    if (self) {
        // Initialization code
        
        self.view.frame = frame;
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:frame];
        
        [self.view addSubview:self.scrollView];
        
        ViewController *vc = [ViewController sharedInstance];
        
        customerCount = count+1;
        
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
        
        [self.view setBackgroundColor:[UIColor whiteColor]];
        self.roomName = name;
        currentTime = [NSDate date];
        self.roomsList = [[NSMutableArray alloc] init];
        
        self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width,self.view.frame.size.height+150);
        
        [self drawView];
        
        camView = [[UIImageView alloc] initWithFrame:CGRectMake(140, 25, 50, 100)];
        
        camView.image = [UIImage imageNamed:@"camera.png"];
        
        [camView setContentMode:UIViewContentModeScaleAspectFill];
        
        [camView setUserInteractionEnabled:YES];
        
        UITapGestureRecognizer *camTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cameraView:)];
        
        [camView addGestureRecognizer:camTap];
        
        [self.scrollView addSubview:camView];
        
        current_index = 0;
        
        
    }
    return self;
}

//sets the view title
-(void) setViewTitle {
    
    ViewController *vc = [ViewController sharedInstance];
    
    for(unsigned long i=[[vc.barView subviews] count]-1;i>=1;i--) {
        
        id viewItem = [[vc.barView subviews] objectAtIndex:i];
        [viewItem removeFromSuperview];
    }
    
    [vc drawRightMenuView];
    
    UILabel *cust_label = [[UILabel alloc] initWithFrame:CGRectMake(35, 25, 250, 32)];
    
    [cust_label setBackgroundColor:[UIColor clearColor]];
    
    [cust_label setText:[labels valueForKey:@"addcomments"]];
    [cust_label setTextColor:[UIColor whiteColor]];
    [cust_label setTextAlignment:NSTextAlignmentCenter];
    [cust_label setFont:[UIFont fontWithName:@"Avenir-Medium" size:18.0]];
    [cust_label setTextAlignment:NSTextAlignmentCenter];
    
    [vc.barView addSubview:cust_label];
    
    UIImageView *backImage = (UIImageView *)[[vc.barView subviews] objectAtIndex:0];
    
    backImage.image = [UIImage imageNamed:@"back.png"];
    
    UITapGestureRecognizer *backTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backToRoomComments:)];
    
    [backImage addGestureRecognizer:backTap];
    
}

//back to pervious room
-(void) backToRoomComments:(id) sender {
    
    ViewController *vc = [ViewController sharedInstance];
    
    RoomComments *roomComment = vc.customerList.roomListView.roomComments;
    [roomComment setViewTitle];
    
    id animation = ^{
        
        self.view.transform = CGAffineTransformMakeTranslation(320, 0);
        
    };
    
    id completion = ^(BOOL finished) {
        
        [self removeFromParentViewController];
    };
    
    [UIView animateWithDuration:0.5 animations:animation completion:completion];
    
}

//draws a view with if any photos and description abou the room
-(void) drawView {
    

    ViewController *vc = [ViewController sharedInstance];
    
    
    backImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,self.scrollView.contentSize.height)];
    
    backImg.image = [UIImage imageNamed:@"view_background.png"];
    
    [self.scrollView addSubview:backImg];
    

    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    
    
    self.roomsViews = [[UICollectionView alloc] initWithFrame:CGRectMake(25, 100, vc.deviceWidth-50, self.scrollView.frame.size.height*0.7) collectionViewLayout:layout];
    
    [self.roomsViews setBackgroundColor:[UIColor clearColor]];
    
    [self.roomsViews setDelegate:self];
    [self.roomsViews setDataSource:self];
    [self.roomsViews registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    
    
    
    //[self.roomsViews registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    
    //[layout setHeaderReferenceSize:CGSizeMake(vc.deviceWidth, 50)];
    
    [self.roomsViews.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.roomsViews.layer setBorderWidth:0.5];
    
    [self.scrollView addSubview:self.roomsViews];
    
    [self.roomsViews setHidden:YES];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(25, self.view.frame.size.height*0.2, 225, 50)];
    
    [label setText:[labels valueForKey:@"comments"]];
    [label setTextColor:color];
    [label setFont:font];
    
    
    
    
    self.commentText = [[UITextView alloc] initWithFrame:CGRectMake(25, self.view.frame.size.height*0.32, vc.deviceWidth-50, 150)];
    [self.commentText.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.commentText.layer setBorderWidth:0.5];
    
    [self.commentText setDelegate:self];
    
    
    
    self.saveButton = [[UIButton alloc] initWithFrame:CGRectMake(50, (self.commentText.frame.origin.y+self.commentText.frame.size.height)+25, 225, 50)];
    
    [self.saveButton setTitle:[labels valueForKey:@"save"] forState:UIControlStateNormal];
    [self.saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.saveButton.titleLabel setFont:font];
    
    [self.saveButton setBackgroundColor:[UIColor colorWithRed:0.0 green:180.0/255.0 blue:0.0 alpha:0.95]];
    [self.saveButton.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.saveButton.layer setBorderWidth:0.5];
    
    
    
    
    
    
    self.cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(175, (self.commentText.frame.origin.y+self.commentText.frame.size.height)+25, 100, 50)];
    
    [self.cancelButton setTitle:[labels valueForKey:@"cancel"] forState:UIControlStateNormal];
    [self.cancelButton setTitleColor:color forState:UIControlStateNormal];
    [self.cancelButton.titleLabel setFont:font];
    
    [self.cancelButton.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.cancelButton.layer setBorderWidth:0.5];

    
    
    if([self.roomsList count]!=0) {
        
       [self.view addSubview:self.roomsViews];
        
       [self.roomsViews setHidden:YES];
       [self.roomsViews setHidden:NO];
        
    
        self.commentText = [[UITextView alloc] initWithFrame:CGRectMake(25, vc.deviceHeight*0.7, vc.deviceWidth-50, 150)];
        [self.commentText.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        [self.commentText.layer setBorderWidth:0.5];
    
        [self.commentText setDelegate:self];
    
    
        self.saveButton = [[UIButton alloc] initWithFrame:CGRectMake(50, vc.deviceHeight+100, 225, 50)];
    
        [self.saveButton setTitle:[labels valueForKey:@"save"] forState:UIControlStateNormal];
        [self.saveButton setTitleColor:color forState:UIControlStateNormal];
        [self.saveButton.titleLabel setFont:font];
    
        [self.saveButton.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        [self.saveButton.layer setBorderWidth:0.5];
    
        
    
        self.cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(175, vc.deviceHeight+100, 100, 50)];
    
        [self.cancelButton setTitle:[labels valueForKey:@"cancel"] forState:UIControlStateNormal];
        [self.cancelButton setTitleColor:color forState:UIControlStateNormal];
        [self.cancelButton.titleLabel setFont:font];
    
        [self.cancelButton.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        [self.cancelButton.layer setBorderWidth:0.5];
    
        
    


    } else {
        
        
        label.frame = CGRectMake(25, self.view.frame.size.height*0.2, vc.deviceWidth-50, 150);
        self.commentText.frame = CGRectMake(25, vc.deviceHeight*0.32, vc.deviceWidth-50, 150);

        self.saveButton.frame = CGRectMake(50, (self.commentText.frame.origin.y+self.commentText.frame.size.height)+25, 225, 50);
        
        self.cancelButton.frame = CGRectMake(175, (self.commentText.frame.origin.y+self.commentText.frame.size.height)+25, 100, 50);


        
    }
    
    
    [self.saveButton addTarget:self action:@selector(saveData:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.cancelButton addTarget:self action:@selector(cancelView:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.scrollView addSubview:label];
    [self.scrollView addSubview:self.commentText];
    [self.scrollView addSubview:self.saveButton];
    //[self addSubview:self.cancelButton];
    
    /*UIImageView *camImage = [[UIImageView alloc] initWithFrame:CGRectMake(vc.deviceWidth-50, 25, 32, 32)];
    
    camImage.image = [UIImage imageNamed:@"camera.png"];
    
    [camImage setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *camTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cameraView:)];
    
    [camImage addGestureRecognizer:camTap];
    
    [vc.barView addSubview:camImage];*/
    
    
    /*UILabel *cust_label = [[UILabel alloc] initWithFrame:CGRectMake(50, 20, 200, 32)];
    
    [cust_label setBackgroundColor:[UIColor whiteColor]];
    
    [cust_label setText:@"Add Comments"];
    [cust_label setTextColor:[UIColor colorWithRed:0.0 green:191.0/255.0 blue:1.0 alpha:1.0]];
    [cust_label setTextAlignment:NSTextAlignmentCenter];
    [cust_label setFont:[UIFont fontWithName:@"Helvetica"  size:24]];
    
    [vc.barView addSubview:cust_label];*/

    [self setViewTitle];
    
}

//gets the images from files and  data from database

-(void) getData {
    
    
    //sNSLog(@"room name %@",self.roomName);
    
    ViewController *vc = [ViewController sharedInstance];
    
    NSString *imagePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:[NSString stringWithFormat:@"/%@/%@/%@",@"Optiqo",self.customerName,vc.selectedRoomName]];
    
    //room images are stored according to customrname in seperate directories
    
    NSString *path = [NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"image1"]];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:path]) {
    
        UIImage *image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"image1"]]];
        
        UIImageView *roomView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 125, 125)];
        [roomView setBackgroundColor:[UIColor whiteColor]];
        roomView.image = image;
        [self.roomsList addObject:roomView];
    }
    
    
    path = [NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"image2"]];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        
        UIImage *image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"image2"]]];
        
        UIImageView *roomView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 125, 125)];
        [roomView setBackgroundColor:[UIColor whiteColor]];
        roomView.image = image;
        
        [self.roomsList addObject:roomView];
    }
    
    
    path = [NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"image3"]];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        
        UIImage *image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"image3"]]];
        UIImageView *roomView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 125, 125)];
        [roomView setBackgroundColor:[UIColor whiteColor]];
        roomView.image = image;
        [self.roomsList addObject:roomView];
    }
    
    
    path = [NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"image4"]];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        
        UIImage *image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"image4"]]];
        
        UIImageView *roomView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 125, 125)];
        [roomView setBackgroundColor:[UIColor whiteColor]];
        roomView.image = image;
        [self.roomsList addObject:roomView];
    }
    
    
    path = [NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"image5"]];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        
        UIImage *image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"image5"]]];
        
        UIImageView *roomView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 125, 125)];
        [roomView setBackgroundColor:[UIColor whiteColor]];
        roomView.image = image;
        [self.roomsList addObject:roomView];
    }
    
    
    
    
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *dataContext = [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchData = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CustomerRooms" inManagedObjectContext:dataContext];
    
    [fetchData setEntity:entity];
    

    
    
    
    //NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData error:&error];
    
    NSManagedObject *userData = nil;
    
    //NSLog(@"customer name %@",self.customerName);
    NSPredicate *pred =[NSPredicate predicateWithFormat:@"(roomName = %@)",vc.selectedRoomName];
    
    [fetchData setPredicate:pred];
    //NSManagedObject *matches = nil;
    
    NSError *error;
    NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData
                                                       error:&error];
    
    if(fetchObjects) {
        if([fetchObjects count]!=0) {
            for(int i=0;i<[fetchObjects count];i++) {
                userData = [fetchObjects objectAtIndex:i];
                self.commentText.text  = [userData valueForKeyPath:@"room_description"];
                

            }
        }
    }

    
}

//starts a camera view to take photos of current room
-(void) cameraView:(id) sender {
    
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:[labels valueForKey:@"cancel"] destructiveButtonTitle:nil otherButtonTitles:[labels valueForKey:@"takephoto"],[labels valueForKey:@"choosephoto"], nil];
    
    [actionSheet showInView:self.scrollView];
    
    
}

//editing the current photos to point divergence
-(void) editUploadImage:(id) sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:[labels valueForKey:@"cancel"] destructiveButtonTitle:nil otherButtonTitles:[labels valueForKey:@"retakephoto"],[labels valueForKey:@"choosephoto"],[labels valueForKey:@"editphoto"],[labels valueForKey:@"deletephoto"], nil];
    
    [actionSheet showInView:self.scrollView];
}

-(void) deleteImage {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:[labels valueForKey:@"cancel"] destructiveButtonTitle:[labels valueForKey:@"delete"] otherButtonTitles:nil, nil];
    
    [actionSheet showInView:self.scrollView];
}


#pragma mark --actionsheet delegate functions
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    NSString *actionButton = [actionSheet buttonTitleAtIndex:buttonIndex];
    
    if([actionButton isEqualToString:[labels valueForKey:@"takephoto"]]) {
        
        [self takePhotoWithCamera];
    }
    
    if([actionButton isEqualToString:[labels valueForKey:@"retakephoto"]]) {
        
        [self takePhotoWithCamera];
    }
    
    if([actionButton isEqualToString:[labels valueForKey:@"choosephoto"]]) {
        
        [self choosePhotoFromLibrary];
    }
    
    if([actionButton isEqualToString:[labels valueForKey:@"editphoto"]]) {
        
        [self editImage];
    }
    
    if([actionButton isEqualToString:[labels valueForKey:@"deletephoto"]]) {
        
        [self deleteImage];
    }
    
    if([actionButton isEqualToString:[labels valueForKey:@"delete"]]) {
        
        [self deleteItemImage];
    }
}

#pragma mark --camera functions
-(void) takePhotoWithCamera {
    
    //UIImage *image = [[UIImage alloc] init];
    
    ViewController *vc = [ViewController sharedInstance];
    
    vc.commentsRoom = self;
    
    
    
    [vc startCameraCommentRoom];
    
    
    
    
}

-(void) choosePhotoFromLibrary {
    
    ViewController *vc = [ViewController sharedInstance];
    
    vc.commentsRoom = self;
    
    [vc showImageLibrary];
}

//edit images
-(void) editImage {
    
    
    //[self.view setScrollEnabled:NO];
    
    
    //NSLog(@"image %@",((UIImageView *) [self.roomsList objectAtIndex:currentIndex.row]).image);
    
    UIImage *image = ((UIImageView *) [self.roomsList objectAtIndex:currentIndex.row]).image;
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    imgView.image = [UIImage imageWithCGImage:image.CGImage];
    
    EditImage *editImage = [[EditImage alloc] initWithFrame:CGRectMake(0, 0, imgView.frame.size.width, imgView.frame.size.height) withImage:image];
    
    [editImage setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:1.0]];
    [self.view addSubview:editImage];
    
    [self.view setUserInteractionEnabled:YES];
    
    //image = editImage.retImage;
    
    /*UIImageView *imageView1 = ((UIImageView *) [self.roomsList objectAtIndex:currentIndex.row]);
    
    image =  [self editSelectedImage:image];
    
    imageView1.image = image;*/
    
}

//edit selected image
-(UIImage *) editSelectedImage:(UIImage *)image {
    

    UIGraphicsBeginImageContext(image.size);
    
	// draw original image into the context
	[image drawAtPoint:CGPointZero];
    
	// get the context for CoreGraphics
	CGContextRef ctx = UIGraphicsGetCurrentContext();
    
	// set stroking color and draw circle
	[[UIColor redColor] setStroke];
    
	// make circle rect 5 px from border
	CGRect circleRect = CGRectMake(0, 0,
                                   image.size.width,
                                   image.size.height);
	circleRect = CGRectInset(circleRect, 5, 5);
    
	// draw circle
	CGContextStrokeEllipseInRect(ctx, circleRect);
    
	// make image out of bitmap context
	UIImage *retImage = UIGraphicsGetImageFromCurrentImageContext();
    
	// free the context
	UIGraphicsEndImageContext();
    
    return retImage;
}

//delete image
-(void) deleteItemImage {
    
    
    /*if(currentVisiblePage!=-1) {
        
        
        [self.pageImages removeObjectAtIndex:(currentVisiblePage-1)];
        
        if([self.pageImages count]==0) {
            
            
            NSLog(@"sub view count %d",[[self.scrollView subviews] count]);
            
            [scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

            [self.scrollView removeFromSuperview];
            [self.pageController removeFromSuperview];
            
            self.scrollView = NULL;
            self.pageController = NULL;
            
        }
        else {
            
            [self setImagePages];
        }
        
    }*/
    
    ViewController *vc = [ViewController sharedInstance];
    
    [self.roomsList removeObjectAtIndex:currentIndex.row];
    [self.roomsViews deleteItemsAtIndexPaths:[NSArray arrayWithObject:self.currentIndex]];
    

    
    NSString *imagePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:[NSString stringWithFormat:@"/%@/%@/%@",@"Optiqo",self.customerName,vc.selectedRoomName]];
    
    
    if(currentIndex.row==0)
    {
        NSString *path = [NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"image1"]];
        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    }
    
    if(currentIndex.row==1)
    {
        NSString *path = [NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"image2"]];
        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    }
    
    if(currentIndex.row==2)
    {
        NSString *path = [NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"image3"]];
        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    }
    
    if(currentIndex.row==3)
    {
        NSString *path = [NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"image4"]];
        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    }
    
    if(currentIndex.row==4)
    {
        NSString *path = [NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"image5"]];
        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    }
    
    if(currentIndex.row==5)
    {
        NSString *path = [NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"image6"]];
        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    }
    

    
    if([self.roomsList count]<=2) {
        
        //NSLog(@"Entered data");
        self.roomsViews.frame = CGRectMake(25, 125, vc.deviceWidth-50, vc.deviceHeight*0.25);
        label.frame = CGRectMake(25, (self.roomsViews.frame.origin.y+self.roomsViews.frame.size.height)+25, vc.deviceWidth-50, 25);
        self.commentText.frame = CGRectMake(25, (label.frame.origin.y+label.frame.size.height)+15, vc.deviceWidth-50, 150);
        
        self.saveButton.frame = CGRectMake(50, (self.commentText.frame.origin.y+self.commentText.frame.size.height)+25, 225, 50);
        
        self.cancelButton.frame = CGRectMake(175, (self.commentText.frame.origin.y+self.commentText.frame.size.height)+25, 100, 50);
        
        [self.roomsViews setHidden:NO];
        
        self.scrollView.contentSize = CGSizeMake(vc.deviceWidth,(self.saveButton.frame.origin.y+self.saveButton.frame.size.height)+150);
        
        backImg.frame = CGRectMake(0, 0, vc.deviceWidth,(self.saveButton.frame.origin.y+self.saveButton.frame.size.height)+150);
    }
    
    if([self.roomsList count]>2 && [self.roomsList count]<=4) {
        
        //NSLog(@"Entered 4 data");
        self.roomsViews.frame = CGRectMake(25, 125, vc.deviceWidth-50, vc.deviceHeight*0.5);
        label.frame = CGRectMake(25, (self.roomsViews.frame.origin.y+self.roomsViews.frame.size.height)+25, vc.deviceWidth-50, 25);
        self.commentText.frame = CGRectMake(25, (label.frame.origin.y+label.frame.size.height)+15, vc.deviceWidth-50, 150);
        
        self.saveButton.frame = CGRectMake(50, (self.commentText.frame.origin.y+self.commentText.frame.size.height)+25, 225, 50);
        
        self.cancelButton.frame = CGRectMake(175, (self.commentText.frame.origin.y+self.commentText.frame.size.height)+25, 100, 50);
        
        [self.roomsViews setHidden:NO];
        
        self.scrollView.contentSize = CGSizeMake(vc.deviceWidth,(self.saveButton.frame.origin.y+self.saveButton.frame.size.height)+150);
        backImg.frame = CGRectMake(0, 0, vc.deviceWidth,(self.saveButton.frame.origin.y+self.saveButton.frame.size.height)+150);
    }
    
    if([self.roomsList count]>4) {
        
        //NSLog(@"Entered 5 data");
        self.roomsViews.frame = CGRectMake(25, 125, vc.deviceWidth-50, vc.deviceHeight*0.7);
        label.frame = CGRectMake(25, (self.roomsViews.frame.origin.y+self.roomsViews.frame.size.height)+25, vc.deviceWidth-50, 25);
        self.commentText.frame = CGRectMake(25, (label.frame.origin.y+label.frame.size.height)+15, vc.deviceWidth-50, 150);
        
        self.saveButton.frame = CGRectMake(50, (self.commentText.frame.origin.y+self.commentText.frame.size.height)+25, 225, 50);
        
        self.cancelButton.frame = CGRectMake(175, (self.commentText.frame.origin.y+self.commentText.frame.size.height)+25, 100, 50);
        
        
        self.scrollView.contentSize = CGSizeMake(vc.deviceWidth,(self.saveButton.frame.origin.y+self.saveButton.frame.size.height)+150);
        backImg.frame = CGRectMake(0, 0, vc.deviceWidth,(self.saveButton.frame.origin.y+self.saveButton.frame.size.height)+150);
    }
    
    [self.roomsViews setHidden:NO];

    if([self.roomsList count]==0) {
        
        [self.roomsViews setHidden:YES];
        
        label.frame = CGRectMake(25, self.view.frame.size.height*0.2, vc.deviceWidth-50, 150);
        self.commentText.frame = CGRectMake(25, vc.deviceHeight*0.32, vc.deviceWidth-50, 150);
        
        self.saveButton.frame = CGRectMake(50, (self.commentText.frame.origin.y+self.commentText.frame.size.height)+25, 225, 50);


        self.scrollView.contentSize = CGSizeMake(vc.deviceWidth,(self.saveButton.frame.origin.y+self.saveButton.frame.size.height)+150);
        backImg.frame = CGRectMake(0, 0, vc.deviceWidth,(self.saveButton.frame.origin.y+self.saveButton.frame.size.height)+150);
    }


    [self.roomsViews reloadData];
   
    currentIndex = nil;
    
    if([self.roomsList count]<6 && [camView isHidden])
    {
        [camView setHidden:NO];
    }

}

//add and the images to gallary
-(void) addRoomImages:(UIImageView *)roomImage {

    ViewController *vc = [ViewController sharedInstance];
    
    [self.roomsViews setHidden:NO];
    
    if(self.currentIndex == nil) {
        UIImageView *imgView = roomImage;
        imgView = roomImage;
        [self.roomsList addObject:imgView];
        
        //NSLog(@"Entered data current index");
        if([self.roomsList count]<=2) {
            
            //NSLog(@"Entered data");
            self.roomsViews.frame = CGRectMake(25, 125, vc.deviceWidth-50, vc.deviceHeight*0.25);
            label.frame = CGRectMake(25, (self.roomsViews.frame.origin.y+self.roomsViews.frame.size.height)+25, vc.deviceWidth-50, 25);
            self.commentText.frame = CGRectMake(25, (label.frame.origin.y+label.frame.size.height)+2, vc.deviceWidth-50, 150);
            
            self.saveButton.frame = CGRectMake(50, (self.commentText.frame.origin.y+self.commentText.frame.size.height)+25, 225, 50);
            
            self.cancelButton.frame = CGRectMake(175, (self.commentText.frame.origin.y+self.commentText.frame.size.height)+25, 100, 50);
            
            [self.roomsViews setHidden:NO];
            self.scrollView.contentSize = CGSizeMake(vc.deviceWidth,(self.saveButton.frame.origin.y+self.saveButton.frame.size.height)+150);
            backImg.frame = CGRectMake(0, 0, vc.deviceWidth,(self.saveButton.frame.origin.y+self.saveButton.frame.size.height)+150);
        }
        
        if([self.roomsList count]>2 && [self.roomsList count]<=4) {
            
           // NSLog(@"Entered 4 data");
            self.roomsViews.frame = CGRectMake(25, 125, vc.deviceWidth-50, vc.deviceHeight*0.5);
            label.frame = CGRectMake(25, (self.roomsViews.frame.origin.y+self.roomsViews.frame.size.height)+25, vc.deviceWidth-50, 25);
            self.commentText.frame = CGRectMake(25, (label.frame.origin.y+label.frame.size.height)+2, vc.deviceWidth-50, 150);
            
            self.saveButton.frame = CGRectMake(50, (self.commentText.frame.origin.y+self.commentText.frame.size.height)+25, 225, 50);
            
            self.cancelButton.frame = CGRectMake(175, (self.commentText.frame.origin.y+self.commentText.frame.size.height)+25, 100, 50);
            
            [self.roomsViews setHidden:NO];
            self.scrollView.contentSize = CGSizeMake(vc.deviceWidth,(self.saveButton.frame.origin.y+self.saveButton.frame.size.height)+150);
            backImg.frame = CGRectMake(0, 0, vc.deviceWidth,(self.saveButton.frame.origin.y+self.saveButton.frame.size.height)+150);
        }

        
        if([self.roomsList count]>4) {
            
            //NSLog(@"Entered 5 data");
            self.roomsViews.frame = CGRectMake(25, 125, vc.deviceWidth-50, vc.deviceHeight*0.7);
            label.frame = CGRectMake(25, (self.roomsViews.frame.origin.y+self.roomsViews.frame.size.height)+25, vc.deviceWidth-50, 25);
            self.commentText.frame = CGRectMake(25, (label.frame.origin.y+label.frame.size.height)+2, vc.deviceWidth-50, 150);
            
            self.saveButton.frame = CGRectMake(50, (self.commentText.frame.origin.y+self.commentText.frame.size.height)+25, 225, 50);
            
            self.cancelButton.frame = CGRectMake(175, (self.commentText.frame.origin.y+self.commentText.frame.size.height)+25, 100, 50);
            self.scrollView.contentSize = CGSizeMake(vc.deviceWidth,(self.saveButton.frame.origin.y+self.saveButton.frame.size.height)+150);
            backImg.frame = CGRectMake(0, 0, vc.deviceWidth,(self.saveButton.frame.origin.y+self.saveButton.frame.size.height)+150);
        }
        
        [self.roomsViews setHidden:NO];
        current_index++;
        
        
        
    } else {
        
        if([self.roomsList count]!=0) {
            UIImageView *imgView = [self.roomsList objectAtIndex:self.currentIndex.row];
            imgView.image = roomImage.image;
            [self.roomsList removeObjectAtIndex:self.currentIndex.row];
            [self.roomsList insertObject:imgView atIndex:self.currentIndex.row];
            [self.roomsViews reloadData];
            
            /*UIImageView  *img_view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 125, 125)];
            
            img_view.image = roomImage.image;
            
            [self.view addSubview:img_view];*/
        }
    }
    
    self.currentIndex = nil;
    
    //NSLog(@"entered");
    
    [self.roomsViews reloadData];
    
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

}

#pragma mark--collectionview delegate functions

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [self.roomsList count];
}

-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *cellIdentifier = @"cellIdentifier";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    [cell setBackgroundColor:[UIColor whiteColor]];
    //[cell.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    //[cell.layer setBorderWidth:0.5];
    [cell.layer setShadowColor:[[UIColor lightGrayColor] CGColor]];
    [cell.layer setShadowOffset:CGSizeMake(-10, 10)];
    [cell.layer setShadowRadius:5.0];
    [cell.layer setShadowOpacity:0.5];
    
    //UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 45, 45)];
    
    //NSString *text = ((UploadContentView *)[self.itemsInformation objectAtIndex:indexPath.row]).uploadItemTypeText.text;
    
    
    
    /*UIImageView *imgView = NULL;
     imgView = [[UIImageView alloc] initWithFrame:CGRectMake(5,5, 75, 75)];
     
     imgView.image = [UIImage imageNamed:@"menu1.png"];*/
    
    [cell addSubview:[self.roomsList objectAtIndex:indexPath.row]];
    //[cell addSubview:imgView];
    
    //[label setText:text];
    
    //[cell addSubview:label];
    
    
    return cell;
    
    
}

-(CGSize) collectionView:(UICollectionView *) collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(125, 125);
    
}

- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(5, 5, 5, 5);
    
}

-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPat
{
    
    
    
    self.currentIndex = indexPat;
    
    
    if(!delete_image) {
        
        [self editUploadImage:nil];
    }
    
    if(delete_image) {
        
        
        
        [self.roomsList removeObjectAtIndex:currentIndex.row];
        [self.roomsViews deleteItemsAtIndexPaths:[NSArray arrayWithObject:currentIndex]];
        
        [self.roomsViews reloadData];
        
        
        
    }
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    /*if (kind == UICollectionElementKindSectionHeader) {
        
        UICollectionReusableView *reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        
        if (reusableview==nil) {
            reusableview=[[UICollectionReusableView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        }
        
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
        
        UIImageView *backView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 40, 40)];
        
        backView.image = [UIImage imageNamed:@"back.png"];
        
        [backView setUserInteractionEnabled:YES];
        
        UITapGestureRecognizer *backTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backToRoomCommentsView:)];
        
        [backView addGestureRecognizer:backTap];
        
        [headerView addSubview:backView];*/
        
        
        /*UIImageView *deleteView = [[UIImageView alloc] initWithFrame:CGRectMake(200, 5, 40, 40)];
        
        deleteView.image = [UIImage imageNamed:@"delete.png"];
        
        [deleteView setUserInteractionEnabled:YES];
        
        UITapGestureRecognizer *deleteTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deleteRooms:)];
        
        [deleteView addGestureRecognizer:deleteTap];
        
        [headerView addSubview:deleteView];
        
        
        UIImageView *addRoomView = [[UIImageView alloc] initWithFrame:CGRectMake(270, 5, 40, 40)];
        
        addRoomView.image = [UIImage imageNamed:@"PlusMenu.png"];
        
        [addRoomView setUserInteractionEnabled:YES];
        
        UITapGestureRecognizer *roomTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addNewRoom:)];
        
        [addRoomView addGestureRecognizer:roomTap];
        
        [headerView addSubview:addRoomView];
        
        
         CALayer *bottomBorder = [CALayer layer];
         
         bottomBorder.frame = CGRectMake(0.0f, 0.0f, self.frame.size.width, 50.0f);
         
         bottomBorder.backgroundColor = [UIColor lightGrayColor].CGColor;
         
         [bottomBorder setShadowColor:[[UIColor blackColor] CGColor]];
         [bottomBorder setShadowOffset:CGSizeMake(-2, 2)];
        
        [headerView.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        [headerView.layer setBorderWidth:0.5];
        [headerView.layer setShadowColor:[[UIColor blackColor] CGColor]];
        [headerView.layer setShadowOffset:CGSizeMake(-2, 2)];
        
        //[headerView.layer addSublayer:bottomBorder];
        
        
        
        //UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        //label.text=@"label";
        [reusableview addSubview:headerView];
        return reusableview;
    }*/
    return nil;
}

#pragma mark--back to roomcomments room

-(void) backToRoomCommentsView:(id) sender {
    
    
    ViewController *vc = [ViewController sharedInstance];
    
    for(unsigned long i=[[vc.barView subviews] count]-1;i>=1;i--) {
        
        id viewItem = [[vc.barView subviews] objectAtIndex:i];
        [viewItem removeFromSuperview];
    }
    
    [vc drawRightMenuView];
    
    [self removeFromParentViewController];
    
}



#pragma mark--saves images and description

-(void) saveData:(id) sender {
    
    ViewController *vc = [ViewController sharedInstance];
    
    NSNumber *imagesPresent = NULL;
    
    //NSLog(@"room list count %d",[self.roomsList count]);
    
    if([self.roomsList count]!=0) {
        
        vc.doneTime  = [NSDate date];
        
        imagesPresent = [[NSNumber alloc] initWithBool:YES];
        
        //NSLog(@"selected room %@",self.roomName);
        
        NSString *imagePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:[NSString stringWithFormat:@"/%@/%@/%@",@"Optiqo",self.customerName,vc.selectedRoomName]];
        
        [[NSFileManager defaultManager] createDirectoryAtPath:imagePath withIntermediateDirectories:YES attributes:nil error:nil];
        
        //NSLog(@" rooms list count %d",[self.roomsList count]);
        
        for(int i=0;i<[self.roomsList count];i++) {
            
            UIImageView *image = [self.roomsList objectAtIndex:i];
            NSData * fullSize = UIImageJPEGRepresentation(image.image, 0.1);
            [fullSize writeToFile:[NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@%d",imagePath,@"image",i+1]] atomically:YES];
 
        }

    }
    else {
        imagesPresent = [[NSNumber alloc] initWithBool:NO];
        //NSLog(@" bool images present %d",[imagesPresent boolValue]);
        vc.doneTime  = [NSDate date];
    }
    
    //NSLog(@" done time %@",vc.doneTime);
    
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *dataContext = [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchData = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CustomerRooms" inManagedObjectContext:dataContext];
    
    [fetchData setEntity:entity];
    
    
    
    //NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData error:&error];
    
    NSManagedObject *userData = nil;
    
    
   
    
    //NSLog(@"customer name %@",self.customerName);
    NSPredicate *pred =[NSPredicate predicateWithFormat:@"(customerName =%@) AND (roomName = %@)",self.customerName,vc.selectedRoomName];

    
    [fetchData setPredicate:pred];
    //NSManagedObject *matches = nil;
    
    NSError *error;
    NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData
                                                       error:&error];
    
    
    //RoomsListView *roomList = (RoomsListView*)[roomComment superview];
    
    //NSLog(@" bool images present after %d",[imagesPresent boolValue]);
    
    if(fetchObjects) {
        if([fetchObjects count]!=0) {
            //NSLog(@"data %d",[imagesPresent boolValue]);
            for(int i=0;i<[fetchObjects count];i++) {
                userData = [fetchObjects objectAtIndex:i];
                [userData setValue:self.commentText.text forKeyPath:@"room_description"];

                [userData setValue:imagesPresent forKey:@"containImages"];
                if(vc.customerList.roomListView.roomComments.isRoomApproved) {
                
                    NSNumber *num = [[NSNumber alloc] initWithBool:YES];
                    NSNumber *marked = [[NSNumber alloc] initWithBool:YES];
                    NSNumber *custReportSent = [[NSNumber alloc] initWithBool:NO];
                    NSNumber *employerReportSent = [[NSNumber alloc] initWithBool:NO];
                    
                    
                    [userData setValue:num forKey:@"approved"];
                    [userData setValue:marked forKey:@"marked"];
                    [userData setValue:vc.currentTime forKey:@"startTime"];
                    [userData setValue:vc.doneTime forKey:@"endTime"];
                    [userData setValue:custReportSent forKey:@"customerReportSent"];
                    [userData setValue:employerReportSent forKey:@"employerReportSent"];

                }
               
                [dataContext save:&error];
                //NSLog(@"error %@",error.description);
            }
        } else {
            
            NSManagedObjectContext *context = [appDelegate managedObjectContext];
            
            NSManagedObject *newContact;
            newContact = [NSEntityDescription
                          insertNewObjectForEntityForName:@"CustomerRooms"
                          inManagedObjectContext:context];
            
            
            
            ViewController *vc = [ViewController sharedInstance];
            
            
            
            //NSLog(@" customer name data %@,%@,%@",customerName,self.roomName,vc.selectedRoomName);
            
            //NSNumber *imagesPresent = [[NSNumber alloc] initWithBool:YES];
            
            [newContact setValue:customerName forKey:@"customerName"];
            [newContact setValue:self.roomName forKey:@"room"];
            [newContact setValue:vc.customerList.roomListView.roomComments.roomNameKey forKey:@"roomKey"];
            [newContact setValue:vc.selectedRoomName forKey:@"roomName"];

            
            [newContact setValue:self.commentText.text forKeyPath:@"room_description"];
            
            //NSLog(@"bool value %d",[imagesPresent boolValue]);
            
            [newContact setValue:imagesPresent forKey:@"containImages"];
            
            if(vc.customerList.roomListView.roomComments.isRoomApproved) {
                
                NSNumber *num = [[NSNumber alloc] initWithBool:YES];
                NSNumber *marked = [[NSNumber alloc] initWithBool:YES];
                NSNumber *custReportSent = [[NSNumber alloc] initWithBool:NO];
                NSNumber *employerReportSent = [[NSNumber alloc] initWithBool:NO];
                
                
                [newContact setValue:num forKey:@"approved"];
                [newContact setValue:marked forKey:@"marked"];
                [newContact setValue:vc.currentTime forKey:@"startTime"];
                [newContact setValue:vc.doneTime forKey:@"endTime"];
                [newContact setValue:custReportSent forKey:@"customerReportSent"];
                [newContact setValue:employerReportSent forKey:@"employerReportSent"];
                
                
            }
            
            
            [context save:&error];
            //NSLog(@"error %@",error.description);
        }
    }
    
   
    
    /*for(unsigned long i=[[vc.barView subviews] count]-1;i>=1;i--) {
        
        id viewItem = [[vc.barView subviews] objectAtIndex:i];
        [viewItem removeFromSuperview];
    }*/

   
    
    //NSLog(@" room approved %d",vc.customerList.roomListView.roomComments.isRoomApproved);
    
    if(vc.customerList.roomListView.roomComments.isRoomApproved) {
        
        
        
        ViewController *vc = [ViewController sharedInstance];
        
        if(!self.reportsListView)
        {
            self.reportsListView = [[ReportsListView alloc] initWithFrame:CGRectMake(0, 0, vc.deviceWidth, vc.deviceHeight) withCustomerName:self.customerName withRoom:self.roomName showOtherButtons:YES];
            [vc.customerList.roomListView.roomComments.view addSubview:self.reportsListView.view];
            self.reportsListView.view.transform = CGAffineTransformMakeTranslation(320, 0);
            id animation = ^{
                
                self.reportsListView.view.transform = CGAffineTransformMakeTranslation(0, 0);
                
            };
            
            [self removeFromParentViewController];
            
            [UIView animateWithDuration:0.5 animations:animation];
        }
        
        
        
        
       
        
        //[roomComment removeFromSuperview];
        //[roomList addBackView];
    }
    else {
        
        id animation = ^{
            
            self.view.transform = CGAffineTransformMakeTranslation(320, 0);
        };
        
        id complete = ^(BOOL finished) {
        
            [self removeFromParentViewController];
            
        };
        
        
        [UIView animateWithDuration:0.5 animations:animation completion:complete];
        
    }

    [self.commentText resignFirstResponder];
}

-(void) cancelView:(id) sender {
    
    ViewController *vc = [ViewController sharedInstance];
    
    for(unsigned long i=[[vc.barView subviews] count]-1;i>=1;i--) {
        
        id viewItem = [[vc.barView subviews] objectAtIndex:i];
        [viewItem removeFromSuperview];
    }
    
    [vc drawRightMenuView];

 
    RoomComments *roomComment = (RoomComments *) [self.view superview];
    RoomsListView *roomList = (RoomsListView*)[roomComment.view superview];
    
    if(roomComment.isRoomApproved) {
    
        [self removeFromParentViewController];
        [roomComment removeFromParentViewController];
        [roomList addBackView];
    }
    else {
        
        [roomComment setViewTitle];
        
        id animation = ^{
          
            self.view.transform = CGAffineTransformMakeTranslation(320, 0);
        };
        
        id completion = ^(BOOL finished) {
        
            [self removeFromParentViewController];
            
        };
        
        [UIView animateWithDuration:0.5 animations:animation completion:completion];
        
    }
    
    
    
}

#pragma --mark textview delegate functions

-(void) textViewDidBeginEditing:(UITextView *)textView {
    
     [self.scrollView setContentOffset:CGPointMake(0.0, (textView.frame.origin.y-50)) animated:YES];
    
}


-(BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    
    
    if([text isEqualToString:@"\n"]) {
        
        
        if([textView.text length]<=80)
        {
            [textView resignFirstResponder];
        
            //CGRect frame = CGRectMake(0, textView.frame.origin.y+300, textView.frame.origin.x, textView.frame.origin.y+50);
        
            [self.scrollView setContentOffset:CGPointMake(0.0, (textView.frame.origin.y-200)) animated:YES];
        
            //[self scrollRectToVisible:frame animated:YES];
        
        
            //self.contentSize = CGSizeMake(vc.deviceWidth,vc.deviceHeight);
        
            return NO;
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[labels valueForKey:@"message"] message:[labels valueForKey:@"max_chars"] delegate:nil cancelButtonTitle:[labels valueForKey:@"ok"] otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    //[textView resignFirstResponder];
    return YES;
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
