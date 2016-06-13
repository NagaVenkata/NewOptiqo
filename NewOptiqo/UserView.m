//
//  UserView.m
//  NewOptiqo
//
//  Created by Umapathi on 8/13/14.
//  Copyright (c) 2014 Umapathi. All rights reserved.
//

#import "UserView.h"
#import "ViewController.h"
#import "AppDelegate.h"

@implementation UserView

@synthesize userFirstName,userLastName,addImage,profileImage,saveButton,cancelButton,userName,searchList,signView;
@synthesize scrollView = _scrollView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super init];
    if (self) {
        // Initialization code
        
        ViewController *vc = [ViewController sharedInstance];
        
        self.view.frame = CGRectMake(0, 70, frame.size.width, frame.size.height);
        [self.view setBackgroundColor:[UIColor whiteColor]];
        
        [self.view setUserInteractionEnabled:YES];
        
        /*if(vc.cleaningType == 1) {
            
            color = [vc.colorArray objectAtIndex:1];
        }
        
        if(vc.cleaningType == 2) {
            
            color = [vc.colorArray objectAtIndex:0];
        }*/
        
        color = [UIColor blackColor];
        
        font = [UIFont fontWithName:@"Avenir-Medium" size:16];
        
        if([vc.userLanguageSelected isEqualToString:@"Swedish"]) {
            
            labels = [vc.englishLabels valueForKey:@"userswedishlabels"];
        }
        
        if([vc.userLanguageSelected isEqualToString:@"German"]) {
            
            labels = [vc.englishLabels valueForKey:@"usergermanlabels"];
        }
        
        if([vc.userLanguageSelected isEqualToString:@"English"]) {
            
            labels = [vc.englishLabels valueForKey:@"userenglishlabels"];
        }
        
        language = [labels valueForKey:@"language"];
        
        //adds the scroll view on top of main view
        
        self.view.userInteractionEnabled = YES;
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        
        [_scrollView setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview:_scrollView];
        [_scrollView setContentSize:CGSizeMake(320, 585)];
        
        [_scrollView setUserInteractionEnabled:YES];
        
        //draws the contents of the view
        [self drawView];
        //fetches the data from database
        [self getData];
        

    }
    return self;
}

