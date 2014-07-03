//
//  TwitterViewController.m
//  KySat
//
//  Created by Zach Jacobs on 6/2/14.
//  Copyright (c) 2014 Matthew Fahrbach. All rights reserved.
//

#import "TwitterViewController.h"
#import "STTwitter.h"

@interface TwitterViewController ()

@end

@implementation TwitterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars=NO;
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    self.refreshControl = [[UIRefreshControl alloc]init];
    [self.TableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];

    self.TableView.backgroundView = nil;
    //self.TableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"newbg1.png"]];
    
    
    self.TableView.backgroundColor = [UIColor blackColor];
    [self refreshTable];
    
    //used to push the content down below the status bar when the view loads
    self.TableView.contentInset = UIEdgeInsetsMake(20.0f, 0.0f, 0.0f, 0.0f);

}


- (void)refreshTable {
    //TODO: refresh your data
    
    STTwitterAPI *twitter = [STTwitterAPI twitterAPIAppOnlyWithConsumerKey:@"Le898YaM5BluxwdcUQop4w" consumerSecret:@"BRO8RiAPgiFvyR1fh9OXFo6vlYNNy2LelVrmTbwE"];
    [twitter verifyCredentialsWithSuccessBlock:^(NSString *bearerToken) {
        
        NSLog(@"Access granted with %@", bearerToken);
        
        [twitter getUserTimelineWithScreenName:@"kyspace" successBlock:^(NSArray *statuses) {
            NSLog(@"-- statuses: %@", statuses);
            //self.getTimelineStatusLabel.text = [NSString stringWithFormat:@"%lu statuses", (unsigned long)[statuses count]];
            
            self.statuses = statuses;
            
            [self.TableView reloadData];
        } errorBlock:^(NSError *error) {
            NSLog(@"-- error: %@", error);
        }];
        
    } errorBlock:^(NSError *error) {
        NSLog(@"-- error %@", error);
        //self.getTimelineStatusLabel.text = [error localizedDescription];
    }];
    
    
    
    [self.refreshControl endRefreshing];
    [self.TableView reloadData];
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.statuses count];
}

//Generate cell to display rows
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   // UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"STTwitterTVCellIdentifier"];

    //http://stackoverflow.com/a/12706271  use nil for the identifier to create a new cell every time.  This is okay
    //because of how simple our application is
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nil];

    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    }
    
    NSDictionary *status = [self.statuses objectAtIndex:indexPath.row];
    
    
    //Combine two strings into one attributed string:  http://stackoverflow.com/a/22588946

    NSString *statusString = [status valueForKey:@"text"];
    NSString *screenNameString = [status valueForKeyPath:@"user.screen_name"];
    NSString *dateString = [status valueForKey:@"created_at"];
    NSString *detailsString = [NSString stringWithFormat:@"@%@ | %@", screenNameString, dateString];
    
    NSString *yourString = [NSString stringWithFormat:@"%@\n%@", statusString, detailsString];
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:yourString];
    
    [attrString beginEditing];
    [attrString addAttribute:NSFontAttributeName
                       value:[UIFont fontWithName:@"Helvetica" size:14.0]
                       range:NSMakeRange(0, [statusString length])];
    
    [attrString addAttribute:NSForegroundColorAttributeName
                       value:[UIColor whiteColor]
                       range:NSMakeRange(0, [statusString length])];
    
    
    [attrString addAttribute:NSFontAttributeName
                       value:[UIFont fontWithName:@"Helvetica" size:10.0]
                       range:NSMakeRange([statusString length] + 1, [detailsString length])];
    
    [attrString addAttribute:NSForegroundColorAttributeName
                       value:[UIColor grayColor]
                       range:NSMakeRange([statusString length] + 1, [detailsString length])];
    
    [attrString endEditing];
    
    CGRect stringSize = [attrString boundingRectWithSize:CGSizeMake(self.TableView.bounds.size.width, CGFLOAT_MAX)
                                                     options:NSStringDrawingUsesLineFragmentOrigin
                                                     context:nil];
    
    
    UITextView *textV=[[UITextView alloc] initWithFrame:CGRectMake(0, 2, self.TableView.bounds.size.width, stringSize.size.height+30)];
    
    //Set the following properties to make the links clickable
    textV.editable=NO;
    textV.selectable=YES;
    textV.scrollEnabled=NO;
    textV.dataDetectorTypes = UIDataDetectorTypeLink;
    
    //Don't set a color here, rely on the attributes that were set on the attributed text above
    textV.attributedText = attrString;
    textV.backgroundColor = [UIColor blackColor];
    
    [cell.contentView addSubview:nil];
    [cell.contentView addSubview:textV];

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //We set up all of this stuff just to get the cell height.  Might be better to just keep an NSMutableArray of heights for each status
    //but that would probably be difficult to keep in sync
    NSDictionary *status = [self.statuses objectAtIndex:indexPath.row];

    NSString *statusString = [status valueForKey:@"text"];
    NSString *screenNameString = [status valueForKeyPath:@"user.screen_name"];
    NSString *dateString = [status valueForKey:@"created_at"];
    NSString *detailsString = [NSString stringWithFormat:@"@%@ | %@", screenNameString, dateString];
    
    NSString *yourString = [NSString stringWithFormat:@"%@\n%@", statusString, detailsString];
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:yourString];
    
    [attrString beginEditing];
    [attrString addAttribute:NSFontAttributeName
                       value:[UIFont fontWithName:@"Helvetica" size:14.0]
                       range:NSMakeRange(0, [statusString length])];
    
    [attrString addAttribute:NSForegroundColorAttributeName
                       value:[UIColor whiteColor]
                       range:NSMakeRange(0, [statusString length])];
    
    
    [attrString addAttribute:NSFontAttributeName
                       value:[UIFont fontWithName:@"Helvetica" size:10.0]
                       range:NSMakeRange([statusString length] + 1, [detailsString length])];
    
    [attrString addAttribute:NSForegroundColorAttributeName
                       value:[UIColor grayColor]
                       range:NSMakeRange([statusString length] + 1, [detailsString length])];
    
    [attrString endEditing];
    
    CGRect rect = [attrString boundingRectWithSize:CGSizeMake(self.TableView.bounds.size.width, CGFLOAT_MAX)
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                                 context:nil];
    
    return rect.size.height + 30;
}

@end
