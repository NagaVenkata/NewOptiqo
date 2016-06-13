//
//  SignView.m
//  NewOptiqo
//
//  Created by Umapathi on 9/5/14.
//  Copyright (c) 2014 Umapathi. All rights reserved.
//

#import "SignView.h"
#import "ViewController.h"

@implementation SignView
@synthesize signatureView,save,clear,signImage;

/*- (id)initWithFrame:(CGRect)frame
{
    self.view = [super initWithFrame:frame];
    if (self.view) {
        // Initialization code
        [self.view setBackgroundColor:[UIColor whiteColor]];
        
        color = [UIColor blackColor];
        font = [UIFont fontWithName:@"Avenir-Medium" size:16.0];
        
        [self.view drawView];
        [self.view setTitleView];
        
        
    }
    return self.view;
}*/

-(void) viewDidLoad {
    
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
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
    
    color = [UIColor blackColor];
    font = [UIFont fontWithName:@"Avenir-Medium" size:16.0];
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.width)];
    //[scrollView setContentSize:CGSizeMake(480.0, self.view.frame.size.height)];
    
    [self.view addSubview:scrollView];
    
    //draw view contents and view title
    [self drawView];
    [self setTitleView];

    
}

-(void) setTitleView {
    
    
    //draws the tilte and icons and top bar for the view.
    
    ViewController *vc =[ViewController sharedInstance];
    
    UIView  *barView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, vc.deviceHeight, 70)];
    
    [barView setBackgroundColor:[UIColor colorWithRed:41.0/255.0 green:41.0/255.0 blue:42.0/255.0 alpha:1.0]];
    
    [self.view addSubview:barView];

    
    UILabel *cust_label = [[UILabel alloc] initWithFrame:CGRectMake(200, 18, 150, 32)];
    
    [cust_label setBackgroundColor:[UIColor clearColor]];
    
    [cust_label setText:[labels valueForKey:@"signature"]];
    [cust_label setTextColor:[UIColor whiteColor]];
    [cust_label setTextAlignment:NSTextAlignmentCenter];
    [cust_label setFont:[UIFont fontWithName:@"Avenir-Medium" size:18]];
    
    [barView addSubview:cust_label];
    
    //UIImageView *backImage = (UIImageView *)[[vc.barView subviews] objectAtIndex:0];
    
    UIImageView *backImage = [[UIImageView alloc] initWithFrame:CGRectMake(25, 14, 40, 40)];
    
    backImage.image = [UIImage imageNamed:@"back.png"];
    
    [backImage setContentMode:UIViewContentModeScaleAspectFit];
    
    [backImage setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *backTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backToUserProfileView:)];
    
    [backImage addGestureRecognizer:backTap];
    
    [barView addSubview:backImage];
    

    
    UIImageView *saveImage = [[UIImageView alloc] initWithFrame:CGRectMake(vc.deviceHeight-110, 14, 40, 40)];
    
    saveImage.image = [UIImage imageNamed:@"save.png"];
    
    [saveImage setContentMode:UIViewContentModeScaleAspectFit];
    
    [saveImage setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *saveTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(saveSignature:)];
    
    [saveImage addGestureRecognizer:saveTap];
    
    [barView addSubview:saveImage];
    
    UIImageView *clearImage = [[UIImageView alloc] initWithFrame:CGRectMake(vc.deviceHeight-60, 14, 40, 40)];
    
    clearImage.image = [UIImage imageNamed:@"close_icon.png"];
    
    [clearImage setContentMode:UIViewContentModeScaleAspectFit];
    
    [clearImage setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *clearTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clearSignature:)];
    
    [clearImage addGestureRecognizer:clearTap];
    
    [barView addSubview:clearImage];
}