-(void) drawView {
    
    //ViewController *vc = [ViewController sharedInstance];
    
    //NSLog(@"font %@",font);
    
    //sets the background image frame to that of scrollview
    UIImageView  *backImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,_scrollView.contentSize.height)];
    
    backImg.image = [UIImage imageNamed:@"view_background.png"];
    
    [_scrollView addSubview:backImg];

    UILabel *userLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 25, 150, 25)];
    
    [userLabel setText:[labels valueForKey:@"userfirstname"]];
    [userLabel setTextColor:[UIColor blackColor]];
    [userLabel setFont:font];
    [_scrollView addSubview:userLabel];
    
    //draws the user first and last name
    self.userFirstName = [[UITextField alloc] initWithFrame:CGRectMake(50, 45, 225, 50)];
    //[self.userName setLeftViewMode:UITextFieldViewModeAlways];
    //self.userName.leftView = [self getImage];
    self.userFirstName.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    [self.userFirstName setDelegate:self];
    [self.userFirstName setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.5]];
    //[self.userName setText:@" UserName"];
    [self.userFirstName setTextColor:color];
    [self.userFirstName setFont:font];
    
    [self.userFirstName.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.userFirstName.layer setBorderWidth:0.5];
    
    [self.userFirstName resignFirstResponder];
    
    self.userFirstName.returnKeyType = UIReturnKeyDone;
    [self.userFirstName setAutocorrectionType:UITextAutocorrectionTypeNo];
    
    [_scrollView addSubview:self.userFirstName];

    UILabel *userLastNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 105, 150, 25)];
    
    [userLastNameLabel setText:[labels valueForKey:@"userlastname"]];
    [userLastNameLabel setTextColor:[UIColor blackColor]];
    [userLastNameLabel setFont:font];
    [_scrollView addSubview:userLastNameLabel];

    
    self.userLastName = [[UITextField alloc] initWithFrame:CGRectMake(50, 125, 225, 50)];
    //[self.userName setLeftViewMode:UITextFieldViewModeAlways];
    //self.userName.leftView = [self getImage];
    self.userLastName.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    [self.userLastName setDelegate:self];
    [self.userLastName setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.5]];
    //[self.userName setText:@" UserName"];
    [self.userLastName setTextColor:color];
    [self.userLastName setFont:font];
    
    [self.userLastName.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.userLastName.layer setBorderWidth:0.5];
    
    [self.userLastName resignFirstResponder];
    
    self.userLastName.returnKeyType = UIReturnKeyDone;
    [self.userLastName setAutocorrectionType:UITextAutocorrectionTypeNo];
    
    [_scrollView addSubview:self.userLastName];

    
    
    /*self.addImage = [[UIImageView alloc] initWithFrame:CGRectMake(50, 100, 50, 50)];
    
    self.addImage.image = NULL;
    
    if(vc.cleaningType == 1) {
    
        self.addImage.image = [UIImage imageNamed:@"addIcon.png"];
    }
    
    if(vc.cleaningType == 2) {
        
        self.addImage.image = [UIImage imageNamed:@"addGreenIcon.png"];
    }
    
    [self.addImage setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *addImagetap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addImageView:)];
    
    [self.addImage addGestureRecognizer:addImagetap];
    
    [self addSubview:self.addImage];*/
    
    //draws the profile view in an circular frame.
    self.profileImage = [[UIImageView alloc] initWithFrame:CGRectMake(115, 185, 100, 100)];
    
    [self.profileImage setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.5]];
    
    [self.profileImage.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    
    [self.profileImage.layer setBorderWidth:0.5];
    
    [self.profileImage.layer setCornerRadius:50.0];
    
    
    [self.profileImage setImage:[UIImage imageNamed:@"camera.png"]];
    
    [self.profileImage.layer setMasksToBounds:YES];
    
    [self.profileImage setContentMode:UIViewContentModeScaleAspectFit];
    
    [self.profileImage setUserInteractionEnabled:YES];
     
    NSString *imagePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:[NSString stringWithFormat:@"/%@",@"Optiqo"]];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"profileImage"]]]) {
        
        UIImage *image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"profileImage"]]];

        self.profileImage.image = [UIImage imageWithCGImage:image.CGImage scale:image.scale orientation:UIImageOrientationLeftMirrored];
        [self.profileImage setContentMode:UIViewContentModeScaleAspectFill];
        
    } else {
        
        [self.profileImage setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.0]];
        
        [self.profileImage.layer setBorderColor:[[UIColor clearColor] CGColor]];
        
        [self.profileImage.layer setBorderWidth:0.0];
        
        [self.profileImage.layer setCornerRadius:0.0];

    }
    
    UITapGestureRecognizer *profiledImagetap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showProfileView:)];
    
    [self.profileImage addGestureRecognizer:profiledImagetap];
    
    [_scrollView addSubview:self.profileImage];
    
    //draws the button sign button, when clicked a user sign image is shown
    self.signButton = [[UIButton alloc] initWithFrame:CGRectMake(50, 315, 225, 50)];
    
    [self.signButton.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.signButton.layer setBorderWidth:0.5];
    [self.signButton setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.5]];
    
    [self.signButton setTitle:[labels valueForKey:@"signature"] forState:UIControlStateNormal];
    
    [self.signButton setTitleColor:color forState:UIControlStateNormal];
    
    [self.signButton.titleLabel setFont:font];
    
    [self.signButton addTarget:self action:@selector(signView:) forControlEvents:UIControlEventTouchUpInside];
    
    [_scrollView addSubview:self.signButton];
    
    /*ViewController *vc = [ViewController sharedInstance];
    
    UIImageView *saveImage = [[UIImageView alloc] initWithFrame:CGRectMake(vc.deviceWidth-50, 25, 32, 32)];
    
    saveImage.image = [UIImage imageNamed:@"save.png"];
    
    [saveImage setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *saveTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(saveData:)];
    
    [saveImage addGestureRecognizer:saveTap];
    
    [vc.barView addSubview:saveImage];*/
    
    //shows a drop down menu view to select the language.
    self.chooseLanguage = [[UIView alloc] initWithFrame:CGRectMake(50, 375, 225, 50)];
    
    [self.chooseLanguage.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    
    [self.chooseLanguage.layer setBorderWidth:0.5];
    
    [self.chooseLanguage.layer setCornerRadius:5.0];
    
    [self.chooseLanguage setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *languageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseLang:)];
    
    [self.chooseLanguage addGestureRecognizer:languageTap];
    
    [self.chooseLanguage setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.5]];
    
    [_scrollView addSubview:self.chooseLanguage];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 225, 45)];
    
    if([[labels valueForKey:@"language"] isEqualToString:@"Swedish"])
        [label setText:[labels valueForKey:@"swedish"]];
    else
        [label setText:[labels valueForKey:@"english"]];
    
    [label setFont:font];
    
    [label setTextAlignment:NSTextAlignmentCenter];
    
    [label setTextColor:color];
    
    [self.chooseLanguage addSubview:label];

    //save the current settings to the database
    self.saveButton = [[UIButton alloc] initWithFrame:CGRectMake(50, 435, 100, 50)];
    
    [self.saveButton setBackgroundColor:[UIColor colorWithRed:0.0 green:180.0/255.0 blue:0.0 alpha:0.95]];
    [self.saveButton.layer setBorderWidth:0.5];
    
    //[self.saveButton setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.5]];
    
    [self.saveButton setTitle:[labels valueForKey:@"save"] forState:UIControlStateNormal];
    
    [self.saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.saveButton.titleLabel setFont:font];
    
    [self.saveButton addTarget:self action:@selector(saveData:) forControlEvents:UIControlEventTouchUpInside];
    
    [_scrollView addSubview:self.saveButton];
    
    //aborts the view and goes back to main view
    self.cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(175, 435, 100, 50)];
    
    [self.cancelButton.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.cancelButton.layer setBorderWidth:0.5];
    
    [self.cancelButton setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.5]];
    
    [self.cancelButton setTitle:[labels valueForKey:@"cancel"] forState:UIControlStateNormal];
    
    [self.cancelButton setTitleColor:color forState:UIControlStateNormal];
    
    [self.cancelButton.titleLabel setFont:font];
    
    [self.cancelButton addTarget:self action:@selector(cancelView:) forControlEvents:UIControlEventTouchUpInside];
    
    [_scrollView addSubview:self.cancelButton];
    
    //sets the title and menu views for this view
    [self setTitleView];


}

