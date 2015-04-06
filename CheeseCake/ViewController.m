//
//  ViewController.m
//  CheeseCake
//
//  Created by Matt Ariane Clarke on 03/04/2015.
//  Copyright (c) 2015 Ariane Oliveira. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"

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
        if([[currentData objectForKey:@"image"] isEqual:[NSNull null]])
        {
           // nulo
        }
        else{
            NSString *ImageURL = currentData [@"image"];
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:ImageURL]];
            cell.image.image = [UIImage imageWithData:imageData];

        }

        
    }
    
    if([[currentData allKeys] containsObject:@"content"])
    {
        
    }
    
    if([[currentData allKeys] containsObject:@"website"])
    {
        
    }
    
    NSString * date = @"";
    NSString * title = @"";
    
    if([[currentData allKeys] containsObject:@"date"])
    {
        date =currentData [@"date"];
    }
    
    
    if([[currentData allKeys] containsObject:@"title"])
    {
        title = currentData [@"title"] ;
    }
    
    
    cell.dateTitle.text = [NSString stringWithFormat:@"%@ - %@", date, title ];

    
    if([[currentData allKeys] containsObject:@"authors"])
    {
        cell.authorText.text =currentData [@"authors"];
    }
    
   

    
    NSLog(@" oi  %@  \n \n *****************  \n \n", currentData[@"title"]);
    
    
//    cell.dateTitle.text =
    
   //NSLog(@" oi  %@", self.restData[1]);
    
    return cell;
}



@end