-(void) drawView {

    //draws a drawing area to hand draw on it and save it.
    
    UIImageView  *backImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 70, self.view.frame.size.height,self.view.frame.size.height)];
    
    backImg.image = [UIImage imageNamed:@"view_background.png"];
    
    [scrollView addSubview:backImg];

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(25, 75, 200, 20)];
    
    [label setText:[labels valueForKey:@"signature"]];
    [label setTextColor:color];
    [label setFont:font];
    [scrollView addSubview:label];
    
    
    self.signatureView = [[SignatureView alloc] initWithFrame:CGRectMake(25,100,self.view.frame.size.height-50,200)];
                          

        
    [self.signatureView.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.signatureView.layer setBorderWidth:0.5];
    
    
    
    [scrollView addSubview:self.signatureView];
    
    self.save = [[UIButton alloc] initWithFrame:CGRectMake(25, self.view.frame.size.height*0.7, 100, 50)];
    
    [self.save.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.save.layer setBorderWidth:0.5];
    
    [self.save setTitle:@"Save" forState:UIControlStateNormal];

    
    [self.save setTitleColor:color forState:UIControlStateNormal];
    [self.save.titleLabel setFont:font];
    
    [self.save addTarget:self.view action:@selector(saveSignature:) forControlEvents:UIControlEventTouchUpInside];
    
    [scrollView addSubview:self.save];
    
    
    self.clear = [[UIButton alloc] initWithFrame:CGRectMake(200, self.view.frame.size.height*0.7, 100, 50)];
    
    [self.clear.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.clear.layer setBorderWidth:0.5];
    
    [self.clear setTitle:@"Clear" forState:UIControlStateNormal];
    
    [self.clear setTitleColor:color forState:UIControlStateNormal];
    
    [self.clear.titleLabel setFont:font];
    
    [self.clear addTarget:self.view action:@selector(clearSignature:) forControlEvents:UIControlEventTouchUpInside];
    
    [scrollView addSubview:self.clear];
    
    [self getSignImage];
    
    /*ViewController *vc = [ViewController sharedInstance];
    
    UIImageView *homeImage = [[UIImageView alloc] initWithFrame:CGRectMake(vc.deviceWidth-50, 15, 32, 32)];
    
    homeImage.image = [UIImage imageNamed:@"home.png"];
    
    [homeImage setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *homeTap = [[UITapGestureRecognizer alloc] initWithTarget:self.view action:@selector(backToMainView:)];
    
    [homeImage addGestureRecognizer:homeTap];
    
    [vc.barView addSubview:homeImage];
    
    UIImageView *backImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 25, 32, 32)];
    
    backImage.image = [UIImage imageNamed:@"back.png"];
    
    [backImage setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *backTap = [[UITapGestureRecognizer alloc] initWithTarget:self.view action:@selector(backToUserProfileView:)];
    
    [backImage addGestureRecognizer:backTap];
    
    [vc.barView addSubview:backImage];
    
    UILabel *cust_label = [[UILabel alloc] initWithFrame:CGRectMake(85, 25, 150, 32)];
    
    [cust_label setBackgroundColor:[UIColor whiteColor]];
    
    [cust_label setText:@"Signature"];
    [cust_label setTextColor:[UIColor colorWithRed:0.0 green:191.0/255.0 blue:1.0 alpha:1.0]];
    [cust_label setTextAlignment:NSTextAlignmentCenter];
    [cust_label setFont:[UIFont fontWithName:@"Avenir-Medium" size:24]];
    
    [vc.barView addSubview:cust_label];*/
}


#pragma mark-- back to main view

-(void) backToMainView:(id) sender {
    
   
    
    ViewController *vc = [ViewController sharedInstance];
    
    for(unsigned long i=[[vc.startView subviews] count]-1;i>=2;i--) {
        
        id viewItem = [[vc.startView subviews] objectAtIndex:i];
        [viewItem removeFromSuperview];
    }
    
    for(unsigned long i=[[vc.barView subviews] count]-1;i>=1;i--) {
        
        id viewItem = [[vc.barView subviews] objectAtIndex:i];
        [viewItem removeFromSuperview];
    }
    
    NSLog(@" sub views %d",(int)[[vc.barView subviews] count]);
    
}



#pragma mark--back to user profile view
-(void) backToUserProfileView:(id) sender {
    
    ViewController *vc = [ViewController sharedInstance];
    
    for(unsigned long i=[[vc.barView subviews] count]-1;i>=1;i--) {
        
        id viewItem = [[vc.barView subviews] objectAtIndex:i];
        [viewItem removeFromSuperview];
    }
    
    //UserView *userView = (UserView *)[self.view superview];
    
    [vc.userView setTitleView];
    
    [self.signatureView removeFromSuperview];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    /*id animation = ^{
        
        self.view.transform = CGAffineTransformMakeTranslation(320, 0);
        
        
    };
    
    id complete = ^{
    
         [self.view removeFromSuperview];
        
    };
    
    [UIView animateWithDuration:0.5 animations:animation completion:complete];*/
    
    
}

