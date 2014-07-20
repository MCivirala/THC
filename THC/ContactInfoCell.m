//
//  ContactInfoCell.m
//  THC
//
//  Created by Nicolas Melo on 7/20/14.
//  Copyright (c) 2014 THC. All rights reserved.
//

#import "ContactInfoCell.h"
#import "ContactInfoButton.h"

@interface ContactInfoCell()
@property (weak, nonatomic) IBOutlet ContactInfoButton *phoneButton;
@property (weak, nonatomic) IBOutlet ContactInfoButton *emailButton;

@end

@implementation ContactInfoCell
- (IBAction)onMakeCall:(id)sender {
}
- (IBAction)onMakeEmail:(id)sender {
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
