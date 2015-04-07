//
//  DetailViewController.h
//  CheeseCake
//
//  Created by Matt Ariane Clarke on 06/04/2015.
//  Copyright (c) 2015 Ariane Oliveira. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *titleTExt;
@property (weak, nonatomic) IBOutlet UILabel *authorText;
@property (weak, nonatomic) IBOutlet UILabel *dataText;

@property (weak, nonatomic) IBOutlet UITextView *contentText;


@property (strong, nonatomic) NSDictionary* dataObject;

@end