#pragma mark-- add labes and images to barview 

-(void) setTitleView {
    
    ViewController *vc = [ViewController sharedInstance];
    
    /*UIImageView *homeImage = [[UIImageView alloc] initWithFrame:CGRectMake(vc.deviceWidth-50, 25, 32, 32)];
    
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
    
    UILabel *cust_label = [[UILabel alloc] initWithFrame:CGRectMake(75, 25, 150, 32)];
    
    [cust_label setBackgroundColor:[UIColor clearColor]];
    
    [cust_label setText:[labels valueForKey:@"user"]];
    [cust_label setTextColor:[UIColor whiteColor]];
    [cust_label setTextAlignment:NSTextAlignmentCenter];
    [cust_label setFont:[UIFont fontWithName:@"Avenir-Medium" size:18]];
    
    [vc.barView addSubview:cust_label];
    
    /*UILabel *label = (UILabel *) [[vc.barView subviews] objectAtIndex:2];
    
    label.text = @"";
    
    label.text = cust_label.text;*/
    
}


#pragma mark-- back to main view

-(void) backToMainView:(id) sender {
    
    ViewController *vc = [ViewController sharedInstance];
    
    //NSLog(@"num views %d",[[vc.startView subviews] count]);
    
    for(unsigned long i=[[vc.startView subviews] count]-1;i>=3;i--) {
        
        id viewItem = [[vc.startView subviews] objectAtIndex:i];
        [viewItem removeFromSuperview];
    }
    
    for(unsigned long i=[[vc.barView subviews] count]-1;i>=1;i--) {
        
        id viewItem = [[vc.barView subviews] objectAtIndex:i];
        [viewItem removeFromSuperview];
    }
    
    [vc drawRightMenuView];
    [vc setViewTitle];
    
    
    id animation = ^{
        
        _scrollView.transform = CGAffineTransformMakeTranslation(320, 0);
        
    };
    
    id complete = ^(BOOL finished){
        
        
        [_scrollView removeFromSuperview];
        [self removeFromParentViewController];
    };
    
    [UIView animateWithDuration:0.5 animations:animation completion:complete];
    
}

