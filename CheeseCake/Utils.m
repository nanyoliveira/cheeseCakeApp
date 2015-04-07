//
//  Utils.m
//  CheeseCake
//
//  Created by Matt Ariane Clarke on 07/04/2015.
//  Copyright (c) 2015 Ariane Oliveira. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+ (Utils *)sharedClient {
    
    static Utils *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[self alloc]init];
        
    });
    return _sharedClient;
}


-(BOOL) testDictionaryField: (NSString *)keyName fromData: (NSDictionary *) dataSource
{
    if([[dataSource allKeys] containsObject:keyName])
    {
        
        if([[dataSource objectForKey:keyName] isEqual:[NSNull null]])
        {
            return NO;
        }
        else{
            return YES;
        }
        
    }
    return NO;
}

@end
