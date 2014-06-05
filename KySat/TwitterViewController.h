//
//  TwitterViewController.h
//  KySat
//
//  Created by Zach Jacobs on 6/2/14.
//  Copyright (c) 2014 Matthew Fahrbach. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TwitterViewController : UITableViewController

@property (nonatomic, strong) NSArray *statuses;
@property (strong, nonatomic) IBOutlet UITableView *TableView;

@end
