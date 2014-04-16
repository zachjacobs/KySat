//
//  SettingsViewController.h
//  AsyncImageDemo
//
//  Created by Nick Lockwood on 18/10/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController

@property (nonatomic, strong) IBOutlet UISwitch *cacheEnabledSwitch;

- (IBAction)toggleCache:(UISwitch *)sender;

@end
