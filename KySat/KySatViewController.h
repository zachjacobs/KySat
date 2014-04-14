//
//  KySatViewController.h
//  KySat
//
//  Created by Matthew Fahrbach on 4/2/14.
//  Copyright (c) 2014 Matthew Fahrbach. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KySatViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *imageViewStatus;
@property (strong, nonatomic) IBOutlet UIButton *topLeftButton;
@property (strong, nonatomic) IBOutlet UIButton *topRightButton;
@property (strong, nonatomic) IBOutlet UIButton *bottomLeftButton;
@property (strong, nonatomic) IBOutlet UIButton *bottomRightButton;

-(void)updateImageView:(NSString*)urlName;
-(void)deselectAllButtons;
-(IBAction)topLeftButtonPressed;
-(IBAction)topRightButtonPressed;
-(IBAction)bottomLeftButtonPressed;
-(IBAction)bottomRightButtonPressed;

@end
