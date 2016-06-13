//
//  ProfileView.h
//  Optiqo
//
//  Created by Umapathi on 8/9/14.
//  Copyright (c) 2014 Umapathi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MenuView : UIScrollView {
    
    NSDictionary *labels;
    
    UILabel *mainMenu;
}

//profile view image
@property (nonatomic,strong) UIImageView *profileImage;
@property (nonatomic,strong) UIButton *userName;
@property (nonatomic,strong) UIButton *profileView;
@property (nonatomic,strong) UIButton *oldReports;

//profile menu view
-(void) showProfileView;

//fetches data from database for profileview
-(void) getData;

//resets the labels
-(void) resetLabels;

@end
