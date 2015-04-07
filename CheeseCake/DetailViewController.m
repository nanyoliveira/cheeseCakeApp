//
//  DetailViewController.m
//  CheeseCake
//
//  Created by Matt Ariane Clarke on 06/04/2015.
//  Copyright (c) 2015 Ariane Oliveira. All rights reserved.
//

#import "DetailViewController.h"
#import "Utils.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setData];
}


-(void)setData
{
    
    if([[self.dataObject allKeys] containsObject:@"image"])
    {
        if([[Utils sharedClient] testDictionaryField:@"image" fromData:self.dataObject])
        {
            NSString *ImageURL = self.dataObject [@"image"];
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:ImageURL]];
            self.image.image = [UIImage imageWithData:imageData];
            
        }
        
        
    }
    
    NSString * date = @"";
    NSString * website = @"";

    if([[self.dataObject allKeys] containsObject:@"date"])
    {
        
        if([[Utils sharedClient]  testDictionaryField:@"date" fromData:self.dataObject])
        {
            date =self.dataObject [@"date"];
        }
    }

    
    if([[self.dataObject allKeys] containsObject:@"website"])
    {
        if([[Utils sharedClient]  testDictionaryField:@"website" fromData:self.dataObject])
        {
            
            website = self.dataObject [@"website"];
            
        }
    }
    self.dataText.text = [NSString stringWithFormat:@"%@ | %@ website", date, website];
    
    
    
    if([[self.dataObject allKeys] containsObject:@"title"])
    {
        if([[Utils sharedClient]  testDictionaryField:@"title" fromData:self.dataObject])
        {
            self.titleTExt.text = self.dataObject [@"title"] ;
        }
    }
    
    
    if([[self.dataObject allKeys] containsObject:@"content"])
    {
        if([[Utils sharedClient] testDictionaryField:@"content" fromData:self.dataObject])
        {
            self.contentText.text = self.dataObject [@"content"] ;
            
        }
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
