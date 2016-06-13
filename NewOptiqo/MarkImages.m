//
//  UIView+MarkImages.m
//  Optiqo Inspect
//
//  Created by Umapathi on 30/03/15.
//  Copyright (c) 2015 Umapathi. All rights reserved.
//

#import "MarkImages.h"

@implementation MarkImages

//draws on top of image and can hand draw to comment the divergance on image

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.frame = frame;
        // Initialization code
        [self setMultipleTouchEnabled:NO];
        //[self setBackgroundColor:[UIColor whiteColor]];
        
        self.signPath = [UIBezierPath bezierPath];
        [self.signPath setLineWidth:5.5];
        
        self.opaque = NO;
        
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}






// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [[UIColor redColor] setStroke];
    [self.signPath stroke];
    
    /*CGRect box = CGRectInset(self.bounds, self.bounds.size.width * 0.1f, self.bounds.size.height * 0.1f);
    UIBezierPath *ballBezierPath = [UIBezierPath bezierPathWithOvalInRect:box];
    [[UIColor whiteColor] setStroke];
    [[UIColor greenColor] setFill]; // Green here to show the black area
    [ballBezierPath stroke];*/
    //[ballBezierPath fill];
    
    
}

#pragma --mark draws the comments with hand draw

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
    
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0.0);
    [[UIColor redColor] setStroke];
    UIGraphicsEndImageContext();
    //[imageView setNeedsDisplay];
    
    
}

@end
