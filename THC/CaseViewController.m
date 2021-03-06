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
#import "ContactInfoButton.h"
#import "DetailFooterView.h"
#import "ViolationSubmissionViewController.h"
#import "SendEmailButton.h"
#import "DetailPhotoCell.h"
#import "PhotoInfo.h"

#import <MessageUI/MFMailComposeViewController.h>

@interface CaseViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) Case *caseInfo;
@property (strong, nonatomic) DetailViewTableHeader *offscreenHeaderView;
@property (strong, nonatomic) DetailContentTableViewCell *offscreenDetailCell;
@property (strong, nonatomic) ContactInfoCell *offscreenContactDetailCell;
@property (strong, nonatomic) DetailPhotoCell *offscreenPhotoCell;
@property (strong, nonatomic) DetailFooterView *footerView;
@property (strong, nonatomic) UIImage *emailImageNormal;
@property (strong, nonatomic) UIImage *emailImagePressed;
@property (strong, nonatomic) UIImage *phoneImageNormal;
@property (strong, nonatomic) UIImage *phoneImagePressed;
@property (strong, nonatomic) UIImage *cachedPhoto;

@end

@implementation CaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.emailImageNormal = [UIImage imageNamed:@"ic_nav_email_normal"];
        self.emailImagePressed = [UIImage imageNamed:@"ic_nav_email_pressed"];
        self.phoneImageNormal = [UIImage imageNamed:@"ic_nav_phone_normal"];
        self.phoneImagePressed = [UIImage imageNamed:@"ic_nav_phone_pressed"];
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
    
    // Detail cells
    UINib *detailNib = [UINib nibWithNibName:@"DetailContentTableViewCell" bundle:nil];
    NSArray *detailNibs = [detailNib instantiateWithOwner:nil options:nil];
    self.offscreenDetailCell = detailNibs[0];
    [self.tableView registerNib:detailNib forCellReuseIdentifier:@"DetailContentTableViewCell"];
    
    
    // Email and Phone button cells
    UINib *contactNib = [UINib nibWithNibName:@"ContactInfoCell" bundle:nil];
    NSArray *contactNibs = [contactNib instantiateWithOwner:nil options:nil];
    self.offscreenContactDetailCell = contactNibs[0];
    [self.tableView registerNib:contactNib forCellReuseIdentifier:@"ContactInfoCell"];
    
    
    // Header views
    UINib *headerNib = [UINib nibWithNibName:@"DetailViewTableHeader" bundle:nil];
    NSArray *nibs = [headerNib instantiateWithOwner:nil options:nil];
    self.offscreenHeaderView = nibs[0];
    [self.tableView registerNib:headerNib forHeaderFooterViewReuseIdentifier:@"TableHeader"];
    
    UINib *footerNib = [UINib nibWithNibName:@"DetailFooterView" bundle:nil];
    NSArray *footerNibs = [footerNib instantiateWithOwner:nil options:nil];
    self.footerView = footerNibs[0];
    [self.footerView.sendEmailButton addTarget:self action:@selector(sendEmail:) forControlEvents:UIControlEventTouchUpInside];
    
    UINib *detailPhotoNib = [UINib nibWithNibName:@"DetailPhotoCell" bundle:nil];
    NSArray *detailPhotoNibs = [detailPhotoNib instantiateWithOwner:nil options:nil];
    self.offscreenPhotoCell = detailPhotoNibs[0];
    [self.tableView registerNib:detailPhotoNib forCellReuseIdentifier:@"PhotoCell"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)sendEmail:(id)sender {
    MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
    controller.mailComposeDelegate = self;
    [controller setSubject:[NSString stringWithFormat:@"Case #%@", self.caseInfo.objectId]];
    [controller setMessageBody:[NSString stringWithFormat:@"Description:\n%@", self.caseInfo.violationDetails] isHTML:NO];
    [controller setToRecipients:@[@"issues@thc.org"]];
    
    if (self.cachedPhoto) {
    
        [controller addAttachmentData:UIImageJPEGRepresentation(self.cachedPhoto, 1) mimeType:@"image/jpeg" fileName:@"Photo.jpeg"];
    }
    if (controller) {
        [self presentViewController:controller animated:YES completion:nil];
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error;
{
    if (result == MFMailComposeResultSent) {
        NSLog(@"It's away!");
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)editForm:(id)sender {
    
    ViolationSubmissionViewController *vsc = [[ViolationSubmissionViewController alloc] init];
    ViolationForm *violationForm = [[ViolationForm alloc] init];
    [violationForm setCase:self.caseInfo];
    
    [vsc setPrefilledForm:violationForm];
    
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vsc];
    nvc.navigationBar.barTintColor = [UIColor colorWithRed: 1 green: 0.455f blue: 0.184f alpha: 1];
    
    [self presentViewController:nvc animated:YES completion:nil];
    
}

- (void)dismissView:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    [self.offscreenHeaderView layoutSubviews];
    CGFloat height = [self.offscreenHeaderView.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    NSLog(@"Height of header view: %f", height);
    
    return height + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    // last section gets an email button
    if (section == 4) {
        [self.footerView layoutSubviews];
        CGFloat height = [self.footerView.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        return height + 1;
    }
    
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (section == 4) {
        return self.footerView;
    }
    
    
    return [[UIView alloc] initWithFrame:CGRectZero];
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
    
    return headerView;
    
}

- (void)configureDetailCell:(DetailContentTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {

            cell.titleLabel.text = @"Tenant Name";
            cell.contentLabel.text = self.caseInfo.name;
            
        } else if (indexPath.row == 1) {
            cell.titleLabel.text = @"Language Spoken";
            cell.contentLabel.text = self.caseInfo.languageSpoken;
            
        }
        
    } else if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            cell.titleLabel.text = @"Hotel";
            cell.contentLabel.text = @"Allstar Hotel";
            
        } else if (indexPath.row == 1) {
            cell.titleLabel.text = @"Address";
            cell.contentLabel.text = self.caseInfo.address;
            
        }
        
    } else if (indexPath.section == 2) {
        cell.titleLabel.text = @"Reported 3 months ago";
        cell.contentLabel.text = self.caseInfo.violationDetails;
        
    } else if (indexPath.section == 4) {
        cell.titleLabel.text = @"Notes";
        cell.contentLabel.text = self.caseInfo.violationDetails;
    }
}

