//
//  PieChartView.m
//  Optiqo Inspect
//
//  Created by Umapathi on 11/2/14.
//  Copyright (c) 2014 Umapathi. All rights reserved.
//

#import "PieChartView.h"
#import "ViewController.h"

#define PI 3.14159265358979323846
static inline float radians(double degrees) { return degrees * PI / 180; }


@implementation PieChartView

@synthesize ratingImage;

//draws a pie chart view showing the approved and dissapproved rooms

- (id)initWithFrame:(CGRect)frame initWithRate:(float) customer_rate withOptions:(int)option withApproveCount:(int)approveCount numReports:(int)reportCount chartStyle:(int)style
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        //NSLog(@"%d option ",option);
        
        [self setBackgroundColor:[UIColor clearColor]];
        
        rate = customer_rate;
        
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

        
        label = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 100,25)];
        
        [label setBackgroundColor:[UIColor clearColor]];
        
        [label setText:[labels valueForKey:@"approved"]];
        
        color = [UIColor blackColor];
        
        font = [UIFont fontWithName:@"Avenir-Medium" size:16.0];
        
        [label setTextColor:color];
        
        [label setFont:font];
        
        
        approveCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 5, self.frame.size.width,25)];
        
        [approveCountLabel setBackgroundColor:[UIColor clearColor]];
        
        NSString *countString = [NSString stringWithFormat:@"%d(%d)",approveCount,reportCount];
        
        approvedReportCount = approveCount;
        
        numReports = reportCount;
        
        if(chart_style==1)
         [approveCountLabel setText:countString];
        
        color = [UIColor blackColor];
        
        font = [UIFont fontWithName:@"Avenir-Medium" size:16.0];
        
        [approveCountLabel setTextColor:color];
        
        [approveCountLabel setFont:font];
        
        
        chart_style = style;
        
        if(option==1 && (chart_style==1 || chart_style == 2)) {
            [self addSubview:label];
        
            [self addSubview:approveCountLabel];
            
            if([vc.customerLanguageSelected isEqualToString:@"English"])
            {
                //NSLog(@"Entered data in report view");
                labels = [vc.englishLabels valueForKey:@"userenglishlabels"];
                
                approveView = [[UIView alloc] initWithFrame:CGRectMake(20, self.frame.size.height*0.90, 25, 25)];
                disapproveView = [[UIView alloc] initWithFrame:CGRectMake(140, self.frame.size.height*0.90, 25, 25)];
                
                approveLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, self.frame.size.height*0.90,100, 25)];
                
                disapproveLabel = [[UILabel alloc] initWithFrame:CGRectMake(170, self.frame.size.height*0.90, 150, 25)];
                
                [approveLabel setText:[labels valueForKey:@"approve"]];
                
                [disapproveLabel setText:[labels valueForKey:@"disapprove"]];

            }
            else
            {
                labels = [vc.englishLabels valueForKey:@"userswedishlabels"];
                
                
                approveView = [[UIView alloc] initWithFrame:CGRectMake(45, self.frame.size.height*0.90, 25, 25)];
                disapproveView = [[UIView alloc] initWithFrame:CGRectMake(180, self.frame.size.height*0.90, 25, 25)];
                
                approveLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, self.frame.size.height*0.90,100, 25)];
                
                disapproveLabel = [[UILabel alloc] initWithFrame:CGRectMake(210, self.frame.size.height*0.90, 150, 25)];
                
                [approveLabel setText:[labels valueForKey:@"approve"]];
                
                [disapproveLabel setText:[labels valueForKey:@"disapprove"]];
            }
            
            //if(chart_style ==1)
            [approveView setBackgroundColor:[UIColor colorWithRed:107.0/255.0 green:179.0/255.0 blue:45.0/255.0 alpha:1.0]];
            
            
            //if(chart_style == 2)
            //    [approveView setBackgroundColor:[UIColor greenColor]];
        
            [self addSubview:approveView];
        
            
            [disapproveView setBackgroundColor:[UIColor redColor]];
        
            [self addSubview:disapproveView];
        
        

            
        
            [approveLabel setBackgroundColor:[UIColor clearColor]];
        
            
        
        
            [approveLabel setTextColor:color];
        
            [approveLabel setFont:font];
        
            [self addSubview:approveLabel];
        
            
        
            [disapproveLabel setBackgroundColor:[UIColor clearColor]];
        
            
        
        
            [disapproveLabel setTextColor:color];
        
            [disapproveLabel setFont:font];
        
            [self addSubview:disapproveLabel];
            
            
        }
        
        //draws a pie view showing the total score
        if(chart_style == 3)
        {
            //NSLog(@"entered data %d",chart_style);
            approveLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, self.frame.size.height*0.90,300, 25)];
            
            [approveLabel setBackgroundColor:[UIColor clearColor]];
            
            [approveLabel setText:[labels valueForKey:@"totalscore"]];
            
            
            [approveLabel setTextColor:[UIColor whiteColor]];
            
            [approveLabel setFont:[UIFont fontWithName:@"ArialMT" size:20.0]];
            
            [self addSubview:approveLabel];
            
        }
        
        
        self.ratingImage = [[UIImage alloc] init];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    if(chart_style == 1)
        [self drawChartWithTableView:rect];
    
    if(chart_style == 2)
        [self drawChartWithReport:rect];

    if(chart_style == 3)
        [self drawChartWithScore:rect];

    

}
//draw apie chart
-(void) drawChartWithTableView:(CGRect)rect {
    
    CGRect parentViewBounds = self.bounds;
    CGFloat x = CGRectGetWidth(parentViewBounds)/2;
    CGFloat y = CGRectGetHeight(parentViewBounds)*0.45;
    
    // Get the graphics context and clear it
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextClearRect(ctx, rect);
    
    // define stroke color
    CGContextSetRGBStrokeColor(ctx, 1, 1, 1, 1.0);
    
    // define line width
    CGContextSetLineWidth(ctx, 4.0);
    
    
    // need some values to draw pie charts
    
    double snapshotCapacity =rate*100;
    double rawCapacity = 100;
    //double systemCapacity = 1;
    
    //int offset = 5;
    double snapshot_start = 0.0;
    double snapshot_finish = snapshotCapacity *360.0/rawCapacity;
    //double system_finish = systemCapacity*360.0/rawCapacity;
    
    //double snapshot_start = 0;
    //double snapshot_finish = 50;
    
    //NSLog(@"capacity %f,%f,%f,%f,%f",rate*100,x,y,snapshot_start+snapshot_finish,snapshot_start);
    
    //NSLog(@"x,y %f,%f",(x)+100*cos(radians(snapshot_start+snapshot_finish)),y+100*sin(radians(snapshot_start+snapshot_finish)));
    
    float xpos = (x)+100*cos(radians(snapshot_start+snapshot_finish));
    
    float ypos = (x)+100*sin(radians(snapshot_start+snapshot_finish));
    
    if(snapshotCapacity >=100.0) {
        
        //CGContextSetFillColor(ctx, CGColorGetComponents( [[UIColor greenColor] CGColor]));
        CGContextSetFillColor(ctx, CGColorGetComponents( [[UIColor colorWithRed:107.0/255.0 green:179.0/255.0 blue:45.0/255.0 alpha:1.0] CGColor]));
        CGContextMoveToPoint(ctx, x, y);
        CGContextAddArc(ctx, x, y, 100,  radians(snapshot_start+snapshot_finish), radians(snapshot_start), 0);
        CGContextClosePath(ctx);
        CGContextFillPath(ctx);
        CGContextDrawImage(ctx, CGRectMake(0, 0, rect.size.width, rect.size.height+100), self.ratingImage.CGImage);
        
        percentString = [NSString stringWithFormat:@"%d%%",100];
        
        UIFont *percentFont = [UIFont fontWithName:@"Avenir-Medium" size:16.0];
        
        
        NSDictionary *attrsDictionary =
        
        [NSDictionary dictionaryWithObjectsAndKeys:
         percentFont, NSFontAttributeName,
         [NSNumber numberWithFloat:1.0], NSBaselineOffsetAttributeName, nil];
        
        CGSize strSize = [percentString sizeWithAttributes:attrsDictionary];
        
        
        
        int str_x = round(strSize.width)/2;
        int str_y = round(strSize.height)/2;
        
        //NSLog(@"string size %d,%d",str_x,str_y);
        
        
        
        [percentString drawAtPoint:CGPointMake(x-str_x, y-str_y) withAttributes:attrsDictionary];
        
    }
    else if(snapshotCapacity <=0.0) {
        
        snapshot_finish = 100.0*360.0/rawCapacity;;
        CGContextSetFillColor(ctx, CGColorGetComponents( [[UIColor redColor] CGColor]));
        CGContextMoveToPoint(ctx, x, y);
        CGContextAddArc(ctx, x, y, 100,  radians(snapshot_start+snapshot_finish), radians(snapshot_start), 0);
        
        CGContextClosePath(ctx);
        CGContextFillPath(ctx);
        
        percentString = [NSString stringWithFormat:@"%d%%",0];
        
        UIFont *percentFont = [UIFont fontWithName:@"Avenir-Medium" size:16.0];
        
        
        NSDictionary *attrsDictionary =
        
        [NSDictionary dictionaryWithObjectsAndKeys:
         percentFont, NSFontAttributeName,
         [NSNumber numberWithFloat:1.0], NSBaselineOffsetAttributeName, nil];
        
        CGSize strSize = [percentString sizeWithAttributes:attrsDictionary];
        
        
        
        int str_x = round(strSize.width)/2;
        int str_y = round(strSize.height)/2;
        
        //NSLog(@"string size %d,%d",str_x,str_y);
        
        
        [percentString drawAtPoint:CGPointMake(x-str_x, y-str_y) withAttributes:attrsDictionary];
        
        
        CGContextDrawImage(ctx, CGRectMake(0, 0, rect.size.width, rect.size.height+100), self.ratingImage.CGImage);
        
        
        
    }
    else {
        
        //CGContextSetFillColor(ctx, CGColorGetComponents( [[UIColor colorWithRed:246.0/255.0 green:176.0/255.0 blue:4.0/255.0 alpha:1.0 ] CGColor]));
        CGContextSetFillColor(ctx, CGColorGetComponents( [[UIColor colorWithRed:107.0/255.0 green:179.0/255.0 blue:45.0/255.0 alpha:1.0] CGColor]));
        CGContextMoveToPoint(ctx, x, y);
        CGContextAddArc(ctx, x, y, 100,  radians(snapshot_start), radians(snapshot_finish), 0);
        
        //NSLog(@" start angle,end angle  %f,%f ",snapshot_start, snapshot_finish);
        
        CGContextClosePath(ctx);
        CGContextFillPath(ctx);
        
        
        
        
        // system capacity
        /*CGContextSetFillColor(ctx, CGColorGetComponents( [[UIColor colorWithRed:15 green:165/255 blue:0 alpha:1 ] CGColor]));
         CGContextMoveToPoint(ctx, x+offset,y);
         CGContextAddArc(ctx, x+offset, y, 100,  radians(snapshot_start+snapshot_finish+offset), radians(snapshot_start+snapshot_finish+system_finish), 0);
         CGContextClosePath(ctx);
         CGContextFillPath(ctx);*/
        
        /*
         data capacity */
        CGContextSetFillColor(ctx, CGColorGetComponents( [[UIColor redColor ] CGColor]));
        CGContextMoveToPoint(ctx, x, y);
        CGContextAddArc(ctx, x, y, 100,  radians(snapshot_start+snapshot_finish), radians(snapshot_start), 0);
        CGContextClosePath(ctx);
        CGContextFillPath(ctx);
        
        //NSLog(@"%f,%f",radians(snapshot_start),radians(snapshot_finish)*(180/PI));
        
        /*float x_coord = x+(100)*cos(radians(snapshot_finish));
         
         float y_coord = y+(100)*sin(radians(snapshot_finish));
         
         float x_coord1 = x+(100)*cos(radians(snapshot_start));
         
         float y_coord1 = y+(100)*sin(radians(snapshot_start));
         
         float x_center = x+(100)*cos(radians((snapshot_start+snapshot_finish)/2));
         
         float y_center = y+(100)*sin(radians((snapshot_start+snapshot_finish)/2));*/
        
        
        
        //NSLog(@"%f,%f,%f,%f,%f,%f,%f,%f",radians(snapshot_start+snapshot_finish),radians(snapshot_start),x_coord,y_coord,x_coord1,y_coord1,x_center,y_center);
        
        //NSLog(@"radians to angle %f,%f",radians(snapshot_finish)*(180.0/PI),radians(snapshot_start)*(180.0/PI));
        
        float angle = radians(snapshot_finish)*(180.0/PI);
        
        int approveRate = (int)ceil(100.0-(rate*100.0));
        
        
        
        percentString = [NSString stringWithFormat:@"%d%%",approveRate];
        
        UIFont *percentFont = [UIFont fontWithName:@"Avenir-Medium" size:16.0];
        
        
        NSDictionary *attrsDictionary =
        
        [NSDictionary dictionaryWithObjectsAndKeys:
         percentFont, NSFontAttributeName,
         [NSNumber numberWithFloat:1.0], NSBaselineOffsetAttributeName, nil];
        
        NSString *approvedStr = [NSString stringWithFormat:@"%d%%",100-approveRate];
        
        
        
        //NSLog(@"angle %f",angle);
        
        if(angle<=45 && angle>0) {
            
            [approvedStr drawAtPoint:CGPointMake(x+25, y+(ypos-y)/2-16.0) withAttributes:attrsDictionary];
        }
        
        if(angle<=90 && angle>45) {
            
            [approvedStr drawAtPoint:CGPointMake(x+25, y+(ypos-y)/2-16.0) withAttributes:attrsDictionary];
        }
        
        
        
        if(angle<=180 && angle>90) {
            
            [approvedStr drawAtPoint:CGPointMake(x-20, 180) withAttributes:attrsDictionary];
        }
        
        if(angle<=180 && angle>0) {
            
            [percentString drawAtPoint:CGPointMake(x-20, 85) withAttributes:attrsDictionary];
            
            
        }
        
        if(angle>180 && angle<270) {
            
            //NSLog(@" coords %f,%f,%f,%f,%f",x,y,x_coord,y_coord,angle);
            [percentString drawAtPoint:CGPointMake(xpos+(260-xpos)/2-16.0, 85) withAttributes:attrsDictionary];
            [approvedStr drawAtPoint:CGPointMake(xpos+(260-xpos)/2-16.0, 180) withAttributes:attrsDictionary];
            
        }
        
        if(angle>=270 && angle<360) {
            
            //NSLog(@" coords %f,%f,%f,%f,%f",x,y,x_coord,y_coord,angle);
            [percentString drawAtPoint:CGPointMake(175, 85) withAttributes:attrsDictionary];
            
            [approvedStr drawAtPoint:CGPointMake(x, 180) withAttributes:attrsDictionary];
        }
        
        /*if(y_coord>y)
         [percentString drawAtPoint:CGPointMake((x_coord1-x_coord), y_coord-y) withAttributes:attrsDictionary];*/
        
        
        CGContextDrawImage(ctx, CGRectMake(0, 0, rect.size.width, rect.size.height+100), self.ratingImage.CGImage);
    }
}

