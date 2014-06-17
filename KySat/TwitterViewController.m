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

//    self.table
    
    self.TableView.backgroundView = nil;
    //self.TableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"newbg1.png"]];
    
    
    self.TableView.backgroundColor = [UIColor darkGrayColor];
    [self refreshTable];
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
    
    NSString *text = [status valueForKey:@"text"];
    NSString *screenName = [status valueForKeyPath:@"user.screen_name"];
    NSString *dateString = [status valueForKey:@"created_at"];

    cell.textLabel.text = text;
    cell.textLabel.textColor = [UIColor lightGrayColor];
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:14.0];
    cell.textLabel.numberOfLines = 0;
    

    cell.detailTextLabel.text = [NSString stringWithFormat:@"@%@ | %@", screenName, dateString];
    cell.backgroundColor = [UIColor clearColor];
    
//    UITapGestureRecognizer *gestureRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openUrl:)];
//    gestureRec.numberOfTouchesRequired = 1;
//    gestureRec.numberOfTapsRequired = 1;
//    [cell addGestureRecognizer:gestureRec];
    [cell setUserInteractionEnabled:YES];
    
    return cell;
}

//TODO: This doesn't actually open a hyperlink just yet 
- (void)openUrl:(id)sender
{
    UIGestureRecognizer *rec = (UIGestureRecognizer *)sender;
    
    id hitLabel = [self.view hitTest:[rec locationInView:self.view] withEvent:UIEventTypeTouches];
    
    if ([hitLabel isKindOfClass:[UITableViewCell class]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:((UILabel *)hitLabel).text]];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //http://stackoverflow.com/a/22235855
    
    NSDictionary *status = [self.statuses objectAtIndex:indexPath.row];
    
    NSString *cellText = [status valueForKey:@"text"];
    UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:14.0];
    
    NSAttributedString *attributedText =
    [[NSAttributedString alloc]
     initWithString:cellText
     attributes:@
     {
     NSFontAttributeName: cellFont
     }];
    CGRect rect = [attributedText boundingRectWithSize:CGSizeMake(self.TableView.bounds.size.width, CGFLOAT_MAX)
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    return rect.size.height + 40;
}

@end
