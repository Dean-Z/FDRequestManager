//
//  FDHTTPRequestManager.h
//  Aaru
//
//  Created by Jason on 2019/11/23.
//  Copyright © 2019 Jason. All rights reserved.
//

#import "NSMutableURLRequest+FDMutableURLRequest.h"
#import <AFNetworking/AFNetworking.h>
#import <Foundation/Foundation.h>
#import "FDResponed.h"
#import "FDRequest.h"

typedef void (^FDRequestCompletionBlock)(FDResponed *response);

@interface FDHTTPRequestManager : NSObject

@property (nonatomic, strong) AFURLSessionManager *sessionManager;

+ (instancetype)shareManager;
- (void)setup;
- (void)request:(FDRequest *)request completion:(FDRequestCompletionBlock)completion;

@end