//draw apie chart

-(void) drawChartWithReport:(CGRect)rect {
    
    CGRect parentViewBounds = self.bounds;
    CGFloat x = CGRectGetWidth(parentViewBounds)/2;
    CGFloat y = CGRectGetHeight(parentViewBounds)*0.45;
    
    // Get the graphics context and clear it
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextClearRect(ctx, rect);
    
    // define stroke color
    CGContextSetRGBStrokeColor(ctx, 1, 1, 1, 1.0);
    
    // define line width
    CGContextSetLineWidth(ctx, 4.0);
    
    
    // need some values to draw pie charts
    
    double snapshotCapacity =rate*100;
    double rawCapacity = 100;
    //double systemCapacity = 1;
    
    int offset = 2;
    double snapshot_start = 0.0;
    double snapshot_finish = snapshotCapacity *360.0/rawCapacity;
    //double system_finish = systemCapacity*360.0/rawCapacity;
    
    //double snapshot_start = 0;
    //double snapshot_finish = 50;
    
    //NSLog(@"capacity %f,%f,%f,%f,%f",rate*100,x,y,snapshot_start+snapshot_finish,snapshot_start);
    
    //NSLog(@"x,y %f,%f",(x)+100*cos(radians(snapshot_start+snapshot_finish)),y+100*sin(radians(snapshot_start+snapshot_finish)));
    
    //float xpos = (x)+100*cos(radians(snapshot_start+snapshot_finish));
    
    //float ypos = (x)+100*sin(radians(snapshot_start+snapshot_finish));
    
    if(snapshotCapacity >=100.0) {
        
        CGContextSetFillColor(ctx, CGColorGetComponents( [[UIColor colorWithRed:107.0/255.0 green:179.0/255.0 blue:45.0/255.0 alpha:1.0] CGColor]));
        CGContextMoveToPoint(ctx, x, y);
        CGContextAddArc(ctx, x, y, 120,  radians(snapshot_start+snapshot_finish), radians(snapshot_start), 0);
        CGContextClosePath(ctx);
        CGContextFillPath(ctx);
        CGContextDrawImage(ctx, CGRectMake(0, 0, rect.size.width, rect.size.height+100), self.ratingImage.CGImage);
        
        CGContextDrawImage(ctx, CGRectMake(0, 0, rect.size.width, rect.size.height+100), self.reportImage.CGImage);
        
    }
    else if(snapshotCapacity <=0.0) {
        
        snapshot_finish = 100.0*360.0/rawCapacity;;
        CGContextSetFillColor(ctx, CGColorGetComponents( [[UIColor redColor] CGColor]));
        CGContextMoveToPoint(ctx, x, y);
        CGContextAddArc(ctx, x, y, 120,  radians(snapshot_start+snapshot_finish), radians(snapshot_start), 0);
        
        CGContextClosePath(ctx);
        CGContextFillPath(ctx);
        
        
        
        CGContextDrawImage(ctx, CGRectMake(0, 0, rect.size.width, rect.size.height+100), self.reportImage.CGImage);
        
    }
    else {
        
        //CGContextSetFillColor(ctx, CGColorGetComponents( [[UIColor colorWithRed:246.0/255.0 green:176.0/255.0 blue:4.0/255.0 alpha:1.0 ] CGColor]));
        CGContextSetFillColor(ctx, CGColorGetComponents( [[UIColor colorWithRed:107.0/255.0 green:179.0/255.0 blue:45.0/255.0 alpha:1.0] CGColor]));
        CGContextMoveToPoint(ctx, x, y);
        CGContextAddArc(ctx, x, y, 120,  radians(snapshot_start), radians(snapshot_finish), 0);
        
        //NSLog(@" start angle,end angle  %f,%f ",snapshot_start, snapshot_finish);
        
        CGContextClosePath(ctx);
        CGContextFillPath(ctx);
        
        int approveRate = (int)ceil(100.0-(rate*100.0));
        
       
        
        if((numReports-approvedReportCount)>1)
        {
            int disApprovedRooms = approveRate/(numReports-approvedReportCount);
            //NSLog(@"approve rate %d,%d,%d",approveRate,disApprovedRooms,(numReports-approvedReportCount));
            //NSLog(@"reports count %d",(numReports-approvedReportCount));
            
            for(int i=0;i<(numReports-approvedReportCount);i++)
            {

                //NSLog(@"snapshot_finish %.2f",snapshot_finish);
                // system capacity
                
                CGContextSetFillColor(ctx, CGColorGetComponents( [[UIColor colorWithRed:250.0/225.0 green:236.0/255.0 blue:208.0/255.0 alpha:1 ] CGColor]));
                CGContextMoveToPoint(ctx, x,y);
                CGContextAddArc(ctx, x, y, 120,  radians(snapshot_finish), radians(snapshot_finish+offset), 0);
                CGContextClosePath(ctx);
                CGContextFillPath(ctx);

               
                /*
                 data capacity */
                CGContextSetFillColor(ctx, CGColorGetComponents( [[UIColor redColor ] CGColor]));
                CGContextMoveToPoint(ctx, x, y);
                CGContextAddArc(ctx, x, y, 120,  radians(snapshot_finish+offset), radians(snapshot_finish+offset+(disApprovedRooms)*360.0/rawCapacity), 0);
                CGContextClosePath(ctx);
                CGContextFillPath(ctx);
                
                snapshot_finish = snapshot_finish+(disApprovedRooms)*360.0/rawCapacity;
                //snapshot_start = snapshot_start + snapshot_finish+offset;
                //snapshot_finish = snapshot_start+snapshot_finish;
            }
            
            CGContextSetFillColor(ctx, CGColorGetComponents( [[UIColor redColor ] CGColor]));
            CGContextMoveToPoint(ctx, x, y);
            CGContextAddArc(ctx, x, y, 120,  radians(snapshot_finish), radians(snapshot_start), 0);
            CGContextClosePath(ctx);
            CGContextFillPath(ctx);
            
        }
        else
        {
            
            /*
             data capacity */
            CGContextSetFillColor(ctx, CGColorGetComponents( [[UIColor redColor ] CGColor]));
            CGContextMoveToPoint(ctx, x, y);
            CGContextAddArc(ctx, x, y, 120,  radians(snapshot_start+snapshot_finish), radians(snapshot_start), 0);
            CGContextClosePath(ctx);
            CGContextFillPath(ctx);
        }
        
        
        //NSLog(@"%f,%f",radians(snapshot_start),radians(snapshot_finish)*(180/PI));
        
        /*float x_coord = x+(100)*cos(radians(snapshot_finish));
         
         float y_coord = y+(100)*sin(radians(snapshot_finish));
         
         float x_coord1 = x+(100)*cos(radians(snapshot_start));
         
         float y_coord1 = y+(100)*sin(radians(snapshot_start));
         
         float x_center = x+(100)*cos(radians((snapshot_start+snapshot_finish)/2));
         
         float y_center = y+(100)*sin(radians((snapshot_start+snapshot_finish)/2));*/
        
        
        
        //NSLog(@"%f,%f,%f,%f,%f,%f,%f,%f",radians(snapshot_start+snapshot_finish),radians(snapshot_start),x_coord,y_coord,x_coord1,y_coord1,x_center,y_center);
        
        //NSLog(@"radians to angle %f,%f",radians(snapshot_finish)*(180.0/PI),radians(snapshot_start)*(180.0/PI));
        
        /*float angle = radians(snapshot_finish)*(180.0/PI);
        
        int approveRate = (int)ceil(100.0-(rate*100.0));
        
        
        
        percentString = [NSString stringWithFormat:@"%d%%",approveRate];
        
        UIFont *percentFont = [UIFont fontWithName:@"Avenir-Medium" size:16.0];
        
        
        NSDictionary *attrsDictionary =
        
        [NSDictionary dictionaryWithObjectsAndKeys:
         percentFont, NSFontAttributeName,
         [NSNumber numberWithFloat:1.0], NSBaselineOffsetAttributeName, nil];
        
        NSString *approvedStr = [NSString stringWithFormat:@"%d%%",100-approveRate];
        
        
        
        NSLog(@"angle %f",angle);
        
        if(angle<=45 && angle>0) {
            
            [approvedStr drawAtPoint:CGPointMake(x+25, y+(ypos-y)/2-16.0) withAttributes:attrsDictionary];
        }
        
        if(angle<=90 && angle>45) {
            
            [approvedStr drawAtPoint:CGPointMake(x+25, y+(ypos-y)/2-16.0) withAttributes:attrsDictionary];
        }
        
        
        
        if(angle<=180 && angle>90) {
            
            [approvedStr drawAtPoint:CGPointMake(x-20, 180) withAttributes:attrsDictionary];
        }
        
        if(angle<=180 && angle>0) {
            
            [percentString drawAtPoint:CGPointMake(x-20, 85) withAttributes:attrsDictionary];
            
            
        }
        
        if(angle>180 && angle<270) {
            
            //NSLog(@" coords %f,%f,%f,%f,%f",x,y,x_coord,y_coord,angle);
            [percentString drawAtPoint:CGPointMake(xpos+(260-xpos)/2-16.0, 85) withAttributes:attrsDictionary];
            [approvedStr drawAtPoint:CGPointMake(xpos+(260-xpos)/2-16.0, 180) withAttributes:attrsDictionary];
            
        }
        
        if(angle>=270 && angle<360) {
            
            //NSLog(@" coords %f,%f,%f,%f,%f",x,y,x_coord,y_coord,angle);
            [percentString drawAtPoint:CGPointMake(175, 85) withAttributes:attrsDictionary];
            
            [approvedStr drawAtPoint:CGPointMake(x, 180) withAttributes:attrsDictionary];
        }
        
        if(y_coord>y)
         [percentString drawAtPoint:CGPointMake((x_coord1-x_coord), y_coord-y) withAttributes:attrsDictionary];*/
        
        
        CGContextDrawImage(ctx, CGRectMake(0, 0, rect.size.width, rect.size.height+100), self.reportImage.CGImage);
    }
}

