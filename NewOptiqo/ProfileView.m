//
//  ProfileView.m
//  Optiqo
//
//  Created by Umapathi on 8/10/14.
//  Copyright (c) 2014 Umapathi. All rights reserved.
//

#import "ProfileView.h"
#import "ViewController.h"
#import "AppDelegate.h"

@implementation ProfileView
@synthesize companyName,streetName,city,boxAddress,country,countryCode,phoneNumber,taxNumber,email,webLink,emailDescription,subjectInfoText,logoImage,saveButton,cancelButton,companyURL,emailBody;
@synthesize scrollView = _scrollView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super init];
    if (self) {
        // Initialization code
        
        ViewController *vc = [ViewController sharedInstance];
        
        /*if(vc.cleaningType == 1) {
            
            color = [vc.colorArray objectAtIndex:1];
        }
        
        if(vc.cleaningType == 2) {
            
            color = [vc.colorArray objectAtIndex:0];
        }*/
        
        self.view.frame = frame;
        
        if([vc.userLanguageSelected isEqualToString:@"Swedish"]) {
            
            labels = [vc.englishLabels valueForKey:@"userswedishlabels"];
        }
        
        if([vc.userLanguageSelected isEqualToString:@"German"]) {
            
            labels = [vc.englishLabels valueForKey:@"usergermanlabels"];
        }
        
        if([vc.userLanguageSelected isEqualToString:@"English"]) {
            
            labels = [vc.englishLabels valueForKey:@"userenglishlabels"];
        }
        
        [self.view setUserInteractionEnabled:YES];
        
        [_scrollView setUserInteractionEnabled:YES];
        
        
        color = [UIColor colorWithRed:15.0/255.0 green:15.0/255.0 blue:15.0/255.0 alpha:1.0];
        
        font = [UIFont fontWithName:@"Avenir-Medium" size:16.0];

        _scrollView = [[UIScrollView alloc] initWithFrame:frame];
        
        [_scrollView setBackgroundColor:[UIColor whiteColor]];
        //draw view contents
        [self drawView];
        //gets data from database
        [self getData];
        //keyboard registration
        [self registerForKeyboardNotifications];
        
        _scrollView.contentSize = CGSizeMake(320.0,1400.0);
        
        
        
    }
    return self;
}

#pragma --mark draws the view contents and textfield to fill the employer data

