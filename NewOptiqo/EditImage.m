//
//  EditImage.m
//  Optiqo Inspect
//
//  Created by Umapathi on 10/9/14.
//  Copyright (c) 2014 Umapathi. All rights reserved.
//

#import "EditImage.h"
#import "ViewController.h"

@implementation EditImage

@synthesize signImage,signPath,retImage;

//draws the image and on top of it draws a transparent to view to draw on it

- (id)initWithFrame:(CGRect)frame withImage:(UIImage *) image
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setMultipleTouchEnabled:NO];
        [self setUserInteractionEnabled:YES];
        //[self setBackgroundColor:[UIColor whiteColor]];
        
        //self.signPath = [UIBezierPath bezierPath];
        //[self.signPath setLineWidth:5.5];

        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        
        //NSLog(@"image in edit image %@",image);
        
        //[self addSubview:imageView];
        
        imageView.image = image;
        
        [imageView setUserInteractionEnabled:YES];
        
        self.retImage = [[UIImage alloc] init];
        
        //editimage = imageView.image;
        
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
        
        [self setViewTitle];
        
        
        [self addSubview:imageView];
        
        MarkImages *markImage = [[MarkImages alloc] initWithFrame:imageView.frame];
        
        [imageView addSubview:markImage];
        
        //[self editImage];
        
        //[self addSubview:imageView];
        
        //self.transform = CGAffineTransformMakeRotation(M_PI_2);
    }
    return self;
}

//sets the view title
-(void) setViewTitle {
    
    ViewController *vc = [ViewController sharedInstance];
    
    for(unsigned long i=[[vc.barView subviews] count]-1;i>=1;i--) {
        
        id viewItem = [[vc.barView subviews] objectAtIndex:i];
        [viewItem removeFromSuperview];
    }
    
    [vc drawRightMenuView];
    
    UILabel *cust_label = [[UILabel alloc] initWithFrame:CGRectMake(25, 25, 250, 32)];
    
    [cust_label setBackgroundColor:[UIColor clearColor]];
    
    [cust_label setText:[labels valueForKey:@"editphoto"]];
    [cust_label setTextColor:[UIColor whiteColor]];
    [cust_label setTextAlignment:NSTextAlignmentCenter];
    [cust_label setFont:[UIFont fontWithName:@"Avenir-Medium" size:18.0]];
    
    [vc.barView addSubview:cust_label];
    
    UIImageView *backImage = (UIImageView *)[[vc.barView subviews] objectAtIndex:0];
    
    backImage.image = [UIImage imageNamed:@"back.png"];
    
    UITapGestureRecognizer *backTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backToCommentsRoom:)];
    
    [backImage addGestureRecognizer:backTap];
    
    

    
}

//back to comments room
-(void) backToCommentsRoom:(id) sender {
    
    ViewController *vc = [ViewController sharedInstance];
    
    CommentsRoom *commentRooms = vc.customerList.roomListView.roomComments.commentsRoom;
    [commentRooms setViewTitle];
    
    //self.frame = CGRectMake(0, 0, 125, 125);
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:imageView.frame];
    
    //imageView.frame = CGRectMake(0, 0, 125, 125);
    
    [self setNeedsDisplay];
    
    [imageView setNeedsDisplay];
    
    imgView.image = [self snapshotImage];
    [imgView setContentMode:UIViewContentModeScaleAspectFit];
    
    [commentRooms addRoomImages:imgView];
    
    id animation = ^{
        
        self.transform = CGAffineTransformMakeTranslation(320, 0);
        
    };
    
    id completion = ^(BOOL finished) {
        
        [self removeFromSuperview];
    };
    
    [UIView animateWithDuration:0.5 animations:animation completion:completion];

    
}

-(void) drawRect:(CGRect)rect {
    
    /*CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextClearRect(ctx, rect);
    
    [imageView drawRect:CGRectMake(0, 0, 125, 125)];
    
    CGContextDrawImage(ctx, CGRectMake(0, 0, rect.size.width, rect.size.height), self.retImage.CGImage);

    UIGraphicsEndImageContext();*/
    
}

- (UIImage *)snapshotImage
{
    //saves the current view as image
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0.0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}

/*-(void) editImage {
    
    
    UIGraphicsBeginImageContext(editimage.size);
    
	// draw original image into the context
	[editimage drawAtPoint:CGPointZero];
    
	// get the context for CoreGraphics
	CGContextRef ctx = UIGraphicsGetCurrentContext();
    
	// set stroking color and draw circle
	[[UIColor redColor] setStroke];
    
	// make circle rect 5 px from border
	CGRect circleRect = CGRectMake(0, 0,
                                   editimage.size.width,
                                   editimage.size.height);
	circleRect = CGRectInset(circleRect, 5, 5);
    
	// draw circle
	CGContextStrokeEllipseInRect(ctx, circleRect);
    
	// make image out of bitmap context
	//UIImage *retImage = UIGraphicsGetImageFromCurrentImageContext();
    
    editimage = UIGraphicsGetImageFromCurrentImageContext();
    
	// free the context
	UIGraphicsEndImageContext();
    
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [[UIColor redColor] setStroke];
    [editimage drawInRect:rect];
    [self.signPath stroke];

    
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint p = [touch locationInView:self];
    [self.signPath moveToPoint:p];
    [self drawSignImage];
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint p = [touch locationInView:self];
    [self.signPath addLineToPoint:p];
    [self setNeedsDisplay];
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    
    UITouch *touch = [touches anyObject];
    CGPoint p = [touch locationInView:self];
    [self.signPath addLineToPoint:p];

    //[self drawSignImage];
    //[self setNeedsDisplay];
    //[self.signPath removeAllPoints];
    
}

-(void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self touchesEnded:touches withEvent:event];
}

-(void) drawSignImage {
    
    UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, YES, 0.0);
    [[UIColor redColor] setStroke];
    if (!retImage) // first draw; paint background white by ...
    {
        NSLog(@"entered");
        UIBezierPath *rectpath = [UIBezierPath bezierPathWithRect:imageView.bounds]; // enclosing bitmap by a rectangle defined by another UIBezierPath object
        [[UIColor whiteColor] setFill];
         
        [rectpath fill]; // filling it with white
        //self.retImage = editimage;
    }
    [editimage drawAtPoint:CGPointZero];
    [self.signPath stroke];
    self.retImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //[imageView setNeedsDisplay];
    
    
}

-(void) clearView {
    
    UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, YES, 0.0);
    [[UIColor whiteColor] setStroke];
    //if(!self.signImage) // first draw; paint background white by ...
    {
        UIBezierPath *rectpath = [UIBezierPath bezierPathWithRect:imageView.bounds]; // enclosing bitmap by a rectangle defined by another UIBezierPath object
        [[UIColor colorWithWhite:1.0 alpha:0.0] setFill];
        [rectpath fill]; // filling it with white
    }
    [editimage drawAtPoint:CGPointZero];
    self.retImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    [imageView setNeedsDisplay];
    [self.signPath removeAllPoints];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