- (void)configurePhotoCell:(DetailPhotoCell *)cell {
    
    NSArray *photos = self.caseInfo.photoIdList;
    if (photos && photos.count > 0) {
        
        PFQuery *query = [PhotoInfo query];
        [query whereKey:@"objectId" equalTo:photos[0]];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                if (objects.count > 0) {
                    PhotoInfo* photoObject = objects[0];
                    PFFile *photo = photoObject.image;
                    [photo getDataInBackgroundWithBlock:^(NSData *data, NSError *photoError) {
                        if (!photoError) {
                            NSData *imageData = data;
//                            UIImage *image = [UIImage imageWithData:imageData];
                            UIImage *image = [UIImage imageWithData:imageData];

                            image = [UIImage imageWithCGImage:image.CGImage
                                                                 scale:1
                                                           orientation:photoObject.orientation];
                            self.cachedPhoto = image;
                            cell.photoImageView.image = image;
                            
                            CGRectMake(cell.photoImageView.frame.origin.x, cell.photoImageView.frame.origin.y,
                                       320, 240);
                            
                            
                            cell.photoImageView.contentMode = UIViewContentModeScaleAspectFill;
                        } else {
                            NSLog(@"Failed to get photo.");
                        }
                    }];
                }
            }
        }];
        
    } else {
        cell.photoImageView.image = [UIImage imageNamed:@"default-568h"];
    }
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ((indexPath.section == 0 && indexPath.row == 2) || (indexPath.section == 1 && indexPath.row == 2)) {
        [self.offscreenContactDetailCell layoutSubviews];
        CGFloat height = [self.offscreenContactDetailCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        NSLog(@"Layout email and phone buttons at height %f", height);
        return height + 1;
    } else if (indexPath.section == 3) {
        
//        [self configurePhotoCell:self.offscreenPhotoCell];
//        self.offscreenPhotoCell.photoImageView.image = [UIImage imageNamed:@"default-568h"];
//        [self.offscreenPhotoCell layoutSubviews];
//        CGFloat height = [self.offscreenPhotoCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
//        
//        NSLog(@"Photos with height %f", height);
//        return height + 1;
        return 241;
    }
    
    [self configureDetailCell:self.offscreenDetailCell forRowAtIndexPath:indexPath];
    [self.offscreenDetailCell layoutSubviews];
    CGFloat height = [self.offscreenDetailCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    NSLog(@"Layout detail cells at height %f", height);
    return height + 1;
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
            [self configureDetailCell:detailCell forRowAtIndexPath:indexPath];
            return detailCell;
            
        } else if (indexPath.row == 1) {
            DetailContentTableViewCell *detailCell = [self.tableView dequeueReusableCellWithIdentifier:@"DetailContentTableViewCell"];
            [self configureDetailCell:detailCell forRowAtIndexPath:indexPath];
            return detailCell;
            
        } else {
            ContactInfoCell *contactInfoCell = [self.tableView dequeueReusableCellWithIdentifier:@"ContactInfoCell"];
            return contactInfoCell;
            
        }
        
    } else if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            DetailContentTableViewCell *detailCell = [self.tableView dequeueReusableCellWithIdentifier:@"DetailContentTableViewCell"];
            [self configureDetailCell:detailCell forRowAtIndexPath:indexPath];
            return detailCell;
            
        } else if (indexPath.row == 1) {
            DetailContentTableViewCell *detailCell = [self.tableView dequeueReusableCellWithIdentifier:@"DetailContentTableViewCell"];
            [self configureDetailCell:detailCell forRowAtIndexPath:indexPath];
            return detailCell;
            
        } else {
            ContactInfoCell *contactInfoCell = [self.tableView dequeueReusableCellWithIdentifier:@"ContactInfoCell"];
            return contactInfoCell;
            
        }
        
    } else if (indexPath.section == 2) {
        DetailContentTableViewCell *detailCell = [self.tableView dequeueReusableCellWithIdentifier:@"DetailContentTableViewCell"];
        [self configureDetailCell:detailCell forRowAtIndexPath:indexPath];
        return detailCell;
        
    } else if (indexPath.section == 3) {
        DetailPhotoCell *photoCell = [self.tableView dequeueReusableCellWithIdentifier:@"PhotoCell"];
        [self configurePhotoCell:photoCell];
        return photoCell;
        
    } else if (indexPath.section == 4) {
        DetailContentTableViewCell *detailCell = [self.tableView dequeueReusableCellWithIdentifier:@"DetailContentTableViewCell"];
        [self configureDetailCell:detailCell forRowAtIndexPath:indexPath];
        return detailCell;
        
    }

    return nil;
}

@end
