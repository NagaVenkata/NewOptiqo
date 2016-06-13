//
//  CreatePdfReport.m
//  NewOptiqo
//
//  Created by Umapathi on 9/10/14.
//  Copyright (c) 2014 Umapathi. All rights reserved.
//

#import "CreatePdfReport.h"
#import "ViewController.h"
#import "AppDelegate.h"

#define COMPRESS_LEVEL 0.5
#define REPORT_FONT @"ArialMT"
#define REPORT_BOLDFONT @"Arial-BoldMT"

@implementation CreatePdfReport
@synthesize filename,reports,customerName,pdfFilename;

//Used to generate a pdf report and send to customer and employer. This report contains the customer detials, employer details, pie chart reprsenting the report status,map, a table representation of the reports with icons and comments

- (id)initWithFrame:(CGRect)frame
{
    self = [super init];
    if (self) {
        // Initialization code
        
        hours = 0;
        minutes = 0;
        seconds = 0;
        startImageCount = 0;
        endImageCount = 0;
    }
    return self;
}

#pragma --mark generating customer report
//generate the cutomer report

-(void) generatePDF {
    
    
    ViewController *vc = [ViewController sharedInstance];
    
    //NSLog(@"customer lang selected in customer report %@,%@",vc.customerLanguageSelected,[labels valueForKey:@"swedish"]);
    
    if([vc.customerLanguageSelected isEqualToString:@"Svenska"]) {
        
        labels = [vc.englishLabels valueForKey:@"userswedishlabels"];
        
         //NSLog(@"customer lang selected %@",vc.customerLanguageSelected);
    }
    
    if([vc.customerLanguageSelected isEqualToString:@"German"]) {
        
        labels = [vc.englishLabels valueForKey:@"usergermanlabels"];
    }
    
    if([vc.customerLanguageSelected isEqualToString:@"English"]) {
        
        labels = [vc.englishLabels valueForKey:@"userenglishlabels"];
    }
    
    [self getCustomer];
    [self getEmployer];
    [self getUser];
    
    
    
    NSString *headingString,*reportString;
    
    if(vc.cleaningType==1) {
        
        headingString = [labels valueForKey:@"quality"];
    }
    
    if(vc.cleaningType==2) {
        
        headingString = [labels valueForKey:@"quality"];
    }

    
    if(vc.cleaningType==1) {
        
        reportString = [labels valueForKey:@"quality_report"];
        
        
    }
    
    if(vc.cleaningType==2) {
        
        reportString = [labels valueForKey:@"quality_report"];
        
    }
    
    
    NSString *inspectionType;
    
    if(vc.cleaningType==1) {
        
        inspectionType = [labels valueForKey:@"homecleaning"];
    }
    
    if(vc.cleaningType==2) {
        
        inspectionType = [labels valueForKey:@"officecleaning"];
    }
    
    
    NSDate *endTime = [NSDate date];
    
    NSString *dateString = [NSDateFormatter localizedStringFromDate:endTime
                                                          dateStyle:NSDateFormatterShortStyle
                                                          timeStyle:NSDateFormatterShortStyle];
    
    NSString *dateTime = [NSString stringWithFormat:@"%@: %@",[labels valueForKey:@"time_date"],dateString];
    
    dateTime = [dateTime stringByReplacingOccurrencesOfString:@"/" withString:@"-"];

    
    NSArray* documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    NSString* documentDirectory = [documentDirectories objectAtIndex:0];
    NSString *pdfFileName = [documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_%@_%@%@",headingString,self.customerName,dateTime,@".pdf"]];
    
    if(![[NSFileManager defaultManager] fileExistsAtPath:pdfFileName])
       [[NSFileManager defaultManager] createFileAtPath:pdfFileName contents:nil attributes:nil];
    
    
    UIGraphicsBeginPDFContextToFile(pdfFileName, CGRectZero, nil);
    //CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 612, 792), nil);
    
    
    //company logo image
    NSString *logoPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:[NSString stringWithFormat:@"/%@/%@",@"Optiqo",@"companyLogoImage.jpg"]];
    
    UIImage *companyLogoImage = [UIImage imageWithContentsOfFile:logoPath];
    
    NSData *jpegData = UIImageJPEGRepresentation(companyLogoImage, COMPRESS_LEVEL);
    companyLogoImage = [UIImage imageWithData:jpegData];

    
    /*UIImage *logoImage = [UIImage imageNamed:@"optiqo_icon.png"];
    
    NSData *jpegData = UIImageJPEGRepresentation(logoImage, COMPRESS_LEVEL);
    logoImage = [UIImage imageWithData:jpegData];*/

    
    [companyLogoImage drawInRect:CGRectMake(20, 20, 150, 50)];
    
    isCustomerReport = YES;

    
    //CGFloat pageOffset = 0;
    
    

    UIFont *font = [UIFont fontWithName:REPORT_FONT size:12.0];
    
    UIFont *bold_font = [UIFont fontWithName:REPORT_BOLDFONT size:12.0];
    
    
    NSDictionary *attrsDictionary =
    
    [NSDictionary dictionaryWithObjectsAndKeys:
     font, NSFontAttributeName,
     [NSNumber numberWithFloat:1.0], NSBaselineOffsetAttributeName, nil];
    
    NSDictionary *attrsDictionaryBold =
    
    [NSDictionary dictionaryWithObjectsAndKeys:
     bold_font, NSFontAttributeName,
     [NSNumber numberWithFloat:1.0], NSBaselineOffsetAttributeName, nil];
    
    /*NSDictionary *attrsImageCountDictionary =
    
    [NSDictionary dictionaryWithObjectsAndKeys:
     font, NSFontAttributeName,
     [NSNumber numberWithFloat:1.0], NSBaselineOffsetAttributeName,[UIColor whiteColor],NSBackgroundColorAttributeName,nil];*/
    
    UIFont *cleaningTypeFont = [UIFont fontWithName:REPORT_FONT size:32.0];
    
    UIColor *cleaningTypecolor = [UIColor clearColor];
    
    UIColor *cleaningTypeForecolor = [UIColor colorWithRed:250.0/255 green:236.0/255.0 blue:208.0/255.0 alpha:1.0];


    NSDictionary *attrsCleaningTypeDictionary =
    
    [NSDictionary dictionaryWithObjectsAndKeys:
     cleaningTypeFont, NSFontAttributeName,
     [NSNumber numberWithFloat:1.0], NSBaselineOffsetAttributeName,cleaningTypecolor,NSBackgroundColorAttributeName,cleaningTypeForecolor,NSForegroundColorAttributeName,nil];

    
    

    //[headingString drawInRect:CGRectMake(250, pageOffset, 200, 34) withFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:14] lineBreakMode:UILineBreakModeWordWrap alignment:UITextAlignmentLeft];
    
    //NSString *customerName = ((RoomListContent *)[self.reports objectAtIndex:0]).customerName;

    
    //[customerName drawInRect:CGRectMake(100, 100, 200, 34) withAttributes:attrsDictionary];
    
    [[self drawReportImage] drawInRect:CGRectMake(5, 75, 600,250)];
    
    if([vc.customerLanguageSelected isEqualToString:@"Svenska"])
        [headingString drawInRect:CGRectMake(190, 75, 200, 40) withAttributes:attrsCleaningTypeDictionary];
    else
        [headingString drawInRect:CGRectMake(200, 75, 200, 40) withAttributes:attrsCleaningTypeDictionary];
    
    cleaningTypeForecolor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    
    attrsCleaningTypeDictionary =
    
    [NSDictionary dictionaryWithObjectsAndKeys:
     cleaningTypeFont, NSFontAttributeName,
     [NSNumber numberWithFloat:1.0], NSBaselineOffsetAttributeName,cleaningTypecolor,NSBackgroundColorAttributeName,cleaningTypeForecolor,NSForegroundColorAttributeName,nil];
    
    if([vc.customerLanguageSelected isEqualToString:@"Svenska"])
        [reportString drawInRect:CGRectMake(310, 75, 200, 40) withAttributes:attrsCleaningTypeDictionary];
    else
        [reportString drawInRect:CGRectMake(310, 75, 200, 40) withAttributes:attrsCleaningTypeDictionary];

    
    [reportImage drawInRect:CGRectMake(71, 120, 200, 200)];
    
    [scoreImage drawInRect:CGRectMake(337, 120, 200, 200)];
    
    //NSString *str = [NSString stringWithFormat:@"%@%f",@"Score",rating];
    
    //PieChartView *pieChartView = [[PieChartView alloc] initWithFrame:CGRectMake(0, 0, 300, 300) initWithRate:1.0 withOptions:2];
    
    //[self addSubview:pieChartView];
    
    //[[self drawReportImageWithText:str] drawInRect:CGRectMake(325, 125, 225, 225)];
    
    //[pieChartView.ratingImage drawInRect:CGRectMake(325, 100, 300, 300)];
    
    
    //UIColor *color = [UIColor greenColor];
    
    /*NSDictionary *statsAttrsDictionary =
    [NSDictionary dictionaryWithObjectsAndKeys:
     font,NSFontAttributeName,color,NSForegroundColorAttributeName,
     [NSNumber numberWithFloat:1.0], NSBaselineOffsetAttributeName, nil];*/
    
    
    //NSString *stats = @"Statistics";
    
    //[stats drawInRect:CGRectMake(100, 150, 200, 34) withAttributes:statsAttrsDictionary];
    
    
    
    
    /*for(int i=0;i<[self.reports count];i++) {
     
        UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 612, 792), nil);
        
        [self addNewPDFPage:i];
        
    }*/
    
    cleaningTypeFont = [UIFont fontWithName:REPORT_FONT size:20.0];
    
    attrsCleaningTypeDictionary =
    
    [NSDictionary dictionaryWithObjectsAndKeys:
     cleaningTypeFont, NSFontAttributeName,
     [NSNumber numberWithFloat:1.0], NSBaselineOffsetAttributeName,cleaningTypecolor,NSBackgroundColorAttributeName,nil];
    
    
    NSString *clientInfo = [labels valueForKey:@"clientinformation"];
    
    [clientInfo drawInRect:CGRectMake(25, 335, 300, 34) withAttributes:attrsCleaningTypeDictionary];
    
    
    
    CGSize textSize1 = [[labels valueForKey:@"name"] sizeWithAttributes:@{NSFontAttributeName:bold_font}];
    
    CGSize textSize2 = [[labels valueForKey:@"reportAddress"] sizeWithAttributes:@{NSFontAttributeName:bold_font}];
    
    CGSize textSize3 = [[labels valueForKey:@"time_date"] sizeWithAttributes:@{NSFontAttributeName:bold_font}];
    
    int maxSize = textSize1.width;
    
    if(textSize1.width<textSize2.width)
        maxSize = textSize2.width;
    
    if(maxSize<textSize3.width)
        maxSize = textSize3.width;
    
    
    NSString *cust_label = [NSString stringWithFormat:@"%@:",[labels valueForKey:@"name"]];
    
    
    NSString *cust_name = self.customerName;
    
    [cust_label drawInRect:CGRectMake(25, 380, 75, 34) withAttributes:attrsDictionaryBold];
    
    [cust_name drawInRect:CGRectMake(maxSize+40, 380, 200, 34) withAttributes:attrsDictionary];
    
    NSString *cust_city = NULL;
    
    if([custCity length]==0) {
        
        cust_city = @"-";
    }
    else {
        
        cust_city = custCity;
    }
    
    NSString *cust_cityLabel = [NSString stringWithFormat:@"%@:",[labels valueForKey:@"reportAddress"]];
    
    [cust_cityLabel drawInRect:CGRectMake(25, 400, 75, 34) withAttributes:attrsDictionaryBold];
    
    [cust_city drawInRect:CGRectMake(maxSize+40, 400, 200, 34) withAttributes:attrsDictionary];
    
    /*NSDate *endTime = [NSDate date];
     
     NSString *dateString = [NSDateFormatter localizedStringFromDate:endTime
     dateStyle:NSDateFormatterShortStyle
     timeStyle:NSDateFormatterShortStyle];
     
     NSString *dateTime = [NSString stringWithFormat:@"%@",dateString];*/
    
    endTime = [NSDate date];
    
    dateString = [NSDateFormatter localizedStringFromDate:endTime
                                                          dateStyle:NSDateFormatterShortStyle
                                                          timeStyle:NSDateFormatterShortStyle];
    
    dateTime = dateString;
    
    
    dateTime = [dateTime stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    
    
    NSString *cust_dateTime =[NSString stringWithFormat:@"%@:",[labels valueForKey:@"time_date"]];
    
    [cust_dateTime drawInRect:CGRectMake(25, 420, 75, 34) withAttributes:attrsDictionaryBold];
    
    [dateTime drawInRect:CGRectMake(maxSize+40, 420, 200, 34) withAttributes:attrsDictionary];
    
   /*
    for(int i=0;i<[self.reports count];i++) {
        
        RoomListContent *roomContent = (RoomListContent *)[self.reports objectAtIndex:i];
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        
        NSUInteger unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit| NSSecondCalendarUnit;
        
        NSDateComponents *components = [calendar components:unitFlags
                                                   fromDate:roomContent.startDate
                                                     toDate:roomContent.endDate options:0];
        
        hours+=components.hour;
        minutes+=components.minute;
        
        if(minutes>=60) {
            hours+=1;
            minutes = 0;
        }
        
        seconds+=components.second;
        
        if(seconds>=60) {
            minutes+=1;
            seconds = 0;
        }
        
    }
    
    NSString *total_hours = [NSString stringWithFormat:@"%ld",(long) hours];
    
    if ([total_hours length]!=2) {
        total_hours = [NSString stringWithFormat:@"0%@",total_hours];
    }
    
    NSString *total_minutes = [NSString stringWithFormat:@"%ld",(long) minutes];
    
    if ([total_minutes length]!=2) {
        total_minutes = [NSString stringWithFormat:@"0%@",total_minutes];
    }
    
    NSString *total_seconds = [NSString stringWithFormat:@"%ld",(long) seconds];
    
    if ([total_seconds length]!=2) {
        total_seconds = [NSString stringWithFormat:@"0%@",total_seconds];
    }
    
    NSString *timeTake = [NSString stringWithFormat:@"%@:%@:%@",total_hours,total_minutes,total_seconds];
    
    
    timeTake = [NSString stringWithFormat:@"%@: %@",[labels valueForKey:@"total_time"],timeTake];
    
    
    [timeTake drawInRect:CGRectMake(25, 445, 300, 34) withAttributes:attrsDictionary];
    
    
    //[self drawLineHorizontalWithFrame:CGRectMake(25, 600, 250, 4)
    //withColor:[UIColor colorWithRed:246.0/255.0 green:176.0/255.0 blue:4.0/255.0 alpha:1.0 ]]; */
    
    
    
    
    //comapny information
    NSString *compayInfo = [labels valueForKey:@"companyinformation"];
    
    [compayInfo drawInRect:CGRectMake(300, 335, 300, 34) withAttributes:attrsCleaningTypeDictionary];
    
    NSString *companyLabel = [NSString stringWithFormat:@"%@:",[labels valueForKey:@"name"]];
    
    
    NSString *companyName = employerName;
    
    [companyLabel drawInRect:CGRectMake(300, 380, 75, 34) withAttributes:attrsDictionaryBold];
    
    [companyName drawInRect:CGRectMake(360, 380, 200, 34) withAttributes:attrsDictionary];
    
    NSString *companyAddressLabel = [NSString stringWithFormat:@"%@:",[labels valueForKey:@"reportAddress"]];
    
    NSString *companyAddress = employerAddress;
    
    [companyAddressLabel drawInRect:CGRectMake(300, 400, 75, 34) withAttributes:attrsDictionaryBold];
    
    [companyAddress drawInRect:CGRectMake(360, 400, 300, 34) withAttributes:attrsDictionary];
    
    NSString *companyEmailLabel = [NSString stringWithFormat:@"%@:",[labels valueForKey:@"reportemail"]];
    
    NSString *companyEmail = employerEmail;
    
    [companyEmailLabel drawInRect:CGRectMake(300, 420, 75, 34) withAttributes:attrsDictionaryBold];
    [companyEmail drawInRect:CGRectMake(360, 420, 300, 34) withAttributes:attrsDictionary];
    
    NSString *companyWebAddressLabel = [NSString stringWithFormat:@"%@:",[labels valueForKey:@"reportwebsite"]];
    
    NSString *companyWebAddress = employerWebSite;
    
    [companyWebAddressLabel drawInRect:CGRectMake(300, 440, 75, 34) withAttributes:attrsDictionaryBold];
    [companyWebAddress drawInRect:CGRectMake(360, 440, 300, 34) withAttributes:attrsDictionary];
    
    NSString *companyPhoneLabel = [NSString stringWithFormat:@"%@:",[labels valueForKey:@"reportphonenumber"]];
    
    
    NSString *companyPhone = employerPhone;
    
    [companyPhoneLabel drawInRect:CGRectMake(300, 460, 75, 34) withAttributes:attrsDictionaryBold];
    [companyPhone drawInRect:CGRectMake(360, 460, 300, 34) withAttributes:attrsDictionary];
    
    
    
    
    //[companyLogoImage drawInRect:CGRectMake(300, 475, 150, 100)];
    
    [self drawLineHorizontalWithFrame:CGRectMake(300, 495, 250, 4)
                            withColor:[UIColor colorWithRed:246.0/255.0 green:176.0/255.0 blue:4.0/255.0 alpha:1.0 ]];
    
    NSString *imagePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:[NSString stringWithFormat:@"/%@/%@",@"Optiqo",@"userSign.jpg"]];
    
    NSString *inspection = [labels valueForKey:@"inspectionCarriedBy:"];
    
    [inspection drawInRect:CGRectMake(300, 500, 300, 34) withAttributes:attrsDictionary];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:imagePath]) {
        
        UIImage *signImage = [UIImage imageWithContentsOfFile:imagePath];
        
        jpegData = UIImageJPEGRepresentation(signImage, COMPRESS_LEVEL);
        signImage = [UIImage imageWithData:jpegData];
        
        
        [signImage drawInRect:CGRectMake(300, 525, 250, 100)];
    }
    
    [self drawLineHorizontalWithFrame:CGRectMake(300, 630, 250, 2)
                            withColor:[UIColor colorWithRed:246.0/255.0 green:176.0/255.0 blue:4.0/255.0 alpha:1.0 ]];
    
    [userName drawInRect:CGRectMake(300, 635, 250, 34) withAttributes:attrsDictionary];

    UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 612, 792), nil);
    
    //companyLogoImage = [UIImage imageNamed:@"optiqo_icon.png"];
    
    //jpegData = UIImageJPEGRepresentation(logoImage, COMPRESS_LEVEL);
    //logoImage = [UIImage imageWithData:jpegData];

    
    [companyLogoImage drawInRect:CGRectMake(20, 20, 150, 50)];
    
    [self drawLineHorizontalWithFrame:CGRectMake(5, 70, 600, 4)
                            withColor:[UIColor colorWithRed:246.0/255.0 green:176.0/255.0 blue:4.0/255.0 alpha:1.0]];

    
    [self drawTableTitles];
    
    images = [[NSMutableArray alloc] init];
    
    [self drawLineVerticalWithFrame:CGRectMake(80, 100, 4, 650)
                  withColor:[UIColor colorWithRed:246.0/255.0 green:176.0/255.0 blue:4.0/255.0 alpha:1.0 ]];
    
    
    if(vc.cleaningType == 1)
    {
        [self houseCleaningReport:@"Customer"];
    }
    
    if(vc.cleaningType == 2)
    {
        [self officeCleaningReport:@"Customer"];
    }

    
   /*
    
    int j=150;
    
    for(int i=0;i<[self.reports count];i++) {
        
        RoomListContent *roomContent = (RoomListContent *)[self.reports objectAtIndex:i];
        
        NSString *roomName = roomContent.customerRoom;
        
        NSString *roomComments = roomContent.roomComents;
        
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        
        NSUInteger unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit| NSSecondCalendarUnit;

        
        NSDateComponents *components = [calendar components:unitFlags
                                                   fromDate:roomContent.startDate
                                                     toDate:roomContent.endDate options:0];
        
        NSString *str_hours = [NSString stringWithFormat:@"%ld",(long) components.hour];
        
        if ([str_hours length]!=2) {
            str_hours = [NSString stringWithFormat:@"0%@",str_hours];
        }
        
        NSString *str_minutes = [NSString stringWithFormat:@"%ld",(long) components.minute];
        
        if ([str_minutes length]!=2) {
            str_minutes = [NSString stringWithFormat:@"0%@",str_minutes];
        }
        
        NSString *str_seconds = [NSString stringWithFormat:@"%ld",(long) components.second];
        
        if ([str_seconds length]!=2) {
            str_seconds = [NSString stringWithFormat:@"0%@",str_seconds];
        }
        
        NSString *timeTake = [NSString stringWithFormat:@"%@:%@:%@",str_hours,str_minutes,str_seconds];
        
        
        
        [self drawLineHorizontalWithFrame:CGRectMake(20, j, 580, 4)
                      withColor:[UIColor colorWithRed:246.0/255.0 green:176.0/255.0 blue:4.0/255.0 alpha:1.0 ]];
        j+=100;
        
        if(j<=750) {
            if([roomName isEqualToString:@"Living room"]) {
            
                UIImage *image = [UIImage imageNamed:@"living_room.png"];
                
                NSData *jpegData = UIImageJPEGRepresentation(image, COMPRESS_LEVEL);
                image = [UIImage imageWithData:jpegData];

            
                [image drawInRect:CGRectMake(25, j-80, 40, 40)];
            }
        
            else if([roomName isEqualToString:@"Study room"]) {
            
                UIImage *image = [UIImage imageNamed:@"study_room.png"];
                
                NSData *jpegData = UIImageJPEGRepresentation(image, COMPRESS_LEVEL);
                image = [UIImage imageWithData:jpegData];
            
                [image drawInRect:CGRectMake(25, j-80, 40, 40)];
            }
            
            else if([roomName isEqualToString:@"kitchen"]) {
                
                UIImage *image = [UIImage imageNamed:@"generic_room.png"];
                
                NSData *jpegData = UIImageJPEGRepresentation(image, COMPRESS_LEVEL);
                image = [UIImage imageWithData:jpegData];
                
                [image drawInRect:CGRectMake(25, j-80, 40, 40)];
            }
        
            else if([roomName isEqualToString:@"Bedroom"]) {
            
                UIImage *image = [UIImage imageNamed:@"bed_room.png"];
                
                NSData *jpegData = UIImageJPEGRepresentation(image, COMPRESS_LEVEL);
                image = [UIImage imageWithData:jpegData];
            
                [image drawInRect:CGRectMake(25, j-80, 40, 40)];
            }
        
            else if([roomName isEqualToString:@"Hallway"]) {
            
                UIImage *image = [UIImage imageNamed:@"dressing_room.png"];
                
                NSData *jpegData = UIImageJPEGRepresentation(image, COMPRESS_LEVEL);
                image = [UIImage imageWithData:jpegData];
            
                [image drawInRect:CGRectMake(25, j-80, 40, 40)];
            }
        
            else if([roomName isEqualToString:@"Bathroom"]) {
            
                UIImage *image = [UIImage imageNamed:@"toilet_room.png"];
                
                NSData *jpegData = UIImageJPEGRepresentation(image, COMPRESS_LEVEL);
                image = [UIImage imageWithData:jpegData];
                
                [image drawInRect:CGRectMake(25, j-80, 40, 40)];
            }
        
            else if([roomName isEqualToString:@"Washing room"]) {
                
                UIImage *image = [UIImage imageNamed:@"wash_room.png"];
                
                NSData *jpegData = UIImageJPEGRepresentation(image, COMPRESS_LEVEL);
                image = [UIImage imageWithData:jpegData];
            
                [image drawInRect:CGRectMake(25, j-80, 40, 40)];
            }
            else
            {
                UIImage *image = [UIImage imageNamed:@"generic_room.png"];
                
                NSData *jpegData = UIImageJPEGRepresentation(image, COMPRESS_LEVEL);
                image = [UIImage imageWithData:jpegData];
                
                [image drawInRect:CGRectMake(25, j-80, 40, 40)];
            }
            
        
            [roomName drawInRect:CGRectMake(95, j-80, 75, 50) withAttributes:attrsDictionary];
        
            NSNumber *approve = roomContent.approveRoom;
        
        
            if([approve boolValue]) {
            
                UIImage *image = [UIImage imageNamed:@"approve.png"];
                
                NSData *jpegData = UIImageJPEGRepresentation(image, COMPRESS_LEVEL);
                image = [UIImage imageWithData:jpegData];
            
                [image drawInRect:CGRectMake(525, j-80, 40, 40)];
            }
            else {
            
                UIImage *image = [UIImage imageNamed:@"close_icon.png"];
                
                NSData *jpegData = UIImageJPEGRepresentation(image, COMPRESS_LEVEL);
                image = [UIImage imageWithData:jpegData];
            
                [image drawInRect:CGRectMake(525, j-80, 40, 40)];
            }
            
            if(![roomComments isEqualToString:@"No Comments"])
                [roomComments drawInRect:CGRectMake(250, j-80, 200, 60) withAttributes:attrsDictionary];
            else {
                
                roomComments = @"-";
                [roomComments drawInRect:CGRectMake(300, j-80, 200, 60) withAttributes:attrsDictionary];
            }
            
            //[timeTake drawInRect:CGRectMake(425, j-80, 100, 60) withAttributes:attrsDictionary];
            
            
            if([roomContent.roomContainsImages boolValue]) {
                [self imageCount:i row:j];
            }
            
        
            
            if(startImageCount != 0 && [roomContent.roomContainsImages boolValue]) {
                NSString *imageCount = [NSString stringWithFormat:@"%d-%d",startImageCount,endImageCount];
            
                [imageCount drawInRect:CGRectMake(185, j-80, 50, 20) withAttributes:attrsDictionary];
                
                
            }
            else
            {
                
                NSString *imageCount = @"-";
                
                [imageCount drawInRect:CGRectMake(200, j-80, 100, 34) withAttributes:attrsDictionary];
            }
            
            startImageCount = endImageCount;
        }
        
        if(j>700) {
            UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 612, 792), nil);
            
            logoImage = [UIImage imageNamed:@"optiqo_icon.png"];
            
            jpegData = UIImageJPEGRepresentation(logoImage, COMPRESS_LEVEL);
            logoImage = [UIImage imageWithData:jpegData];
            
            [logoImage drawInRect:CGRectMake(20, 20, 250, 40)];
            
            [self drawLineHorizontalWithFrame:CGRectMake(5, 70, 600, 4)
                                    withColor:[UIColor colorWithRed:246.0/255.0 green:176.0/255.0 blue:4.0/255.0 alpha:1.0 ]];

            
            [self drawTableTitles];
            
            [self drawLineVerticalWithFrame:CGRectMake(80, 100, 4, 650)
                          withColor:[UIColor colorWithRed:246.0/255.0 green:176.0/255.0 blue:4.0/255.0 alpha:1.0 ]];
            
            j=150;
            i--;
        }
        
    }
    
    //[self drawLineVerticalWithFrame:CGRectMake(60, 20, 4, 700)
                  //withColor:[UIColor colorWithRed:246.0/255.0 green:176.0/255.0 blue:4.0/255.0 alpha:1.0 ]];
    [self drawLineHorizontalWithFrame:CGRectMake(20, j, 580, 4)
                            withColor:[UIColor colorWithRed:246.0/255.0 green:176.0/255.0 blue:4.0/255.0 alpha:1.0 ]];
    
   
    UIImage *img = NULL;
    
    if([images count]!=0) {
        
        
        j=100;
        
        xIndex = 50;
        yIndex = 100;
        
        UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 612, 792), nil);
        
        logoImage = [UIImage imageNamed:@"optiqo_icon.png"];
        
        jpegData = UIImageJPEGRepresentation(logoImage, COMPRESS_LEVEL);
        logoImage = [UIImage imageWithData:jpegData];
        
        [logoImage drawInRect:CGRectMake(20, 20, 200, 40)];
        
        [self drawLineHorizontalWithFrame:CGRectMake(5, 70, 600, 4)
                                withColor:[UIColor colorWithRed:246.0/255.0 green:176.0/255.0 blue:4.0/255.0 alpha:1.0 ]];

    
        img = [images objectAtIndex:0];
    
        [img drawInRect:CGRectMake(xIndex, yIndex, 250, 150)];
    
        NSString *imgCountLabel = [NSString stringWithFormat:@"%d",1];
    

        [imgCountLabel drawInRect:CGRectMake(xIndex+125, 75, 30, 25) withAttributes:attrsImageCountDictionary];
    }
    
   

    for(int i=1;i<[images count];i++) {
        
        //[self drawImageCount:i row:j];
        
        img = [images objectAtIndex:i];
        
        
        if(i%2==0){
        
            xIndex = 50;
            yIndex +=200;
            
            if(yIndex>650) {
                
                UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 612, 792), nil);
                logoImage = [UIImage imageNamed:@"optiqo_icon.png"];
                
                jpegData = UIImageJPEGRepresentation(logoImage, COMPRESS_LEVEL);
                logoImage = [UIImage imageWithData:jpegData];
                
                [logoImage drawInRect:CGRectMake(20, 20, 250, 50)];
                
                [self drawLineHorizontalWithFrame:CGRectMake(5, 70, 600, 4)
                                        withColor:[UIColor colorWithRed:246.0/255.0 green:176.0/255.0 blue:4.0/255.0 alpha:1.0 ]];

                yIndex=100;
            }
            
        }
        else {
            
            xIndex+=260;
        }
        
        
       [img drawInRect:CGRectMake(xIndex, yIndex, 250, 150)];
        
        UIView *imageCount = [[UIView alloc] initWithFrame:CGRectMake(xIndex, yIndex+120, 25, 30)];
        
        UILabel *label = [[[UILabel alloc] init] initWithFrame:CGRectMake(0, 0, imageCount.frame.size.width, imageCount.frame.size.height)];
        
        [label setBackgroundColor:[UIColor whiteColor]];
        
        NSString *imgCountLabel = [NSString stringWithFormat:@"%d",(i+1)];
        
        [label setText:imgCountLabel];
        
        [label setTextAlignment:NSTextAlignmentCenter];
        
        [label setFont:[UIFont fontWithName:@"Avnier-medium" size:16.0]];
        
        [label.text drawInRect:CGRectMake(xIndex+125, yIndex-25, 30, 25) withAttributes:attrsImageCountDictionary];
 
            

    }*/
    
    
    UIGraphicsEndPDFContext();
    
    //pdf file name
    
    self.filename = pdfFileName;
    
    //generats a name for pdf file
    /*self.pdfFilename =  [NSString stringWithFormat:@"%@ %@ - %@ %@ - %@",[labels valueForKey:@"quality"],[labels valueForKey:@"quality_report"],self.customerName,dateTime,@".pdf"];*/
    
    if([vc.customerLanguageSelected isEqualToString:@"Svenska"])
        self.pdfFilename =  [NSString stringWithFormat:@"%@%@ - %@ - %@ - %@",[labels valueForKey:@"quality"],[labels valueForKey:@"quality_report"],self.customerName,dateTime,@".pdf"];
    else
        self.pdfFilename =  [NSString stringWithFormat:@"%@ %@ - %@ - %@ - %@",[labels valueForKey:@"quality"],[labels valueForKey:@"quality_report"],self.customerName,dateTime,@".pdf"];

}

