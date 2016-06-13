//
//  RoomsListView.h
//  NewOptiqo
//
//  Created by Umapathi on 8/24/14.
//  Copyright (c) 2014 Umapathi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoomComments.h"
#import "SearchList.h"

@interface RoomsListView : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UITextFieldDelegate,SearchListDelegate> {
    

    BOOL isSaved,delete_room,isAddRoomViewShown;
    
    UIColor *color;
    
    UIFont *font;
    
    NSIndexPath *currentIndex;
    
    NSMutableArray *predefinedRoomIndex;
    
    NSMutableArray *predefinedRooms;
    
    NSMutableArray *currentRooms;
    
    UIView *predefineRooms;
    
    UIView *addNewRoomsView;
    
    int cleaningType;
    
    UICollectionViewCell *cell;
    
    UILabel *cust_label;
    
    NSDictionary *labels;
    
    NSString *roomName;
    
    BOOL isRoomListShow;
    
    BOOL isButtonClicked;
    
}

//UICollection view
@property (strong,nonatomic) UICollectionView *roomsViews;

//array to hold rooms
@property (nonatomic,strong) NSMutableArray *roomsList;

//add a new room
@property (nonatomic,strong) UIView *addRoomButton;

//customerName
@property (nonatomic,strong) NSString *customerName;

@property (nonatomic,strong) RoomComments *roomComments;

@property (strong,nonatomic) NSMutableArray *deleteRooms;

@property (strong,nonatomic) SearchList *searchList;


- (id)initWithFrame:(CGRect)frame;
- (id)initWithFrame:(CGRect)frame withString:(NSString *) custName;
-(void) getData;
-(void) add_newRoom;
-(UIView *) getView:(NSString *) roomName;
-(void) addView;
-(void) addBackView;
-(void) deleteCurrentRoom:(int) room_num;

-(void) addPredefinedHRooms;

-(void) addPredefinedORooms;

-(void) getDeleteItemsView;

-(void) setViewTitle;

-(void) refreshRooms;

-(UIImageView *) getImage;

//delete customer rooms
-(void) deleteCustomerRooms;

@end