-(void) drawView {
    
    //draws the view contents and textfield to fill the employer data
    
    UIImageView  *backImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _scrollView.frame.size.width,1400)];
    
    backImg.image = [UIImage imageNamed:@"view_background.png"];
    
    backImg.userInteractionEnabled = YES;
    
    [_scrollView addSubview:backImg];
    
    UILabel *urlLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 25, 200, 20)];
    
    [urlLabel setText:[labels valueForKey:@"companycode"]];
    [urlLabel setTextColor:color];
    [urlLabel setFont:font];
    [_scrollView addSubview:urlLabel];
    
    CGSize textSize = [urlLabel.text sizeWithAttributes:@{NSFontAttributeName:font}];
    //info image
    UIImageView *company_info = [[UIImageView alloc] initWithFrame:CGRectMake(50+(textSize.width)+10, 22, 20, 20)];
    
    company_info.image = [UIImage imageNamed:@"company_info.png"];
    
    [company_info setContentMode:UIViewContentModeScaleAspectFill];
    
    [company_info setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *addImagetap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showCompanyInfo:)];
     
     [company_info addGestureRecognizer:addImagetap];
    
    [_scrollView addSubview:company_info];
    
    
    self.companyURL = [[UITextField alloc] initWithFrame:CGRectMake(50, 50, 200, 50)];
    //[self.companyURL setLeftViewMode:UITextFieldViewModeAlways];
    //self.companyURL.leftView = [self getImage];
    self.companyURL.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    [self.companyURL setDelegate:self];
    [self.companyURL setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.5]];
    [self.companyURL setTextColor:color];
    [self.companyURL setFont:font];
    
    
    
    [self.companyURL.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];

    [self.companyURL.layer setBorderWidth:0.5];
    [self.companyURL.layer setCornerRadius:0.5];
    
    [self.companyURL resignFirstResponder];
    self.companyURL.autocorrectionType = UITextAutocorrectionTypeNo;
    
    self.companyURL.returnKeyType = UIReturnKeyGo;
    
    [_scrollView addSubview:self.companyURL];
    
    UILabel *companyNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 125, 200, 20)];
    
    [companyNameLabel setText:[labels valueForKey:@"companyname"]];
    [companyNameLabel setTextColor:color];
    [companyNameLabel setFont:font];
    [_scrollView addSubview:companyNameLabel];

    
    
    self.companyName = [[UITextField alloc] initWithFrame:CGRectMake(50, 150, 200, 50)];
    //[self.companyName setLeftViewMode:UITextFieldViewModeAlways];
    //self.companyName.leftView = [self getImage];
    self.companyName.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    [self.companyName setDelegate:self];
    [self.companyName setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.5]];
    //[self.companyName setText:@"Company Name"];
    [self.companyName setTextColor:color];
    [self.companyName setFont:font];
    
    
    [self.companyName.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.companyName.layer setBorderWidth:0.5];
    
    [self.companyName resignFirstResponder];
    self.companyName.autocorrectionType = UITextAutocorrectionTypeNo;
    
    self.companyName.returnKeyType = UIReturnKeyDone;
    
    [_scrollView addSubview:self.companyName];
    
    UILabel *streetNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 225, 200, 20)];
    
    [streetNameLabel setText:[labels valueForKey:@"customeraddress"]];
    [streetNameLabel setTextColor:color];
    [streetNameLabel setFont:font];
    [_scrollView addSubview:streetNameLabel];
    
    
    self.streetName = [[UITextField alloc] initWithFrame:CGRectMake(50, 250, 200, 50)];
    //[self.streetName setLeftViewMode:UITextFieldViewModeAlways];
    //self.streetName.leftView = [self getImage];
    self.streetName.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    [self.streetName setDelegate:self];
    [self.streetName setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.5]];
    //[self.streetName setText:@"Street Name"];
    [self.streetName setTextColor:color];
    [self.streetName setFont:font];
    
    [self.streetName.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.streetName.layer setBorderWidth:0.5];
    
    [self.streetName resignFirstResponder];
    
    //[self.streetName setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    self.streetName.returnKeyType = UIReturnKeyDone;
    self.streetName.autocorrectionType = UITextAutocorrectionTypeNo;
    
    [_scrollView addSubview:self.streetName];
    
    UILabel *cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 325, 200, 20)];
    
    [cityLabel setText:[labels valueForKey:@"city"]];
    [cityLabel setTextColor:color];
    [cityLabel setFont:font];
    [_scrollView addSubview:cityLabel];

    
    
    self.city = [[UITextField alloc] initWithFrame:CGRectMake(50, 350, 200, 50)];
    //[self.boxAddress setLeftViewMode:UITextFieldViewModeAlways];
    //self.boxAddress.leftView = [self getImage];
    self.city.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    [self.city setDelegate:self];
    [self.city setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.5]];
    //[self.boxAddress setText:@"Box Address"];
    [self.city setTextColor:color];
    [self.city setFont:font];
    
    [self.city.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.city.layer setBorderWidth:0.5];
    
    [self.city resignFirstResponder];
    
    self.city.returnKeyType = UIReturnKeyDone;
    self.city.autocorrectionType = UITextAutocorrectionTypeNo;
    
    [_scrollView addSubview:self.city];
    
    UILabel *boxAddressLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 425, 200, 20)];
    
    [boxAddressLabel setText:[labels valueForKey:@"boxaddress"]];
    [boxAddressLabel setTextColor:color];
    [boxAddressLabel setFont:font];
    [_scrollView addSubview:boxAddressLabel];
    
    
    
    self.boxAddress = [[UITextField alloc] initWithFrame:CGRectMake(50, 450, 200, 50)];
    //[self.boxAddress setLeftViewMode:UITextFieldViewModeAlways];
    //self.boxAddress.leftView = [self getImage];
    self.boxAddress.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    [self.boxAddress setDelegate:self];
    [self.boxAddress setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.5]];
    //[self.boxAddress setText:@"Box Address"];
    [self.boxAddress setTextColor:color];
    [self.boxAddress setFont:font];
    
    [self.boxAddress.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.boxAddress.layer setBorderWidth:0.5];
    
    [self.boxAddress resignFirstResponder];
    
    self.boxAddress.returnKeyType = UIReturnKeyDone;
    self.boxAddress.autocorrectionType = UITextAutocorrectionTypeNo;
    
    [_scrollView addSubview:self.boxAddress];

    
    
    UILabel *countryLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 525, 200, 20)];
    
    [countryLabel setText:[labels valueForKey:@"country"]];
    [countryLabel setTextColor:color];
    [countryLabel setFont:font];
    [_scrollView addSubview:countryLabel];

    
    
    self.country = [[UITextField alloc] initWithFrame:CGRectMake(50, 550, 200, 50)];
    //[self.country setLeftViewMode:UITextFieldViewModeAlways];
    //self.country.leftView = [self getImage];
    self.country.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    [self.country setDelegate:self];
    [self.country setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.5]];
    //[self.country setText:@"Country"];
    [self.country setTextColor:color];
    [self.country setFont:font];
    
    [self.country.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.country.layer setBorderWidth:0.5];
    
    [self.country resignFirstResponder];
    
    self.country.returnKeyType = UIReturnKeyDone;
    self.country.autocorrectionType = UITextAutocorrectionTypeNo;
    
    [_scrollView addSubview:self.country];
    
    /*UILabel *codeLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 625, 50, 20)];
    
    [codeLabel setText:[labels valueForKey:@"code"]];
    [codeLabel setTextColor:color];
    [codeLabel setFont:font];
    [_scrollView addSubview:codeLabel];

    
    
    self.countryCode = [[UITextField alloc] initWithFrame:CGRectMake(50, 650, 50, 50)];
    //[self.countryCode setLeftViewMode:UITextFieldViewModeAlways];
    //self.countryCode.leftView = [self getImage];
    self.countryCode.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    [self.countryCode setDelegate:self];
    [self.countryCode setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.5]];
    //[self.countryCode setText:@"Code"];
    [self.countryCode setTextColor:color];
    [self.countryCode setFont:font];
    
    [self.countryCode.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.countryCode.layer setBorderWidth:0.5];
    
    [self.countryCode resignFirstResponder];
    
    self.countryCode.keyboardType = UIKeyboardTypeDecimalPad;
    self.countryCode.returnKeyType = UIReturnKeyDone;
    
    [_scrollView addSubview:self.countryCode];*/
    
    
    UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 625, 150, 20)];
    
    [phoneLabel setText:[labels valueForKey:@"phonenumber"]];
    [phoneLabel setTextColor:color];
    [phoneLabel setFont:font];
    [_scrollView addSubview:phoneLabel];

    
    self.phoneNumber = [[UITextField alloc] initWithFrame:CGRectMake(50, 650, 200, 50)];
    //[self.phoneNumber setLeftViewMode:UITextFieldViewModeAlways];
    //self.phoneNumber.leftView = [self getImage];
    self.phoneNumber.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    [self.phoneNumber setDelegate:self];
    [self.phoneNumber setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.5]];
    //[self.phoneNumber setText:@"Phone Number"];
    [self.phoneNumber setTextColor:color];
    [self.phoneNumber setFont:font];
    
    [self.phoneNumber.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.phoneNumber.layer setBorderWidth:0.5];
    
    [self.phoneNumber resignFirstResponder];

    self.phoneNumber.returnKeyType = UIReturnKeyDone;
    self.phoneNumber.autocorrectionType = UITextAutocorrectionTypeNo;

    
    [_scrollView addSubview:self.phoneNumber];
    
    
    UILabel *taxLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 725, 200, 20)];
    
    [taxLabel setText:[labels valueForKey:@"taxnumber"]];
    [taxLabel setTextColor:color];
    [taxLabel setFont:font];
    [_scrollView addSubview:taxLabel];

    
    self.taxNumber = [[UITextField alloc] initWithFrame:CGRectMake(50, 750, 200, 50)];
    //[self.taxNumber setLeftViewMode:UITextFieldViewModeAlways];
    //self.taxNumber.leftView = [self getImage];
    self.taxNumber.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    [self.taxNumber setDelegate:self];
    [self.taxNumber setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.5]];
    //[self.taxNumber setText:@"Tax Number"];
    [self.taxNumber setTextColor:color];
    [self.taxNumber setFont:font];
    
    [self.taxNumber.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.taxNumber.layer setBorderWidth:0.5];
    
    [self.taxNumber resignFirstResponder];
    
    self.taxNumber.returnKeyType = UIReturnKeyDone;
    self.taxNumber.autocorrectionType = UITextAutocorrectionTypeNo;
    
    [_scrollView addSubview:self.taxNumber];
    
    //875
    UILabel *emailLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 825, 200, 20)];
    
    [emailLabel setText:[labels valueForKey:@"email"]];
    [emailLabel setTextColor:color];
    [emailLabel setFont:font];
    [_scrollView addSubview:emailLabel];
    
    self.email = [[UITextField alloc] initWithFrame:CGRectMake(50, 850, 200, 50)];
    //[self.email setLeftViewMode:UITextFieldViewModeAlways];
    //self.email.leftView = [self getImage];
    self.email.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    [self.email setDelegate:self];
    [self.email setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.5]];
    //[self.email setText:@"E-Mail"];
    [self.email setTextColor:color];
    [self.email setFont:font];
    
    [self.email.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.email.layer setBorderWidth:0.5];
    
    [self.email resignFirstResponder];
    
    [self.email setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    self.email.returnKeyType = UIReturnKeyDone;
    self.email.autocorrectionType = UITextAutocorrectionTypeNo;
    
    [_scrollView addSubview:self.email];
    
    
    UILabel *webLinkLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 925, 200, 20)];
    
    [webLinkLabel setText:[labels valueForKey:@"url"]];
    [webLinkLabel setTextColor:color];
    [webLinkLabel setFont:font];
    [_scrollView addSubview:webLinkLabel];
    
    
    
    self.webLink = [[UITextField alloc] initWithFrame:CGRectMake(50, 950, 200, 50)];
    //[self.webLink setLeftViewMode:UITextFieldViewModeAlways];
    //self.webLink.leftView = [self getImage];
    self.webLink.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    [self.webLink setDelegate:self];
    [self.webLink setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.5]];
    //[self.webLink setText:@"Web Link"];
    [self.webLink setTextColor:color];
    [self.webLink setFont:font];
    
    [self.webLink.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.webLink.layer setBorderWidth:0.5];
    
    [self.webLink resignFirstResponder];
    
    self.webLink.returnKeyType = UIReturnKeyDone;
    [self.webLink setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    self.webLink.autocorrectionType = UITextAutocorrectionTypeNo;
    
    [_scrollView addSubview:self.webLink];

    
    
    UILabel *subjectinfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 1025, 250, 20)];
    
    [subjectinfoLabel setText:[labels valueForKey:@"emailsubject"]];
    [subjectinfoLabel setTextColor:color];
    [subjectinfoLabel setFont:font];
    //[_scrollView addSubview:subjectinfoLabel];
    
    
    self.subjectInfoText = [[UITextField alloc] initWithFrame:CGRectMake(50, 1050, 200, 50)];
    //[self.subjectInfoText setLeftViewMode:UITextFieldViewModeAlways];
    //self.subjectInfoText.leftView = [self getImage];
    self.subjectInfoText.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    [self.subjectInfoText setDelegate:self];
    [self.subjectInfoText setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.5]];
    //[self.subjectInfoText setText:@"Enter mail subject line"];
    [self.subjectInfoText setTextColor:color];
    [self.subjectInfoText setFont:font];
    
    [self.subjectInfoText.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.subjectInfoText.layer setBorderWidth:0.5];
    
    [self.subjectInfoText resignFirstResponder];
    
    self.subjectInfoText.returnKeyType = UIReturnKeyDone;
    self.subjectInfoText.autocorrectionType = UITextAutocorrectionTypeNo;
    
    //[_scrollView addSubview:self.subjectInfoText];


    
    
    UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 1025, 200, 20)];
    
    [descriptionLabel setText:[labels valueForKey:@"description"]];
    emailDescription.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    [descriptionLabel setTextColor:color];
    [descriptionLabel setFont:font];
    [_scrollView addSubview:descriptionLabel];
    
    self.emailDescription = [[UITextView alloc] initWithFrame:CGRectMake(50, 1050, 200, 100)];
    [self.emailDescription setDelegate:self];
    [self.emailDescription setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.5]];
    //[self.description setText:@"Description"];
    [self.emailDescription setTextColor:color];
    [self.emailDescription setFont:font];
    
    [self.emailDescription.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.emailDescription.layer setBorderWidth:0.5];
    
    [self.emailDescription resignFirstResponder];
    
    self.emailDescription.returnKeyType = UIReturnKeyDone;
    self.emailDescription.autocorrectionType = UITextAutocorrectionTypeNo;
    
    [_scrollView addSubview:self.emailDescription];

    
    
    
    self.logoImage = [[UIImageView alloc] initWithFrame:CGRectMake(50, 1175, 200, 50)];
    
    self.logoImage.image = [UIImage imageNamed:@"report_icon.png"];
    
    [self.logoImage setContentMode:UIViewContentModeScaleAspectFill];
    
    imageData = UIImageJPEGRepresentation(self.logoImage.image, 0.7);
    
    //[self.logoImage setUserInteractionEnabled:YES];
    
    /*UITapGestureRecognizer *addImagetap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addImageView:)];
    
    [self.addImage addGestureRecognizer:addImagetap];*/
    
    [_scrollView addSubview:self.logoImage];
    
    
    /*self.logoImage = [[UIImageView alloc] initWithFrame:CGRectMake(50, 1175, 200, 50)];
    
    
    [self.logoImage addGestureRecognizer:addImagetap];
    
    [self addSubview:self.logoImage];*/
    
    
    self.saveButton = [[UIButton alloc] initWithFrame:CGRectMake(50, 1250, 100, 50)];
    
    [self.saveButton setBackgroundColor:[UIColor colorWithRed:0.0 green:180.0/255.0 blue:0.0 alpha:0.95]];
    [self.saveButton.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.saveButton.layer setBorderWidth:0.5];
    
    [self.saveButton setTitle:[labels valueForKey:@"save"] forState:UIControlStateNormal];
    
    [self.saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.saveButton.titleLabel setFont:font];
    
    [self.saveButton addTarget:self action:@selector(saveData:) forControlEvents:UIControlEventTouchUpInside];
    
    [_scrollView addSubview:self.saveButton];
    
    
    self.cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(175, 1250, 100, 50)];
    
    [self.cancelButton.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.cancelButton.layer setBorderWidth:0.5];
    
    [self.cancelButton setTitle:[labels valueForKey:@"cancel"] forState:UIControlStateNormal];
    
    [self.cancelButton.titleLabel setFont:font];
    
    [self.cancelButton setTitleColor:color forState:UIControlStateNormal];
    
    [self.cancelButton addTarget:self action:@selector(cancelView:) forControlEvents:UIControlEventTouchUpInside];
    
    [_scrollView addSubview:self.cancelButton];
    
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
    
    UILabel *cust_label = NULL;
    
    if([[labels valueForKey:@"addprofile"] length]<=11)
        cust_label = [[UILabel alloc] initWithFrame:CGRectMake(50, 25, 200, 32)];
    else
        cust_label = [[UILabel alloc] initWithFrame:CGRectMake(60, 25, 200, 32)];
    
    [cust_label setBackgroundColor:[UIColor clearColor]];
    
    [cust_label setText:[labels valueForKey:@"profile"]];
    [cust_label setTextColor:[UIColor whiteColor]];
    [cust_label setTextAlignment:NSTextAlignmentCenter];
    [cust_label setFont:[UIFont fontWithName:@"Avenir-Medium"  size:18]];
    
    [vc.barView addSubview:cust_label];
    
    
}

