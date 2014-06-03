//
//  HelpViewController.m
//  KySat
//
//  Created by Zach Jacobs on 6/1/14.
//  Copyright (c) 2014 Matthew Fahrbach. All rights reserved.
//

#import "HelpViewController.h"
#import "KySatAppDelegate.h"

@interface HelpViewController ()

@end

@implementation HelpViewController

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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)helpButtonClick:(id)sender {
    self.tabBarController.selectedIndex = 2;
}

- (IBAction)emailButtonClick:(id)sender {
    NSString *stringURL = @"mailto:tclements@kentuckyspace.com";
    NSURL *url = [NSURL URLWithString:stringURL];
    [[UIApplication sharedApplication] openURL:url];
}


- (IBAction)satTrackerButtonClick:(id)sender {
    self.tabBarController.selectedIndex = 0;
}

- (IBAction)tweetButtonClick:(id)sender {
    self.tabBarController.selectedIndex = 3;
}



@end
