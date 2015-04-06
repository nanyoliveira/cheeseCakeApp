//
//  AFNetworkingConnect.m
//  CheeseCake
//
//  Created by Matt Ariane Clarke on 04/04/2015.
//  Copyright (c) 2015 Ariane Oliveira. All rights reserved.
//

#import "AFNetworkingConnect.h"


NSString *stringURL;
NSURL *url ;
NSURLRequest *request;

@implementation AFNetworkingConnect



+ (AFNetworkingConnect *)sharedClient {
    
    static AFNetworkingConnect *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[self alloc]init];
        stringURL = @"http://www.ckl.io/challenge/";
        url = [NSURL URLWithString:stringURL];
        request = [NSURLRequest requestWithURL:url];
       
    });
    return _sharedClient;
}

-(void) getData: (SEL)retrieveData withView: (UIViewController *) view
{
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [view performSelector:retrieveData withObject:responseObject];

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
        NSLog(@" Error retrieving data from http://www.ckl.io/challenge/ /n Error message: %@", error.description);
    }];
    
    
    [operation start];

}



@end
