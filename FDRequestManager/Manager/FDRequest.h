//
//  FDRequest.h
//  Aaru
//
//  Created by Jason on 2019/11/23.
//  Copyright © 2019 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, FDRqueestMethod) {
    FDRequestMethodGET,
    FDRequestMethodPOST,
    FDRequestMethodPUT,
    FDRequestMethodDELETE,
    FDRequestMethodHEAD,
    FDRequestMethodPATCH,
};

@interface FDRequest : NSObject

@property (nonatomic, strong) NSString *urlString;
@property (nonatomic, assign) FDRqueestMethod method;
@property (nonatomic, strong) Class resposeModelClass;
@property (nonatomic, strong) NSURLSessionTask *task;

@property (nonatomic, strong) NSDictionary *additionHeader; // 应对特殊需求需要多加的header
@property (nonatomic, strong) NSString *domain;

- (void)addParam:(id)value forKey:(NSString *)key;
- (NSMutableDictionary *)params;

@end