//get user information

-(void) getUser {
    
    
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *dataContext = [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchData = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:dataContext];
    
    [fetchData setEntity:entity];
    
    NSError *error;
    
    NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData error:&error];
    
    NSManagedObject *userData = nil;
    
    if(fetchObjects) {
        
        for(int i=0;i<[fetchObjects count];i++) {
            
            userData = [fetchObjects objectAtIndex:i];
            
            userName = [NSString stringWithFormat:@"%@ %@",[userData valueForKey:@"userFirstName"],[userData valueForKey:@"userLastName"]];
        }
    }
    
}

//get emoloyer information
-(void) getEmployer {
    
    
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
            
            employerName = [userData valueForKey:@"companyName"];
            employerAddress = [userData valueForKey:@"streetName"];
            employerEmail = [userData valueForKey:@"email"];
            employerWebSite = [userData valueForKey:@"webLink"];
            employerPhone = [userData valueForKey:@"phoneNumber"];
        }
    }
    
}

//get customer information
-(void) getCustomer {
    
    
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *dataContext = [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchData = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Customer" inManagedObjectContext:dataContext];
    
    [fetchData setEntity:entity];
    
    
    
    //NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData error:&error];
    
    NSManagedObject *userData = nil;
    
    NSPredicate *pred =[NSPredicate predicateWithFormat:@"(name = %@)",self.customerName];
    
    [fetchData setPredicate:pred];
    //NSManagedObject *matches = nil;
    
    NSError *error;
    NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData
                                                       error:&error];
    
    if(fetchObjects) {
        
        for(int i=0;i<[fetchObjects count];i++) {
            userData = [fetchObjects objectAtIndex:i];
            custLanguage = [userData valueForKey:@"language"];
            custCity = [userData valueForKey:@"address"];
            
        }
    }
    
}