#pragma mark--fetches data from database

-(void) getData {
    
    ViewController *vc = [ViewController sharedInstance];
    
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];

    NSManagedObjectContext *dataContext = [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchData = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:dataContext];
    
    [fetchData setEntity:entity];
    
    NSError *error;
    
    NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData error:&error];
    
    NSManagedObject *userData = nil;
    
    if(fetchObjects) {
        
        if([fetchObjects count]!=0)
        {
            for(int i=0;i<[fetchObjects count];i++) {
            
                userData = [fetchObjects objectAtIndex:i];
                [self.userFirstName setText:[userData valueForKey:@"userFirstName"]];
                [self.userLastName setText:[userData valueForKey:@"userLastName"]];
                language = [userData valueForKey:@"language"];
            
                self.userName = [NSString stringWithFormat:@"%@ %@",[userData valueForKey:@"userFirstName"],[userData valueForKey:@"userLastName"]];
            
                if([language isEqualToString:@"English"] || [language isEqualToString:@"Engelska"])
                    vc.userLanguageSelected = @"English";
                else
                    vc.userLanguageSelected = @"Swedish";
                
            
                
            
                UILabel *label = [[self.chooseLanguage subviews] objectAtIndex:0];
            
                [label setText:language];
            
                //NSLog(@"language %@",language);
            
                if([language isEqualToString:@"Swedish"] || [language isEqualToString:@"Svenska"])
                    [label setText:[labels valueForKey:@"swedish"]];
                else
                    [label setText:[labels valueForKey:@"english"]];

            }
        }
        else
        {
            if([vc.userLanguageSelected isEqualToString:@"Swedish"])
            {
                UILabel *label = [[self.chooseLanguage subviews] objectAtIndex:0];
                
                [label setText:@"Svenska"];
            }
            else
            {
                UILabel *label = [[self.chooseLanguage subviews] objectAtIndex:0];
                
                [label setText:@"English"];
            }
        }
        
    }
    
    
    
    
}

//shows the sign view when cliked on sign button
-(void) signView:(id) sender {
    
    ViewController *vc = [ViewController sharedInstance];
    
    self.signView = [[SignView alloc] init];
    
    self.signView.view.frame = CGRectMake(0,70,vc.deviceWidth,vc.deviceHeight);

    //[self addSubview:signView.view];
    
    /*signView.view.transform = CGAffineTransformMakeTranslation(320, 0);
    
    id animation = ^{
        
      
        signView.view.transform = CGAffineTransformMakeTranslation(0, 0);

        
    };
    
    [UIView animateWithDuration:0.5 animations:animation];*/
    
    //ViewController *vc = [ViewController sharedInstance];
    
    [vc presentViewController:self.signView animated:YES completion:nil];
    
}

