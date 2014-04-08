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

-(void)updateImageView:(NSString*)urlName;
-(IBAction)topLeftButtonPressed;
-(IBAction)topRightButtonPressed;
-(IBAction)bottomLeftButtonPressed;
-(IBAction)bottomRightButtonPressed;

@end
