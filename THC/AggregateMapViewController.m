//
//  AggregateMapViewController.m
//  THC
//
//  Created by Nicolas Melo on 7/3/14.
//  Copyright (c) 2014 THC. All rights reserved.
//

#import "AggregateMapViewController.h"
#import <MapKit/MapKit.h>
#import "LoginViewController.h"
#import "SignupViewController.h"
#import <Parse/Parse.h>

@interface AggregateMapViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *signupButton;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tapGestureRecognizer;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation AggregateMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.loginButton = [[UIButton alloc] init];
        self.loginButton.hidden = NO;
        self.loginButton.enabled = YES;
    }
    return self;
}
- (IBAction)onLogin:(id)sender {
    LoginViewController *loginViewController = [[LoginViewController alloc] init];
    [self presentViewController:loginViewController animated:YES completion:nil];
    
}
- (IBAction)onSignup:(id)sender {
    SignupViewController *signupViewController = [[SignupViewController alloc] init];
    [self presentViewController:signupViewController animated:YES completion:nil];
}

-(void)zoomInToTenderloin
{
    MKCoordinateRegion region = { {0.0, 0.0 }, { 0.0, 0.0 } };
    region.center.latitude = 37.785134;
    region.center.longitude = -122.412752;
    
    region.span.longitudeDelta = 0.03f;
    region.span.latitudeDelta = 0.03f;
    [self.mapView setRegion:region animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self zoomInToTenderloin];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        NSLog(@"Logged in user %@", currentUser.username);
        self.signupButton.hidden = YES;
        [self.loginButton setTitle:@"Cases" forState:UIControlStateNormal];
        [self.loginButton removeTarget:self action:@selector(onLogin:) forControlEvents:UIControlEventTouchUpInside];
        [self.loginButton addTarget:self action:@selector(onCaseMenu:) forControlEvents:UIControlEventTouchUpInside];
        
    } else {
        NSLog(@"No user logged in.");
        [self.loginButton setTitle:@"Login" forState:UIControlStateNormal];
        [self.loginButton removeTarget:self action:@selector(onCaseMenu:) forControlEvents:UIControlEventTouchUpInside];
        [self.loginButton addTarget:self action:@selector(onLogin:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onNewReport:(id)sender {
    NSLog(@"Create new report.");
}

- (void)onCaseMenu:(id)sender {
    NSLog(@"Load case menu.");
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
}

- (IBAction)onTap:(UITapGestureRecognizer *)sender {
    [self.searchBar resignFirstResponder];
}


@end