#pragma mark-- shows company info message box

-(void) showCompanyInfo:(id) sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[labels valueForKey:@"message"] message:[labels valueForKey:@"companyInfoMessage"] delegate:nil cancelButtonTitle:[labels valueForKey:@"ok"] otherButtonTitles:nil, nil];
    //alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    /*UITextField *textField = [alert textFieldAtIndex:0];
    [textField setBackgroundColor:[UIColor whiteColor]];
    //textField.delegate = self;
    textField.borderStyle = UITextBorderStyleNone;
    textField.frame = CGRectMake(15, 75, 255, 30);
    textField.text = @"www.optiqo.se";
    textField.keyboardAppearance = UIKeyboardAppearanceAlert;
    //[textField becomeFirstResponder];
    //[alert addSubview:textField];*/
    
    [alert show];
}



#pragma mark-- back to main view

-(void) backToMainView:(id) sender {
    
    ViewController *vc = [ViewController sharedInstance];
    
    //NSLog(@"num views %ld",(long)[[vc.startView subviews] count]);
    
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
        
        _scrollView.transform = CGAffineTransformMakeTranslation(320, 0);
        
    };
    
    id complete = ^(BOOL finished){
        
        
        [_scrollView removeFromSuperview];
    };
    
    [UIView animateWithDuration:0.5 animations:animation completion:complete];
    
}

