//
//  SearchList.h
//  FindItems
//
//  Created by Umapathi on 8/11/14.
//  Copyright (c) 2014 Umapathi. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol SearchListDelegate <NSObject>
@optional
-(void) getSelectedString:(NSString *) searchString;

@end

@interface SearchList : UIViewController<UITableViewDataSource,UITableViewDelegate> {
    
    
    UIColor *color;
    UIFont *font;
    
    NSDictionary *labels;
    
}

@property (nonatomic,strong) UITableView *langTableView;
@property (nonatomic,strong) NSMutableArray *searchList;
@property (nonatomic,strong) NSMutableArray *filterList;
@property (nonatomic,strong) NSString *searchedString;
@property (nonatomic,retain) id delegate;
@property (readwrite) BOOL isChoosen;

//initialize the view with different options
- (id)initWithFrame:(CGRect)frame;

-(id) initWithFrame:(CGRect)frame withString:(NSString *) searchString;
-(id) initWithFrame:(CGRect)frame withArray:(NSMutableArray *) array;


-(NSString *) getSearchedString;
-(BOOL) itemFound:(NSString *) searchedString;


@end
