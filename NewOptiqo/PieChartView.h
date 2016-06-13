//
//  PieChartView.h
//  Optiqo Inspect
//
//  Created by Umapathi on 11/2/14.
//  Copyright (c) 2014 Umapathi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PieChartView : UIView {
    
    float rate;
    UILabel *label,*approveCountLabel;
    UIColor *color;
    UIFont *font;
    UILabel *approveLabel;
    UILabel *disapproveLabel;
    UIView  *approveView;
    UIView *disapproveView;
    UIImage *img;
    
    int approvedReportCount,numReports;
    
    NSString *percentString;
    
    NSDictionary *labels;
    
    int chart_style;
}

@property (nonatomic,strong) UIImage *ratingImage;
@property (nonatomic,strong) UIImage *reportImage;
@property (nonatomic,strong) UIImage *scoreImage;


- (id)initWithFrame:(CGRect)frame initWithRate:(float) customer_rate withOptions:(int) option withApproveCount:(int) approveCount numReports:(int) reportCount chartStyle:(int) style;
- (void) drawReportImage;

-(void) drawChartWithTableView:(CGRect)rect;

-(void) drawChartWithReport:(CGRect)rect;

-(void) drawChartWithScore:(CGRect)rect;

@end
