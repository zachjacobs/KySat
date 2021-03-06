//
//  KySatViewController.m
//  KySat
//
//  Created by Matthew Fahrbach on 4/2/14.
//  Copyright (c) 2014 Matthew Fahrbach. All rights reserved.
//

#import "KySatViewController.h"
#define IS_WIDESCREEN ( [ [ UIScreen mainScreen ] bounds ].size.height == 568 )

@interface KySatViewController ()

@end

@implementation KySatViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //[self preferredStatusBarStyle];
    
    //cache all images here and just display them instead of downloading them everytime.
}

- (void)viewWillLayoutSubviews {

    //must set these programatically to adjust to the button view.  A 3.5-inch screen must squeeze
    //the buttons to ensure that everything will fit.  For some reason, we can't detect the
    //button view height by using self.buttonViewHeight.constraint (it's always 150?)
    //So we detect if we're using a 4" screen.  This is very dependent on the autolayout
    //constraints
    CGFloat buttonViewHeight = 0;
    if(IS_WIDESCREEN)
        buttonViewHeight = 150;
    else
        buttonViewHeight = 134;
    
    self.topLeftButtonHeight.constant = buttonViewHeight/2;
    self.bottomLeftButtonHeight.constant = buttonViewHeight/2;
    self.bottomRightButtonHeight.constant = buttonViewHeight/2;
    self.topRightButtonHeight.constant = buttonViewHeight/2;
    self.buttonGradientLeftConstraint.constant = buttonViewHeight;
    self.buttonGradientRightConstraint.constant = buttonViewHeight;
    
    [super viewWillLayoutSubviews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    //Dispose of images here
}

// updateImageView: urlName
// Displays the image at urlName in the image view.
-(void)updateImageView:(NSString*)urlName
{
    // http://stackoverflow.com/questions/15702608/faster-way-to-load-an-image-from-a-url-and-display-it-in-an-iphone-app
    dispatch_queue_t q = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(q, ^{
        
        
//        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Mainstoryboard"
//                                                                 bundle: nil];
//        //---update the UIViewController---
//        KySatViewController *vc = (KySatViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"KYSatVC"];
        /* Fetch the image from the server... */
        NSURL *url = [NSURL URLWithString:urlName];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *img = [[UIImage alloc] initWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            /* This is the main thread again, where we set the tableView's image to
             be what we just fetched. */
            self.imageViewStatus.image = img;
        });
    });
}

// The buttons have statuses: default, highlighted, selected, etc.
// The display of the button may change with its status.
-(void)deselectAllButtons
{
    [_topLeftButton setSelected:NO];
    [_topRightButton setSelected:NO];
    [_bottomLeftButton setSelected:NO];
    [_bottomRightButton setSelected:NO];
}

-(IBAction)topLeftButtonPressed
{
    [self deselectAllButtons];
    [_topLeftButton setSelected:YES];
    [_currentSatelliteLabel setText:@"Current Satellite: KySat-2"];
    [self updateImageView:@"http://www.heavens-above.com/orbitdisplay.aspx?icon=default&width=1100&height=550&mode=M&satid=39384"];
}

-(IBAction)topRightButtonPressed
{
    [self deselectAllButtons];
    [_topRightButton setSelected:YES];
    [_currentSatelliteLabel setText:@"Current Satellite: T-LogoQube"];
    [self updateImageView:@"http://www.heavens-above.com/orbitdisplay.aspx?icon=default&width=1100&height=550&mode=M&satid=39434"];
}

-(IBAction)bottomLeftButtonPressed
{
    [self deselectAllButtons];
    [_bottomLeftButton setSelected:YES];
    [_currentSatelliteLabel setText:@"Current Satellite: $50 Sat"];
    [self updateImageView:@"http://www.heavens-above.com/orbitdisplay.aspx?icon=default&width=1100&height=550&mode=M&satid=39436"];
}

-(IBAction)bottomRightButtonPressed
{
    [self deselectAllButtons];
    [_bottomRightButton setSelected:YES];
    [_currentSatelliteLabel setText:@"Current Satellite: UniSat-5"];
    [self updateImageView:@"http://www.heavens-above.com/orbitdisplay.aspx?icon=default&width=1100&height=550&mode=M&satid=39421"];
}

// Use the white status bar for this app.
- (UIStatusBarStyle)preferredStatusBarStyle
{
    // http://stackoverflow.com/questions/18977160/change-status-bar-text-colour-from-white-ios-7-xcode-5
    return UIStatusBarStyleLightContent;
}

@end
