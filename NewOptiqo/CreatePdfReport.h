//
//  CreatePdfReport.h
//  NewOptiqo
//
//  Created by Umapathi on 9/10/14.
//  Copyright (c) 2014 Umapathi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AdSupport/ASIdentifierManager.h>
#import <MapKit/MapKit.h>
#import <MapKit/MKAnnotation.h>
#import <MapKit/MKMapSnapshotOptions.h>
#import "CreatePdfReport.h"
#import "RoomListContent.h"
#import "PieChartView.h"

@interface CreatePdfReport : NSObject<MKMapViewDelegate> {
    
    NSString *employerName;
    
    NSInteger hours,minutes,seconds;
    
    MKMapView *customerMapView;
    
    MKPointAnnotation *point;
    
    UIImage *mapImage,*reportImage,*scoreImage;
    
    NSData *data;
    
    int startImageCount,endImageCount;
    
    int imagesCount;
    
    int xIndex,yIndex;
    
    NSMutableArray *images;
    
    float rating;
    
    NSString *userName;
    
    NSString *custLanguage;
    NSString *custCity;
    
    NSString *employerAddress;
    NSString *employerEmail;
    NSString *employerWebSite;
    NSString *employerPhone;
    
    NSDictionary *labels;
    
    BOOL isCustomerReport;
}

@property(nonatomic,strong) NSString *filename;
@property(nonatomic,strong) NSString *pdfFilename;
@property(nonatomic,strong) NSMutableArray *reports;
@property(nonatomic,strong) NSString *customerName;


-(void) generatePDF;
//-(void) addNewPDFPage:(int) index;
-(void) drawImages:(int) index;
-(void) getUser;
-(void) getEmployer;
-(void) getCustomer;
-(void) generateEmployerPDF;
-(CGRect) drawLineHorizontalWithFrame:(CGRect) rect withColor:(UIColor *) color;
-(CGRect) drawLineVerticalWithFrame:(CGRect) rect withColor:(UIColor *) color;
-(void) setReportImage:(NSArray *) images;

-(void) houseCleaningReport:(NSString *) type;
-(void) officeCleaningReport:(NSString *) type;

//draw table heading titles
-(void) drawTableTitles;

-(void) imageCount:(int) index row:(int) j;

-(void) drawImageCount:(int)index  row:(int) j;

- (UIImage *) drawReportImage;

- (UIImage *) drawReportImageWithText:(NSString *) text;

-(UIImage *) compressImage:(UIImage *) image newWidth:(int) width newHeight:(int)height;

//-(NSString *) getCustomerTotalTime;

@end
