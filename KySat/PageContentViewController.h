//
//  PageContentViewController.h
//  PageViewDemo
//
//  Created by Zach Jacobs on 5/19/14.
//  Copyright (c) 2014 Matthew Fahrbach. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageContentViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *storyImageView;
@property (strong, nonatomic) IBOutlet UITextView *storyTextView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *storyImageHeightConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *storyImageWidthConstraint;


@property NSUInteger pageIndex;
@property NSString *backgroundImageFile;
@property NSString *storyImageFile;
@property NSString *storyTitleText;
@property NSString *storyText;

@end
