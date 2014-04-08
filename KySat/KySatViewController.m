//
//  KySatViewController.m
//  KySat
//
//  Created by Matthew Fahrbach on 4/2/14.
//  Copyright (c) 2014 Matthew Fahrbach. All rights reserved.
//

#import "KySatViewController.h"

@interface KySatViewController ()

@property (nonatomic, strong) NSData *imageData;

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

-(IBAction)topLeftButtonPressed
{
    printf("enter function topLeftButtonPressed\n");
    [self updateImageView:@"http://4.bp.blogspot.com/-KqIn9k3g9ck/UTsdEH8WotI/AAAAAAAAAHY/KBTqD5kiGWw/s1600/animals_beautiful_extraordinary_wild_birds_mad_owl_picture-17.jpg"];
    printf("exit function topLeftButtonPressed\n");
}

-(IBAction)topRightButtonPressed
{
    printf("enter function topRightButtonPressed\n");
    [self updateImageView:@"http://actnowtraining.files.wordpress.com/2012/02/cat.jpg"];
    printf("exit function topRightButtonPressed\n");
}

-(IBAction)bottomLeftButtonPressed
{
    printf("enter function bottomLeftButtonPressed\n");
    [self updateImageView:@"http://static.ddmcdn.com/en-us/apl/breedselector/images/breed-selector/dogs/breeds/border-collie_04_lg.jpg"];
    printf("exit function bottomLeftButtonPressed\n");
}

-(IBAction)bottomRightButtonPressed
{
    printf("enter function bottomRightButtonPressed\n");
    [self updateImageView:@"http://images.nationalgeographic.com/wpf/media-live/photos/000/005/cache/great-white-shark_559_600x450.jpg"];
    printf("exit function bottomRightButtonPressed\n");
}

@end
