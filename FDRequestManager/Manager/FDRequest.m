//
//  FDRequest.m
//  Aaru
//
//  Created by Jason on 2019/11/23.
//  Copyright © 2019 Jason. All rights reserved.
//

#import "FDRequest.h"

@interface FDRequest()
@property (nonatomic, strong) NSMutableDictionary *params;
@end


@implementation FDRequest

- (void)addParam:(id)value forKey:(NSString *)key {
    if (key == nil || value == nil) {
        return;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        value = [(NSNumber *)value stringValue];
    }
    [self.params setObject:value forKey:key];
}

- (NSMutableDictionary *)params {
    if (!_params) {
        _params = @{}.mutableCopy;
    }
    return _params;
}

- (NSString *)urlString {
    return [self.domain stringByAppendingString:_urlString];
}

- (NSString *)domain {
    if (!_domain) {
        return _domain;
    }
    return @"";
}

- (NSDictionary *)additionHeader {
    if (!_additionHeader) {
        return _additionHeader;
    }
    return nil;
}

@end
