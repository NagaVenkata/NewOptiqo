//
//  RoomListContent.m
//  NewOptiqo
//
//  Created by Umapathi on 9/9/14.
//  Copyright (c) 2014 Umapathi. All rights reserved.
//

#import "RoomListContent.h"
#import "ViewController.h"

@implementation RoomListContent
@synthesize customerName,customerRoom,customerRoomName,customerRoomNameKey,roomApproved,roomDescription,approveRoom,images,startDate,endDate,roomComents,roomContainsImages,customerRoomImage,report_time;

//class used to store the room information such as room name, icon, language to use them showing the rooms list and also generating the rooms overview pdf report

-(void) initWithData:(NSString *)name withRoom:(NSString *)room withApproved:(UIImage *) image withDescription:(UIImage *)image1 withApproveRoom:(NSNumber *) num withDescription:(NSString *) descp withRoomKey:(NSString *) roomkey{
    
    self.customerName = name;
    
    
    
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
    
    self.customerRoomNameKey = roomkey;
    
    if([labels valueForKey:self.customerRoomNameKey])
      self.customerRoom = [labels valueForKey:self.customerRoomNameKey];
    else
        self.customerRoom = room;
    
    
    //NSLog(@"customer room key %@,%@,%@",self.customerRoom,[labels valueForKey:@"dressingroom"],[labels valueForKey:@"toilet"]);
    

    if(vc.cleaningType==1)
    {
       if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"livingroom"]])
       {
           self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"living_room.png"]];
       }
       else if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"studyroom"]])
       {
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"study_room.png"]];
       }
       else if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"kitchen"]])
       {
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"coffee_room.png"]];
       }
       else if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"bedroom"]])
       {
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bed_room.png"]];
       }
       else if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"dressingroom"]])
       {
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dressing_room.png"]];
       }
       else if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"toilet"]])
       {
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"toilet_room.png"]];
       }
       else if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"washingroom"]])
       {
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wash_room.png"]];
       }
       else
       {
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"generic_room.png"]];
        }
    }
    
    if(vc.cleaningType == 2)
    {
        if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"reception"]]) {
            
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"reception.png"]];
            
        }
        
        else if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"hallway"]]) {
            
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hallway.png"]];
            
           
        }
        
        else if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"officeroom"]]) {
            
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"office_room.png"]];
            
            
        }
        
        else if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"grouproom"]]) {
            
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"entrance.png"]];
            
            
        }
        
        else if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"conferenceroom"]]) {
            
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"conference_room.png"]];
            

        }
        
        else if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"kitchen"]]) {
            
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"coffee_room.png"]];
            
           
        }
        
        else if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"lift"]]) {
            
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lift.png"]];
            
            
        }
        
        else if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"exculator"]]) {
            
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"exculator.png"]];
            
            
        }
        
        else if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"stairs"]]) {
            
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"stairs.png"]];
            
            
        }
        
        else if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"storeroom"]]) {
            
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"store_room.png"]];
            
            
        }
        
        else if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"wherehouse"]]) {
            
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wherehouse.png"]];
            
            
        }
        
        else if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"washroom"]]) {
            
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"washroom.png"]];
            
            
        }
        
        else if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"shower"]]) {
            
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shower.png"]];
            
            
        }
        
        else if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"toilet"]]) {
            
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"toilet.png"]];
            
            
        }
        
        else if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"wasteroom"]]) {
            
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wasteroom.png"]];
            
            
        }
        
        else if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"parking"]]) {
            
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"parking.png"]];
            
           
        }
        
        else
        {
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"generic_room.png"]];
            
            
        }
    }
    
    self.roomApproved = [[UIImageView alloc] initWithImage:image];
    
    self.roomDescription = [[UIImageView alloc] initWithImage:image1];
    
    self.approveRoom = num;
}

#pragma --mark functions to individually set room properties

-(void) set_images:(UIImage *)imagView {
    
    self.images = [[UIImageView alloc] initWithImage:imagView];
}

