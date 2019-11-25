//
//  NSMutableURLRequest+FDMutableURLRequest.h
//  Aaru
//
//  Created by Jason on 2019/11/23.
//  Copyright © 2019 Jason. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "FDRequest.h"

@interface NSMutableURLRequest (FDMutableURLRequest)

+ (NSMutableURLRequest *)URLRequest:(FDRequest *)request;
+ (NSMutableURLRequest *)URLRequest:(FDRequest *)request headers:(NSDictionary *)headers;

@end

