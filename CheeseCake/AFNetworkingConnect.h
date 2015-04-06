//
//  AFNetworkingConnect.h
//  CheeseCake
//
//  Created by Matt Ariane Clarke on 04/04/2015.
//  Copyright (c) 2015 Ariane Oliveira. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface AFNetworkingConnect : NSObject

+ (AFNetworkingConnect *)sharedClient;

-(void) getData: (SEL)retrieveData withView: (UIViewController *) view;

@end
