//
//  RoomListContent.h
//  NewOptiqo
//
//  Created by Umapathi on 9/9/14.
//  Copyright (c) 2014 Umapathi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RoomListContent : NSObject {
    
    NSDictionary *labels;
}

@property(strong,nonatomic) NSString *customerName;
@property(strong,nonatomic) NSString *customerRoom;
@property(strong,nonatomic) NSString *customerRoomName;
@property(strong,nonatomic) NSString *customerRoomNameKey;
@property(strong,nonatomic) UIImageView *roomApproved;
@property(strong,nonatomic) UIImageView *roomDescription;
@property(strong,nonatomic) NSNumber *approveRoom;
@property(strong,nonatomic) UIImageView *images;
@property(strong,nonatomic) UIImageView *customerRoomImage;
@property(strong,nonatomic) NSDate *startDate;
@property(strong,nonatomic) NSDate *endDate;
@property(strong,nonatomic) NSString *roomComents;
@property(strong,nonatomic) NSNumber *roomContainsImages;
@property(strong,nonatomic) NSString *report_time;
@property(strong,nonatomic) NSString *total_time;

-(void) initWithData:(NSString *)name withRoom:(NSString *)room withApproved:(UIImage *) image withDescription:(UIImage *)image1 withApproveRoom:(NSNumber *) num withDescription:(NSString *) descp withRoomKey:(NSString *) roomkey;

-(void) set_images:(UIImage*)imagView;
-(void) set_startTime:(NSDate*)date;
-(void) set_endTime:(NSDate*)date;
-(void) setRoomComments:(NSString *) comments;
-(void) setCustomer_RoomName:(NSString *)customerroomname;
-(void) setCustomerReport;
-(void) setEmployerReport;



@end
