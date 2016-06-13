//
//  ProfileView.m
//  Optiqo
//
//  Created by Umapathi on 8/9/14.
//  Copyright (c) 2014 Umapathi. All rights reserved.
//

#import "MenuView.h"
#import "ViewController.h"
#import "AppDelegate.h"

@implementation MenuView

@synthesize profileImage,userName,profileView,oldReports;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        ViewController *vc = [ViewController sharedInstance];
        
        UIColor *color = NULL;
        
        if(vc.cleaningType == 1) {
            color = [vc.colorArray objectAtIndex:1];
        }
        
        if(vc.cleaningType == 2) {
            color = [vc.colorArray objectAtIndex:0];
        }
        
        //sets the labeles to the user language selected
        if([vc.userLanguageSelected isEqualToString:@"Swedish"]) {
            
            labels = [vc.englishLabels valueForKey:@"userswedishlabels"];
        }
        
        if([vc.userLanguageSelected isEqualToString:@"German"]) {
            
            labels = [vc.englishLabels valueForKey:@"usergermanlabels"];
        }
        
        if([vc.userLanguageSelected isEqualToString:@"English"]) {
            
            labels = [vc.englishLabels valueForKey:@"userenglishlabels"];
        }
        
        
        //[self setBackgroundColor:color];
        
        //float redColor,greenColor,blueColor,alpha;
        
        //[color getRed:&redColor green:&greenColor blue:&blueColor alpha:&alpha];
        
        [self setBackgroundColor:[UIColor colorWithRed:41.0/255.0 green:41.0/255.0 blue:42.0/255.0 alpha:1.0]];
        
        //draws the profile view
        [self showProfileView];
        //fetchs the data from database for user
        [self getData];
    }
    return self;
}

#pragma mark --draw all menu views

-(void) showProfileView {
    
    
    UIView *barView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 140)];
    
    [barView setBackgroundColor:[UIColor colorWithRed:41.0/255.0 green:41.0/255.0 blue:42.0/255.0 alpha:1.0]];
    
    
    //sets the title of left menu
    mainMenu = [[UILabel alloc] initWithFrame:CGRectMake(40, 85,150 ,50)];
    
    [mainMenu setBackgroundColor:[UIColor clearColor]];
    
    [mainMenu setText:[labels valueForKey:@"mainmenu"]];
    [mainMenu setTextAlignment:NSTextAlignmentCenter];
    
    [mainMenu setFont:[UIFont fontWithName:@"Avenir-Medium" size:24]];
    
    [mainMenu setTextColor:[UIColor whiteColor]];

    [barView addSubview:mainMenu];
    
    [self addSubview:barView];
    
    
    //draws the user image and label for user profile view. when clicke the user profile view is shown
    self.profileImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width/2-60, 140, 100,100)];
    [self.profileImage.layer setBorderColor:[UIColor whiteColor].CGColor];
    
    
    
    NSString *imagePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:[NSString stringWithFormat:@"/%@",@"Optiqo"]];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"profileImage"]]]) {
        
        
        UIImage *img = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"profileImage"]]];
        self.profileImage.image = [UIImage imageWithCGImage:img.CGImage scale:img.scale orientation:UIImageOrientationLeftMirrored];
        self.profileImage.image = img;
        [self.profileImage setContentMode:UIViewContentModeScaleAspectFill];

    }
    else {
        
        self.profileImage.image = [UIImage imageNamed:@"profile_image.png"];
    }
    
    [self.profileImage.layer setBorderWidth:1.5];
    [self.profileImage.layer setCornerRadius:50.0];
    self.profileImage.layer.masksToBounds = YES;

    
    [self.profileImage setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showUserProfilerView:)];
    
    [self.profileImage addGestureRecognizer:tap];
    
    [self addSubview:self.profileImage];

    
    self.userName = [[UIButton alloc] initWithFrame:CGRectMake(15, 250, self.frame.size.width-50, 50)];
    
    [self.userName setBackgroundColor:[UIColor clearColor]];
    

    
    [self.userName setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.userName.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.userName.titleLabel setFont:[UIFont fontWithName:@"Avenir-Medium" size:24]];
    self.userName.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
    self.userName.titleLabel.numberOfLines = 0;
    
    [self.userName addTarget:self action:@selector(showUserProfilerView:) forControlEvents:UIControlEventTouchUpInside];
    
    

    
    [self addSubview:self.userName];
    
    
    //draws the profile image and label for company profile view. when clicke the company profile view is shown
    UIImageView *settingsView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 320,self.frame.size.width-100,50)];
    [settingsView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    
    settingsView.image = [UIImage imageNamed:@"settings.png"];
    
    [settingsView setContentMode:UIViewContentModeScaleAspectFit];
    

    
    [settingsView setUserInteractionEnabled:YES];
    
    
    UITapGestureRecognizer *settingsTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showProfileView:)];
    
    [settingsView addGestureRecognizer:settingsTap];
    
    
    
    
    [self addSubview:settingsView];

    
    
    self.profileView = [[UIButton alloc] initWithFrame:CGRectMake(40, 375, self.frame.size.width-100, 50)];
    
    [self.profileView setBackgroundColor:[UIColor clearColor]];
    
    [self.profileView setTitle:[labels valueForKey:@"profile"] forState:UIControlStateNormal];
    
    
    
    [self.profileView.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.profileView.titleLabel setFont:[UIFont fontWithName:@"Avenir-Medium" size:24]];
    
    [self.profileView setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.profileView.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.profileView.titleLabel.numberOfLines = 0;
    
    [self.profileView addTarget:self action:@selector(showProfileView:) forControlEvents:UIControlEventTouchUpInside];
    
    
    

    
    [self.profileView setUserInteractionEnabled:YES];
    
    //UITapGestureRecognizer *profileTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showProfileView:)];
    
    //[self.profileView addGestureRecognizer:profileTap];
    
    [self addSubview:profileView];
    
    //draws the report image and label for user oldreport view. when clicke the old report view is shown
    
    UIImageView *reportsView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 430,self.frame.size.width-100,50)];
    [reportsView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    
    [reportsView setUserInteractionEnabled:YES];
    
    
    reportsView.image = [UIImage imageNamed:@"reports.png"];
    
    
    UITapGestureRecognizer *reportTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showOldReportsView:)];
    
    [reportsView addGestureRecognizer:reportTap];
    
    [reportsView setContentMode:UIViewContentModeScaleAspectFit];
    
    [self addSubview:reportsView];

    
    [self addSubview:self.profileView];
    
    self.oldReports = [[UIButton alloc] initWithFrame:CGRectMake(40, 490, self.frame.size.width-100, 25)];
    
    [self.oldReports setBackgroundColor:[UIColor clearColor]];
    
    [self.oldReports setTitle:[labels valueForKey:@"reports"] forState:UIControlStateNormal];
    
    
    [self.oldReports.titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    [self.oldReports.titleLabel setFont:[UIFont fontWithName:@"Avenir-Medium"  size:24]];
    
    [self.oldReports setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.oldReports setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *oldReportsTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showOldReportsView:)];
    
    [self.oldReports addGestureRecognizer:oldReportsTap];
    
    
    [self addSubview:self.oldReports];
    
    
}

