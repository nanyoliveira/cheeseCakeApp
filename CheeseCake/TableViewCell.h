//
//  TableViewCell.h
//  CheeseCake
//
//  Created by Matt Ariane Clarke on 06/04/2015.
//  Copyright (c) 2015 Ariane Oliveira. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *webSite;
@property (weak, nonatomic) IBOutlet UILabel *dateTitle;

@property (weak, nonatomic) IBOutlet UILabel *authorText;
@property (weak, nonatomic) IBOutlet UIImageView *image;



-(void)markAsRead;

@end
