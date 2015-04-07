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

@property NSArray*  restData;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.dataTable.delegate = self;
    self.dataTable.dataSource = self;
    
  
    
    [ self setTitle:@"CheeseCake list"];
   

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
      [self getRESTData];
}



#pragma mark - REST/data
-(void) getRESTData
{
    [[AFNetworkingConnect sharedClient] getData:@selector(populateTable:) withView:self];
}

-(void)populateTable:(NSObject *)data
{
    self.restData = (NSArray *) data;
    [self.dataTable  reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - table
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
    }
    
    NSDictionary * currentData = (NSDictionary *) self.restData[indexPath.row];
    
    [UIView transitionWithView:self.view
                    duration:1
                    options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        
                        [self loadCell:cell withData:currentData];
                        
                    } completion:nil];
    
    
    return cell;
}


-(void) loadCell:(TableViewCell*)cell withData:(NSDictionary*)currentData
{
    if([[Utils sharedClient] testDictionaryField:@"image" fromData:currentData])
    {
        NSString *ImageURL = currentData [@"image"];
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:ImageURL]];
        cell.image.image = [UIImage imageWithData:imageData];
    }
    
    if([[Utils sharedClient]  testDictionaryField:@"website" fromData:currentData])
    {
        cell.webSite.text = [NSString stringWithFormat:@"%@ website", [currentData objectForKey:@"website"] ];
    }
    
    
    NSString * date = @"";
    NSString * title = @"";
    
    if([[Utils sharedClient]  testDictionaryField:@"date" fromData:currentData])
    {
        date =currentData [@"date"];
    }
    if([[Utils sharedClient]  testDictionaryField:@"title" fromData:currentData])
    {
        title = currentData [@"title"] ;
    }
    cell.dateTitle.text = [NSString stringWithFormat:@"%@ - %@", date, title ];
    
    
    if([[Utils sharedClient]  testDictionaryField:@"authors" fromData:currentData])
    {
        cell.authorText.text =currentData [@"authors"];
    }

}

#pragma mark - passing Data
- (void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
    if ([sender isKindOfClass:[TableViewCell class]])
    {
        
        if ([segue.destinationViewController isKindOfClass:[DetailViewController class]])
        {
            
            [sender markAsRead];
            DetailViewController *nextViewController = segue.destinationViewController;
            NSIndexPath *path = [self.dataTable indexPathForCell:sender];
            NSDictionary *selectedObject = (NSDictionary *) self.restData[path.row];
            nextViewController.dataObject = selectedObject;
            
        }
    }
}


#pragma mark - Sort list
- (IBAction)chooseKindOfSort:(id)sender {
    UIAlertView * kindsOfSort = [[UIAlertView alloc ]initWithTitle:@"Sort list by "
                                                           message:@"Choose the sort kind"
                                                           delegate:self
                                                           cancelButtonTitle:@"cancel"
                                                           otherButtonTitles:@"Author", @"Date", @"Title", @"Website", nil];
    
    [kindsOfSort show];
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
     NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if([title isEqualToString:@"Author"])
    {
         [self sortByKey:@"authors"];
        
    }else if([title isEqualToString:@"Date"])
    {
        [self sortByKey:@"date"];
    }
    else if([title isEqualToString:@"Title"])
    {
        [self sortByKey:@"title"];
    }
    else if([title isEqualToString:@"Website"])
    {
        [self sortByKey:@"website"];
    }
}

-(void)sortByKey:(NSString *)key
{
    NSArray *unsortedList = [self.restData copy];
    
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:key  ascending:YES];
    
    self.restData= [self.restData sortedArrayUsingDescriptors:[NSArray arrayWithObjects:descriptor,nil]];

    
    [self.dataTable beginUpdates];
    
    NSInteger sourceRow = 0;
    for (NSString *city in unsortedList) {
        NSInteger destRow = [self.restData indexOfObject:city];
        
        if (destRow != sourceRow) {
            NSIndexPath *sourceIndexPath = [NSIndexPath indexPathForItem:sourceRow inSection:0];
            NSIndexPath *destIndexPath = [NSIndexPath indexPathForItem:destRow inSection:0];
            [self.dataTable moveRowAtIndexPath:sourceIndexPath toIndexPath:destIndexPath];
            
        }
        sourceRow++;
    }
    [self.dataTable endUpdates];
}


@end