-(void) set_startTime:(NSDate *)date{
    
    self.startDate = date;
    
}


-(void) set_endTime:(NSDate *)date{
    
    self.endDate = date;
    
}

-(void) setRoomComments:(NSString *)comments {
    
    self.roomComents = comments;
}

-(void) setCustomer_RoomName:(NSString *)customerroomname {
    
    self.customerRoomName = customerroomname;
    
    //NSLog(@"customer room name %@",self.customerRoomName);
    
    if(![labels valueForKey:self.customerRoomNameKey]) {
        self.customerRoom = self.customerRoom;
    }
}
    
    
#pragma --mark set customer report room names and icons according to customer language

-(void) setCustomerReport {
    
    ViewController *vc = [ViewController sharedInstance];
    
    //NSLog(@"Entered customer report %@",vc.customerLanguageSelected);
    
    if([vc.customerLanguageSelected isEqualToString:@"Svenska"]) {
        
        labels = [vc.englishLabels valueForKey:@"userswedishlabels"];
        
        //NSLog(@"Entered customer report %@",vc.customerLanguageSelected);
    }
    
    if([vc.customerLanguageSelected isEqualToString:@"German"]) {
        
        labels = [vc.englishLabels valueForKey:@"usergermanlabels"];
    }
    
    if([vc.customerLanguageSelected isEqualToString:@"English"]) {
        
        labels = [vc.englishLabels valueForKey:@"userenglishlabels"];
    }
    
    
    /*CGFloat minuteDifference = [self.endDate timeIntervalSinceDate:self.startDate] / 60.0;
    
    NSLog(@" data %.2f ",minuteDifference);
    
    NSTimeInterval diff = [self.endDate timeIntervalSinceDate:self.startDate];
    
    long seconds = lroundf(diff); // Modulo (%) operator below needs int or long
    
    long hour = seconds / 3600;
    long mins = (seconds % 3600) / 60;
    long secs = seconds % 60;
    
    //NSLog(@" data1 %d,%d,%d ",hour,mins,secs);
    
    NSString *str_hour = [NSString stringWithFormat:@"%ld",hour];
    
    NSString *str_mins = [NSString stringWithFormat:@"%ld",mins];
    
    NSString *str_secs = [NSString stringWithFormat:@"%ld",secs];
    
    if([str_hour length]<2)
        str_hour = [NSString stringWithFormat:@"0%@",str_hour];

    if([str_mins length]<2)
        str_mins = [NSString stringWithFormat:@"0%@",str_mins];

    if([str_secs length]<2)
        str_secs = [NSString stringWithFormat:@"0%@",str_secs];*/
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSUInteger unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit| NSSecondCalendarUnit;
    
    NSDateComponents *components = [calendar components:unitFlags
                                               fromDate:self.startDate
                                                 toDate:self.endDate options:0];
    
    NSInteger hours =components.hour;
    NSInteger minutes=components.minute;
    
    if(minutes>=60) {
        hours+=1;
        minutes = 0;
    }
    
    NSInteger seconds=components.second;
    
    if(seconds>=60) {
        minutes+=1;
        seconds = 0;
    }

    
    NSString *str_hours = [NSString stringWithFormat:@"%ld",(long) hours];
    
    if ([str_hours length]!=2) {
        str_hours = [NSString stringWithFormat:@"0%@",str_hours];
    }
    
    NSString *str_minutes = [NSString stringWithFormat:@"%ld",(long) minutes];
    
    if ([str_minutes length]!=2) {
        str_minutes = [NSString stringWithFormat:@"0%@",str_minutes];
    }
    
    NSString *str_seconds = [NSString stringWithFormat:@"%ld",(long) seconds];
    
    if ([str_seconds length]!=2) {
        str_seconds = [NSString stringWithFormat:@"0%@",str_seconds];
    }
    
    
    
    self.report_time = [NSString stringWithFormat:@"%@:%@:%@",str_hours,str_minutes,str_seconds];
    
    
    
    
    //self.customerRoom = [labels valueForKey:self.customerRoomNameKey];
    
    //NSLog(@"customer room %@",self.customerRoom);
    
    if(vc.cleaningType==1)
    {
        if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"livingroom"]])
        {
            self.customerRoom = [labels valueForKey:@"livingroom"];
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"living_room.png"]];
        }
        else if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"studyroom"]])
        {
            self.customerRoom = [labels valueForKey:@"studyroom"];
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"study_room.png"]];
        }
        else if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"kitchen"]])
        {
            self.customerRoom = [labels valueForKey:@"kitchen"];
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"coffee_room.png"]];
        }
        else if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"bedroom"]])
        {
            self.customerRoom = [labels valueForKey:@"bedroom"];
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bed_room.png"]];
        }
        else if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"dressingroom"]])
        {
            self.customerRoom = [labels valueForKey:@"dressingroom"];
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dressing_room.png"]];
        }
        else if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"toilet"]])
        {
            self.customerRoom = [labels valueForKey:@"toilet"];
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"toilet_room.png"]];
        }
        else if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"washingroom"]])
        {
            self.customerRoom = [labels valueForKey:@"washingroom"];
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wash_room.png"]];
        }
        else
        {
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"generic_room.png"]];
        }
    }
    
    if(vc.cleaningType == 2)
    {
        if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"reception"]]) {
            
            self.customerRoom = [labels valueForKey:@"reception"];
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"reception.png"]];
            
        }
        
        else if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"hallway"]]) {
            
            self.customerRoom = [labels valueForKey:@"hallway"];
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hallway.png"]];
            
            
        }
        
        else if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"officeroom"]]) {
            
            self.customerRoom = [labels valueForKey:@"officeroom"];
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"office_room.png"]];
            
            
        }
        
        else if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"grouproom"]]) {
            
            self.customerRoom = [labels valueForKey:@"grouproom"];
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"entrance.png"]];
            
            
        }
        
        else if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"conferenceroom"]]) {
            
            self.customerRoom = [labels valueForKey:@"conferenceroom"];
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"conference_room.png"]];
            
            
        }
        
        else if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"kitchen"]]) {
            
            self.customerRoom = [labels valueForKey:@"kitchen"];
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"coffee_room.png"]];
            
            
        }
        
        else if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"lift"]]) {
            
            self.customerRoom = [labels valueForKey:@"lift"];
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lift.png"]];
            
            
        }
        
        else if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"exculator"]]) {
            
            self.customerRoom = [labels valueForKey:@"exculator"];
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"exculator.png"]];
            
            
        }
        
        else if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"stairs"]]) {
            
            self.customerRoom = [labels valueForKey:@"stairs"];
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"stairs.png"]];
            
            
        }
        
        else if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"storeroom"]]) {
            
            self.customerRoom = [labels valueForKey:@"storeroom"];
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"store_room.png"]];
            
            
        }
        
        else if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"wherehouse"]]) {
            
            self.customerRoom = [labels valueForKey:@"wherehouse"];
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wherehouse.png"]];
            
            
        }
        
        else if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"washroom"]]) {
            
            self.customerRoom = [labels valueForKey:@"washroom"];
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"washroom.png"]];
            
            
        }
        
        else if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"shower"]]) {
            
            self.customerRoom = [labels valueForKey:@"shower"];
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shower.png"]];
            
            
        }
        
        else if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"toilet"]]) {
            
            self.customerRoom = [labels valueForKey:@"toilet"];
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"toilet.png"]];
            
            
        }
        
        else if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"wasteroom"]]) {
            
            self.customerRoom = [labels valueForKey:@"wasteroom"];
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wasteroom.png"]];
            
            
        }
        
        else if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"parking"]]) {
            
            self.customerRoom = [labels valueForKey:@"parking"];
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"parking.png"]];
            
            
        }
        
        else if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"gym"]]) {
            self.customerRoom = [labels valueForKey:@"gym"];
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gym.png"]];
            
        }
        else if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"mall"]]) {
            self.customerRoom = [labels valueForKey:@"mall"];
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mall.png"]];
            
        }
        
        else
        {
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"generic_room.png"]];
            
            
        }
    }
    
    
}