//map view
- (void)mapView:(MKMapView *)mv didAddAnnotationViews:(NSArray *)views
{
    
    ViewController *vc = [ViewController sharedInstance];
    
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = vc.lat;
    zoomLocation.longitude= vc.lan;

    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance
    (zoomLocation, 1500, 1500);
    [mv setRegion:region animated:NO];
    
    
    
    
    //[mv selectAnnotation:region animated:YES];
}


//draw images with index

-(void) drawImages:(int) index {
    
    //NSString *customerName = ((RoomListContent *)[self.reports objectAtIndex:index]).customerName;
    
    NSString *roomName = ((RoomListContent *)[self.reports objectAtIndex:index]).customerRoom;
    
    NSString *imagePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:[NSString stringWithFormat:@"/%@/%@/%@",@"Optiqo",customerName,roomName]];
    

    
    int i=50;
    
    NSString *path = [NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"image1"]];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        
        UIImage *image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"image1"]]];
        UIImageJPEGRepresentation(image, 0.75);
        [image drawInRect:CGRectMake(i, 275, 100, 100)];
        

    }
    
    i+=125;
    
    path = [NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"image2"]];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        
        UIImage *image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"image2"]]];
        
        UIImageJPEGRepresentation(image, 0.75);
        [image drawInRect:CGRectMake(i, 275, 100, 100)];
        

    }
    
    i+=125;
    
    path = [NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"image3"]];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        
        UIImage *image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"image3"]]];
        
        UIImageJPEGRepresentation(image, 0.75);
        [image drawInRect:CGRectMake(i, 275, 100, 100)];
        

    }
    
    i+=125;
    
    path = [NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"image4"]];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        
        UIImage *image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"image4"]]];
        
        UIImageJPEGRepresentation(image, 0.75);
        [image drawInRect:CGRectMake(i, 275, 100, 100)];
        
    }
    
    i+=125;
    
    path = [NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"image5"]];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        
        UIImage *image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"image5"]]];
        
        UIImageJPEGRepresentation(image, 0.75);
        [image drawInRect:CGRectMake(i, 275, 100, 100)];
        
        
    }
    
    
}

#pragma --mark generate employer report