//draw a pie chart to show total score

-(void) drawChartWithScore:(CGRect)rect {
    
    CGRect parentViewBounds = self.bounds;
    CGFloat x = CGRectGetWidth(parentViewBounds)/2;
    CGFloat y = CGRectGetHeight(parentViewBounds)*0.45;
    
    // Get the graphics context and clear it
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextClearRect(ctx, rect);
    
    // define stroke color
    CGContextSetRGBStrokeColor(ctx, 1, 1, 1, 1.0);
    
    // define line width
    CGContextSetLineWidth(ctx, 4.0);
    
    
    // need some values to draw pie charts
    
    double snapshotCapacity = 100;
    double rawCapacity = 100;
    //double systemCapacity = 1;
    
    //int offset = 5;
    double snapshot_start = 0.0;
    double snapshot_finish = snapshotCapacity *360.0/rawCapacity;
    //double system_finish = systemCapacity*360.0/rawCapacity;
    
    //double snapshot_start = 0;
    //double snapshot_finish = 50;
    
    //NSLog(@"capacity %f,%f,%f,%f,%f",rate*100,x,y,snapshot_start+snapshot_finish,snapshot_start);
    
    //NSLog(@"x,y %f,%f",(x)+100*cos(radians(snapshot_start+snapshot_finish)),y+100*sin(radians(snapshot_start+snapshot_finish)));
    
    
    CGContextSetFillColor(ctx, CGColorGetComponents( [[UIColor colorWithRed:250.0/255.0 green:236.0/255.0 blue:208.0/255.0 alpha:1.0 ] CGColor]));
    CGContextMoveToPoint(ctx, x, y);
    CGContextAddArc(ctx, x, y, 120,  radians(snapshot_start+snapshot_finish), radians(snapshot_start), 0);
    CGContextClosePath(ctx);
    CGContextFillPath(ctx);
    CGContextDrawImage(ctx, CGRectMake(0, 0, rect.size.width, rect.size.height+100), self.ratingImage.CGImage);
        
    percentString = @"Score\n";
    
    float rate_score = (((numReports-approvedReportCount)*1.0)/(numReports*1.0))*10.0;
        
    percentString = [percentString stringByAppendingString:[NSString stringWithFormat:@"  %.1f",(10.0-rate_score)]];
        
    UIFont *percentFont = [UIFont fontWithName:@"AkzidenzGroteskBE-Bold" size:58.0];
        
    UIColor *cleaningTypecolor = [UIColor clearColor];
        

        
    UIColor *cleaningTypeForecolor = [UIColor colorWithRed:246.0/255.0 green:176.0/255.0 blue:4.0/255.0 alpha:1.0];

        
        
    NSDictionary *attrsDictionary =
        
    [NSDictionary dictionaryWithObjectsAndKeys:
         percentFont, NSFontAttributeName,
         [NSNumber numberWithFloat:1.0], NSBaselineOffsetAttributeName,cleaningTypecolor,NSBackgroundColorAttributeName,cleaningTypeForecolor,NSForegroundColorAttributeName, nil];
        
    CGSize strSize = [percentString sizeWithAttributes:attrsDictionary];
        
        
        
    int str_x = round(strSize.width)/2;
    int str_y = round(strSize.height)/2;
        
    //NSLog(@"string size %d,%d",str_x,str_y-5);
        
        
        
    [percentString drawAtPoint:CGPointMake(x-str_x, y-str_y) withAttributes:attrsDictionary];
        
    
        
    CGContextDrawImage(ctx, CGRectMake(0, 0, rect.size.width, rect.size.height+100), self.scoreImage.CGImage);
    
    /*for (NSString* family in [UIFont familyNames])
    {
        NSLog(@"%@", family);
        
        for (NSString* name in [UIFont fontNamesForFamilyName: family])
        {
            NSLog(@"  %@", name);
        }
    }*/
    
}


//saves the pie chart to images
- (void) drawReportImage {
    
    if(chart_style == 1)
    {
        UIGraphicsBeginImageContext(self.bounds.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        [self.layer renderInContext:context];
        self.ratingImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    if(chart_style == 2)
    {
        UIGraphicsBeginImageContext(self.bounds.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        [self.layer renderInContext:context];
        self.reportImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    if(chart_style == 3)
    {
        UIGraphicsBeginImageContext(self.bounds.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        [self.layer renderInContext:context];
        self.scoreImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
}

@end