#pragma mark--fetches data from database

-(void) getData {
    
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *dataContext = [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchData = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Employee" inManagedObjectContext:dataContext];
    
    [fetchData setEntity:entity];
    
    NSError *error;
    
    NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData error:&error];
    
    NSManagedObject *userData = nil;
    
    if(fetchObjects) {
        
        for(int i=0;i<[fetchObjects count];i++) {
            
            userData = [fetchObjects objectAtIndex:i];
            
            [self.companyName setText:[userData valueForKey:@"companyName"]];
            [self.streetName setText:[userData valueForKey:@"streetName"]];
            [self.city setText:[userData valueForKey:@"city"]];
            [self.boxAddress setText:[userData valueForKey:@"boxAddress"]];
            [self.country  setText:[userData valueForKey:@"country"]];
            [self.countryCode setText:[userData valueForKey:@"countryCode"]];
            [self.phoneNumber setText:[userData valueForKey:@"phoneNumber"]];
            [self.taxNumber setText:[userData valueForKey:@"taxNumber"]];
            [self.email setText:[userData valueForKey:@"email"]];
            [self.webLink setText:[userData valueForKey:@"webLink"]];
            [self.emailDescription setText:[userData valueForKey:@"descriptionText"]];
            [self.subjectInfoText setText:[userData valueForKey:@"emailSubject"]];
            imageLink = [userData valueForKey:@"imageLink"];
            
            self.emailBody = [userData valueForKey:@"descriptionText"];
            

        }
    }
    
    NSString *imagePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:[NSString stringWithFormat:@"/%@",@"Optiqo"]];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"companyLogoImage"]]]) {
        
        
        UIImage *img = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"companyLogoImage"]]];
        self.logoImage.image = img;
        
        [self setLogoImageView:img];
        
        [self.addImage setHidden:YES];
        
        [self.addImage removeFromSuperview];
        
        self.addImage = nil;
        
        imageData = UIImagePNGRepresentation(img);
    }
    
    
    
    
}

