//
//  UserView.h
//  NewOptiqo
//
//  Created by Umapathi on 8/13/14.
//  Copyright (c) 2014 Umapathi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignView.h"
#import "SearchList.h"



@interface UserView : UIViewController<UITextFieldDelegate,UIActionSheetDelegate,SearchListDelegate> {
    
    UIColor *color;
    UIFont *font;
    
    NSDictionary *labels;
    
    NSString *language;
    
    
}

@property (nonatomic,strong) UITextField *userFirstName;
@property (nonatomic,strong) UITextField *userLastName;
@property (nonatomic,strong) UIImageView *addImage;
@property (nonatomic,strong) UIImageView *profileImage;
@property (nonatomic,strong) UIButton *signButton;
@property (nonatomic,strong) UIButton *saveButton;
@property (nonatomic,strong) UIButton *cancelButton;
@property (strong,nonatomic) UIView *chooseLanguage;
@property (strong,nonatomic) UIScrollView *scrollView;
@property (strong,nonatomic) NSString *userName;
@property (strong,nonatomic) SearchList *searchList;
@property (strong,nonatomic) SignView *signView;

//initialize the view
-(id) initWithFrame:(CGRect) frame;
//draws the view contents
-(void) drawView;
//gets the data from database
-(void) getData;
//starts the camera view
-(void) takePhotoWithCamera;
//starts the library view
-(void) choosePhotoFromLibrary;
//delete the images
-(void) deleteImage;
//delete the user image
-(void) deleteUserImage;
//sets the view title view and menu views
-(void) setTitleView;
//gets the image from photo taken from camera
-(UIImageView *) getImage;
//validates the user inputs.
-(BOOL) validateUser;

@end
