//
//  ProfileView.h
//  Optiqo
//
//  Created by Umapathi on 8/10/14.
//  Copyright (c) 2014 Umapathi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileView : UIViewController<UITextFieldDelegate,UIScrollViewDelegate,UITextViewDelegate,UIActionSheetDelegate,NSXMLParserDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate> {
    
    UITextField *currentTextField;
    CGPoint offset;
    
    UIColor *color;
    UIFont *font;
    
    NSString *element;
    
    NSDictionary *labels;
    
    NSURL *imageURL;
    NSData *imageData;
    
    NSString *imageLink;
    
    NSMutableString *companyContent;
    NSMutableString *cityContent;

}

@property (nonatomic,strong) UIScrollView *scrollView;

@property (nonatomic,strong) UITextField *companyURL;

@property (nonatomic,strong) UITextField *companyName;
@property (nonatomic,strong) UITextField *streetName;
@property (nonatomic,strong) UITextField *city;
@property (nonatomic,strong) UITextField *boxAddress;
@property (nonatomic,strong) UITextField *country;
@property (nonatomic,strong) UITextField *countryCode;
@property (nonatomic,strong) UITextField *phoneNumber;
@property (nonatomic,strong) UITextField *taxNumber;
@property (nonatomic,strong) UITextField *email;
@property (nonatomic,strong) UITextField *webLink;
@property (nonatomic,strong) UITextView *emailDescription;
@property (nonatomic,strong) UITextField *subjectInfoText;
@property (nonatomic,strong) UIImageView *addImage;
@property (nonatomic,strong) UIImageView *logoImage;
@property (nonatomic,strong) UIButton *saveButton;
@property (nonatomic,strong) UIButton *cancelButton;
@property (nonatomic,strong) NSString *emailBody;

//initialize the view
-(id) initWithFrame:(CGRect) frame;
//draws the view contents
-(void) drawView;
//keyboard notifiction
-(void) registerForKeyboardNotifications;
//fetchs the data from database
-(void) getData;
//validate the profile view
-(BOOL) validate;

//parse xml data
-(void) parseCompanyXML;

-(UIImageView *) getImage;

//-(void) showImageLibrary;

//logo image
-(void) setLogoImageView:(UIImage *)logoImage;

@end