#pragma --mark saves the data to the database

-(void) saveData:(id) sender {
    
    if([self validate]) {
        
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        
        NSManagedObjectContext *context =
        [appDelegate managedObjectContext];
        
        NSFetchRequest *fetchData = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Employee" inManagedObjectContext:context];
        
        [fetchData setEntity:entity];
        
        NSError *error;
        
        NSArray *fetchObjects = [context executeFetchRequest:fetchData error:&error];
        
        NSManagedObject *userData = nil;
        
        //ViewController *vc = [ViewController sharedInstance];
        
        if([fetchObjects count] !=0) {
            
            for(int i=0;i<[fetchObjects count];i++) {
                
                userData = [fetchObjects objectAtIndex:i];
                [userData setValue:self.companyName.text forKey:@"companyName"];
                [userData setValue:self.streetName.text forKey:@"streetName"];
                [userData setValue:self.city.text forKey:@"city"];
                [userData setValue:self.boxAddress.text forKey:@"boxAddress"];
                [userData setValue:self.country.text forKey:@"country"];
                [userData setValue:self.countryCode.text forKey:@"countryCode"];
                [userData setValue:self.phoneNumber.text forKey:@"phoneNumber"];
                [userData setValue:self.taxNumber.text forKey:@"taxNumber"];
                [userData setValue:self.email.text forKey:@"email"];
                [userData setValue:self.webLink.text forKey:@"webLink"];
                [userData setValue:self.emailDescription.text forKey:@"descriptionText"];
                [userData setValue:self.subjectInfoText.text forKey:@"emailSubject"];
                [userData setValue:imageLink forKey:@"imageLink"];
                [context save:&error];
                
                NSLog(@"error %@",error.description);
                
                //[vc.menuView.userName setText:self.companyName.text];
            }
        }
        else {
            
            NSManagedObject *newContact;
            newContact = [NSEntityDescription
                          insertNewObjectForEntityForName:@"Employee"
                          inManagedObjectContext:context];
            [newContact setValue: self.companyName.text forKey:@"companyName"];
            [newContact setValue: self.streetName.text forKey:@"streetName"];
            [newContact setValue:self.city.text forKey:@"city"];
            [newContact setValue: self.boxAddress.text forKey:@"boxAddress"];
            [newContact setValue: self.country.text forKey:@"country"];
            [newContact setValue: self.countryCode.text forKey:@"countryCode"];
            [newContact setValue: self.phoneNumber.text forKey:@"phoneNumber"];
            [newContact setValue: self.taxNumber.text forKey:@"taxNumber"];
            [newContact setValue: self.email.text forKey:@"email"];
            [newContact setValue: self.webLink.text forKey:@"webLink"];
            [newContact setValue: self.emailDescription.text forKey:@"descriptionText"];
            [newContact setValue: self.subjectInfoText.text forKey:@"emailSubject"];
            [newContact setValue: imageLink forKey:@"imageLink"];
            
            [context save:&error];
            
            NSLog(@"error %@",error.description);
            
            //[vc.menuView.userName setTitle:self.companyName.text forState:UIControlStateNormal];
        }
        
        
        NSString *imagePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:[NSString stringWithFormat:@"/%@",@"Optiqo"]];

        if([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"companyLogoImage"]]]) {
            
            [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"companyLogoImage"]] error:nil];
        }
        
        [[NSFileManager defaultManager] createDirectoryAtPath:imagePath withIntermediateDirectories:YES attributes:nil error:nil];
        
        
        
        [imageData writeToFile:[NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"companyLogoImage"]] atomically:YES];

        
        
        NSMutableURLRequest *request =
        [[NSMutableURLRequest alloc] initWithURL:
         [NSURL URLWithString:@"http://optiqoinspect.net16.net/optiqo/server.php"]];
        
        [request setHTTPMethod:@"POST"];
        
        //NSString *postString = @"name=ivybridge&description=This%20is%20desp.";
        
        //NSLog(@"city %@\n",city.text);
        
        NSString *postString = [NSString stringWithFormat:@"companyName=%@&streetName=%@&city=%@&boxAddress=%@&country=%@&code=%@&phoneNumber=%@&taxNumber=%@&email=%@&description=%@&webLink=%@&mailSubject=%@&companyLogo=%@",self.companyName.text,self.streetName.text,self.city.text,self.boxAddress.text,self.country.text,self.countryCode.text,self.phoneNumber.text,self.taxNumber.text,self.email.text,self.emailDescription.text,self.webLink.text,self.subjectInfoText.text,imageLink];
        
        [request setValue:[NSString
                           stringWithFormat:@"%ld", (long)[postString length]]
       forHTTPHeaderField:@"Content-length"];
        
        [request setHTTPBody:[postString
                              dataUsingEncoding:NSUTF8StringEncoding]];
        
        [[NSURLConnection alloc] 
         initWithRequest:request delegate:self];

        
        
        [self backToMainView:sender];        
        
        [_scrollView removeFromSuperview];
    }
    
    
    
    
    /*AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context =
    [appDelegate managedObjectContext];
    NSManagedObject *newContact;
    newContact = [NSEntityDescription
                  insertNewObjectForEntityForName:@"Employee"
                  inManagedObjectContext:context];
    [newContact setValue: self.userName.text forKey:@"userName"];
    [newContact setValue: self.userEmail.text forKey:@"email"];
    [newContact setValue: self.employer.text forKey:@"employer"];
    [newContact setValue: self.userLanguage.text forKey:@"language"];
    
    NSError *error;
    [context save:&error];
    
    NSLog(@"error %@",error.description);*/

    
    
}

//cancels the view and goes to main view
-(void) cancelView:(id) sender {
    
    [self backToMainView:sender];
    
    [_scrollView removeFromSuperview];
}