-(void) generateEmployerPDF {
    
    /*NSArray* documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    NSString* documentDirectory = [documentDirectories objectAtIndex:0];
    NSString *pdfFileName = [documentDirectory stringByAppendingPathComponent:@"mypdf.pdf"];
    
    UIGraphicsBeginPDFContextToFile(pdfFileName, CGRectZero, nil);
    //CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 612, 792), nil);
    
    CGFloat pageOffset = 0;
    
    ViewController *vc = [ViewController sharedInstance];
    
    NSString *headingString;
    
    if(vc.cleaningType==1) {
        
        headingString = @"Home Cleaning Report";
    }
    
    if(vc.cleaningType==2) {
        
        headingString = @"Office Cleaning Report";
    }
    
    
    [self getEmployer];
    
    
    UIFont *font = [UIFont fontWithName:@"Avenir-Medium" size:16.0];
    
    NSDictionary *attrsDictionary =
    
    [NSDictionary dictionaryWithObjectsAndKeys:
     font, NSFontAttributeName,
     [NSNumber numberWithFloat:1.0], NSBaselineOffsetAttributeName, nil];
    
    [headingString drawInRect:CGRectMake(250, pageOffset, 200, 34) withAttributes:attrsDictionary];
    
    
    //[headingString drawInRect:CGRectMake(250, pageOffset, 200, 34) withFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:14] lineBreakMode:UILineBreakModeWordWrap alignment:UITextAlignmentLeft];
    
    NSString *customerName = ((RoomListContent *)[self.reports objectAtIndex:0]).customerName;
    
    
    [customerName drawInRect:CGRectMake(300, 100, 200, 34) withAttributes:attrsDictionary];
    
    
    for(int i=0;i<[self.reports count];i++) {
        
        UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 612, 792), nil);
        
        [self addNewPDFPage:i];
        
    }
    
    UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 612, 792), nil);
    
    
    NSString *imagePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:[NSString stringWithFormat:@"/%@",@"Optiqo"]];
    
    
    
    NSString  *path = [NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"custMap"]];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        
        //NSLog(@"entered data");
        UIImage *image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"custMap"]]];
        
        [image drawInRect:CGRectMake(50, 50, 200, 200)];
        
        
    }

    
    
    
    for(int i=0;i<[self.reports count];i++) {
    
        RoomListContent *roomContent = (RoomListContent *)[self.reports objectAtIndex:i];
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        
        NSUInteger unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit| NSSecondCalendarUnit;
        
        NSDateComponents *components = [calendar components:unitFlags
                                                    fromDate:roomContent.startDate
                                                      toDate:roomContent.endDate options:0];
        hours+=components.hour;
        minutes+=components.minute;
        
        if(minutes>=60) {
            hours+=1;
            minutes = 0;
        }
        
        seconds+=components.second;
        
        if(seconds>=60) {
            minutes+=1;
            seconds = 0;
        }
        
    }

    NSString *timeTake = [NSString stringWithFormat:@"%ld:%ld:%ld",(long)hours,(long)minutes,(long)seconds];
    
    
    timeTake = [NSString stringWithFormat:@"%@:%@",@"Totla Time Taken",timeTake];
    
    
    [timeTake drawInRect:CGRectMake(50, 300, 500, 34) withAttributes:attrsDictionary];
    
    
    imagePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:[NSString stringWithFormat:@"/%@/%@",@"Optiqo",@"userSign.jpg"]];
    
    
    if([[NSFileManager defaultManager] fileExistsAtPath:imagePath]) {
        
        UIImage *signImage = [UIImage imageWithContentsOfFile:imagePath];
        
        [signImage drawInRect:CGRectMake(50, 350, 250, 200)];
    }
    

    
    UIGraphicsEndPDFContext();
    
    self.filename = pdfFileName;*/
    
    ViewController *vc = [ViewController sharedInstance];
    
    //NSLog(@"user selected language %@",vc.userLanguageSelected);
    
    if([vc.customerLanguageSelected isEqualToString:@"Svenska"]|| [vc.userLanguageSelected isEqualToString:@"Swedish"]) {
        
        labels = [vc.englishLabels valueForKey:@"userswedishlabels"];
    }
    
    if([vc.customerLanguageSelected isEqualToString:@"German"]) {
        
        labels = [vc.englishLabels valueForKey:@"usergermanlabels"];
    }
    
    if([vc.customerLanguageSelected isEqualToString:@"English"]) {
        
        labels = [vc.englishLabels valueForKey:@"userenglishlabels"];
    }
    
    [self getCustomer];
    [self getEmployer];
    [self getUser];
    
    
    
    NSString *headingString,*reportString;
    
    if(vc.cleaningType==1) {
        
        headingString = [labels valueForKey:@"quality"];
    }
    
    if(vc.cleaningType==2) {
        
        headingString = [labels valueForKey:@"quality"];
    }
    
    if(vc.cleaningType==1) {
        
        reportString = [labels valueForKey:@"quality_report"];
        
    }
    
    if(vc.cleaningType==2) {
        
        reportString = [labels valueForKey:@"quality_report"];
        
    }
    
    
    NSString *inspectionType;
    
    if(vc.cleaningType==1) {
        
        inspectionType = [labels valueForKey:@"homecleaning"];
    }
    
    if(vc.cleaningType==2) {
        
        inspectionType = [labels valueForKey:@"officecleaning"];
    }
    
    
    NSDate *endTime = [NSDate date];
    
    NSString *dateString = [NSDateFormatter localizedStringFromDate:endTime
                                                          dateStyle:NSDateFormatterShortStyle
                                                          timeStyle:NSDateFormatterShortStyle];
    
    NSString *dateTime = [NSString stringWithFormat:@"%@: %@",[labels valueForKey:@"time_date"],dateString];
    
    dateTime = [dateTime stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    
    
    NSArray* documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    NSString* documentDirectory = [documentDirectories objectAtIndex:0];
    NSString *pdfFileName = [documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@-%@%@%@",inspectionType,self.customerName,dateTime,@".pdf"]];
    UIGraphicsBeginPDFContextToFile(pdfFileName, CGRectZero, nil);
    //CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 612, 792), nil);
    
    /*UIImage *logoImage = [UIImage imageNamed:@"optiqo_icon.png"];
    
    NSData *jpegData = UIImageJPEGRepresentation(logoImage, COMPRESS_LEVEL);
    logoImage = [UIImage imageWithData:jpegData];
    logoImage drawInRect:CGRectMake(20, 20, 150, 40)];*/
    
    //company logo image
    NSString *logoPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:[NSString stringWithFormat:@"/%@/%@",@"Optiqo",@"companyLogoImage.jpg"]];

    
    UIImage *companyLogoImage = [UIImage imageWithContentsOfFile:logoPath];
    
    NSData *jpegData = UIImageJPEGRepresentation(companyLogoImage, COMPRESS_LEVEL);
    companyLogoImage = [UIImage imageWithData:jpegData];
    
    
    /*UIImage *logoImage = [UIImage imageNamed:@"optiqo_icon.png"];
     
     NSData *jpegData = UIImageJPEGRepresentation(logoImage, COMPRESS_LEVEL);
     logoImage = [UIImage imageWithData:jpegData];*/
    
    
    [companyLogoImage drawInRect:CGRectMake(20, 20, 150, 50)];
    
    
    //CGFloat pageOffset = 0;
    
    
    
    UIFont *font = [UIFont fontWithName:REPORT_FONT size:12.0];
    
    UIFont *bold_font = [UIFont fontWithName:REPORT_BOLDFONT size:12.0];
    
    
    NSDictionary *attrsDictionary =
    
    [NSDictionary dictionaryWithObjectsAndKeys:
     font, NSFontAttributeName,
     [NSNumber numberWithFloat:1.0], NSBaselineOffsetAttributeName, nil];
    
    NSDictionary *attrsDictionaryBold =
    
    [NSDictionary dictionaryWithObjectsAndKeys:
     bold_font, NSFontAttributeName,
     [NSNumber numberWithFloat:1.0], NSBaselineOffsetAttributeName, nil];
    
    /*NSDictionary *attrsImageCountDictionary =
    
    [NSDictionary dictionaryWithObjectsAndKeys:
     font, NSFontAttributeName,
     [NSNumber numberWithFloat:1.0], NSBaselineOffsetAttributeName,[UIColor whiteColor],NSBackgroundColorAttributeName,nil];*/
    
    UIFont *cleaningTypeFont = [UIFont fontWithName:REPORT_FONT size:32.0];
    
    UIColor *cleaningTypecolor = [UIColor clearColor];
    
    UIColor *cleaningTypeForecolor = [UIColor colorWithRed:250.0/255 green:236.0/255.0 blue:208.0/255.0 alpha:1.0];
    
    NSDictionary *attrsCleaningTypeDictionary =
    
    [NSDictionary dictionaryWithObjectsAndKeys:
     cleaningTypeFont, NSFontAttributeName,
     [NSNumber numberWithFloat:1.0], NSBaselineOffsetAttributeName,cleaningTypecolor,NSBackgroundColorAttributeName,cleaningTypeForecolor,NSForegroundColorAttributeName,nil];
    
    
    //[headingString drawInRect:CGRectMake(250, pageOffset, 200, 34) withFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:14] lineBreakMode:UILineBreakModeWordWrap alignment:UITextAlignmentLeft];
    
    //NSString *customerName = ((RoomListContent *)[self.reports objectAtIndex:0]).customerName;
    
    
    //[customerName drawInRect:CGRectMake(100, 100, 200, 34) withAttributes:attrsDictionary];
    
    [[self drawReportImage] drawInRect:CGRectMake(5, 75, 600,250)];
    
    
    
    if([vc.customerLanguageSelected isEqualToString:@"Svenska"])
        [headingString drawInRect:CGRectMake(190, 75, 200, 40) withAttributes:attrsCleaningTypeDictionary];
    else
        [headingString drawInRect:CGRectMake(200, 75, 200, 40) withAttributes:attrsCleaningTypeDictionary];
    
    cleaningTypeForecolor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    
    attrsCleaningTypeDictionary =
    
    [NSDictionary dictionaryWithObjectsAndKeys:
     cleaningTypeFont, NSFontAttributeName,
     [NSNumber numberWithFloat:1.0], NSBaselineOffsetAttributeName,cleaningTypecolor,NSBackgroundColorAttributeName,cleaningTypeForecolor,NSForegroundColorAttributeName,nil];
    
    if([vc.customerLanguageSelected isEqualToString:@"Svenska"])
        [reportString drawInRect:CGRectMake(310, 75, 200, 40) withAttributes:attrsCleaningTypeDictionary];
    else
        [reportString drawInRect:CGRectMake(310, 75, 200, 40) withAttributes:attrsCleaningTypeDictionary];
    

    
    [reportImage drawInRect:CGRectMake(71, 120, 200, 200)];
    
    [scoreImage drawInRect:CGRectMake(337, 120, 200, 200)];
    
    //NSString *str = [NSString stringWithFormat:@"%@%f",@"Score",rating];
    
    //PieChartView *pieChartView = [[PieChartView alloc] initWithFrame:CGRectMake(0, 0, 300, 300) initWithRate:1.0 withOptions:2];
    
    //[self addSubview:pieChartView];
    
    //[[self drawReportImageWithText:str] drawInRect:CGRectMake(325, 125, 225, 225)];
    
    //[pieChartView.ratingImage drawInRect:CGRectMake(325, 100, 300, 300)];
    
    
    //UIColor *color = [UIColor greenColor];
    
    /*NSDictionary *statsAttrsDictionary =
     [NSDictionary dictionaryWithObjectsAndKeys:
     font,NSFontAttributeName,color,NSForegroundColorAttributeName,
     [NSNumber numberWithFloat:1.0], NSBaselineOffsetAttributeName, nil];*/
    
    
    //NSString *stats = @"Statistics";
    
    //[stats drawInRect:CGRectMake(100, 150, 200, 34) withAttributes:statsAttrsDictionary];
    
    
    
    
    /*for(int i=0;i<[self.reports count];i++) {
     
     UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 612, 792), nil);
     
     [self addNewPDFPage:i];
     
     }*/
    
    cleaningTypeFont = [UIFont fontWithName:REPORT_FONT size:20.0];
    
    attrsCleaningTypeDictionary =
    
    [NSDictionary dictionaryWithObjectsAndKeys:
     cleaningTypeFont, NSFontAttributeName,
     [NSNumber numberWithFloat:1.0], NSBaselineOffsetAttributeName,cleaningTypecolor,NSBackgroundColorAttributeName,nil];

    
    NSString *clientInfo = [labels valueForKey:@"clientinformation"];
    
    [clientInfo drawInRect:CGRectMake(25, 335, 300, 34) withAttributes:attrsCleaningTypeDictionary];
    
    
    CGSize textSize1 = [[labels valueForKey:@"name"] sizeWithAttributes:@{NSFontAttributeName:bold_font}];
    
    CGSize textSize2 = [[labels valueForKey:@"reportAddress"] sizeWithAttributes:@{NSFontAttributeName:bold_font}];
    
    CGSize textSize3 = [[labels valueForKey:@"time_date"] sizeWithAttributes:@{NSFontAttributeName:bold_font}];

    CGSize textSize4 = [[labels valueForKey:@"total_time"] sizeWithAttributes:@{NSFontAttributeName:bold_font}];

    
    
    
    int maxSize = (int)textSize1.width;
    
    if(maxSize<textSize2.width)
        maxSize = (int)textSize2.width;
    
    if(maxSize<textSize3.width)
        maxSize = (int)textSize3.width;
    
    if(maxSize<textSize4.width)
        maxSize = (int)textSize4.width;
   
    //NSLog(@"sizes %f,%f,%f,%f",textSize1.width,textSize2.width,textSize3.width,textSize4.width);
    
    //NSLog(@"sizes %d,%d,%d,%d,%d",(int)textSize1.width,(int)textSize2.width,(int)textSize3.width,(int)textSize4.width,maxSize);

    
    NSString *cust_label = [NSString stringWithFormat:@"%@:",[labels valueForKey:@"name"]];
    
    
    NSString *cust_name = self.customerName;
    
    [cust_label drawInRect:CGRectMake(25, 380, 75, 34) withAttributes:attrsDictionaryBold];
    
    [cust_name drawInRect:CGRectMake(maxSize+40, 380, 200, 34) withAttributes:attrsDictionary];
    
    NSString *cust_city = NULL;
    
    if([custCity length]==0) {
        
        cust_city = @"-";
    }
    else {
        
        cust_city = custCity;
    }
    
    NSString *cust_cityLabel = [NSString stringWithFormat:@"%@:",[labels valueForKey:@"reportAddress"]];
    
    [cust_cityLabel drawInRect:CGRectMake(25, 400, 75, 34) withAttributes:attrsDictionaryBold];
    
    [cust_city drawInRect:CGRectMake(maxSize+40, 400, 200, 34) withAttributes:attrsDictionary];
    
    /*NSDate *endTime = [NSDate date];
     
     NSString *dateString = [NSDateFormatter localizedStringFromDate:endTime
     dateStyle:NSDateFormatterShortStyle
     timeStyle:NSDateFormatterShortStyle];
     
     NSString *dateTime = [NSString stringWithFormat:@"%@",dateString];*/
    
    endTime = [NSDate date];
    
    dateString = [NSDateFormatter localizedStringFromDate:endTime
                                                dateStyle:NSDateFormatterShortStyle
                                                timeStyle:NSDateFormatterShortStyle];
    
    dateTime = dateString;
    
    
    dateTime = [dateTime stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    
    
    NSString *cust_dateTime =[NSString stringWithFormat:@"%@:",[labels valueForKey:@"time_date"]];
    
    [cust_dateTime drawInRect:CGRectMake(25, 420, 75, 34) withAttributes:attrsDictionaryBold];
    
    [dateTime drawInRect:CGRectMake(maxSize+40, 420, 200, 34) withAttributes:attrsDictionary];
    
    NSString *timeTaken;
    
    //NSLog(@"number of reports %d",(int)[self.reports count]);
    
    for(int i=0;i<1;i++) {
        
        RoomListContent *roomContent = (RoomListContent *)[self.reports objectAtIndex:i];
        
        timeTaken = roomContent.total_time;
        
        /*NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        
        NSUInteger unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit| NSSecondCalendarUnit;
        
        NSDateComponents *components = [calendar components:unitFlags
                                                   fromDate:roomContent.startDate
                                                     toDate:roomContent.endDate options:0];
        
        hours+=components.hour;
        minutes+=components.minute;
        
        if(minutes>=60) {
            hours+=1;
            minutes = 0;
        }
        
        seconds+=components.second;
        
        if(seconds>=60) {
            minutes+=1;
            seconds = 0;
        }*/
        
    }
    
    /*NSString *total_hours = [NSString stringWithFormat:@"%ld",(long) hours];
    
    if ([total_hours length]!=2) {
        total_hours = [NSString stringWithFormat:@"0%@",total_hours];
    }
    
    NSString *total_minutes = [NSString stringWithFormat:@"%ld",(long) minutes];
    
    if ([total_minutes length]!=2) {
        total_minutes = [NSString stringWithFormat:@"0%@",total_minutes];
    }
    
    NSString *total_seconds = [NSString stringWithFormat:@"%ld",(long) seconds];
    
    if ([total_seconds length]!=2) {
        total_seconds = [NSString stringWithFormat:@"0%@",total_seconds];
    }
    
    NSString *timeTake = [NSString stringWithFormat:@"%@:%@:%@",total_hours,total_minutes,total_seconds];*/
    
    
    NSString *cust_timeTaken = [NSString stringWithFormat:@"%@:",[labels valueForKey:@"total_time"]];
    
    [cust_timeTaken drawInRect:CGRectMake(25, 440, 75, 34) withAttributes:attrsDictionaryBold];
    
    [timeTaken drawInRect:CGRectMake(maxSize+40, 440, 200, 34) withAttributes:attrsDictionary];
    
    NSString *imagePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:[NSString stringWithFormat:@"/%@/%@",@"Optiqo",customerName]];
    
    
    NSString  *path = [NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"currentMapLoc"]];
    
    //NSLog(@"map %@",path);
    
    //draws a map
    
    if([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        
        //NSLog(@"entered data %@",path);
        UIImage *image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"currentMapLoc"]]];
        
        jpegData = UIImageJPEGRepresentation(image, COMPRESS_LEVEL);
        image = [UIImage imageWithData:jpegData];

        [image drawInRect:CGRectMake(25, 475, 250, 300)];
        
        
    }
    
    //[self drawLineHorizontalWithFrame:CGRectMake(25, 600, 250, 4)
                            //withColor:[UIColor colorWithRed:246.0/255.0 green:176.0/255.0 blue:4.0/255.0 alpha:1.0 ]];

    
    //comapny information
    NSString *compayInfo = [labels valueForKey:@"companyinformation"];
    
    [compayInfo drawInRect:CGRectMake(300, 335, 300, 34) withAttributes:attrsCleaningTypeDictionary];
    
    NSString *companyLabel = [NSString stringWithFormat:@"%@:",[labels valueForKey:@"name"]];
    
    
    NSString *companyName = employerName;
    
    [companyLabel drawInRect:CGRectMake(300, 380, 75, 34) withAttributes:attrsDictionaryBold];
    
    [companyName drawInRect:CGRectMake(360, 380, 200, 34) withAttributes:attrsDictionary];
    
    NSString *companyAddressLabel = [NSString stringWithFormat:@"%@:",[labels valueForKey:@"reportAddress"]];
    
    NSString *companyAddress = employerAddress;
    
    [companyAddressLabel drawInRect:CGRectMake(300, 400, 75, 34) withAttributes:attrsDictionaryBold];
    
    [companyAddress drawInRect:CGRectMake(360, 400, 300, 34) withAttributes:attrsDictionary];
    
    NSString *companyEmailLabel = [NSString stringWithFormat:@"%@:",[labels valueForKey:@"reportemail"]];
    
    NSString *companyEmail = employerEmail;
    
    [companyEmailLabel drawInRect:CGRectMake(300, 420, 75, 34) withAttributes:attrsDictionaryBold];
    [companyEmail drawInRect:CGRectMake(360, 420, 300, 34) withAttributes:attrsDictionary];
    
    NSString *companyWebAddressLabel = [NSString stringWithFormat:@"%@:",[labels valueForKey:@"reportwebsite"]];
    
    NSString *companyWebAddress = employerWebSite;
    
    [companyWebAddressLabel drawInRect:CGRectMake(300, 440, 75, 34) withAttributes:attrsDictionaryBold];
    [companyWebAddress drawInRect:CGRectMake(360, 440, 300, 34) withAttributes:attrsDictionary];
    
    NSString *companyPhoneLabel = [NSString stringWithFormat:@"%@:",[labels valueForKey:@"reportphonenumber"]];
    
    
    NSString *companyPhone = employerPhone;
    
    [companyPhoneLabel drawInRect:CGRectMake(300, 460, 75, 34) withAttributes:attrsDictionaryBold];
    [companyPhone drawInRect:CGRectMake(360, 460, 300, 34) withAttributes:attrsDictionary];
    
    
    
    
    //[companyLogoImage drawInRect:CGRectMake(300, 475, 150, 100)];
    
    [self drawLineHorizontalWithFrame:CGRectMake(300, 495, 250, 4)
                            withColor:[UIColor colorWithRed:246.0/255.0 green:176.0/255.0 blue:4.0/255.0 alpha:1.0 ]];
    
     imagePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:[NSString stringWithFormat:@"/%@/%@",@"Optiqo",@"userSign.jpg"]];
    
    NSString *inspection = [labels valueForKey:@"inspectionCarriedBy:"];
    
    [inspection drawInRect:CGRectMake(300, 500, 300, 34) withAttributes:attrsDictionary];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:imagePath]) {
        
        UIImage *signImage = [UIImage imageWithContentsOfFile:imagePath];
        
        jpegData = UIImageJPEGRepresentation(signImage, COMPRESS_LEVEL);
        signImage = [UIImage imageWithData:jpegData];
        
        
        [signImage drawInRect:CGRectMake(300, 525, 250, 100)];
    }
    
    [self drawLineHorizontalWithFrame:CGRectMake(300, 630, 250, 2)
                            withColor:[UIColor colorWithRed:246.0/255.0 green:176.0/255.0 blue:4.0/255.0 alpha:1.0 ]];
    
    [userName drawInRect:CGRectMake(300, 635, 250, 34) withAttributes:attrsDictionary];

    //should put name of the user
    
    
    UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 612, 792), nil);
    
    //logoImage = [UIImage imageNamed:@"optiqo_icon.png"];
    
    [companyLogoImage drawInRect:CGRectMake(20, 20, 150, 50)];
    
    [self drawLineHorizontalWithFrame:CGRectMake(5, 70, 600, 4)
                            withColor:[UIColor colorWithRed:246.0/255.0 green:176.0/255.0 blue:4.0/255.0 alpha:1.0]];
    
    
    [self drawTableTitles];
    
    images = [[NSMutableArray alloc] init];
    
    [self drawLineVerticalWithFrame:CGRectMake(80, 100, 4, 650)
                          withColor:[UIColor colorWithRed:246.0/255.0 green:176.0/255.0 blue:4.0/255.0 alpha:1.0 ]];
    
    if(vc.cleaningType == 1)
    {
        [self houseCleaningReport:@"Employer"];
    }
    
    if(vc.cleaningType == 2)
    {
        [self officeCleaningReport:@"Employer"];
    }

    
    /*
    
    int j=150;
    
    for(int i=0;i<[self.reports count];i++) {
        
        RoomListContent *roomContent = (RoomListContent *)[self.reports objectAtIndex:i];
        
        NSString *roomName = roomContent.customerRoom;
        
        NSString *roomComments = roomContent.roomComents;
        
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        
        NSUInteger unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit| NSSecondCalendarUnit;
        
        
        NSDateComponents *components = [calendar components:unitFlags
                                                   fromDate:roomContent.startDate
                                                     toDate:roomContent.endDate options:0];
        
        NSString *str_hours = [NSString stringWithFormat:@"%ld",(long) components.hour];
        
        if ([str_hours length]!=2) {
            str_hours = [NSString stringWithFormat:@"0%@",str_hours];
        }
        
        NSString *str_minutes = [NSString stringWithFormat:@"%ld",(long) components.minute];
        
        if ([str_minutes length]!=2) {
            str_minutes = [NSString stringWithFormat:@"0%@",str_minutes];
        }
        
        NSString *str_seconds = [NSString stringWithFormat:@"%ld",(long) components.second];
        
        if ([str_seconds length]!=2) {
            str_seconds = [NSString stringWithFormat:@"0%@",str_seconds];
        }
        
        NSString *timeTake = [NSString stringWithFormat:@"%@:%@:%@",str_hours,str_minutes,str_seconds];
        
        
        
        [self drawLineHorizontalWithFrame:CGRectMake(20, j, 580, 4)
                                withColor:[UIColor colorWithRed:246.0/255.0 green:176.0/255.0 blue:4.0/255.0 alpha:1.0 ]];
        j+=100;
        
        if(j<=750) {
            if([roomName isEqualToString:@"Living room"]) {
                
                UIImage *image = [UIImage imageNamed:@"living_room.png"];
                
                jpegData = UIImageJPEGRepresentation(image, COMPRESS_LEVEL);
                image = [UIImage imageWithData:jpegData];

                
                [image drawInRect:CGRectMake(25, j-80, 40, 40)];
            }
            
            else if([roomName isEqualToString:@"Study room"]) {
                
                UIImage *image = [UIImage imageNamed:@"study_room.png"];
                
                jpegData = UIImageJPEGRepresentation(image, COMPRESS_LEVEL);
                image = [UIImage imageWithData:jpegData];

                
                [image drawInRect:CGRectMake(25, j-80, 40, 40)];
            }
            
            else if([roomName isEqualToString:@"kitchen"]) {
                
                UIImage *image = [UIImage imageNamed:@"generic_room.png"];
                
                jpegData = UIImageJPEGRepresentation(image, COMPRESS_LEVEL);
                image = [UIImage imageWithData:jpegData];

                
                [image drawInRect:CGRectMake(25, j-80, 40, 40)];
            }
            
            else if([roomName isEqualToString:@"Bedroom"]) {
                
                UIImage *image = [UIImage imageNamed:@"bed_room.png"];
                
                jpegData = UIImageJPEGRepresentation(image, COMPRESS_LEVEL);
                image = [UIImage imageWithData:jpegData];

                
                [image drawInRect:CGRectMake(25, j-80, 40, 40)];
            }
            
            else if([roomName isEqualToString:@"Hallway"]) {
                
                UIImage *image = [UIImage imageNamed:@"dressing_room.png"];
                
                jpegData = UIImageJPEGRepresentation(image, COMPRESS_LEVEL);
                image = [UIImage imageWithData:jpegData];

                
                [image drawInRect:CGRectMake(25, j-80, 40, 40)];
            }
            
            else if([roomName isEqualToString:@"Bathroom"]) {
                
                UIImage *image = [UIImage imageNamed:@"toilet_room.png"];
                
                jpegData = UIImageJPEGRepresentation(image, COMPRESS_LEVEL);
                image = [UIImage imageWithData:jpegData];

                
                [image drawInRect:CGRectMake(25, j-80, 40, 40)];
            }
            
            else if([roomName isEqualToString:@"Washing room"]) {
                
                UIImage *image = [UIImage imageNamed:@"wash_room.png"];
                
                jpegData = UIImageJPEGRepresentation(image, COMPRESS_LEVEL);
                image = [UIImage imageWithData:jpegData];

                
                [image drawInRect:CGRectMake(25, j-80, 40, 40)];
            }
            else
            {
                UIImage *image = [UIImage imageNamed:@"generic_room.png"];
                
                jpegData = UIImageJPEGRepresentation(image, COMPRESS_LEVEL);
                image = [UIImage imageWithData:jpegData];

                
                [image drawInRect:CGRectMake(25, j-80, 40, 40)];
            }
            
            
            [roomName drawInRect:CGRectMake(95, j-80, 75, 50) withAttributes:attrsDictionary];
            
            NSNumber *approve = roomContent.approveRoom;
            
            
            if([approve boolValue]) {
                
                UIImage *image = [UIImage imageNamed:@"approve.png"];
                
                jpegData = UIImageJPEGRepresentation(image, COMPRESS_LEVEL);
                image = [UIImage imageWithData:jpegData];

                
                [image drawInRect:CGRectMake(525, j-80, 40, 40)];
            }
            else {
                
                UIImage *image = [UIImage imageNamed:@"close_icon.png"];
                
                jpegData = UIImageJPEGRepresentation(image, COMPRESS_LEVEL);
                image = [UIImage imageWithData:jpegData];

                
                [image drawInRect:CGRectMake(525, j-80, 40, 40)];
            }
            
            if(![roomComments isEqualToString:@"No Comments"])
                [roomComments drawInRect:CGRectMake(250, j-80, 200, 60) withAttributes:attrsDictionary];
            else {
                
                roomComments = @"-";
                [roomComments drawInRect:CGRectMake(300, j-80, 200, 60) withAttributes:attrsDictionary];
            }
            
            [timeTake drawInRect:CGRectMake(425, j-80, 100, 60) withAttributes:attrsDictionary];
            
            
            if([roomContent.roomContainsImages boolValue]) {
                [self imageCount:i row:j];
            }
            
            
            
            if(startImageCount != 0 && [roomContent.roomContainsImages boolValue]) {
                NSString *imageCount = [NSString stringWithFormat:@"%d-%d",startImageCount,endImageCount];
                
                [imageCount drawInRect:CGRectMake(185, j-80, 50, 20) withAttributes:attrsDictionary];
                
                
            }
            else
            {
                
                NSString *imageCount = @"-";
                
                [imageCount drawInRect:CGRectMake(200, j-80, 100, 34) withAttributes:attrsDictionary];
            }
            
            startImageCount = endImageCount;
        }
        
        if(j>700) {
            UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 612, 792), nil);
            
            logoImage = [UIImage imageNamed:@"optiqo_icon.png"];
            
            jpegData = UIImageJPEGRepresentation(logoImage, COMPRESS_LEVEL);
            logoImage = [UIImage imageWithData:jpegData];

            
            [logoImage drawInRect:CGRectMake(20, 20, 250, 40)];
            
            [self drawLineHorizontalWithFrame:CGRectMake(5, 70, 600, 4)
                                    withColor:[UIColor colorWithRed:246.0/255.0 green:176.0/255.0 blue:4.0/255.0 alpha:1.0 ]];
            
            
            [self drawTableTitles];
            
            [self drawLineVerticalWithFrame:CGRectMake(80, 100, 4, 650)
                                  withColor:[UIColor colorWithRed:246.0/255.0 green:176.0/255.0 blue:4.0/255.0 alpha:1.0 ]];
            
            j=150;
            i--;
        }
        
    }
    
    //[self drawLineVerticalWithFrame:CGRectMake(60, 20, 4, 700)
    //withColor:[UIColor colorWithRed:246.0/255.0 green:176.0/255.0 blue:4.0/255.0 alpha:1.0 ]];
    [self drawLineHorizontalWithFrame:CGRectMake(20, j, 580, 4)
                            withColor:[UIColor colorWithRed:246.0/255.0 green:176.0/255.0 blue:4.0/255.0 alpha:1.0 ]];
    
    
    UIImage *img = NULL;
    
    if([images count]!=0) {
        
        
        j=100;
        
        xIndex = 50;
        yIndex = 100;
        
        UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 612, 792), nil);
        
        logoImage = [UIImage imageNamed:@"optiqo_icon.png"];
        
        jpegData = UIImageJPEGRepresentation(logoImage, COMPRESS_LEVEL);
        logoImage = [UIImage imageWithData:jpegData];

        
        [logoImage drawInRect:CGRectMake(20, 20, 200, 40)];
        
        [self drawLineHorizontalWithFrame:CGRectMake(5, 70, 600, 4)
                                withColor:[UIColor colorWithRed:246.0/255.0 green:176.0/255.0 blue:4.0/255.0 alpha:1.0 ]];
        
        
        img = [images objectAtIndex:0];
        
        [img drawInRect:CGRectMake(xIndex, yIndex, 250, 150)];
        
        NSString *imgCountLabel = [NSString stringWithFormat:@"%d",1];
        
        
        [imgCountLabel drawInRect:CGRectMake(xIndex+125, 75, 30, 25) withAttributes:attrsImageCountDictionary];
    }
    
    
    
    for(int i=1;i<[images count];i++) {
        
        //[self drawImageCount:i row:j];
        
        img = [images objectAtIndex:i];
        
        
        if(i%2==0){
            
            xIndex = 50;
            yIndex +=200;
            
            if(yIndex>650) {
                
                UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 612, 792), nil);
                logoImage = [UIImage imageNamed:@"optiqo_icon.png"];
                
                jpegData = UIImageJPEGRepresentation(logoImage, COMPRESS_LEVEL);
                logoImage = [UIImage imageWithData:jpegData];

                
                [logoImage drawInRect:CGRectMake(20, 20, 250, 50)];
                
                [self drawLineHorizontalWithFrame:CGRectMake(5, 70, 600, 4)
                                        withColor:[UIColor colorWithRed:246.0/255.0 green:176.0/255.0 blue:4.0/255.0 alpha:1.0 ]];
                
                yIndex=100;
            }
            
        }
        else {
            
            xIndex+=260;
        }
        
        jpegData = UIImageJPEGRepresentation(img, COMPRESS_LEVEL);
        img = [UIImage imageWithData:jpegData];

        
        [img drawInRect:CGRectMake(xIndex, yIndex, 250, 150)];
        
        UIView *imageCount = [[UIView alloc] initWithFrame:CGRectMake(xIndex, yIndex+120, 25, 30)];
        
        UILabel *label = [[[UILabel alloc] init] initWithFrame:CGRectMake(0, 0, imageCount.frame.size.width, imageCount.frame.size.height)];
        
        [label setBackgroundColor:[UIColor whiteColor]];
        
        NSString *imgCountLabel = [NSString stringWithFormat:@"%d",(i+1)];
        
        [label setText:imgCountLabel];
        
        [label setTextAlignment:NSTextAlignmentCenter];
        
        [label setFont:[UIFont fontWithName:@"Avnier-medium" size:16.0]];
        
        [label.text drawInRect:CGRectMake(xIndex+125, yIndex-25, 30, 25) withAttributes:attrsImageCountDictionary];
        
        
        
    }
    */
    
    UIGraphicsEndPDFContext();
    
    self.filename = pdfFileName;
    
    
    
    //generats a name for pdf file
    if([vc.customerLanguageSelected isEqualToString:@"Svenska"])
        self.pdfFilename =  [NSString stringWithFormat:@"%@%@ - %@ - %@ - %@",[labels valueForKey:@"quality"],[labels valueForKey:@"quality_report"],self.customerName,dateTime,@".pdf"];
    else
        self.pdfFilename =  [NSString stringWithFormat:@"%@ %@ - %@ - %@ - %@",[labels valueForKey:@"quality"],[labels valueForKey:@"quality_report"],self.customerName,dateTime,@".pdf"];
    
}

