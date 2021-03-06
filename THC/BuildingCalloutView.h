//
//  BuildingCalloutView.h
//  THC
//
//  Created by Nicolas Melo on 7/22/14.
//  Copyright (c) 2014 THC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Building;
@interface BuildingCalloutView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *hotelNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *hotelDescriptionLabel;
@property (strong, nonatomic) Building *building;
@property (weak, nonatomic) IBOutlet UILabel *violationsCountLabel;

@end