#pragma mark --validates the textfields and logoImage
-(BOOL) validate {
    
    BOOL validateItems = YES;
    if([self.companyName.text length]==0) {
        
        self.companyName.layer.borderColor =  [[UIColor colorWithRed:0.95 green:0.0 blue:0.0 alpha:1.0] CGColor];
        validateItems = NO;
        
    }
    
    /*if([self.streetName.text isEqualToString:@"Street Name"]) {
        
        self.streetName.layer.borderColor =  [[UIColor colorWithRed:0.95 green:0.0 blue:0.0 alpha:1.0] CGColor];
        validateItems = NO;
        
    }
    
    if([self.boxAddress.text isEqualToString:@"Box Address"]) {
        
        self.boxAddress.layer.borderColor =  [[UIColor colorWithRed:0.95 green:0.0 blue:0.0 alpha:1.0] CGColor];
        validateItems = NO;
        
    }
    
    
    if([self.country.text isEqualToString:@"Box Address"]) {
        
        self.country.layer.borderColor =  [[UIColor colorWithRed:0.95 green:0.0 blue:0.0 alpha:1.0] CGColor];
        validateItems = NO;
        
    }
    
    if([self.country.text isEqualToString:@"Country"]) {
        
        self.country.layer.borderColor =  [[UIColor colorWithRed:0.95 green:0.0 blue:0.0 alpha:1.0] CGColor];
        validateItems = NO;
        
    }
    
    if([self.countryCode.text isEqualToString:@"Code"]) {
        
        self.countryCode.layer.borderColor =  [[UIColor colorWithRed:0.95 green:0.0 blue:0.0 alpha:1.0] CGColor];
        validateItems = NO;
        
    }
    
    if([self.phoneNumber.text isEqualToString:@"Phone Number"]) {
        
        self.phoneNumber.layer.borderColor =  [[UIColor colorWithRed:0.95 green:0.0 blue:0.0 alpha:1.0] CGColor];
        validateItems = NO;
        
    } else*/
    if([self.phoneNumber.text length]!=0){
        
        if(![self.phoneNumber.text intValue]) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[labels valueForKey:@"message"] message:[labels valueForKey:@"validphone"] delegate:nil cancelButtonTitle:[labels valueForKey:@"ok"] otherButtonTitles:nil, nil];
            [alert show];
            self.phoneNumber.layer.borderColor = [UIColor redColor].CGColor;
                    validateItems = NO;
        }
        
    }
    
    /*if([self.taxNumber.text isEqualToString:@"Tax Number"]) {
        
        self.taxNumber.layer.borderColor =  [[UIColor colorWithRed:0.95 green:0.0 blue:0.0 alpha:1.0] CGColor];
        validateItems = NO;
        
    }*/
    
    
    
    if([self.email.text length]!=0){
        
        NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}";
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
        [emailTest evaluateWithObject:[self.email text]];
        if([emailTest evaluateWithObject:[self.email text]]==NO) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login" message:@"Please enter valid email" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            self.email.layer.borderColor = [UIColor redColor].CGColor;
            validateItems = NO;
        }
        
    }
    
    /*if([self.webLink.text isEqualToString:@"Web Link"]) {
        
        self.webLink.layer.borderColor =  [[UIColor colorWithRed:0.95 green:0.0 blue:0.0 alpha:1.0] CGColor];
        validateItems = NO;
    }
    
    if([self.description.text isEqualToString:@"Description"]) {
        
        self.description.layer.borderColor =  [[UIColor colorWithRed:0.95 green:0.0 blue:0.0 alpha:1.0] CGColor];
        validateItems = NO;
    
    }
    
    if([self.webLink.text isEqualToString:@"Web Link"]) {
        
        self.webLink.layer.borderColor =  [[UIColor colorWithRed:0.95 green:0.0 blue:0.0 alpha:1.0] CGColor];
        validateItems = NO;
    }
    
    
    if([self.subjectInfoText.text isEqualToString:@"Enter mail subject line"]) {
        
        self.subjectInfoText.layer.borderColor =  [[UIColor colorWithRed:0.95 green:0.0 blue:0.0 alpha:1.0] CGColor];
        validateItems = NO;
    }*/
    
    
    return validateItems;
}


//adds the logo image
-(void) addImageView:(id) sender {
    
    
    
    /*ViewController *vc = [ViewController sharedInstance];
    
    [vc startCamera:nil];*/
    
    UIActionSheet *actionSheet = nil;
    
    if(self.addImage.image!=nil) {
        
        actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Choose Photo", nil];
    }
    else {
        
        actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Choose Photo",@"Delete Photo", nil];
        
    }
    
    [actionSheet showInView:_scrollView];
    
}


//delete the image
-(void) deleteImage {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Delete" otherButtonTitles:nil, nil];
    
    [actionSheet showInView:_scrollView];
}



#pragma mark --actionsheet delegate functions
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    NSString *actionButton = [actionSheet buttonTitleAtIndex:buttonIndex];
    
    /*if([actionButton isEqualToString:@"Take Photo"]) {
        
        [self takePhotoWithCamera];
    }*/
    
    if([actionButton isEqualToString:@"Choose Photo"]) {
        
        [self choosePhotoFromLibrary];
    }
    
    if([actionButton isEqualToString:@"Delete Photo"]) {
        
        [self deleteImage];
    }
    
    if([actionButton isEqualToString:@"Delete"]) {
        
        [self deleteUserImage];
    }
}

/*-(void) takePhotoWithCamera {
    
    ViewController *vc = [ViewController sharedInstance];
    
    [vc startCamera:nil];
}*/

-(void) choosePhotoFromLibrary {
    
    ViewController *vc = [ViewController sharedInstance];
    
    [vc showImageLibrary:_scrollView];
}

//delete the user image