#pragma --mark saves the user filled data to user table in database
//saves the data to database
-(void) saveData:(id) sender {
    
    //NSLog(@"entered data");
   
    if([self validateUser]) {
    
        AppDelegate *appDelegate =
        [[UIApplication sharedApplication] delegate];
    
        NSManagedObjectContext *context =
        [appDelegate managedObjectContext];
    
        NSFetchRequest *fetchData = [[NSFetchRequest alloc] init];
    
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:context];
    
        [fetchData setEntity:entity];
    
        NSError *error;
    
        NSArray *fetchObjects = [context executeFetchRequest:fetchData error:&error];
    
        NSManagedObject *userData = nil;
    
        ViewController *vc = [ViewController sharedInstance];
    
        if([fetchObjects count] !=0) {
            
            for(int i=0;i<[fetchObjects count];i++) {
            
                userData = [fetchObjects objectAtIndex:i];
                [userData setValue:self.userFirstName.text forKey:@"userFirstName"];
                [userData setValue:self.userLastName.text forKey:@"userLastName"];
                [userData setValue:language forKey:@"language"];
                [context save:&error];
            
                NSLog(@"error %@",error.description);
            
                NSString *username = [NSString stringWithFormat:@"%@ \n %@",self.userFirstName.text,self.userLastName.text];
                

                
                [vc.menuView.userName setTitle:username forState:UIControlStateNormal];
                
                
                
                vc.userLanguageSelected = language;
                
                
            }
        }
        else {
    
            NSManagedObject *newContact;
            newContact = [NSEntityDescription
                  insertNewObjectForEntityForName:@"User"
                  inManagedObjectContext:context];
            [newContact setValue:self.userFirstName.text forKey:@"userFirstName"];
            [newContact setValue:self.userLastName.text forKey:@"userLastName"];
            [newContact setValue:language forKey:@"language"];
            vc.userLanguageSelected = language;
    
    
            [context save:&error];
        
            NSLog(@"error %@",error.description);
            
            
            
            NSString *username = [NSString stringWithFormat:@"%@ \n %@",self.userFirstName.text,self.userLastName.text];
            

        
            [vc.menuView.userName setTitle:username forState:UIControlStateNormal];
        
           // NSLog(@"error %d",[self.userName.text length]);
        
            /*if([self.userName.text length]>9) {
            
                vc.menuView.userName.frame = CGRectMake(25, 250, self.frame.size.width-25, 50);
            }*/
        
        }
    
        if([language isEqualToString:@"English"] || [language isEqualToString:@"Engelska"])
            vc.userLanguageSelected = @"English";
        else
            vc.userLanguageSelected = @"Swedish";
        
        UILabel *label = [[self.chooseLanguage subviews] objectAtIndex:0];
        
        [label setText:language];
        
        if([[labels valueForKey:@"language"] isEqualToString:@"Swedish"])
            [label setText:[labels valueForKey:@"swedish"]];
        else
            [label setText:[labels valueForKey:@"english"]];

        for(unsigned long i=[[vc.startView subviews] count]-1;i>=4;i--) {
        
            id viewItem = [[vc.startView subviews] objectAtIndex:i];
            [viewItem removeFromSuperview];
        }
    
        for(unsigned long i=[[vc.barView subviews] count]-1;i>=1;i--) {
        
            id viewItem = [[vc.barView subviews] objectAtIndex:i];
            [viewItem removeFromSuperview];
        }
        if(vc.toggleMenu)
            vc.toggleMenu = !vc.toggleMenu;
        //[vc drawRightMenuView];
        [vc setViewTitle];
        [vc resetMenuLabels];
        
        self.signView = nil;
        self.searchList = nil;
    
        [self removeFromParentViewController];
    }
    
    
}

