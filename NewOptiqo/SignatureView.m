//
//  SignatureView.m
//  NewOptiqo
//
//  Created by Umapathi on 8/27/14.
//  Copyright (c) 2014 Umapathi. All rights reserved.
//

#import "SignatureView.h"

@implementation SignatureView
@synthesize signImage,signPath;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setMultipleTouchEnabled:NO];
        [self setBackgroundColor:[UIColor whiteColor]];
        self.signPath = [UIBezierPath bezierPath];
        [self.signPath setLineWidth:1.5];
        
        //self.transform = CGAffineTransformMakeRotation(M_PI_2);
    }
    return self;
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    //draw by hand
    [self.signImage drawInRect:rect];
    [self.signPath stroke];
    
}

#pragma --mark touch functions to draw and save the lines

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    ctr = 0;
    UITouch *touch = [touches anyObject];
    CGPoint p = [touch locationInView:self];
    [self.signPath moveToPoint:p];
    pnts[0] = [touch locationInView:self];
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    /*CGPoint p = [touch locationInView:self];
    [self.signPath addLineToPoint:p];
    [self setNeedsDisplay];*/
    CGPoint p = [touch locationInView:self];
    ctr++;
    pnts[ctr] = p;
    if (ctr == 4) // 4th point
    {
        pnts[3] = CGPointMake((pnts[2].x + pnts[4].x)/2.0, (pnts[2].y + pnts[4].y)/2.0);
        
        [self.signPath moveToPoint:pnts[0]];
        [self.signPath addCurveToPoint:pnts[3] controlPoint1:pnts[1] controlPoint2:pnts[2]]; // this is how a Bezier curve is appended to a path. We are adding a cubic Bezier from pt[0] to pt[3], with control points pt[1] and pt[2]
        [self setNeedsDisplay];
        //pnts[0] = [self.signPath currentPoint];
        //ctr = 0;
        pnts[0] = pnts[3];
        pnts[1] = pnts[4];
        ctr = 1;
    }
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    

    //UITouch *touch = [touches anyObject];
    //CGPoint p = [touch locationInView:self];
    //[self.signPath addLineToPoint:p];
    [self drawSignImage];
    
    [self setNeedsDisplay];
    pnts[0] = [self.signPath currentPoint]; // let the second endpoint of the current Bezier segment be the first one for the next Bezier segment
    [self.signPath removeAllPoints];
    ctr = 0;
    //[self setNeedsDisplay];
    //[self.signPath removeAllPoints];
    
}

-(void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self touchesEnded:touches withEvent:event];
}

//stores the drawing as image

-(void) drawSignImage {
    
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0.0);
    [[UIColor blackColor] setStroke];
    if (!self.signImage) // first draw; paint background white by ...
    {
        UIBezierPath *rectpath = [UIBezierPath bezierPathWithRect:self.bounds]; // enclosing bitmap by a rectangle defined by another UIBezierPath object
        [[UIColor whiteColor] setFill];
        [rectpath fill]; // filling it with white
    }
    [self.signImage drawAtPoint:CGPointZero];
    [self.signPath stroke];
    self.signImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
}

//clear the drawings

-(void) clearView {
    
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0.0);
    [[UIColor whiteColor] setStroke];
    //if(!self.signImage) // first draw; paint background white by ...
    {
        UIBezierPath *rectpath = [UIBezierPath bezierPathWithRect:self.bounds]; // enclosing bitmap by a rectangle defined by another UIBezierPath object
        [[UIColor whiteColor] setFill];
        [rectpath fill]; // filling it with white
    }
    [self.signImage drawAtPoint:CGPointZero];
    //self.signImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self setNeedsDisplay];
    [self.signPath removeAllPoints];
    
    self.signImage = nil;
}

/*
- (BOOL)shouldAutorotate
{
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}


- (NSUInteger)supportedInterfaceOrientations
{
    
    return UIInterfaceOrientationMaskLandscapeLeft;
}
*/ 

-(void) dealloc {
    
    self.signImage = nil;
    self.signPath = nil;
    
}

@end
