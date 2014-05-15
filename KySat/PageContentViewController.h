//
//  PageContentViewController.h
//  KySat
//
//  Created by Zach Jacobs on 5/14/14.
//  Copyright (c) 2014 Matthew Fahrbach. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageContentViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UITextField *titleLabel;

@property NSUInteger pageIndex;
@property NSString *titleText;
@property NSString *imageFile;

@end