//cancels the current view and goes back to main view.
-(void) cancelView:(id) sender {
    
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
    
    [vc drawRightMenuView];
    [vc setViewTitle];
    

    
    id animation = ^{
        
        _scrollView.transform = CGAffineTransformMakeTranslation(320, 0);
        
    };
    
    id complete = ^(BOOL finished){
        
        
        [self removeFromParentViewController];
    };
    
    [UIView animateWithDuration:0.5 animations:animation completion:complete];
    
    

}

//adds image view

-(void) addImageView:(id) sender {
    
    /*ViewController *vc = [ViewController sharedInstance];
    
    [vc startCamera:nil];*/
    
    UIActionSheet *actionSheet = NULL;
    
    if(self.profileImage.image==NULL) {
    
        actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:[labels valueForKey:@"cancel"] destructiveButtonTitle:nil otherButtonTitles:[labels valueForKey:@"takephoto"],[labels valueForKey:@"choosephoto"], nil];
    }
    else {
        
        actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:[labels valueForKey:@"cancel"] destructiveButtonTitle:nil otherButtonTitles:[labels valueForKey:@"takephoto"],[labels valueForKey:@"choosephoto"], nil];

    }
    
    [actionSheet showInView:_scrollView];
}

//delete the images

-(void) deleteImage {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:[labels valueForKey:@"cancel"] destructiveButtonTitle:[labels valueForKey:@"delete"] otherButtonTitles:nil, nil];
    
    [actionSheet showInView:_scrollView];
}

//chooser the language from drop menu

-(void) chooseLang:(id) sender {
    
    
    if(!self.searchList)
    {
        self.searchList = [[SearchList alloc] initWithFrame:CGRectMake(self.chooseLanguage.frame.origin.x, self.chooseLanguage.frame.origin.y+self.chooseLanguage.frame.size.height, self.chooseLanguage.frame.size.width, 100)];
    
        [self.searchList.view.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    
        [self.searchList.view.layer setBorderWidth:0.5];
    
        [self.searchList setDelegate:self];
    
        [_scrollView addSubview:self.searchList.view];
    }
}

//set the current language choosen

-(void) getSelectedString:(NSString *) searchString {
    
    if([searchString length]!=0) {
        
        UILabel *label = [[self.chooseLanguage subviews] objectAtIndex:0];
        
        [label setText:searchString];
        language = searchString;
        [self.searchList.view removeFromSuperview];
        [self.searchList removeFromParentViewController];
        self.searchList = nil;
    }
    
}


#pragma mark --actionsheet delegate functions
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    NSString *actionButton = [actionSheet buttonTitleAtIndex:buttonIndex];
    
    if([actionButton isEqualToString:[labels valueForKey:@"takephoto"]]) {
        
        [self takePhotoWithCamera];
    }
    
    if([actionButton isEqualToString:[labels valueForKey:@"choosephoto"]]) {
        
        [self choosePhotoFromLibrary];
    }
    
    if([actionButton isEqualToString:[labels valueForKey:@"deletephoto"]]) {
        
        [self deleteImage];
    }
    
    if([actionButton isEqualToString:[labels valueForKey:@"delete"]]) {
        
        [self deleteUserImage];
    }
}

#pragma --mark starts the camera view or choose image from library
-(void) takePhotoWithCamera {
    
    ViewController *vc = [ViewController sharedInstance];
    
    [vc startCamera:nil];
}

-(void) choosePhotoFromLibrary {
    
    ViewController *vc = [ViewController sharedInstance];
    
    [vc showImageLibrary];
}

//delets the user image

