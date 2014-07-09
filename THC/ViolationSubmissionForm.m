//
//  ViolationSubmissionForm.m
//  THC
//
//  Created by Hunaid Hussain on 7/6/14.
//  Copyright (c) 2014 THC. All rights reserved.
//

#import "ViolationSubmissionForm.h"
#import "AddressForm.h"
#import "Case.h"
#import "PhotoInfo.h"
#import "Building.h"


#define kFirstName   @{FXFormFieldKey: @"firstName", FXFormFieldTitle:@"First Name:", FXFormFieldHeader: @"Tell us about yourself", @"textField.autocapitalizationType": @(UITextAutocapitalizationTypeWords)}
#define kLastName    @{FXFormFieldKey: @"lastName", FXFormFieldTitle:@"Last Name:", @"textField.autocapitalizationType": @(UITextAutocapitalizationTypeWords)}
#define kUnit        @{FXFormFieldKey: @"unitNum", FXFormFieldTitle:@"Unit Number:"}
#define kAddress     @{FXFormFieldKey: @"addressForm", FXFormFieldTitle:@"Your Address", FXFormFieldInline: @YES, }
#define kPhone       @{FXFormFieldKey: @"phoneNumber", FXFormFieldTitle:@"Phone Number:", FXFormFieldHeader: @"Your Contact Information", FXFormFieldTitle: @"Phone", FXFormFieldType: FXFormFieldTypeNumber}
#define kEmail       @{FXFormFieldKey: @"email", FXFormFieldTitle:@"Email:"}
#define kLanguages   @{FXFormFieldKey: @"languagesSpoken", FXFormFieldTitle:@"Languages Spoken:", FXFormFieldHeader: @"Your Language", FXFormFieldOptions: @[@"English", @"Spanish", @"Chinese", @"Cantonese", @"Vietnamese", @"Fillipino", @"Punjabi", @"Hindi", @"Korean", @"Malay", @"Other"], FXFormFieldCell: [FXFormOptionPickerCell class], FXFormFieldAction: @"addOtherLanguage:"}
#define kOtherLang   @{FXFormFieldKey: @"otherLanguage", FXFormFieldTitle:@"Other Language:"}

#define kSubmit      @{FXFormFieldTitle: @"Submit", FXFormFieldHeader: @"", FXFormFieldHeader: @"", FXFormFieldAction: @"submitViolationSubmissionForm:"}

@implementation ViolationSubmissionForm

- (id)init
{
    if ((self = [super init]))
    {
        
    }
    return self;
}

- (NSArray *)fields
{
    
    NSArray *fieldsArray;
    if (!self.showOtherLanguage) {
        fieldsArray = [NSArray arrayWithObjects:kFirstName, kLastName, kUnit, kAddress, kPhone, kEmail, kLanguages, nil];
    } else {
        fieldsArray = [NSArray arrayWithObjects:kFirstName, kLastName, kUnit, kAddress, kPhone, kEmail, kLanguages, kOtherLang, nil];
    }
    
    return fieldsArray;
 }

- (NSArray *)extraFields
{
    NSArray *extraFieldsArray;
    extraFieldsArray = [NSArray arrayWithObjects:kSubmit, nil];

    return extraFieldsArray;
}

- (void)printFormContents {
    
    NSLog(@"First Name: %@, Last Name: %@", self.firstName, self.lastName);
    NSLog(@"Unit Number: %@", self.unitNum);
    if ([self.addressForm.hotelName isEqualToString:@""]) {
        //NSLog(@"Address Other: %@", self.addressForm.other);
    } else {
    NSLog(@"Address: %@", self.addressForm.hotelName);
    }
    NSLog(@"Phone Number: %@", self.phoneNumber);
    NSLog(@"Email: %@", self.email);
    NSLog(@"Language Spoken %@", self.languagesSpoken);
}

- (void)createCaseWithDescription:(NSString *) description andImageData:(NSData *) imageData {

    
    NSString *userId = nil;
    if ([PFUser currentUser]) {
        userId = [[PFUser currentUser] objectId];
    }
    
//    PFQuery *query = [PFQuery queryWithClassName:@"Building"];
//    [query whereKey:@"buildingName" equalTo:self.addressForm.hotelName];
//    [query findObjectsInBackgroundWithBlock:^(NSArray *buildings, NSError *error) {
//        if (!error) {
//            // The find succeeded.
//            if (buildings.count > 1 || buildings.count == 0) {
//                NSLog(@"Error: Could not find any Hotel with name %@", self.addressForm.hotelName);
//                return;
//            }
//            NSLog(@"Successfully retrieved %lu scores.", (unsigned long)buildings.count);
//            // Do something with the found objects
//            for (PFObject *building in buildings) {
//                NSLog(@"%@", building);
//            }
//        } else {
//            // Log details of the failure
//            NSLog(@"Error: %@ %@", error, [error userInfo]);
//        }
//    }];

    Case* newCase = [Case object];
    
    PhotoInfo* photoInfo = [PhotoInfo object];
    photoInfo.caseId = newCase.objectId;
    photoInfo.caption = nil;
    PFFile *imageFile = [PFFile fileWithName:@"Image.jpg" data:imageData];
    photoInfo.image = imageFile;
    
    //NSLog(@"testPhoto: %@", photoInfo);
    [photoInfo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        if (succeeded) {
            // Create the case and add the image
            //myCase.caseId = @"test1";
            Building *building = self.addressForm.hotelBuildings[self.addressForm.hotelName];
            
            if (building) {
                newCase.buildingId = building.objectId;
                newCase.address = building.streetAddress;
            } else {
                newCase.address = self.addressForm.otherAddress.streetName;
            }
            newCase.name = @"New Case";
            newCase.caseId = newCase.objectId;
            newCase.unit = self.unitNum;
            newCase.phoneNumber = self.phoneNumber;
            newCase.email = self.email;
            newCase.languageSpoken = self.languagesSpoken;
            newCase.description = description;
            newCase.userId = userId;
            newCase.status = caseOpen;
            [newCase saveInBackgroundWithBlock:^(BOOL caseSuccess, NSError *caseError) {
                if (caseSuccess) {
                        [[[UIAlertView alloc] initWithTitle:@"Violation Submitted" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
                } else if (caseError) {
                    [[[UIAlertView alloc] initWithTitle:@"Could not Submit the Case" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];

                }
                
            }];
        } else if (error) {
            [[[UIAlertView alloc] initWithTitle:@"Could not Submit the Photo" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
        }
    }];
    
}

@end
