//
//  KySatViewController.h
//  KySat
//
//  Created by Matthew Fahrbach on 4/2/14.
//  Copyright (c) 2014 Matthew Fahrbach. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KySatViewController : UIViewController

// Outlets from the story board objects

@property (strong, nonatomic) IBOutlet UIImageView *imageViewStatus;
@property (strong, nonatomic) IBOutlet UIButton *topLeftButton;
@property (strong, nonatomic) IBOutlet UIButton *topRightButton;
@property (strong, nonatomic) IBOutlet UIButton *bottomLeftButton;
@property (strong, nonatomic) IBOutlet UIButton *bottomRightButton;
@property (strong, nonatomic) IBOutlet UILabel *currentSatelliteLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topLeftButtonHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLeftButtonHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomRightButtonHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topRightButtonHeight;
@property (weak, nonatomic) IBOutlet UIView *buttonView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonGradientLeftConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonGradientRightConstraint;


// KySatViewController methods
-(void)updateImageView:(NSString*)urlName;
-(void)deselectAllButtons;
-(IBAction)topLeftButtonPressed;
-(IBAction)topRightButtonPressed;
-(IBAction)bottomLeftButtonPressed;
-(IBAction)bottomRightButtonPressed;
- (UIStatusBarStyle)preferredStatusBarStyle;

@end