#pragma --mark set employer report room names and icons according to employer language

-(void) setEmployerReport {
    
    ViewController *vc = [ViewController sharedInstance];
    
    //NSLog(@"Entered customer report %@",vc.customerLanguageSelected);
    
    if([vc.customerLanguageSelected isEqualToString:@"Svenska"]|| [vc.customerLanguageSelected isEqualToString:@"Swedish"]) {
        
        labels = [vc.englishLabels valueForKey:@"userswedishlabels"];
        
        //NSLog(@"Entered customer report %@",vc.customerLanguageSelected);
    }
    
    if([vc.customerLanguageSelected isEqualToString:@"German"]) {
        
        labels = [vc.englishLabels valueForKey:@"usergermanlabels"];
    }
    
    if([vc.customerLanguageSelected isEqualToString:@"English"]) {
        
        labels = [vc.englishLabels valueForKey:@"userenglishlabels"];
    }
    
    
    /*CGFloat minuteDifference = [self.endDate timeIntervalSinceDate:self.startDate] / 60.0;
     
     NSLog(@" data %.2f ",minuteDifference);
     
     NSTimeInterval diff = [self.endDate timeIntervalSinceDate:self.startDate];
     
     long seconds = lroundf(diff); // Modulo (%) operator below needs int or long
     
     long hour = seconds / 3600;
     long mins = (seconds % 3600) / 60;
     long secs = seconds % 60;
     
     //NSLog(@" data1 %d,%d,%d ",hour,mins,secs);
     
     NSString *str_hour = [NSString stringWithFormat:@"%ld",hour];
     
     NSString *str_mins = [NSString stringWithFormat:@"%ld",mins];
     
     NSString *str_secs = [NSString stringWithFormat:@"%ld",secs];
     
     if([str_hour length]<2)
     str_hour = [NSString stringWithFormat:@"0%@",str_hour];
     
     if([str_mins length]<2)
     str_mins = [NSString stringWithFormat:@"0%@",str_mins];
     
     if([str_secs length]<2)
     str_secs = [NSString stringWithFormat:@"0%@",str_secs];*/
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSUInteger unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit| NSSecondCalendarUnit;
    
    NSDateComponents *components = [calendar components:unitFlags
                                               fromDate:self.startDate
                                                 toDate:self.endDate options:0];
    
    NSInteger hours =components.hour;
    NSInteger minutes=components.minute;
    
    if(minutes>=60) {
        hours+=1;
        minutes = 0;
    }
    
    NSInteger seconds=components.second;
    
    if(seconds>=60) {
        minutes+=1;
        seconds = 0;
    }
    
    
    NSString *str_hours = [NSString stringWithFormat:@"%ld",(long) hours];
    
    if ([str_hours length]!=2) {
        str_hours = [NSString stringWithFormat:@"0%@",str_hours];
    }
    
    NSString *str_minutes = [NSString stringWithFormat:@"%ld",(long) minutes];
    
    if ([str_minutes length]!=2) {
        str_minutes = [NSString stringWithFormat:@"0%@",str_minutes];
    }
    
    NSString *str_seconds = [NSString stringWithFormat:@"%ld",(long) seconds];
    
    if ([str_seconds length]!=2) {
        str_seconds = [NSString stringWithFormat:@"0%@",str_seconds];
    }
    
    
    
    self.report_time = [NSString stringWithFormat:@"%@:%@:%@",str_hours,str_minutes,str_seconds];
    
    
    
    
    //self.customerRoom = [labels valueForKey:self.customerRoomNameKey];
    
    //NSLog(@"customer room %@",self.customerRoom);
    
    if(vc.cleaningType==1)
    {
        if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"livingroom"]])
        {
            self.customerRoom = [labels valueForKey:@"livingroom"];
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"living_room.png"]];
        }
        else if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"studyroom"]])
        {
            self.customerRoom = [labels valueForKey:@"studyroom"];
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"study_room.png"]];
        }
        else if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"kitchen"]])
        {
            self.customerRoom = [labels valueForKey:@"kitchen"];
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"coffee_room.png"]];
        }
        else if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"bedroom"]])
        {
            self.customerRoom = [labels valueForKey:@"bedroom"];
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bed_room.png"]];
        }
        else if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"dressingroom"]])
        {
            self.customerRoom = [labels valueForKey:@"dressingroom"];
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dressing_room.png"]];
        }
        else if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"toilet"]])
        {
            self.customerRoom = [labels valueForKey:@"toilet"];
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"toilet_room.png"]];
        }
        else if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"washingroom"]])
        {
            self.customerRoom = [labels valueForKey:@"washingroom"];
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wash_room.png"]];
        }
        else
        {
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"generic_room.png"]];
        }
    }
    
    if(vc.cleaningType == 2)
    {
        if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"reception"]]) {
            
            self.customerRoom = [labels valueForKey:@"reception"];
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"reception.png"]];
            
        }
        
        else if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"hallway"]]) {
            
            self.customerRoom = [labels valueForKey:@"hallway"];
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hallway.png"]];
            
            
        }
        
        else if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"officeroom"]]) {
            
            self.customerRoom = [labels valueForKey:@"officeroom"];
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"office_room.png"]];
            
            
        }
        
        else if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"grouproom"]]) {
            
            self.customerRoom = [labels valueForKey:@"grouproom"];
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"entrance.png"]];
            
            
        }
        
        else if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"conferenceroom"]]) {
            
            self.customerRoom = [labels valueForKey:@"conferenceroom"];
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"conference_room.png"]];
            
            
        }
        
        else if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"kitchen"]]) {
            
            self.customerRoom = [labels valueForKey:@"kitchen"];
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"coffee_room.png"]];
            
            
        }
        
        else if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"lift"]]) {
            
            self.customerRoom = [labels valueForKey:@"lift"];
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lift.png"]];
            
            
        }
        
        else if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"exculator"]]) {
            
            self.customerRoom = [labels valueForKey:@"exculator"];
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"exculator.png"]];
            
            
        }
        
        else if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"stairs"]]) {
            
            self.customerRoom = [labels valueForKey:@"stairs"];
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"stairs.png"]];
            
            
        }
        
        else if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"storeroom"]]) {
            
            self.customerRoom = [labels valueForKey:@"storeroom"];
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"store_room.png"]];
            
            
        }
        
        else if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"wherehouse"]]) {
            
            self.customerRoom = [labels valueForKey:@"wherehouse"];
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wherehouse.png"]];
            
            
        }
        
        else if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"washroom"]]) {
            
            self.customerRoom = [labels valueForKey:@"washroom"];
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"washroom.png"]];
            
            
        }
        
        else if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"shower"]]) {
            
            self.customerRoom = [labels valueForKey:@"shower"];
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shower.png"]];
            
            
        }
        
        else if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"toilet"]]) {
            
            self.customerRoom = [labels valueForKey:@"toilet"];
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"toilet.png"]];
            
            
        }
        
        else if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"wasteroom"]]) {
            
            self.customerRoom = [labels valueForKey:@"wasteroom"];
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wasteroom.png"]];
            
            
        }
        
        else if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"parking"]]) {
            
            self.customerRoom = [labels valueForKey:@"parking"];
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"parking.png"]];
            
            
        }
        
        else if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"gym"]]) {
            self.customerRoom = [labels valueForKey:@"gym"];
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gym.png"]];
            
        }
        else if([[labels valueForKey:self.customerRoomNameKey] isEqualToString:[labels valueForKey:@"mall"]]) {
            self.customerRoom = [labels valueForKey:@"mall"];
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mall.png"]];
            
        }
        
        else
        {
            self.customerRoomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"generic_room.png"]];
            
            
        }
    }
    
    
}


@end
