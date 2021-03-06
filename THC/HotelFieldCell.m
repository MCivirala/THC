//
//  HotelFieldCell.m
//  THC
//
//  Created by Hunaid Hussain on 7/20/14.
//  Copyright (c) 2014 THC. All rights reserved.
//

#import "HotelFieldCell.h"
#import "KxMenu.h"

#define orangeColor [UIColor colorWithRed: 255.0f/255.0f green: 116.0f/255.0f blue: 47.0f/255.0f alpha: 1]

//#define HotelList @[@"English", @"Spanish", @"Chinese", @"Mandarin", @"Vietnami", @"Phillipino", @"Punjabi", @"Hindi", @"Gujrati"]
#define HotelList @[@"Allstar Hotel", @"Boyd Hotel", @"Caldrake Arms Hotel", @"Edgeworth Hotel", @"Elk Hotel", @"Galvin Apartments", @"Graystone Hotel", @"Hartland Hotel", @"Hotel Union", @"Jefferson Hotel", @"Mayfair Hotel", @"Mission Hotel", @"Pierre Hotel", @"Pierre Hotel", @"Raman Hotel", @"Royan Hotel", @"Seneca Hotel", @"Vincent Hotel"]
@implementation HotelFieldCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)getFieldValueFromform {
    if ([self.delegate respondsToSelector:@selector(getValueForField:)]) {
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
            NSString *value = [self.delegate getValueForField:@"selectedHotel"];
            if (value != nil && ![value isEqualToString:@""]) {
                self.hotelLabel.text = value;
            }
//        });
    }
}

- (void)showMenu:(CGRect)frame onView:(UIView *)view forOrientation:(UIInterfaceOrientation) orientation
{
    
    NSArray *hotels = HotelList;
    NSMutableArray *menuItems = [NSMutableArray array];
    
    [menuItems addObject:[KxMenuItem menuItem:@"Select Your Hotel" image:nil target:nil action:nil]];

    for (NSString *hotel in hotels) {
        KxMenuItem *item = [KxMenuItem menuItem:hotel image:nil target:self action:@selector(pushMenuItem:)];
        item.foreColor = [UIColor grayColor];
        item.alignment = NSTextAlignmentCenter;
        [menuItems addObject:item];
    }
    

    KxMenuItem *first = menuItems[0];
    first.foreColor = orangeColor;
//    first.foreColor = [UIColor greenColor];
    
    first.alignment = NSTextAlignmentCenter;

    [KxMenu setTintColor:[UIColor colorWithRed: 230.0f/255.0f green: 230.0f/255.0f blue: 230.0f/255.0f alpha: 1]];
    [KxMenu showMenuInView:view
                  fromRect:frame
                 menuItems:menuItems
            forOrientation:orientation ];
    
}

- (void) pushMenuItem:(id)sender
{
    KxMenuItem *menu = (KxMenuItem *) sender;
    
    self.hotelLabel.text = menu.title;
    self.hotelLabel.textColor = [UIColor blackColor];
    
    if ([self.delegate respondsToSelector:@selector(setValue:forField:)]) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            [self.delegate setValue:menu.title forField:@"selectedHotel"];
        });
    }
    
    [self setNeedsDisplay];
}

@end
