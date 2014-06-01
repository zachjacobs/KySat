//
//  ViewController.h
//  PageViewDemo
//
//  Created by Zach Jacobs on 5/19/14.
//  Copyright (c) 2014 Matthew Fahrbach. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageContentViewController.h"

@interface ViewController : UIViewController <UIPageViewControllerDataSource>

- (IBAction)startWalkthrough:(id)sender;

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageTitles;
@property (strong, nonatomic) NSArray *pageStoryImages;
@property (strong, nonatomic) NSArray *pageStories;
@end
