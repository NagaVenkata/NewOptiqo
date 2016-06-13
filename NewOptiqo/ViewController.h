//
//  ViewController.h
//  Optiqo
//
//  Created by Umapathi on 8/8/14.
//  Copyright (c) 2014 Umapathi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>
#include "MenuView.h"
#include "RightMenuView.h"
#include "ProfileView.h"
#include "UserView.h"
#include "CustomersList.h"
#include "CommentsRoom.h"
#include "ShowOldReportsView.h"
#include "InitialHelpView.h"
#include "ReportsListView.h"

@interface ViewController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate,MFMailComposeViewControllerDelegate,UIAlertViewDelegate> {
    
    UIImage *cam_image;
    
    CABasicAnimation *anim,*anim1;
    
    UIImageView  *backImg;
    
    BOOL isforwardScale;
    
    UIImageView *startButton;
    
    NSString *customerName;
    
    NSString *companyName;
    
    NSDictionary *labels;
    
    BOOL isCustomerReportSent,isEmployerReportSent,isReportSent;
    
    UIScrollView *profileScrollView;
    
    ReportsListView  *reportListView;
    
    BOOL isSendMailCustomer;
    
}

//start view
@property (nonatomic,strong) UIView *startView;

//bar view
@property (nonatomic,strong) UIView *barView;

//bottom bar view
@property (nonatomic,strong) UIView *bottomBarView;


//menu View
@property (nonatomic,strong) MenuView *menuView;

//right menu View
@property (nonatomic,strong) RightMenuView *rightmenuView;


//profile View
@property (nonatomic,strong) ProfileView *profileView;

//profile View
@property (nonatomic,strong) UserView *userView;

//old report room
@property (nonatomic,strong) ShowOldReportsView *reports;

//customer View
@property (nonatomic,strong) CustomersList *customerList;

//Comments Room
@property (nonatomic,strong) CommentsRoom *commentsRoom;


//array to store the colors
@property (strong,nonatomic) NSMutableArray *colorArray;

//value to choose the type of customer
@property (readwrite) int cleaningType;


//customer name
@property (nonatomic,strong) NSString *customerName;


//language selected
@property (nonatomic,strong) NSString *userLanguageSelected;

//language selected
@property (nonatomic,strong) NSString *customerLanguageSelected;

//swedish labels
@property (nonatomic,strong) NSDictionary *swedishLabels;

//german labels
@property (nonatomic,strong) NSDictionary *germanLabels;


//englsih labels
@property (nonatomic,strong) NSDictionary *englishLabels;

@property (nonatomic,strong) NSString *selectedRoomName;

//current device width and height
@property (readwrite) float deviceWidth;
@property (readwrite) float deviceHeight;
@property (readwrite) BOOL  toggleMenu;
@property (readwrite) BOOL  toggleRightMenu;

@property (readwrite) float lat;
@property (readwrite) float lan;


@property (nonatomic,strong) NSDate *currentTime;
@property (nonatomic,strong) NSDate *doneTime;

@property (readwrite) BOOL isCustomer;

@property (readwrite) BOOL isHomeCleaningSelected;

@property (readwrite) BOOL isOfficeCleaningSelected;

@property (nonatomic,strong) NSDate *reportSentDate;

@property (nonatomic,strong) UIView *activityView;

@property (nonatomic,strong) NSDate *customerStartTime;

@property (nonatomic,strong) NSDate *customerEndTime;


//singleton instance
+(id) sharedInstance;


//draw views
-(void) drawStartView;
-(void) drawBarView;
-(void) showUserView;
-(void) showPorfileView;
-(void) showOldReports;

//camera view for different purpouse
-(void) startCamera:(UIImage *) image;
-(void) startCameraCommentRoom;
-(void) showImageLibrary;
-(void) showImageLibrary:(UIScrollView *) scrollView;
-(void) drawRightMenuView;
-(void) resetMenuView;
-(void) setViewTitle;

//sends customer and employer reports
-(void) sendEmail:(NSArray *) filenames withPercent:(int) percent withMailAttrs:(NSMutableArray *) attrs;

//moves the background image forword and backward.
-(void) scalefarward;
-(void) scalebackward;

//resets the menu labels according to current language selected
-(void) resetMenuLabels;

//fetchs data from database
-(void) getData;

//sets the customer report to true
-(void) setCustomerReport;

//sets the employer
-(void) setEmployerReport;

//checks the customer and employer report status
-(void) checkReportStatus;

//resets the customer and employer report status
-(void) resetReportsStatus;

//gets user selected language
-(void) getUserSelectedLanguage;

//gets app user name
-(NSString *) getAppUserName;

//gets employer email message
-(NSString *) getEmployerEmailBody;

//send email to customer
-(void) sendEmail:(NSString *)email;

//sets the report status 
-(void) updatReportStatus;

//check user or employer information present if not a alert is shown to add them
-(BOOL) IsUser_EmployerInfoPresent;

@end