//draws horizontal line in pdf report
-(CGRect) drawLineHorizontalWithFrame:(CGRect)rect withColor:(UIColor *)color {
    
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(currentContext, color.CGColor);
    
    CGContextSetLineWidth(currentContext,rect.size.height);
    
    CGPoint startPoint = rect.origin;
    CGPoint endPoint = CGPointMake(rect.origin.x +rect.size.width, rect.origin.y);
    
    CGContextBeginPath(currentContext);
    CGContextMoveToPoint(currentContext, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(currentContext, endPoint.x, endPoint.y);
    
    CGContextClosePath(currentContext);
    CGContextDrawPath(currentContext, kCGPathFillStroke);
    
    return rect;
}

//draw vertical line
-(CGRect) drawLineVerticalWithFrame:(CGRect)rect withColor:(UIColor *)color {
    
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(currentContext, color.CGColor);
    
    CGContextSetLineWidth(currentContext,rect.size.width);
    
    CGPoint startPoint = rect.origin;
    CGPoint endPoint = CGPointMake(rect.origin.x, rect.origin.y+rect.size.height);
    
    CGContextBeginPath(currentContext);
    CGContextMoveToPoint(currentContext, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(currentContext, endPoint.x, endPoint.y);
    
    CGContextClosePath(currentContext);
    CGContextDrawPath(currentContext, kCGPathFillStroke);
    
    return rect;
}

//draw the table like view with titles
-(void) drawTableTitles {
    
    UIFont *font = [UIFont fontWithName:REPORT_FONT size:12.0];
    
    NSMutableParagraphStyle *paragraphStyle_left = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    /// Set line break mode
    paragraphStyle_left.lineBreakMode = NSLineBreakByTruncatingTail;
    /// Set text alignment
    paragraphStyle_left.alignment = NSTextAlignmentLeft;
    
    NSMutableParagraphStyle *paragraphStyle_center = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    /// Set line break mode
    paragraphStyle_center.lineBreakMode = NSLineBreakByTruncatingTail;
    /// Set text alignment
    paragraphStyle_center.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attrsDictionary =
    
    [NSDictionary dictionaryWithObjectsAndKeys:
     font, NSFontAttributeName,
     [NSNumber numberWithFloat:1.0], NSBaselineOffsetAttributeName,paragraphStyle_left ,NSParagraphStyleAttributeName,nil];
    
    //NSLog(@" rooms %@",[labels valueForKey:@"room"]);
    
    NSString *roomType = [NSString stringWithFormat:@"%@",[labels valueForKey:@"reportroom"]];
    
    //[roomType drawInRect:CGRectMake(25, 100, 50, 40) withAttributes:attrsDictionary];
    
    //NSString *roomName = [NSString stringWithFormat:@"%@\n%@",[labels valueForKey:@"room"],[labels valueForKey:@"name"]];
    
    [roomType drawInRect:CGRectMake(90, 100, 75, 40) withAttributes:attrsDictionary];
    
    attrsDictionary =
    
    [NSDictionary dictionaryWithObjectsAndKeys:
     font, NSFontAttributeName,
     [NSNumber numberWithFloat:1.0], NSBaselineOffsetAttributeName,paragraphStyle_center,NSParagraphStyleAttributeName,nil];

    
    NSString *pictures = [labels valueForKey:@"pictures"];
    
    [pictures drawInRect:CGRectMake(185, 100, 75, 40) withAttributes:attrsDictionary];
    
    NSString *comments = [labels valueForKey:@"comments"];
    
    [comments drawInRect:CGRectMake(250, 100, 200, 40) withAttributes:attrsDictionary];
    
    if(!isCustomerReport) {
        NSString *time = [labels valueForKey:@"time"];
    
        [time drawInRect:CGRectMake(450, 100, 50, 40) withAttributes:attrsDictionary];
    }
    
    NSString *status = [labels valueForKey:@"status"]; 
    
    [status drawInRect:CGRectMake(525, 100, 50, 40) withAttributes:attrsDictionary];

}

//get images count for each room
-(void) imageCount:(int)index  row:(int) j {
    
    //NSString *customerName = ((RoomListContent *)[self.reports objectAtIndex:index]).customerName;
    
    //NSString *customerroom = ((RoomListContent *)[self.reports objectAtIndex:index]).customerRoom;
    
    NSString *roomName = ((RoomListContent *)[self.reports objectAtIndex:index]).customerRoomName;
    
    NSString *imagePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:[NSString stringWithFormat:@"/%@/%@/%@",@"Optiqo",customerName,roomName]];
    
    //NSLog(@"image path %@",imagePath);
    
    NSString *path = [NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"image1"]];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        
        
        startImageCount+=1;
        endImageCount = startImageCount;
        
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        
        [image drawInRect:CGRectMake(200, j-35, 30, 20)];
        
        image = [self compressImage:image newWidth:640 newHeight:480];
        
        NSData *imageData= UIImageJPEGRepresentation(image, 0.1);
        image = [UIImage imageWithData:imageData];
        
        [images addObject:image];
        
    }
    
    
    
    path = [NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"image2"]];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        
        
        endImageCount+=1;
        
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        
        image = [self compressImage:image newWidth:640 newHeight:480];
        
        NSData *imageData= UIImageJPEGRepresentation(image, 0.1);
        image = [UIImage imageWithData:imageData];
        
        [images addObject:image];
        
    }
    
    
    
    path = [NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"image3"]];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        
        endImageCount+=1;
        
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        
        image = [self compressImage:image newWidth:640 newHeight:480];
        
        NSData *imageData= UIImageJPEGRepresentation(image, 0.1);
        image = [UIImage imageWithData:imageData];

        
        [images addObject:image];
    }
    
    
    
    path = [NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"image4"]];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        
        endImageCount+=1;
        
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        
        image = [self compressImage:image newWidth:640 newHeight:480];
        
        NSData *imageData= UIImageJPEGRepresentation(image, 0.1);
        image = [UIImage imageWithData:imageData];

        
        [images addObject:image];
        
    }
    
    
    
    path = [NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"image5"]];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        
        endImageCount+=1;
        
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        
        image = [self compressImage:image newWidth:640 newHeight:480];
        
        NSData *imageData= UIImageJPEGRepresentation(image, 0.1);
        image = [UIImage imageWithData:imageData];

        
        [images addObject:image];
        
    }
    
    
    path = [NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"image6"]];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        
        endImageCount+=1;
        
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        
        image = [self compressImage:image newWidth:640 newHeight:480];
        
        NSData *imageData= UIImageJPEGRepresentation(image, 0.1);
        image = [UIImage imageWithData:imageData];
        
        
        [images addObject:image];
        
    }
    
    
    
    
}

