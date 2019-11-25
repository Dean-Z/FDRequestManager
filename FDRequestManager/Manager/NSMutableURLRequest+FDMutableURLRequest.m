//
//  NSMutableURLRequest+FDMutableURLRequest.m
//  Aaru
//
//  Created by Jason on 2019/11/23.
//  Copyright © 2019 Jason. All rights reserved.
//

#import "NSMutableURLRequest+FDMutableURLRequest.h"
#import <AFNetworking/AFNetworking.h>

NSString * stringForMethod(FDRqueestMethod method) {
    switch (method) {
        case FDRequestMethodGET:
            return @"GET";
        case FDRequestMethodPOST:
            return @"POST";
        case FDRequestMethodPUT:
            return @"PUT";
        case FDRequestMethodDELETE:
            return @"DELETE";
        case FDRequestMethodHEAD:
            return @"HEAD";
        case FDRequestMethodPATCH:
            return @"PATCH";
        default:
            return @"GET";
    }
}

@implementation NSMutableURLRequest (FDMutableURLRequest)

+ (NSMutableURLRequest *)URLRequest:(FDRequest *)request {
    return [self URLRequest:request headers:nil];
}

+ (NSMutableURLRequest *)URLRequest:(FDRequest *)request headers:(NSDictionary *)headers {
    static AFHTTPRequestSerializer *serializer;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        serializer = [[AFHTTPRequestSerializer alloc]init];
    });
    NSMutableURLRequest *req = nil;
    NSError *error = nil;
    req = [serializer requestWithMethod:stringForMethod(request.method)
                              URLString:request.urlString
                             parameters:request.params
                                  error:&error];
    NSParameterAssert(error == nil);
    NSParameterAssert(request);
    [headers enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [req setValue:obj forHTTPHeaderField:key];
    }];
    if (request.additionHeader) {
        [request.additionHeader enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [req setValue:obj forHTTPHeaderField:key];
        }];
    }
    return req;
}

@end