-(void) deleteUserImage {
    
    [self.profileImage setImage:[UIImage imageNamed:@"camera.png"]];
    
    [self.profileImage.layer setBorderWidth:0.0];
    [self.profileImage.layer setBorderColor:[[UIColor clearColor] CGColor]];
    [self.profileImage.layer setCornerRadius:0.0];
    
    ViewController *vc = [ViewController sharedInstance];
    
    vc.menuView.profileImage = nil;
    
    NSString *imagePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:[NSString stringWithFormat:@"/%@",@"Optiqo"]];
    
    [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"profileImage"]] error:nil];
        
    [self.profileImage setContentMode:UIViewContentModeScaleAspectFit];
    
    [self.profileImage setUserInteractionEnabled:YES];
    
    [self.profileImage setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.0]];
    
    [self.profileImage.layer setBorderColor:[[UIColor clearColor] CGColor]];
    
    [self.profileImage.layer setBorderWidth:0.0];
    
    [self.profileImage.layer setCornerRadius:0.0];
}


//edits the current user image

-(void) showProfileView:(id) sender {
    
    
    UIActionSheet *actionSheet = NULL;
    
    if(self.profileImage.image==NULL) {
        
        actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:[labels valueForKey:@"cancel"] destructiveButtonTitle:nil otherButtonTitles:[labels valueForKey:@"takephoto"],[labels valueForKey:@"choosephoto"], nil];
    }
    else {
        
        actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:[labels valueForKey:@"cancel"] destructiveButtonTitle:nil otherButtonTitles:[labels valueForKey:@"takephoto"],[labels valueForKey:@"choosephoto"],[labels valueForKey:@"deletephoto"], nil];
        
    }
    
    [actionSheet showInView:_scrollView];
    
}

#pragma mark--textfield delegate functions

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    //UITextPosition *beginning = [textField beginningOfDocument];
    
    //[textField setSelectedTextRange:[textField textRangeFromPosition:beginning toPosition:beginning]];
    
    if([textField.text length]==0) {
        textField.placeholder = nil;
        textField.text = @"";
    }
    

}

-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    
    return YES;
}



- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if([textField.text length]==0)
        textField = nil;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    ViewController *vc = [ViewController sharedInstance];
    
    
    
    //vc.toggleMenu = !vc.toggleMenu;
    
    if(vc.toggleMenu) {
        
        //NSLog(@" toogle view in user %d",vc.toggleMenu);
        
        id animation = ^{
            
            vc.startView.transform = CGAffineTransformMakeTranslation(0, 0);
            vc.menuView.transform = CGAffineTransformMakeTranslation(-vc.deviceWidth, 0);
            //[vc.menuView setHidden:YES];
            vc.toggleMenu = !vc.toggleMenu;
        };
        
        [UIView animateWithDuration:0.5 animations:animation];
        
    }
    
    if(!searchList.view.isHidden) {
        
        [searchList.view setHidden:YES];
        [searchList.view removeFromSuperview];
        [searchList removeFromParentViewController];
        searchList = nil;
    }
    
}

-(UIImageView *) getImage {
    
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"transparent.png"]];
    
    image.frame = CGRectMake(0, 0, 8, 8);
    
    [image setContentMode:UIViewContentModeScaleAspectFit];
    
    return image;
}
//validates the user input field
-(BOOL) validateUser {
    
    
    if([self.userFirstName.text length]==0) {
        
        [self.userFirstName becomeFirstResponder];
        return NO;
    }
    
    if([self.userLastName.text length]==0) {
        
        [self.userLastName becomeFirstResponder];
        return NO;
    }
    
    NSString *imagePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:[NSString stringWithFormat:@"/%@/%@",@"Optiqo",@"userSign.jpg"]];
    
    if(![[NSFileManager defaultManager] fileExistsAtPath:imagePath]) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[labels valueForKey:@"signature"] message:@"Add Signature" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    
    
    
    /*if([language isEqualToString:[labels valueForKey:@"language"]]) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[labels valueForKey:@"Language"] message:@"Choose Language" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }*/
    
    return YES;

}



-(void) dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    self.searchList = nil;
    self.signView = nil;
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