//draw images count for each room
-(void) drawImageCount:(int)index  row:(int) j {
    
    NSString *customer_name = ((RoomListContent *)[self.reports objectAtIndex:index]).customerName;
    
    NSString *roomName = ((RoomListContent *)[self.reports objectAtIndex:index]).customerRoomName;
    
    NSString *imagePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:[NSString stringWithFormat:@"/%@/%@/%@",@"Optiqo",customer_name,roomName]];
    
    
    NSString *path = [NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"image1"]];
    
    //NSLog(@"image path %@",path);
    
    if([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        
        NSData *imageData  = UIImageJPEGRepresentation(image, 0.25);
        
        image = [UIImage imageWithData:imageData];

        
        [image drawInRect:CGRectMake(xIndex, j, 350, 350)];
        
        xIndex+=325;
        
        imagesCount++;
    }
    
    
    
    path = [NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"image2"]];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        
        
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        
        NSData *imageData  = UIImageJPEGRepresentation(image, 0.25);
        
        image = [UIImage imageWithData:imageData];

        
        [image drawInRect:CGRectMake(375, j, 350, 350)];
        
        imagesCount++;
    }
    
    
    
    path = [NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"image3"]];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        
        NSData *imageData  = UIImageJPEGRepresentation(image, 0.25);
        
        image = [UIImage imageWithData:imageData];
        
        [image drawInRect:CGRectMake(175, j, 50, 40)];
        
        imagesCount++;
    }
    
    
    
    path = [NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"image4"]];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        
        NSData *imageData  = UIImageJPEGRepresentation(image, 0.25);
        
        image = [UIImage imageWithData:imageData];

        
        [image drawInRect:CGRectMake(175, j, 50, 40)];
        
        imagesCount++;
        
    }
    
    
    
    path = [NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"image5"]];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        
        UIImageJPEGRepresentation(image, 0.25);
        [image drawInRect:CGRectMake(175, j, 50, 40)];
        
        imagesCount++;
        
    }
    
    
    
    
}

//sets the report pie chart images
-(void) setReportImage:(NSArray *) images_array  {
    
    reportImage = [images_array objectAtIndex:0];
    scoreImage  = [images_array objectAtIndex:1];
}

