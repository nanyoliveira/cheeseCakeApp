//
//  TableViewCell.m
//  CheeseCake
//
//  Created by Matt Ariane Clarke on 06/04/2015.
//  Copyright (c) 2015 Ariane Oliveira. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = [UIColor colorWithRed:(245/255.0) green:(245/255.0) blue:(245/255.0) alpha:1];
    self.dateTitle.font = [UIFont boldSystemFontOfSize:16.0f];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


-(void)markAsRead
{
    self.selected = NO;
    self.backgroundColor = [UIColor colorWithRed:(255/255.0) green:(255/255.0) blue:(255/255.0) alpha:1];
    self.dateTitle.font = [UIFont boldSystemFontOfSize:13.0f];
}

@end
