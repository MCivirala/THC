//
//  AddressForm.h
//  THC
//
//  Created by Hunaid Hussain on 7/6/14.
//  Copyright (c) 2014 THC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FXForms.h"


@interface AddressForm : NSObject <FXForm>

@property (strong, nonatomic) NSString    *hotelName;
@property (strong, nonatomic) NSString    *other;

@end