//draws report image
- (UIImage *) drawReportImage {
    
    UIView *bkview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 600, 400)];
    
    UIGraphicsBeginImageContext(bkview.bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //CGContextSetFillColor(context, CGColorGetComponents( [[UIColor redColor ] CGColor]));
    //CGContextAddRect(context, CGRectMake(0, 0, 300, 300));
    
    [bkview setBackgroundColor:[UIColor colorWithRed:246.0/255.0 green:192.0/255.0 blue:4.0/255.0 alpha:1.0]];
    [bkview.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    return image;
}

//draw report image with index
- (UIImage *) drawReportImageWithText:(NSString *)text {
    
    UIView *bkview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
    
    bkview.layer.cornerRadius = 75.0;
    
    bkview.layer.borderWidth = 0.05;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 200, 200)];
    
    [label setBackgroundColor:[UIColor clearColor]];
    
    [label setText:text];
    
    [label setFont:[UIFont fontWithName:@"Avnier-medium" size:24.0]];
    
    [label setTextAlignment:NSTextAlignmentCenter];
    
    [label setTextColor:[UIColor orangeColor]];
    
    label.lineBreakMode = NSLineBreakByWordWrapping;
    
    label.numberOfLines = 0;
    
    [bkview addSubview:label];
    
    UIGraphicsBeginImageContext(bkview.bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //CGContextSetFillColor(context, CGColorGetComponents( [[UIColor redColor ] CGColor]));
    //CGContextAddRect(context, CGRectMake(0, 0, 300, 300));
    
    [bkview setBackgroundColor:[UIColor colorWithRed:246.0/255.0 green:176.0/255.0 blue:4.0/255.0 alpha:1.0 ]];
    [bkview.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

//draw house cleaning report content with images, room names, comments for customer and employer
-(void) houseCleaningReport:(NSString *) type {
    
    UIFont *font = [UIFont fontWithName:REPORT_FONT size:12.0];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    /// Set line break mode
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;

    /// Set text alignment
    paragraphStyle.alignment = NSTextAlignmentCenter;

    NSMutableParagraphStyle *paragraphStyle1 = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    /// Set line break mode
    paragraphStyle1.lineBreakMode = NSLineBreakByTruncatingTail;
    /// Set text alignment
    paragraphStyle1.alignment = NSTextAlignmentLeft;

    
    NSDictionary *attrsDictionary =
    
    [NSDictionary dictionaryWithObjectsAndKeys:
     font, NSFontAttributeName,
     [NSNumber numberWithFloat:1.0], NSBaselineOffsetAttributeName,paragraphStyle,NSParagraphStyleAttributeName,nil];
    
    NSDictionary *attrsDictionary1 =
    
    [NSDictionary dictionaryWithObjectsAndKeys:
     font, NSFontAttributeName,
     [NSNumber numberWithFloat:1.0], NSBaselineOffsetAttributeName,paragraphStyle1,NSParagraphStyleAttributeName,nil];
    
    NSDictionary *attrsImageCountDictionary =
    
    [NSDictionary dictionaryWithObjectsAndKeys:
     font, NSFontAttributeName,
     [NSNumber numberWithFloat:1.0], NSBaselineOffsetAttributeName,[UIColor whiteColor],NSBackgroundColorAttributeName,nil];
    
    


    UIImage *logoImage;
    NSData *jpegData;
    
    
    NSString *logoPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:[NSString stringWithFormat:@"/%@/%@",@"Optiqo",@"companyLogoImage.jpg"]];
    
    
    logoImage = [UIImage imageWithContentsOfFile:logoPath];
    
    jpegData = UIImageJPEGRepresentation(logoImage, COMPRESS_LEVEL);
    logoImage = [UIImage imageWithData:jpegData];
    
    
    
    
    
    int j=150;
    
    for(int i=0;i<[self.reports count];i++) {
        
        RoomListContent *roomContent = (RoomListContent *)[self.reports objectAtIndex:i];
        
        if([type isEqualToString:@"customer"])
            [roomContent setCustomerReport];
        else
            [roomContent setEmployerReport];
        
        NSString *roomName = roomContent.customerRoom;
        
        
        NSString *roomComments = roomContent.roomComents;
        
        NSString *roomTime = roomContent.report_time;
        
        
        [self drawLineHorizontalWithFrame:CGRectMake(20, j, 580, 4)
                                withColor:[UIColor colorWithRed:246.0/255.0 green:176.0/255.0 blue:4.0/255.0 alpha:1.0 ]];
        j+=60;
        
        if(j<=750) {
            //if([roomName isEqualToString:[labels valueForKey:@"livingroom"]]) {
                
                UIImage *image = roomContent.customerRoomImage.image;
                
                NSData *jpegData = UIImageJPEGRepresentation(image, COMPRESS_LEVEL);
                image = [UIImage imageWithData:jpegData];
                
                
                [image drawInRect:CGRectMake(25, j-50, 40, 40)];
            /*}
            
            else if([roomName isEqualToString:[labels valueForKey:@"studyroom"]]) {
                
                UIImage *image = [UIImage imageNamed:@"study_room.png"];
                
                NSData *jpegData = UIImageJPEGRepresentation(image, COMPRESS_LEVEL);
                image = [UIImage imageWithData:jpegData];
                
                [image drawInRect:CGRectMake(25, j-80, 40, 40)];
            }
            
            else if([roomName isEqualToString:[labels valueForKey:@"kitchen"]]) {
                
                UIImage *image = [UIImage imageNamed:@"coffee_room.png"];
                
                jpegData = UIImageJPEGRepresentation(image, COMPRESS_LEVEL);
                image = [UIImage imageWithData:jpegData];
                
                [image drawInRect:CGRectMake(25, j-80, 40, 40)];
            }
            
            else if([roomName isEqualToString:[labels valueForKey:@"bedroom"]]) {
                
                UIImage *image = [UIImage imageNamed:@"bed_room.png"];
                
                NSData *jpegData = UIImageJPEGRepresentation(image, COMPRESS_LEVEL);
                image = [UIImage imageWithData:jpegData];
                
                [image drawInRect:CGRectMake(25, j-80, 40, 40)];
            }
            
            else if([roomName isEqualToString:[labels valueForKey:@"hallway"]]) {
                
                UIImage *image = [UIImage imageNamed:@"dressing_room.png"];
                
                NSData *jpegData = UIImageJPEGRepresentation(image, COMPRESS_LEVEL);
                image = [UIImage imageWithData:jpegData];
                
                [image drawInRect:CGRectMake(25, j-80, 40, 40)];
            }
            
            else if([roomName isEqualToString:[labels valueForKey:@"bathroom"]]) {
                
                UIImage *image = [UIImage imageNamed:@"toilet_room.png"];
                
                NSData *jpegData = UIImageJPEGRepresentation(image, COMPRESS_LEVEL);
                image = [UIImage imageWithData:jpegData];
                
                [image drawInRect:CGRectMake(25, j-80, 40, 40)];
            }
            
            else if([roomName isEqualToString:[labels valueForKey:@"washroom"]]) {
                
                UIImage *image = [UIImage imageNamed:@"wash_room.png"];
                
                NSData *jpegData = UIImageJPEGRepresentation(image, COMPRESS_LEVEL);
                image = [UIImage imageWithData:jpegData];
                
                [image drawInRect:CGRectMake(25, j-80, 40, 40)];
            }
            else
            {
                UIImage *image = [UIImage imageNamed:@"generic_room.png"];
                
                NSData *jpegData = UIImageJPEGRepresentation(image, COMPRESS_LEVEL);
                image = [UIImage imageWithData:jpegData];
                
                [image drawInRect:CGRectMake(25, j-80, 40, 40)];
            }*/
            
            
            [roomName drawInRect:CGRectMake(90, j-35, 100, 50) withAttributes:attrsDictionary1];
            
            NSNumber *approve = roomContent.approveRoom;
            
            
            if([approve boolValue]) {
                
                UIImage *image = [UIImage imageNamed:@"approve.png"];
                
                NSData *jpegData = UIImageJPEGRepresentation(image, COMPRESS_LEVEL);
                image = [UIImage imageWithData:jpegData];
                
                [image drawInRect:CGRectMake(530, j-50, 40, 40)];
            }
            else {
                
                UIImage *image = [UIImage imageNamed:@"close_icon.png"];
                
                NSData *jpegData = UIImageJPEGRepresentation(image, COMPRESS_LEVEL);
                image = [UIImage imageWithData:jpegData];
                
                [image drawInRect:CGRectMake(530, j-50, 40, 40)];
            }
            
            if(![roomComments isEqualToString:[labels valueForKey:@"nocomments"]])
                if([roomComments length]<=60)
                    [roomComments drawInRect:CGRectMake(250, j-35, 200, 60) withAttributes:attrsDictionary]
                    ;
                else
                    [roomComments drawInRect:CGRectMake(250, j-50, 200, 70) withAttributes:attrsDictionary]
                    ;
            else {
                
                roomComments = @"-";
                [roomComments drawInRect:CGRectMake(250, j-35, 200, 60) withAttributes:attrsDictionary];
            }
            
            //[timeTake drawInRect:CGRectMake(425, j-80, 100, 60) withAttributes:attrsDictionary];
            
            
            if([roomContent.roomContainsImages boolValue]) {
                [self imageCount:i row:j];
            }
            
            
            
            if(endImageCount > 1 && [roomContent.roomContainsImages boolValue]) {
                NSString *imageCount = [NSString stringWithFormat:@"%d-%d",startImageCount,endImageCount];
                
                [imageCount drawInRect:CGRectMake(185, j-55, 75, 15) withAttributes:attrsDictionary];
                
                
            }
            else if(startImageCount == 1 && [roomContent.roomContainsImages boolValue])
            {
                
                NSString *imageCount = [NSString stringWithFormat:@"%d",startImageCount];
                
                [imageCount drawInRect:CGRectMake(175, j-55, 75, 15) withAttributes:attrsDictionary];
            }
            else
            {
                NSString *imageCount = @"-";
                
                [imageCount drawInRect:CGRectMake(175, j-35, 75, 34) withAttributes:attrsDictionary];
            }
            
            startImageCount = endImageCount;
            
            if(!isCustomerReport) {
                
                [roomTime drawInRect:CGRectMake(445, j-35, 75, 34) withAttributes:attrsDictionary];
            }

        }
        
        
        if(j>700) {
            UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 612, 792), nil);
            
            /*logoImage = [UIImage imageNamed:@"optiqo_icon.png"];
            
            jpegData = UIImageJPEGRepresentation(logoImage, COMPRESS_LEVEL);
            logoImage = [UIImage imageWithData:jpegData];*/
            
            logoImage = [UIImage imageWithContentsOfFile:logoPath];
            
            jpegData = UIImageJPEGRepresentation(logoImage, COMPRESS_LEVEL);
            logoImage = [UIImage imageWithData:jpegData];
            
            [logoImage drawInRect:CGRectMake(20, 20, 150, 50)];
            
            [self drawLineHorizontalWithFrame:CGRectMake(5, 70, 600, 4)
                                    withColor:[UIColor colorWithRed:246.0/255.0 green:176.0/255.0 blue:4.0/255.0 alpha:1.0 ]];
            
            
            [self drawTableTitles];
            
            [self drawLineVerticalWithFrame:CGRectMake(80, 100, 4, 650)
                                  withColor:[UIColor colorWithRed:246.0/255.0 green:176.0/255.0 blue:4.0/255.0 alpha:1.0 ]];
            
            j=150;
            i--;
        }
        
    }
    
    //[self drawLineVerticalWithFrame:CGRectMake(60, 20, 4, 700)
    //withColor:[UIColor colorWithRed:246.0/255.0 green:176.0/255.0 blue:4.0/255.0 alpha:1.0 ]];
    [self drawLineHorizontalWithFrame:CGRectMake(20, j, 580, 4)
                            withColor:[UIColor colorWithRed:246.0/255.0 green:176.0/255.0 blue:4.0/255.0 alpha:1.0 ]];
    
    
    UIImage *img = NULL;
    
    if([images count]!=0) {
        
        
        j=100;
        
        xIndex = 50;
        yIndex = 100;
        
        UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 612, 792), nil);
        
        /*logoImage = [UIImage imageNamed:@"optiqo_icon.png"];
        
        jpegData = UIImageJPEGRepresentation(logoImage, COMPRESS_LEVEL);
        logoImage = [UIImage imageWithData:jpegData];*/
        
        logoImage = [UIImage imageWithContentsOfFile:logoPath];
        
        jpegData = UIImageJPEGRepresentation(logoImage, COMPRESS_LEVEL);
        logoImage = [UIImage imageWithData:jpegData];
        
        [logoImage drawInRect:CGRectMake(20, 20, 150, 50)];
        
        [self drawLineHorizontalWithFrame:CGRectMake(5, 70, 600, 4)
                                withColor:[UIColor colorWithRed:246.0/255.0 green:176.0/255.0 blue:4.0/255.0 alpha:1.0 ]];
        
        
        img = [images objectAtIndex:0];
        
        
        [img drawInRect:CGRectMake(xIndex, yIndex, 250, 150)];
        
        NSString *imgCountLabel = [NSString stringWithFormat:@"%d",1];
        
        
        [imgCountLabel drawInRect:CGRectMake(xIndex+125, 75, 30, 25) withAttributes:attrsImageCountDictionary];
    }
    
    
    
    for(int i=1;i<[images count];i++) {
        
        //[self drawImageCount:i row:j];
        
        img = [images objectAtIndex:i];
        
        
        if(i%2==0){
            
            xIndex = 50;
            yIndex +=200;
            
            if(yIndex>650) {
                
                UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 612, 792), nil);
                /*logoImage = [UIImage imageNamed:@"optiqo_icon.png"];
                
                jpegData = UIImageJPEGRepresentation(logoImage, COMPRESS_LEVEL);
                logoImage = [UIImage imageWithData:jpegData];*/
                
                logoImage = [UIImage imageWithContentsOfFile:logoPath];
                
                jpegData = UIImageJPEGRepresentation(logoImage, COMPRESS_LEVEL);
                logoImage = [UIImage imageWithData:jpegData];
                
                [logoImage drawInRect:CGRectMake(20, 20, 150, 50)];
                
                [self drawLineHorizontalWithFrame:CGRectMake(5, 70, 600, 4)
                                        withColor:[UIColor colorWithRed:246.0/255.0 green:176.0/255.0 blue:4.0/255.0 alpha:1.0 ]];
                
                yIndex=100;
            }
            
        }
        else {
            
               xIndex+=260;
        }
        
        [img drawInRect:CGRectMake(xIndex, yIndex, 250, 150)];
        
        UIView *imageCount = [[UIView alloc] initWithFrame:CGRectMake(xIndex, yIndex+120, 25, 30)];
        
        UILabel *label = [[[UILabel alloc] init] initWithFrame:CGRectMake(0, 0, imageCount.frame.size.width, imageCount.frame.size.height)];
        
        [label setBackgroundColor:[UIColor whiteColor]];
        
        NSString *imgCountLabel = [NSString stringWithFormat:@"%d",(i+1)];
        
        [label setText:imgCountLabel];
        
        [label setTextAlignment:NSTextAlignmentCenter];
        
        [label setFont:[UIFont fontWithName:@"Avnier-medium" size:16.0]];
        
        [label.text drawInRect:CGRectMake(xIndex+125, yIndex-25, 30, 25) withAttributes:attrsImageCountDictionary];
        
        
        
    }
}

//draw office cleaning report content with images, room names, comments for customer and employer