-(void) deleteUserImage {

    [self.logoImage removeFromSuperview];
    self.logoImage = nil;
    
    
    self.addImage = [[UIImageView alloc] initWithFrame:CGRectMake(125, 1175, 50, 50)];
    
    self.addImage.image = [UIImage imageNamed:@"add.png"];
    
    [self.addImage setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *addImagetap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addImageView:)];
    
    [self.addImage addGestureRecognizer:addImagetap];
    
    [_scrollView addSubview:self.addImage];

    NSString *imagePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:[NSString stringWithFormat:@"/%@",@"Optiqo"]];
    
    [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"companyLogoImage"]] error:nil];
}


-(void) showProfileView:(id) sender {
    
    
}

#pragma --mark textfiled delegate functions

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    UITextPosition *beginning = [textField beginningOfDocument];
    
    [textField setSelectedTextRange:[textField textRangeFromPosition:beginning toPosition:beginning]];
    
    //textField.placeholder = nil;
    //textField.text = @"";
    
    currentTextField = textField;
}

-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if(textField == self.countryCode) {
        
        if([self.countryCode.text length]>=4 && range.length==0)
            return NO;
        else
            return YES;
    }
    
    if(textField == self.phoneNumber) {
        
        if(![self.countryCode.text isEqualToString:@"Code"] && [self.phoneNumber.text length]>=10 && range.length==0) {
            return NO;
        }
        else if([self.countryCode.text length]==4 &&[self.phoneNumber.text length]>=11 && range.length==0) {
            
            return NO;
        }
        else {
            
            return YES;
        }
        
    }
    
    return YES;
}



- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if([textField.text length]==0)
        currentTextField = nil;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //NSLog(@" text length %d,%d",[self.countryCode.text length],[self.phoneNumber.text length]);
    
    if([self.companyURL.text length]!=0) {
        
        [self parseCompanyXML];
        
    }
    else {
        if([self.countryCode.text length]==4 && ![self.countryCode.text isEqualToString:@"Code"] && [self.phoneNumber.text length]==11) {
        
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login" message:@"Please enter valid phone number" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            self.phoneNumber.layer.borderColor = [UIColor redColor].CGColor;
        
            return NO;
        }
    }
    
    [textField resignFirstResponder];
    
    return YES;
}

#pragma --mark textview delegate functions

-(void) textViewDidBeginEditing:(UITextView *)textView {
    
    [self.scrollView setContentOffset:CGPointMake(0.0, (textView.frame.origin.y-50)) animated:YES];
    
}


-(BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        
        //CGRect frame = CGRectMake(0, textView.frame.origin.y+300, textView.frame.origin.x, textView.frame.origin.y+50);
        
        [self.scrollView setContentOffset:CGPointMake(0.0, (textView.frame.origin.y-200)) animated:YES];
        
        //[self scrollRectToVisible:frame animated:YES];
        
        
        //self.contentSize = CGSizeMake(vc.deviceWidth,vc.deviceHeight);
        
        return NO;
    }
    //[textView resignFirstResponder];
    return YES;
}

#pragma --mark keyboard notification functions

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    _scrollView.contentSize = CGSizeMake(320.0,1400.0);
    
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    /*UIEdgeInsets contentInsets = UIEdgeInsetsZero;
     self.contentInset = contentInsets;
     self.scrollIndicatorInsets = contentInsets;*/
    
    _scrollView.frame = CGRectMake(0, 70, _scrollView.frame.size.width, _scrollView.frame.size.height);
    _scrollView.contentOffset = offset;
    
}


- (void)keyboardWasShown:(NSNotification*)aNotification {
    //NSLog(@"Entered keyboard show");
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    //NSLog(@"size of keyboard %f,%f",kbSize.width,kbSize.height);
    
    offset = _scrollView.contentOffset;
    
    CGRect bkgndRect = currentTextField.frame;
    if((bkgndRect.origin.y)>kbSize.height) {
        //NSLog(@"current frame pos %f,%f,%f,%f",currentTextField.frame.origin.x,currentTextField.frame.origin.y,currentTextField.frame.size.width,currentTextField.frame.size.height);
        
        //bkgndRect.size.height -= kbSize.height;
        //[currentTextField.superview setFrame:bkgndRect];
        [_scrollView setContentOffset:CGPointMake(0.0, ((currentTextField.frame.origin.y+currentTextField.frame.size.height+20.0)-kbSize.height)) animated:YES];
    }
    
    /*CGRect viewFrame = self.scrollView.frame;
     viewFrame.size.height -= kbSize.height;
     self.scrollView.frame = viewFrame;
     
     CGRect textFieldRect = [currentTextField frame];
     textFieldRect.origin.y += 10;
     [scrollView setContentOffset:CGPointMake(0.0,textFieldRect.size.height) animated:YES];*/
    
    
    //[self.scrollView scrollRectToVisible:textFieldRect animated:YES];
}


-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    ViewController *vc = [ViewController sharedInstance];
    
    vc.toggleMenu = !vc.toggleMenu;
    
    //NSLog(@" toogle view in profile %d",vc.toggleMenu);
    
    if(vc.toggleMenu) {
        
        id animation = ^{
            
            vc.startView.transform = CGAffineTransformMakeTranslation(0, 0);
            vc.menuView.transform = CGAffineTransformMakeTranslation(-vc.deviceWidth, 0);
        };
        
        [UIView animateWithDuration:0.5 animations:animation];
        
    }
}

#pragma --mark parse a xml file from remote server.

-(void) parseCompanyXML {
    
    
    //NSLog(@"company text %@",self.companyURL.text);
    NSString *parseXML = [NSString stringWithFormat:@"%@%@%@",@"http://optiqoinspect.net16.net/optiqo/",self.companyURL.text,@".xml"];
    
    //@"http://www.ida.liu.se/~nagta58/",self.companyURL.text,@".xml"
    
    //NSLog(@"parse xml %@",parseXML);
    
    NSURL *xmlURL = [NSURL URLWithString:parseXML];
    //NSURL *xmlURL = [NSURL URLWithString:@"http://images.apple.com/main/rss/hotnews/hotnews.rss"];
    
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:xmlURL];
    
    [xmlParser setDelegate:self];
    
    BOOL parsexml = [xmlParser parse];
    
    if(!parsexml) {
        
        //NSLog(@"Cannot parse xml file");
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[labels valueForKey:@"message"] message:[labels valueForKey:@"error_code"] delegate:nil cancelButtonTitle:[labels valueForKey:@"ok"] otherButtonTitles:nil, nil];
        
        [alert show];
        self.companyURL.text = @"";
    }
}

