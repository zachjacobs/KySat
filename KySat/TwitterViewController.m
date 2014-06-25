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

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"STTwitterTVCellIdentifier"];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"STTwitterTVCellIdentifier"];
    }
    
    NSDictionary *status = [self.statuses objectAtIndex:indexPath.row];
    
//    NSString *text = [status valueForKey:@"text"];


//    cell.textLabel.text = text;
//    cell.textLabel.textColor = [UIColor whiteColor];
//    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:14.0];
//    cell.textLabel.numberOfLines = 0;
    
    
//    NSAttributedString *attributedText =
//    [[NSAttributedString alloc]
//     initWithString:string
//     attributes:@
//     {
//     NSFontAttributeName: [UIFont fontWithName:@"Helvetica" size:14.0]
//     }];
    
//    NSAttributedString *screenNameDateString =
//    [[NSAttributedString alloc]
//     initWithString:[NSString stringWithFormat:@"@%@ | %@", screenName, dateString]
//     attributes:@
//     {
//     NSFontAttributeName: [UIFont fontWithName:@"Helvetica" size:14.0]
//     }];
    
    
    //http://stackoverflow.com/a/22588946
    

    
    
    
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
    
    
    UITextView *textV=[[UITextView alloc] initWithFrame:CGRectMake(0, 0, self.TableView.bounds.size.width, stringSize.size.height+40)];
    
    //Set the following properties to make the links clickable
    textV.editable=NO;
    textV.selectable=YES;
    textV.scrollEnabled=NO;
    textV.dataDetectorTypes = UIDataDetectorTypeLink;
    
    //Don't set a color here, rely on the attributes that were set on the attributed text above
    textV.attributedText = attrString;
    textV.backgroundColor = [UIColor blackColor];
    
    [cell.contentView addSubview:textV];

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //http://stackoverflow.com/a/22235855
    
    NSDictionary *status = [self.statuses objectAtIndex:indexPath.row];
    
//    NSString *cellText = [status valueForKey:@"text"];
//    UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:14.0];
//    
//    NSAttributedString *attributedText =
//    [[NSAttributedString alloc]
//     initWithString:cellText
//     attributes:@
//     {
//     NSFontAttributeName: cellFont
//     }];
//    CGRect rect = [attributedText boundingRectWithSize:CGSizeMake(self.TableView.bounds.size.width, CGFLOAT_MAX)
//                                               options:NSStringDrawingUsesLineFragmentOrigin
//                                               context:nil];
    
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
    
    
    
    return rect.size.height + 40;
}

@end
