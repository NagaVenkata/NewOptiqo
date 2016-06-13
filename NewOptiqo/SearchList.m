//
//  SearchList.m
//  FindItems
//
//  Created by Umapathi on 8/11/14.
//  Copyright (c) 2014 Umapathi. All rights reserved.
//

#import "SearchList.h"
#import "ViewController.h"

@implementation SearchList

@synthesize langTableView,searchList,searchedString,filterList,delegate,isChoosen;

//used as a sub menu to select the different languages and customer cleaning types

- (id)initWithFrame:(CGRect)frame
{
    self = [super init];
    if (self) {
        // Initialization code
        
        self.view.frame = frame;
        
        ViewController *vc = [ViewController sharedInstance];
        
        if(vc.cleaningType == 1) {
            
            color = [vc.colorArray objectAtIndex:1];
        }
        
        if(vc.cleaningType == 2) {
            
            color = [vc.colorArray objectAtIndex:0];
        }
        
        if([vc.userLanguageSelected isEqualToString:@"Swedish"]) {
            
            labels = [vc.englishLabels valueForKey:@"userswedishlabels"];
        }
        
        if([vc.userLanguageSelected isEqualToString:@"German"]) {
            
            labels = [vc.englishLabels valueForKey:@"usergermanlabels"];
        }
        
        if([vc.userLanguageSelected isEqualToString:@"English"]) {
            
            labels = [vc.englishLabels valueForKey:@"userenglishlabels"];
        }
        
        color = [UIColor blackColor];
        font = [UIFont fontWithName:@"Avenir-Medium" size:16.0];
        
        [self.view setBackgroundColor:[UIColor whiteColor]];
        self.searchList = [[NSMutableArray alloc] initWithObjects:[labels valueForKey:@"english"],[labels valueForKey:@"swedish"],nil];
        
        self.filterList = [[NSMutableArray alloc] initWithObjects:[labels valueForKey:@"english"],[labels valueForKey:@"swedish"], nil];
        
        NSLog(@"frame %f,%f",frame.origin.x,frame.origin.y);
        self.view.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
        [self.view.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        [self.view.layer setBorderWidth:0.5];
        self.langTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width,frame.size.height)];
        
        [self.langTableView setDelegate:self];
        [self.langTableView setDataSource:self];
        
        
        [self.view addSubview:self.langTableView];
        
        
    }
    return self;
}

-(id) initWithFrame:(CGRect)frame withString:(NSString *) searchString {
    
    self = [super init];
    if (self) {
        // Initialization code
        
        ViewController *vc = [ViewController sharedInstance];
        
        self.view.frame = frame;
        
        if(vc.cleaningType == 1) {
            
            color = [vc.colorArray objectAtIndex:1];
        }
        
        if(vc.cleaningType == 2) {
            
            color = [vc.colorArray objectAtIndex:0];
        }
        
        color = [UIColor blackColor];
        font = [UIFont fontWithName:@"Avenir-Medium" size:16.0];

        
        [self.view setBackgroundColor:[UIColor whiteColor]];
        self.searchList = [[NSMutableArray alloc] initWithObjects:[labels valueForKey:@"english"],[labels valueForKey:@"swedish"],nil];

        self.filterList = [[NSMutableArray alloc] initWithObjects:[labels valueForKey:@"english"],[labels valueForKey:@"swedish"],nil];

        
        self.view.frame = CGRectMake(frame.origin.x, frame.size.height+50, 200, 200);
        [self.view.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        [self.view.layer setBorderWidth:0.5];
        self.langTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 200,200)];
        
        [self.langTableView setDelegate:self];
        [self.langTableView setDataSource:self];

        
        [self.view addSubview:self.langTableView];
        
        
    }
    return self;
    
}

-(id) initWithFrame:(CGRect)frame withArray:(NSMutableArray *) array {
    
    self = [super init];
    if (self) {
        // Initialization code
        
        self.view.frame = frame;
        
        ViewController *vc = [ViewController sharedInstance];
        
        if(vc.cleaningType == 1) {
            
            color = [vc.colorArray objectAtIndex:1];
        }
        
        if(vc.cleaningType == 2) {
            
            color = [vc.colorArray objectAtIndex:0];
        }
        
        color = [UIColor blackColor];
        font = [UIFont fontWithName:@"Avenir-Medium" size:16.0];

        
        [self.view setBackgroundColor:[UIColor whiteColor]];
        self.searchList = array;
        
        self.filterList = array;
        
        
        self.view.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
        [self.view.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        [self.view.layer setBorderWidth:0.5];
        self.langTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width,frame.size.height)];
        
        [self.langTableView setDelegate:self];
        [self.langTableView setDataSource:self];
        
        
        [self.view addSubview:self.langTableView];
    }
    return self;
}

#pragma --mark tabel view delegate functions


-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    //NSLog(@"entered data");
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.filterList count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView  dequeueReusableCellWithIdentifier:cellIdentifier];
    
    //sNSLog(@"enetered data");
    
    if(cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithFrame:CGRectZero];
    }
    
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    
    NSString *text = [self.filterList objectAtIndex:indexPath.row];
    
    [cell.textLabel setText:text];
    [cell.textLabel setTextColor:color];
    [cell.textLabel setFont:font];
    
    return  cell;
    
    
    
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.searchedString = [self.filterList objectAtIndex:indexPath.row];
    
    self.isChoosen = YES;

    [self.delegate getSelectedString:self.searchedString];
    
    [self.view setHidden:YES];
    //[self removeFromParentViewController];
}

//returs the option choosed by the user
-(NSString *) getSearchedString {
    
    return self.searchedString;
}

-(BOOL) itemFound:(NSString *)string {
    
    [filterList removeAllObjects];
    
    for(int i=0;i<[searchList count];i++) {
        
        NSString *searchString = [searchList objectAtIndex:i];
        
        NSRange range = [searchString rangeOfString:string];
        if(range.location!=NSNotFound) {
            [self.filterList addObject:searchString];

        }
    }
    
    if([self.filterList count]!=0) {
        
        [self.langTableView reloadData];
        return YES;
        
    }
    
    return NO;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