#pragma --mark parse the xml file contents

-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    element = elementName;
    
    
    if([elementName isEqualToString:@"Comapny"]) {
        
        //NSLog(@" data %@",[attributeDict objectForKey:@"Company Name"]);
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if([element isEqualToString:@"CompanyName"]) {
        
        if(!companyContent)
        {
            
        }
        
        if([string length]!=0 && [string length]!=7) {
        
            [self.companyName setText:string];
        }
        
    }
    
    if([element isEqualToString:@"StreetName"]) {
        
       
        if([string length]!=0 && [string length]!=7) {
            [self.streetName setText:string];
        }
    }
    
    if([element isEqualToString:@"City"]) {
        
        
        if(!cityContent)
        {
            cityContent = [[NSMutableString alloc] init];
        }
        else
            [cityContent setString:@""];
        
        [cityContent appendString:string];
        
        
        if([cityContent length]!=0 && [cityContent length]!=7) {
            [self.city setText:cityContent];
        }
    }
    
    if([element isEqualToString:@"BoxAddress"]) {
        
        if([string length]!=0 && [string length]!=7) {
            [self.boxAddress setText:string];
        }
    }
    
    if([element isEqualToString:@"Country"]) {
        
        if([string length]!=0 && [string length]!=7) {
            [self.country setText:string];
        }
    }
    
    if([element isEqualToString:@"Code"]) {
        
        if([string length]!=0 && [string length]!=7) {
            [self.countryCode setText:string];
        }
    }
    
    if([element isEqualToString:@"PhoneNumber"]) {
        
        if([string length]!=0 && [string length]!=7) {
            [self.phoneNumber setText:string];
        }
    }
    
    if([element isEqualToString:@"TaxNumber"]) {
        
        if([string length]!=0 && [string length]!=7) {
            [self.taxNumber setText:string];
        }
    }
    
    if([element isEqualToString:@"Email"]) {
        
        if([string length]!=0 && [string length]!=7) {
            [self.email setText:string];
        }
    }
    
    if([element isEqualToString:@"Description"]) {
        
        if([string length]!=0 && [string length]!=7) {
            [self.emailDescription setText:string];
            //NSLog(@"description %@",self.emailDescription);
        }
    }
    
    if([element isEqualToString:@"WebLink"]) {
        
        if([string length]!=0 && [string length]!=7) {
            [self.webLink setText:string];
        }
    }
    
    if([element isEqualToString:@"MailSubject"]) {
        
        //NSLog(@"string %@,%d",string,(int)[string length]);
        if([string length]!=1 && [string length]!=7) {
            [self.subjectInfoText setText:string];
        }
    }
    
    if([element isEqualToString:@"CompanyLogo"]) {
        

        
        if([string length]!=1 && [string length]!=5) {
           // NSLog(@"comapny logo %@,%d",string,[string length]);
            [self.logoImage removeFromSuperview];
            self.logoImage = nil;
            self.logoImage = [[UIImageView alloc] initWithFrame:CGRectMake(50, 1175, 200, 50)];
            
            [self.logoImage setUserInteractionEnabled:YES];
            
            /*UITapGestureRecognizer *addImageTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                   action:@selector(addImageView:)];
            
            [self.logoImage addGestureRecognizer:addImageTap];*/
            
            imageLink = string;
            
            [_scrollView addSubview:self.logoImage];
            imageURL = [NSURL URLWithString:string];
            imageData = [NSData dataWithContentsOfURL:imageURL];
            self.logoImage.image = [[UIImage alloc] initWithData:imageData];
            //self.logoImage.image =  [UIImage imageNamed:@"add.png"];
            [self.logoImage setHidden:NO];
            [self.addImage setHidden:YES];
            
            //NSLog(@"Entered company logo %@",imageURL);
            
        }
    }
}

-(void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    
    
    if([element isEqualToString:@"Company"]) {
        
        /*NSLog(@"string %@,%d",string,[string length]);
        if([string length]!=0) {
            
            [self.companyName setText:string];
        }*/
        
    }
    
}

-(UIImageView *) getImage {
    
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"transparent.png"]];
    
    image.frame = CGRectMake(0, 0, 8, 8);
    
    [image setContentMode:UIViewContentModeScaleAspectFit];
    
    return image;
}

//sets the company logo image 

-(void) setLogoImageView:(UIImage *)image {
    
    if(self.logoImage==nil) {
        
        self.logoImage = [[UIImageView alloc] initWithFrame:CGRectMake(50, 1175, 200, 50)];
        
        [self.logoImage setUserInteractionEnabled:YES];
        
        /*UITapGestureRecognizer *addImageTap = [[UITapGestureRecognizer alloc] initWithTarget:self
        action:@selector(addImageView:)];
        
        [self.logoImage addGestureRecognizer:addImageTap];*/
        
        [_scrollView addSubview:self.logoImage];
        
        self.logoImage.image = nil;
        
        self.logoImage.image = image;
        
        //imageData = UIImageJPEGRepresentation(image, 0.7);
        
        [self.addImage removeFromSuperview];
        
        self.addImage = nil;
        
        //NSLog(@"entered set image");
    }
    else
    {
        [self.logoImage removeFromSuperview];
    
        self.logoImage.image = nil;
    
        self.logoImage.image = image;
    
        //imageData = UIImageJPEGRepresentation(image, 0.7);
    
        [self.addImage removeFromSuperview];
    
        self.addImage = nil;
        
        [_scrollView addSubview:self.logoImage];
        
        //NSLog(@"entered set image edit");
    }
    
    
}

-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