//fetches the data for user from database.
-(void) getData {
    
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
        
        for(int i=0;i<[fetchObjects count];i++) {
            
            userData = [fetchObjects objectAtIndex:i];
            NSString *username = [NSString stringWithFormat:@"%@\n%@",[userData valueForKey:@"userFirstName"],[userData valueForKey:@"userLastName"]];
            [self.userName setTitle:username forState:UIControlStateNormal];
    
            if([self.userName.titleLabel.text length]>9) {
                
                self.userName.frame = CGRectMake(20, 250, self.frame.size.width-50, 50);
            }
        }
        
        if([fetchObjects count]==0) {
            
            [self.userName setTitle:[labels valueForKey:@"username"] forState:UIControlStateNormal];
            
            if([self.userName.titleLabel.text length]>9) {
                
                self.userName.frame = CGRectMake(20, 250, self.frame.size.width-50, 50);
            }
        }
    }
    
    
    
    
}

#pragma mark --menu items userinteraction actions

//shows user profile when userview is clicked
-(void) showUserProfilerView:(id) sender {
    
    ViewController *vc = [ViewController sharedInstance];
    [vc showUserView];
}

//shows user profile when profileview is clicked
-(void) showProfileView:(id) sender {
    
    ViewController *vc = [ViewController sharedInstance];
    [vc showPorfileView];
    
}

#pragma mark--shows all old reports 

//shows old reports when oldreportview is clicked
-(void) showOldReportsView:(id) sender {
    
    ViewController *vc = [ViewController sharedInstance];
    [vc showOldReports];
    
}

//resets the labels
-(void) resetLabels {
    
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
    
    [mainMenu setText:[labels valueForKey:@"mainmenu"]];
    [self.profileView setTitle:[labels valueForKey:@"profile"] forState:UIControlStateNormal];
    [self.oldReports setTitle:[labels valueForKey:@"reports"] forState:UIControlStateNormal];
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
