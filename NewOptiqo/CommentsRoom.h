//
//  CommentsRoom.h
//  NewOptiqo
//
//  Created by Umapathi on 8/29/14.
//  Copyright (c) 2014 Umapathi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReportsListView.h"
#import "RoomComments.h"
#import "EditImage.h"

@interface CommentsRoom : UIViewController<UIActionSheetDelegate,UITextViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate> {
    
    int currentVisiblePage;
    
    BOOL *delete_image;
    
    NSDate *currentTime,*doneTime;
    
    int current_index;
    
    UIColor *color;
    UIFont *font;
    
    UILabel *label;
    
    NSDictionary *labels;
    
    int customerCount;
    
    UIImageView  *backImg;
    
    UIImageView *camView;
}



//UICollection view
@property (strong,nonatomic) UICollectionView *roomsViews;

//array to hold rooms
@property (nonatomic,strong) NSMutableArray *roomsList;

//selected image index
@property (strong,nonatomic) NSIndexPath *currentIndex;

//@property (nonatomic,strong) RoomComments *roomComment;

@property (nonatomic,strong) ReportsListView *reportsListView;

@property (nonatomic,strong) UIScrollView *scrollView;

@property (nonatomic,strong) UIPageControl *pageController;

@property (nonatomic,strong) NSMutableArray *pageImages;

@property (nonatomic,strong) NSMutableArray *pageViews;

@property (nonatomic,strong) UITextView *commentText;

@property (nonatomic,strong) UIImageView *imageView;

@property (nonatomic,strong) NSString *customerName;

@property (nonatomic,strong) NSString *roomName;

@property(nonatomic,strong) UIButton *saveButton;

@property(nonatomic,strong) UIButton *cancelButton;

- (id)initWithFrame:(CGRect)frame;
- (id)initWithFrame:(CGRect)frame roomName:(NSString *) name withCustomerCount:(int) count;
-(void) getData;
-(void) drawView;
-(void) addRoomImages:(UIImageView *) roomImage;
-(void) setViewTitle;
-(void) editImage;
-(UIImage *) editSelectedImage:(UIImage*) image;

@end
