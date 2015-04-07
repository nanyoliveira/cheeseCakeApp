//
//  ViewController.m
//  CheeseCake
//
//  Created by Matt Ariane Clarke on 03/04/2015.
//  Copyright (c) 2015 Ariane Oliveira. All rights reserved.
//

#import "ViewController.h"
#import "Utils.h"
#import "TableViewCell.h"
#import "DetailViewController.h"

@interface ViewController ()

@property NSMutableArray*  restData;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.dataTable.delegate = self;
    self.dataTable.dataSource = self;
    
    [self getRESTData];
    
    [ self setTitle:@"CheeseCake list"];
   

}

-(void) getRESTData
{
    [[AFNetworkingConnect sharedClient] getData:@selector(populateTable:) withView:self];
}

-(void)populateTable:(NSObject *)data
{
    self.restData = (NSMutableArray *) data;
    [self.dataTable  reloadData];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger) tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.restData count];
}

-(TableViewCell *)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell==nil) {
        cell = [[TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        NSLog(@"cell == nil ");
        
    }
    
    NSDictionary * currentData = (NSDictionary *) self.restData[indexPath.row];
    
    if([[currentData allKeys] containsObject:@"image"])
    {
        if([[Utils sharedClient] testDictionaryField:@"image" fromData:currentData])
        {
            NSString *ImageURL = currentData [@"image"];
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:ImageURL]];
            cell.image.image = [UIImage imageWithData:imageData];

        }

        
    }
    
  
    
    if([[currentData allKeys] containsObject:@"website"])
    {
        if([[Utils sharedClient]  testDictionaryField:@"website" fromData:currentData])
        {
            cell.webSite.text = [NSString stringWithFormat:@"From %@ website", [currentData objectForKey:@"website"] ];

        }
    }
    
    NSString * date = @"";
    NSString * title = @"";
    
    if([[currentData allKeys] containsObject:@"date"])
    {
        
        if([[Utils sharedClient]  testDictionaryField:@"date" fromData:currentData])
        {
            date =currentData [@"date"];
        }
    }
    
    
    if([[currentData allKeys] containsObject:@"title"])
    {
        if([[Utils sharedClient]  testDictionaryField:@"title" fromData:currentData])
        {
            title = currentData [@"title"] ;
        }
    }
    
    
    cell.dateTitle.text = [NSString stringWithFormat:@"%@ - %@", date, title ];

    
    if([[currentData allKeys] containsObject:@"authors"])
    {
        cell.authorText.text =currentData [@"authors"];
    }
    
    
    return cell;
}




- (void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender

{
    
    if ([sender isKindOfClass:[TableViewCell class]])
        
    {
        
        if ([segue.destinationViewController isKindOfClass:[DetailViewController class]])
            
        {
            
            DetailViewController *nextViewController = segue.destinationViewController;
            NSIndexPath *path = [self.dataTable indexPathForCell:sender];
            NSDictionary *selectedObject = (NSDictionary *) self.restData[path.row];
            nextViewController.dataObject = selectedObject;
      
        }
        
    }
    
}


@end
