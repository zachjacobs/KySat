//
//  ViewController.m
//  PageViewDemo
//
//  Created by Zach Jacobs on 5/19/14.
//  Copyright (c) 2014 Matthew Fahrbach. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Create the data modelOver 200
    _pageTitles = @[@"About Kentucky Space", @"Kentucky Space and Partner Satellites in Orbit", @"Kentucky Space and partner Satellites in Orbit", @"Kentucky Space and Partner Satellites in Orbit", @"Kentucky Space and Partner Satellites in Orbit", @"What can we learn by removing gravity from the equation?", @"Exomedicine Research"];
    _pageStoryImages = @[@"kstransparenthdlogo.png",
                         @"kysat2pic.png",
                         @"tlogoqubepic.png",
                         @"fiftysatpic.png",
                         @"cxbnpic.png",
                         @"exomedlogo.png",
                         @"exomedlogo.png"];
    
    _pageStories = @[@"Kentucky Space LLC is an ambitions, non-profit enterprise focused on R and D, educational, small entrepreneurial and commercial space solutions.\n\n Swipe to continue.",
                     @"KySat-2 (Kentucky Satellite 2)\nLaunched: 11/19/2013 from Wallops Island Virginia\nOrbit: 500 km x 40.6 degree inclination\nKySat-2 is a 1U CubeSat fulfilling the original educational outreach and technology demonstrator goals of KySat-1 while additionally testing an attitude determination system that uses the satellite's existing camera.  The spacecraft transmitted at 437.405 MHz and can be tracked by amateur radio stations.",
                     @"T-LogoQube (Eagle-1):\nLaunched: 11/20/2013 from Yasny Russia\nOrbit: 630 x 490 km at 96 degrees inclination\nT-LogoQube is a technology demonstrator for PocketQube class satellites.",
                     @"$50 Sat (Eagle-2):\nLaunched: 11/20/2013 from Yasny Russia\nOrbit: 630 x 490 km at 96 degrees inclination\n$50 Sat is a demonstrator to create a cost effective platform for engineering and science students for developing real world skills.  Data is transmitted through FM morse code.  $50 sat is a collaborative education project between Professor Bob Twiggs, Morehead State University, and 3 amateur radio operators; Howie DeFelice AB2S, Michael Kirkhard KD8QBA, and Stuart Robinson GW7HPW.",
                     @"CXBN (Cosmic X-Ray Background):\nLaunched: 9/17/2012 from Vandenberg AFB\nOrbit: 385 x 800 km at 60 degrees inclination\nCXBN is a 2U CubeSat built by Kentucky Space partner Morehead State University to measure the cosmic X-Ray background of the universe in the 30 - 50 KeV range.",
                     @"During their evolution over billions of years, the form and function of all organisms on Earth have adapted to the force of Earth's gravity and these characteristics are encoded in their genes: up-down asymmetry, structural strength, size of force-producing elements and sensory systems.  By eliminating gravity, cells molecules, protein crystals, microbes, etc. behave in very different ways.  This presents opportunities to explore new and potentially game-changing discoveries in areas such as human tissue regeneration, drug development and treatements for diseases such as cancer and other life threatening and chronic conditions, as well as energy and novel materials",
                     @"Together with the Exomedicine Institute, Kentucky Space develops and pursues microgravity research initiatives focused on medical solutions.\n\nClick for more information!\n\nwww.exomedicine.com",];
    
    // Create page view controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    
    //set up an array of page content view controllers
    PageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (IBAction)startWalkthrough:(id)sender {
//
//}

- (PageContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.pageTitles count] == 0) || (index >= [self.pageTitles count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    PageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
    pageContentViewController.storyImageFile = self.pageStoryImages[index];
    pageContentViewController.storyTitleText = self.pageTitles[index];
    pageContentViewController.storyText = self.pageStories[index];
    pageContentViewController.pageIndex = index;
    
    return pageContentViewController;
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageTitles count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.pageTitles count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

- (IBAction)startWalkthrough:(id)sender {
    PageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
}
@end