//gets the sign image if allready present
-(void) getSignImage {
    
    NSString *imagePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:[NSString stringWithFormat:@"/%@/%@",@"Optiqo",@"userSign.jpg"]];
    
    
    //NSLog(@"file exsits %d",[[NSFileManager defaultManager] fileExistsAtPath:imagePath]);
    
    //UIImage *img = [UIImage imageWithContentsOfFile:imagePath];
    
    //NSData *data = UIImageJPEGRepresentation(img, 1.0);
    
    //NSLog(@"image size %d",[data length]);

    
    if([[NSFileManager defaultManager] fileExistsAtPath:imagePath]) {
        
        self.signImage = [[UIImageView alloc] initWithFrame:CGRectMake(25,100,self.view.frame.size.height-75,200)];
        self.signImage.image = [UIImage imageWithContentsOfFile:imagePath];
        
        [self.signImage setUserInteractionEnabled:YES];
        
        UITapGestureRecognizer *imageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editImage:)];
        
        [self.signImage addGestureRecognizer:imageTap];
        
        [self.view addSubview:self.signImage];
        
        
    }
}

//edit the image
-(void) editImage:(id) sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:[labels valueForKey:@"cancel"] destructiveButtonTitle:[labels valueForKey:@"delete"] otherButtonTitles:nil, nil];
    
    [actionSheet showInView:self.view];
}

#pragma mark --actionsheet delegate functions
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    NSString *actionButton = [actionSheet buttonTitleAtIndex:buttonIndex];
    
    if([actionButton isEqualToString:[labels valueForKey:@"delete"]]) {
        
        [self.signImage removeFromSuperview];
        
        NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:[NSString stringWithFormat:@"/%@",@"Optiqo"]];
        
        NSString *imagePath = [NSString stringWithFormat:@"%@/%@",path,@"userSign.jpg"];

        
        if([[NSFileManager defaultManager] fileExistsAtPath:imagePath]) {
            
            [[NSFileManager defaultManager] removeItemAtPath:imagePath error:nil];
        }
    }
}


//save the drawings or signature to a image
-(void) saveSignature:(id) sender {
    
    
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:[NSString stringWithFormat:@"/%@",@"Optiqo"]];
    
    

    //if(![[NSFileManager defaultManager] fileExistsAtPath:path]) {


        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    //}
    


    NSString *imagePath = [NSString stringWithFormat:@"%@/%@",path,@"userSign.jpg"];
    
    
    //NSLog(@"file exsits %d",[[NSFileManager defaultManager] fileExistsAtPath:imagePath]);
    
    
    //[UIImageJPEGRepresentation(self.view.signatureView.signImage, 1.0) writeToFile:imagePath atomically:YES];
    
    NSData *data = UIImageJPEGRepresentation(self.signatureView.signImage, 1.0);
    
    //NSLog(@" data length %d",[data length]);
    
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:imagePath];

    if([data length]!=0) {
    
        if([[NSFileManager defaultManager] fileExistsAtPath:imagePath]) {
        
            [[NSFileManager defaultManager] removeItemAtPath:imagePath error:nil];
        }
    
        //NSData *data = UIImageJPEGRepresentation(self.signatureView.signImage, 1.0);
    
        //NSLog(@" data length %d",[data length]);
    
        [data writeToFile:[NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",path,@"userSign"]] atomically:YES];
    
    
        UIImage *img = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",path,@"userSign"]]];
    
        data = UIImageJPEGRepresentation(img, 1.0);
    
    
        //NSLog(@"image size %d",[data length]);
    
        
    }
    else if(!fileExists)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[labels valueForKey:@"message"] message:[labels valueForKey:@"writesignature"] delegate:nil cancelButtonTitle:[labels valueForKey:@"ok"] otherButtonTitles:nil, nil];
        
        [alert show];
        
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//clear the signature view

-(void) clearSignature:(id) sender {
    
    
    NSString *imagePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:[NSString stringWithFormat:@"/%@/%@",@"Optiqo",@"userSign.jpg"]];

    NSData *data = UIImageJPEGRepresentation(self.signatureView.signImage, 1.0);
    
    if([[NSFileManager defaultManager] fileExistsAtPath:imagePath] && [data length]==0) {
        
        
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:[labels valueForKey:@"cancel"] destructiveButtonTitle:[labels valueForKey:@"delete"] otherButtonTitles:nil, nil];
        
        [actionSheet showInView:self.view];
        
    }
    else {
        
       self.signatureView.signImage = nil;
    
       [self.signatureView clearView];
    }

    
}

-(BOOL) shouldAutorotate {
    
    return YES;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}


- (NSUInteger)supportedInterfaceOrientations
{
    
    return UIInterfaceOrientationMaskLandscapeLeft;
}

#pragma mark--statusbar content color
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(void) dealloc {
    
    self.signatureView = nil;
    self.clear = nil;
    self.save = nil;
    self.signImage = nil;
    scrollView = nil;
    color = nil;
    font = nil;
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
