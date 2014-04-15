//
//  KySatViewController.m
//  KySat
//
//  Created by Matthew Fahrbach on 4/2/14.
//  Copyright (c) 2014 Matthew Fahrbach. All rights reserved.
//

#import "KySatViewController.h"

@interface KySatViewController ()

@property (nonatomic) NSInteger *selectedButton;

@end

@implementation KySatViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateImageView:(NSString*)urlName
{
    // http://stackoverflow.com/questions/15702608/faster-way-to-load-an-image-from-a-url-and-display-it-in-an-iphone-app
    dispatch_queue_t q = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(q, ^{
        //---update the UIViewController---
        KySatViewController *vc =
        (KySatViewController *)
        [[[UIApplication sharedApplication] keyWindow]
         rootViewController];
        /* Fetch the image from the server... */
        NSURL *url = [NSURL URLWithString:urlName];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *img = [[UIImage alloc] initWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            /* This is the main thread again, where we set the tableView's image to
             be what we just fetched. */
            vc.imageViewStatus.image = img;
        });
    });
}

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
    [self updateImageView:@"http://www.heavens-above.com/orbitdisplay.aspx?icon=iss&width=600&height=300&mode=M&satid=25544"];
}

-(IBAction)topRightButtonPressed
{
    [self deselectAllButtons];
    [_topRightButton setSelected:YES];
    [_currentSatelliteLabel setText:@"Current Satellite: T-LogoQube"];
    [self updateImageView:@"http://actnowtraining.files.wordpress.com/2012/02/cat.jpg"];
}

-(IBAction)bottomLeftButtonPressed
{
    [self deselectAllButtons];
    [_bottomLeftButton setSelected:YES];
    [_currentSatelliteLabel setText:@"Current Satellite: $50 Sat"];
    [self updateImageView:@"http://static.ddmcdn.com/en-us/apl/breedselector/images/breed-selector/dogs/breeds/border-collie_04_lg.jpg"];
}

-(IBAction)bottomRightButtonPressed
{
    [self deselectAllButtons];
    [_bottomRightButton setSelected:YES];
    [_currentSatelliteLabel setText:@"Current Satellite: UniSat-5"];
    [self updateImageView:@"http://images.nationalgeographic.com/wpf/media-live/photos/000/005/cache/great-white-shark_559_600x450.jpg"];
}

@end
