//
//  PageContentViewController.m
//  PageViewDemo
//
//  Created by Zach Jacobs on 5/19/14.
//  Copyright (c) 2014 Matthew Fahrbach. All rights reserved.
//

#import "PageContentViewController.h"

@interface PageContentViewController ()

@end

@implementation PageContentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIPageControl *pageControl = [UIPageControl appearance];
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    pageControl.backgroundColor = [UIColor clearColor];
    
    //Refresh all UI elements on the view that loaded
    //self.backgroundImageView.image = [UIImage imageNamed:self.backgroundImageFile];
    //Set the titleLabel to wrap if the titles are too long
    self.storyImageView.image = [UIImage imageNamed:self.storyImageFile];
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.text = self.storyTitleText;
    self.storyTextView.text = self.storyText;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
