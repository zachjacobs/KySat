//
//  KySatAppDelegate.m
//  KySat
//
//  Created by Matthew Fahrbach on 4/2/14.
//  Copyright (c) 2014 Matthew Fahrbach. All rights reserved.
//
//  Resources:
//  - http://mobiforge.com/design-development/using-background-fetch-ios
//  - http://stackoverflow.com/questions/11757107/ios-how-to-handle-images
//  - http://stackoverflow.com/questions/15702608/faster-way-to-load-an-image-from-a-url-and-display-it-in-an-iphone-app
//  - https://github.com/nicklockwood/AsyncImageView
//  - http://www.heavens-above.com/orbit.aspx?satid=25544&lat=0&lng=0&loc=Unspecified&alt=0&tz=UCT

#import "KySatAppDelegate.h"
#import "KySatViewController.h"

@interface KySatAppDelegate ()

@property (nonatomic, strong) NSString *temperature;
@property (nonatomic, strong) NSData *imageData;

@end

@implementation KySatAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[UIApplication sharedApplication]
        setMinimumBackgroundFetchInterval:
     UIApplicationBackgroundFetchIntervalMinimum];

    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    printf("enter function\n");
    // MCF: Attempting to update the image whenever the app will enter the foreground
    // http://stackoverflow.com/questions/15702608/faster-way-to-load-an-image-from-a-url-and-display-it-in-an-iphone-app
    dispatch_queue_t q = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(q, ^{
        //---update the UIViewController---
        KySatViewController *vc =
        (KySatViewController *)
        [[[UIApplication sharedApplication] keyWindow]
         rootViewController];
        /* Fetch the image from the server... */
        NSURL *url = [NSURL URLWithString:@"http://www.heavens-above.com/orbitdisplay.aspx?icon=iss&width=600&height=300&mode=M&satid=25544"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *img = [[UIImage alloc] initWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            /* This is the main thread again, where we set the tableView's image to
             be what we just fetched. */
            vc.imageViewStatus.image = img;
        });
    });
    printf("exit function\n");
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end









