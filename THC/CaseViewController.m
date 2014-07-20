//
//  CaseViewController.m
//  THC
//
//  Created by Nicolas Melo on 7/18/14.
//  Copyright (c) 2014 THC. All rights reserved.
//

#import "CaseViewController.h"
#import "Case.h"
#import "DetailContentTableViewCell.h"
#import "ContactInfoCell.h"
#import "DetailViewTableHeader.h"

@interface CaseViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) Case *caseInfo;
//@property (strong, nonatomic) DetailViewTableHeader *headerView;

@end

@implementation CaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithCase:(Case *)caseInfo {
    
    self.caseInfo = caseInfo;
    return [self initWithNibName:nil bundle:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    UIColor * orangeNavBarColor = [UIColor colorWithRed:255/255.0f green:116/255.0f blue:47/255.0f alpha:1.0f];

    self.navigationController.navigationBar.barTintColor = orangeNavBarColor;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.title = [NSString stringWithFormat:@"Case #%@", self.caseInfo.objectId];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_nav_edit_normal"] style:UIBarButtonItemStylePlain target:self action:@selector(editForm:)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_nav_close_normal"] style:UIBarButtonItemStylePlain target:self action:@selector(dismissView:)];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    UINib *detailNib = [UINib nibWithNibName:@"DetailContentTableViewCell" bundle:nil];
    [self.tableView registerNib:detailNib forCellReuseIdentifier:@"DetailContentTableViewCell"];
    
    UINib *contactNib = [UINib nibWithNibName:@"ContactInfoCell" bundle:nil];
    [self.tableView registerNib:contactNib forCellReuseIdentifier:@"ContactInfoCell"];
    
    UINib *headerNib = [UINib nibWithNibName:@"DetailViewTableHeader" bundle:nil];
//    NSArray *nibs = [headerNib instantiateWithOwner:nil options:nil];
//    self.headerView = nibs[0];
    
    [self.tableView registerNib:headerNib forHeaderFooterViewReuseIdentifier:@"TableHeader"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)editForm:(id)sender {
    
}

- (void)dismissView:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//
//    switch (section) {
//        case 0:
//            return @"Tenant Information";
//        case 1:
//            return @"Hotel Information";
//        case 2:
//            return @"Violation Description";
//        case 3:
//            return @"Attached Photos";
//        case 4:
//            return @"Notes";
//        default:
//            NSLog(@"Not good, we ran out of options.");
//            break;
//    }
//    
//    return @"Bad news...";
//}

//- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
//    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width, 64.0)];
//    //headerView.contentMode = UIViewContentModeScaleToFill;
//    
//    // Add the label
//    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, -14, 300.0, 30.0)];
//    headerLabel.backgroundColor = [UIColor clearColor];
//    headerLabel.opaque = NO;
//    headerLabel.textColor = [UIColor darkGrayColor];
//    headerLabel.highlightedTextColor = [UIColor blackColor];
//    
//    //this is what you asked
//    headerLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:15.0];
//    
//    headerLabel.shadowColor = [UIColor clearColor];
//    headerLabel.shadowOffset = CGSizeMake(0.0, 1.0);
//    headerLabel.numberOfLines = 0;
//    [headerView addSubview: headerLabel];
//    
//    switch (section) {
//        case 0:
//            headerLabel.text = @"Tenant Information";
//            break;
//        case 1:
//            headerLabel.text = @"Hotel Information";
//            break;
//        case 2:
//            headerLabel.text = @"Violation Description";
//            break;
//        case 3:
//            headerLabel.text = @"Attached Photos";
//            break;
//        case 4:
//            headerLabel.text = @"Notes";
//            break;
//        default:
//            NSLog(@"Not good, we ran out of options.");
//            break;
//    }
//    
//    return headerView;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    DetailViewTableHeader *headerView = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:@"TableHeader"];
    
    switch (section) {
        case 0:
            headerView.headerTitleLabel.text = @"Tenant Information";
            break;
        case 1:
            headerView.headerTitleLabel.text = @"Hotel Information";
            break;
        case 2:
            headerView.headerTitleLabel.text = @"Violation Description";
            break;
        case 3:
            headerView.headerTitleLabel.text = @"Attached Photos";
            break;
        case 4:
            headerView.headerTitleLabel.text = @"Notes";
            break;
        default:
            NSLog(@"Not good, we ran out of options.");
            break;
    }
    
//    CGRect frame = CGRectMake(0, 0, 320, 86);
//    headerView.frame = frame;
    
    return headerView;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 90;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section < 2) {
        return 3;
    } else {
        return 1;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            
            DetailContentTableViewCell *detailCell = [self.tableView dequeueReusableCellWithIdentifier:@"DetailContentTableViewCell"];
            detailCell.titleLabel.text = @"Tenant Name";
            detailCell.contentLabel.text = @"Nicolas Melo";
            return detailCell;
            
        } else if (indexPath.row == 1) {
            DetailContentTableViewCell *detailCell = [self.tableView dequeueReusableCellWithIdentifier:@"DetailContentTableViewCell"];
            detailCell.titleLabel.text = @"Tenant Name";
            detailCell.contentLabel.text = @"Nicolas Melo";
            return detailCell;
            
        } else {
            ContactInfoCell *contactInfoCell = [self.tableView dequeueReusableCellWithIdentifier:@"ContactInfoCell"];
            return contactInfoCell;
            
        }
        
    } else if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            DetailContentTableViewCell *detailCell = [self.tableView dequeueReusableCellWithIdentifier:@"DetailContentTableViewCell"];
            detailCell.titleLabel.text = @"Tenant Name";
            detailCell.contentLabel.text = @"Nicolas Melo";
            return detailCell;
            
        } else if (indexPath.row == 1) {
            DetailContentTableViewCell *detailCell = [self.tableView dequeueReusableCellWithIdentifier:@"DetailContentTableViewCell"];
            detailCell.titleLabel.text = @"Tenant Name";
            detailCell.contentLabel.text = @"Nicolas Melo";
            return detailCell;
            
        } else {
            ContactInfoCell *contactInfoCell = [self.tableView dequeueReusableCellWithIdentifier:@"ContactInfoCell"];
            return contactInfoCell;
            
        }
        
    } else if (indexPath.section == 2) {
        DetailContentTableViewCell *detailCell = [self.tableView dequeueReusableCellWithIdentifier:@"DetailContentTableViewCell"];
        detailCell.titleLabel.text = @"Reported 3 months ago";
        detailCell.contentLabel.text = @"Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et.";
        return detailCell;
        
    } else if (indexPath.section == 3) {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        cell.textLabel.text = @"Boom!";
        
        return cell;
        
    } else if (indexPath.section == 4) {
        DetailContentTableViewCell *detailCell = [self.tableView dequeueReusableCellWithIdentifier:@"DetailContentTableViewCell"];
        detailCell.titleLabel.text = @"Tenant Name";
        detailCell.contentLabel.text = @"Nicolas Melo";
        return detailCell;
        
    }

    return nil;
}

@end
