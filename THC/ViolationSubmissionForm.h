//
//  ViolationSubmissionForm.h
//  THC
//
//  Created by Hunaid Hussain on 7/6/14.
//  Copyright (c) 2014 THC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FXForms.h"
#import "AddressForm.h"

@interface ViolationSubmissionForm : NSObject <FXForm>

@property (strong, nonatomic) NSString       *firstName;
@property (strong, nonatomic) NSString       *lastName;
@property (strong, nonatomic) NSString       *unitNum;
@property (strong, nonatomic) AddressForm    *addressForm;
@property (strong, nonatomic) NSString       *phoneNumber;
@property (strong, nonatomic) NSString       *email;
@property (strong, nonatomic) NSString       *languagesSpoken;

// Removing notes until we find a suitable place/reason to put this back
//@property (strong, nonatomic) NSString       *notes;


@end