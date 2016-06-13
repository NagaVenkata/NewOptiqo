//
//  Reportview.h
//  NewOptiqo
//
//  Created by Umapathi on 9/11/14.
//  Copyright (c) 2014 Umapathi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoomListContent.h"

@interface Reportview : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate> {
    
    NSString *roomType;
    NSString *customerName;
    NSString *customerRoom;
    NSString *customerRoomName;
    NSString *currentTime;
    NSString *currentDate;
    NSString *roomDescription;
    NSDate *startTime;
    NSDate *endTime;
    
    UIColor *color;
    UIFont *font;
    
    NSDictionary *labels;
    
    UIImageView  *backImg;
    
    UIImageView *roomImageView;
    
    int index;
}

@property (strong,nonatomic) UIScrollView *scrollView;
//UICollection view
@property (strong,nonatomic) UICollectionView *roomsViews;

//array to hold rooms
@property (nonatomic,strong) NSMutableArray *roomsList;


-(id) initWithFrame:(CGRect)frame withRoomComment:(RoomListContent *) reportView withIndex:(int) reportIndex;
-(void) showData;
-(void) drawImages;
-(void) setViewTitle;

@end
