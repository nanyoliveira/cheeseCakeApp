//
//  Utils.h
//  CheeseCake
//
//  Created by Matt Ariane Clarke on 07/04/2015.
//  Copyright (c) 2015 Ariane Oliveira. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

+ (Utils *)sharedClient;

-(BOOL) testDictionaryField: (NSString *)keyName fromData: (NSDictionary *) dataSource;

@end