-(void) officeCleaningReport:(NSString *) type {
    
    UIFont *font = [UIFont fontWithName:REPORT_FONT size:12.0];
    
    
    NSMutableParagraphStyle *paragraphStyle_left = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    /// Set line break mode
    paragraphStyle_left.lineBreakMode = NSLineBreakByCharWrapping;
    /// Set text alignment
    paragraphStyle_left.alignment = NSTextAlignmentCenter;
    
    

    
    NSMutableParagraphStyle *paragraphStyle_center = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    /// Set line break mode
    paragraphStyle_center.lineBreakMode = NSLineBreakByTruncatingTail;
    /// Set text alignment
    paragraphStyle_center.alignment = NSTextAlignmentLeft;
    
    NSDictionary *attrsDictionary =
    
    [NSDictionary dictionaryWithObjectsAndKeys:
     font, NSFontAttributeName,
     [NSNumber numberWithFloat:1.0], NSBaselineOffsetAttributeName,paragraphStyle_center,NSParagraphStyleAttributeName, nil];
    
    NSDictionary *attrsDictionary1 =
    
    [NSDictionary dictionaryWithObjectsAndKeys:
     font, NSFontAttributeName,
     [NSNumber numberWithFloat:1.0], NSBaselineOffsetAttributeName,paragraphStyle_center,NSParagraphStyleAttributeName, nil];

    
    NSDictionary *attrsImageCountDictionary =
    
    [NSDictionary dictionaryWithObjectsAndKeys:
     font, NSFontAttributeName,
     [NSNumber numberWithFloat:1.0], NSBaselineOffsetAttributeName,[UIColor whiteColor],NSBackgroundColorAttributeName,nil];
    
    
    UIImage *logoImage;
    NSData *jpegData;
    
    
    NSString *logoPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:[NSString stringWithFormat:@"/%@/%@",@"Optiqo",@"companyLogoImage.jpg"]];
    
    
    logoImage = [UIImage imageWithContentsOfFile:logoPath];
    
    jpegData = UIImageJPEGRepresentation(logoImage, COMPRESS_LEVEL);
    logoImage = [UIImage imageWithData:jpegData];

    
    
    int j=150;
    
    for(int i=0;i<[self.reports count];i++) {
        
        RoomListContent *roomContent = (RoomListContent *)[self.reports objectAtIndex:i];
        
        if([type isEqualToString:@"customer"])
            [roomContent setCustomerReport];
        else
            [roomContent setEmployerReport];
        
        NSString *roomName = roomContent.customerRoom;
        
        NSString *roomComments = roomContent.roomComents;
        
        NSString *roomTime = roomContent.report_time;
        
        //NSLog(@"room name in office report %@,%@",roomName,roomComments);
        
        
        [self drawLineHorizontalWithFrame:CGRectMake(20, j, 580, 4)
                                withColor:[UIColor colorWithRed:246.0/255.0 green:176.0/255.0 blue:4.0/255.0 alpha:1.0 ]];
        j+=60;
        
        if(j<=750) {
            
            
                UIImage *image = roomContent.customerRoomImage.image;
            
                NSData *jpegData = UIImageJPEGRepresentation(image, COMPRESS_LEVEL);
                image = [UIImage imageWithData:jpegData];
                
                
                [image drawInRect:CGRectMake(25, j-50, 40, 40)];
            
                attrsDictionary =
            
                [NSDictionary dictionaryWithObjectsAndKeys:
                 font, NSFontAttributeName,
                 [NSNumber numberWithFloat:1.0], NSBaselineOffsetAttributeName,paragraphStyle_left,NSParagraphStyleAttributeName, nil];

            
                [roomName drawInRect:CGRectMake(90, j-35, 100, 50) withAttributes:attrsDictionary1];
            
            
            
                NSNumber *approve = roomContent.approveRoom;
            
            
            if([approve boolValue]) {
                
                UIImage *image = [UIImage imageNamed:@"approve.png"];
                
                NSData *jpegData = UIImageJPEGRepresentation(image, COMPRESS_LEVEL);
                image = [UIImage imageWithData:jpegData];
                
                [image drawInRect:CGRectMake(525, j-50, 40, 40)];
            }
            else {
                
                UIImage *image = [UIImage imageNamed:@"close_icon.png"];
                
                NSData *jpegData = UIImageJPEGRepresentation(image, COMPRESS_LEVEL);
                image = [UIImage imageWithData:jpegData];
                
                [image drawInRect:CGRectMake(525, j-50, 40, 40)];
            }
            
            if(![roomComments isEqualToString:[labels valueForKey:@"nocomments"]])
                if([roomComments length]<=60)
                    [roomComments drawInRect:CGRectMake(250, j-35, 200, 60) withAttributes:attrsDictionary]
                    ;
                else
                    [roomComments drawInRect:CGRectMake(250, j-50, 200, 70) withAttributes:attrsDictionary]
                    ;
            else {
                
                roomComments = @"-";
                [roomComments drawInRect:CGRectMake(325, j-35, 200, 60) withAttributes:attrsDictionary];
            }
            
            //[timeTake drawInRect:CGRectMake(425, j-80, 100, 60) withAttributes:attrsDictionary];
            
            // draws an image under image count 
            if([roomContent.roomContainsImages boolValue]) {
                [self imageCount:i row:j];
            }
            
            
            
            if(endImageCount > 1 && [roomContent.roomContainsImages boolValue]) {
                NSString *imageCount = [NSString stringWithFormat:@"%d-%d",startImageCount,endImageCount];
                
                [imageCount drawInRect:CGRectMake(185, j-55, 75, 15) withAttributes:attrsDictionary];
                
                
                
            }
            else if(startImageCount == 1 && [roomContent.roomContainsImages boolValue])
            {
                
                NSString *imageCount = [NSString stringWithFormat:@"%d",startImageCount];
                
                [imageCount drawInRect:CGRectMake(175, j-55, 75, 15) withAttributes:attrsDictionary];
            }
            else
            {
                NSString *imageCount = @"-";
                
                [imageCount drawInRect:CGRectMake(175, j-35, 75, 34) withAttributes:attrsDictionary];
            }
            
            startImageCount = endImageCount;
            
            if(!isCustomerReport) {
                
                [roomTime drawInRect:CGRectMake(445, j-35, 75, 34) withAttributes:attrsDictionary];
            }
            
        }
        
        
        if(j>700) {
            UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 612, 792), nil);
            
            /*logoImage = [UIImage imageNamed:@"optiqo_icon.png"];
            
            jpegData = UIImageJPEGRepresentation(logoImage, COMPRESS_LEVEL);
            logoImage = [UIImage imageWithData:jpegData];*/
            
            logoImage = [UIImage imageWithContentsOfFile:logoPath];
            
            jpegData = UIImageJPEGRepresentation(logoImage, COMPRESS_LEVEL);
            logoImage = [UIImage imageWithData:jpegData];
            
            [logoImage drawInRect:CGRectMake(20, 20, 150, 50)];
            
            [self drawLineHorizontalWithFrame:CGRectMake(5, 70, 600, 4)
                                    withColor:[UIColor colorWithRed:246.0/255.0 green:176.0/255.0 blue:4.0/255.0 alpha:1.0 ]];
            
            
            [self drawTableTitles];
            
            [self drawLineVerticalWithFrame:CGRectMake(80, 100, 4, 650)
                                  withColor:[UIColor colorWithRed:246.0/255.0 green:176.0/255.0 blue:4.0/255.0 alpha:1.0 ]];
            
            j=150;
            i--;
        }
        
    }
    
    //[self drawLineVerticalWithFrame:CGRectMake(60, 20, 4, 700)
    //withColor:[UIColor colorWithRed:246.0/255.0 green:176.0/255.0 blue:4.0/255.0 alpha:1.0 ]];
    [self drawLineHorizontalWithFrame:CGRectMake(20, j, 580, 4)
                            withColor:[UIColor colorWithRed:246.0/255.0 green:176.0/255.0 blue:4.0/255.0 alpha:1.0 ]];
    //draw the images
    
    UIImage *img = NULL;
    
    if([images count]!=0) {
        
        
        j=100;
        
        xIndex = 50;
        yIndex = 100;
        
        UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 612, 792), nil);
        
        /*logoImage = [UIImage imageNamed:@"optiqo_icon.png"];
        
        jpegData = UIImageJPEGRepresentation(logoImage, COMPRESS_LEVEL);
        logoImage = [UIImage imageWithData:jpegData];*/
        
        logoImage = [UIImage imageWithContentsOfFile:logoPath];
        
        jpegData = UIImageJPEGRepresentation(logoImage, COMPRESS_LEVEL);
        logoImage = [UIImage imageWithData:jpegData];
        
        [logoImage drawInRect:CGRectMake(20, 20, 150, 50)];
        
        [self drawLineHorizontalWithFrame:CGRectMake(5, 70, 600, 4)
                                withColor:[UIColor colorWithRed:246.0/255.0 green:176.0/255.0 blue:4.0/255.0 alpha:1.0 ]];
        
        
        img = [images objectAtIndex:0];
        
        [img drawInRect:CGRectMake(xIndex, yIndex, 250, 150)];
        
        NSString *imgCountLabel = [NSString stringWithFormat:@"%d",1];
        
        
        [imgCountLabel drawInRect:CGRectMake(xIndex+125, 75, 30, 25) withAttributes:attrsImageCountDictionary];
    }
    
    
    
    for(int i=1;i<[images count];i++) {
        
        //[self drawImageCount:i row:j];
        
        img = [images objectAtIndex:i];
        
        
        if(i%2==0){
            
            xIndex = 50;
            yIndex +=200;
            
            if(yIndex>650) {
                
                UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 612, 792), nil);
                /*logoImage = [UIImage imageNamed:@"optiqo_icon.png"];
                
                jpegData = UIImageJPEGRepresentation(logoImage, COMPRESS_LEVEL);
                logoImage = [UIImage imageWithData:jpegData];*/
                
                logoImage = [UIImage imageWithContentsOfFile:logoPath];
                
                jpegData = UIImageJPEGRepresentation(logoImage, COMPRESS_LEVEL);
                logoImage = [UIImage imageWithData:jpegData];
                
                [logoImage drawInRect:CGRectMake(20, 20, 150, 50)];
                
                [self drawLineHorizontalWithFrame:CGRectMake(5, 70, 600, 4)
                                        withColor:[UIColor colorWithRed:246.0/255.0 green:176.0/255.0 blue:4.0/255.0 alpha:1.0 ]];
                
                yIndex=100;
            }
            
        }
        else {
            
            xIndex+=260;
        }
        
        
        [img drawInRect:CGRectMake(xIndex, yIndex, 250, 150)];
        
        UIView *imageCount = [[UIView alloc] initWithFrame:CGRectMake(xIndex, yIndex+120, 25, 30)];
        
        UILabel *label = [[[UILabel alloc] init] initWithFrame:CGRectMake(0, 0, imageCount.frame.size.width, imageCount.frame.size.height)];
        
        [label setBackgroundColor:[UIColor whiteColor]];
        
        NSString *imgCountLabel = [NSString stringWithFormat:@"%d",(i+1)];
        
        [label setText:imgCountLabel];
        
        [label setTextAlignment:NSTextAlignmentCenter];
        
        [label setFont:[UIFont fontWithName:@"Avnier-medium" size:16.0]];
        
        [label.text drawInRect:CGRectMake(xIndex+125, yIndex-25, 30, 25) withAttributes:attrsImageCountDictionary];
        
        
        
    }
}


-(UIImage *) compressImage:(UIImage *)image newWidth:(int)width newHeight:(int)height {
    
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [image drawInRect:CGRectMake(0, 0, width, height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

/*else if([roomName isEqualToString:[labels valueForKey:@"hallway"]]) {
 
 UIImage *image = [UIImage imageNamed:@"hallway.png"];
 
 NSData *jpegData = UIImageJPEGRepresentation(image, COMPRESS_LEVEL);
 image = [UIImage imageWithData:jpegData];
 
 [image drawInRect:CGRectMake(25, j-80, 40, 40)];
 }
 
 else if([roomName isEqualToString:[labels valueForKey:@"officeroom"]]) {
 
 UIImage *image = [UIImage imageNamed:@"office_room.png"];
 
 jpegData = UIImageJPEGRepresentation(image, COMPRESS_LEVEL);
 image = [UIImage imageWithData:jpegData];
 
 [image drawInRect:CGRectMake(25, j-80, 40, 40)];
 }
 
 else if([roomName isEqualToString:[labels valueForKey:@"grouproom"]]) {
 
 UIImage *image = [UIImage imageNamed:@"group_room.png"];
 
 NSData *jpegData = UIImageJPEGRepresentation(image, COMPRESS_LEVEL);
 image = [UIImage imageWithData:jpegData];
 
 [image drawInRect:CGRectMake(25, j-80, 40, 40)];
 }
 
 else if([roomName isEqualToString:[labels valueForKey:@"conferenceroom"]]) {
 
 UIImage *image = [UIImage imageNamed:@"conference_room.png"];
 
 NSData *jpegData = UIImageJPEGRepresentation(image, COMPRESS_LEVEL);
 image = [UIImage imageWithData:jpegData];
 
 [image drawInRect:CGRectMake(25, j-80, 40, 40)];
 }
 
 else if([roomName isEqualToString:[labels valueForKey:@"kitchen"]]) {
 
 UIImage *image = [UIImage imageNamed:@"generic_room.png"];
 
 NSData *jpegData = UIImageJPEGRepresentation(image, COMPRESS_LEVEL);
 image = [UIImage imageWithData:jpegData];
 
 [image drawInRect:CGRectMake(25, j-80, 40, 40)];
 }
 
 else if([roomName isEqualToString:[labels valueForKey:@"coffeeroom"]]) {
 
 UIImage *image = [UIImage imageNamed:@"coffee_room.png"];
 
 NSData *jpegData = UIImageJPEGRepresentation(image, COMPRESS_LEVEL);
 image = [UIImage imageWithData:jpegData];
 
 [image drawInRect:CGRectMake(25, j-80, 40, 40)];
 }
 
 else if([roomName isEqualToString:[labels valueForKey:@"lift"]]) {
 
 UIImage *image = [UIImage imageNamed:@"lift.png"];
 
 NSData *jpegData = UIImageJPEGRepresentation(image, COMPRESS_LEVEL);
 image = [UIImage imageWithData:jpegData];
 
 [image drawInRect:CGRectMake(25, j-80, 40, 40)];
 }
 
 else if([roomName isEqualToString:[labels valueForKey:@"exculator"]]) {
 
 UIImage *image = [UIImage imageNamed:@"exculator.png"];
 
 NSData *jpegData = UIImageJPEGRepresentation(image, COMPRESS_LEVEL);
 image = [UIImage imageWithData:jpegData];
 
 [image drawInRect:CGRectMake(25, j-80, 40, 40)];
 }
 
 else if([roomName isEqualToString:[labels valueForKey:@"stairs"]]) {
 
 UIImage *image = [UIImage imageNamed:@"stairs.png"];
 
 NSData *jpegData = UIImageJPEGRepresentation(image, COMPRESS_LEVEL);
 image = [UIImage imageWithData:jpegData];
 
 [image drawInRect:CGRectMake(25, j-80, 40, 40)];
 }
 
 else if([roomName isEqualToString:[labels valueForKey:@"storeroom"]]) {
 
 UIImage *image = [UIImage imageNamed:@"store_room.png"];
 
 NSData *jpegData = UIImageJPEGRepresentation(image, COMPRESS_LEVEL);
 image = [UIImage imageWithData:jpegData];
 
 [image drawInRect:CGRectMake(25, j-80, 40, 40)];
 }
 
 else if([roomName isEqualToString:[labels valueForKey:@"wherehouse"]]) {
 
 UIImage *image = [UIImage imageNamed:@"wherehouse.png"];
 
 NSData *jpegData = UIImageJPEGRepresentation(image, COMPRESS_LEVEL);
 image = [UIImage imageWithData:jpegData];
 
 [image drawInRect:CGRectMake(25, j-80, 40, 40)];
 }
 
 else if([roomName isEqualToString:[labels valueForKey:@"washroom"]]) {
 
 UIImage *image = [UIImage imageNamed:@"washroom.png"];
 
 NSData *jpegData = UIImageJPEGRepresentation(image, COMPRESS_LEVEL);
 image = [UIImage imageWithData:jpegData];
 
 [image drawInRect:CGRectMake(25, j-80, 40, 40)];
 }
 
 else if([roomName isEqualToString:[labels valueForKey:@"shower"]]) {
 
 UIImage *image = [UIImage imageNamed:@"shower.png"];
 
 NSData *jpegData = UIImageJPEGRepresentation(image, COMPRESS_LEVEL);
 image = [UIImage imageWithData:jpegData];
 
 [image drawInRect:CGRectMake(25, j-80, 40, 40)];
 }
 
 else if([roomName isEqualToString:[labels valueForKey:@"toilet"]]) {
 
 UIImage *image = [UIImage imageNamed:@"toilet.png"];
 
 NSData *jpegData = UIImageJPEGRepresentation(image, COMPRESS_LEVEL);
 image = [UIImage imageWithData:jpegData];
 
 [image drawInRect:CGRectMake(25, j-80, 40, 40)];
 }
 
 else if([roomName isEqualToString:[labels valueForKey:@"wasteroom"]]) {
 
 UIImage *image = [UIImage imageNamed:@"wasteroom.png"];
 
 NSData *jpegData = UIImageJPEGRepresentation(image, COMPRESS_LEVEL);
 image = [UIImage imageWithData:jpegData];
 
 [image drawInRect:CGRectMake(25, j-80, 40, 40)];
 }
 
 else if([roomName isEqualToString:[labels valueForKey:@"parking"]]) {
 
 UIImage *image = [UIImage imageNamed:@"parking.png"];
 
 NSData *jpegData = UIImageJPEGRepresentation(image, COMPRESS_LEVEL);
 image = [UIImage imageWithData:jpegData];
 
 [image drawInRect:CGRectMake(25, j-80, 40, 40)];
 }
 
 else
 {
 UIImage *image = [UIImage imageNamed:@"generic_room.png"];
 
 NSData *jpegData = UIImageJPEGRepresentation(image, COMPRESS_LEVEL);
 image = [UIImage imageWithData:jpegData];
 
 [image drawInRect:CGRectMake(25, j-80, 40, 40)];
 }*/


@end
