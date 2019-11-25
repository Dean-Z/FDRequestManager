//
//  FDHTTPRequestManager.m
//  Aaru
//
//  Created by Jason on 2019/11/23.
//  Copyright © 2019 Jason. All rights reserved.
//

#import "FDHTTPRequestManager.h"
#import "YYModel.h"

//static CGFloat FDDefaultRquestTimeoutIntervalForRequest = 10;
static FDHTTPRequestManager *manager = nil;

@interface FDHTTPRequestManager ()

@end

@implementation FDHTTPRequestManager

+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[FDHTTPRequestManager alloc] init];
    });
    return manager;
}

- (instancetype)init {
    self = [super init];
    [self setup];
    return self;
}

- (void)setup {
    [self setupRequestSerializerForSessionManager];
}

- (void)setupRequestSerializerForSessionManager {
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data",
                                                 @"application/json", @"text/html", @"image/jpeg", @"image/png",
                                                 @"application/octet-stream", @"text/json", @"text/javascript", nil];
    self.sessionManager.responseSerializer = responseSerializer;
}

- (void)request:(FDRequest *)request completion:(FDRequestCompletionBlock)completion {
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest URLRequest:request headers:nil];
    request.task = [self.sessionManager dataTaskWithRequest:urlRequest
                                             uploadProgress:nil
                                           downloadProgress:nil
                                          completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error)
    {
        FDResponed *rsp = [FDResponed new];
        if (!error) {
            if (request.resposeModelClass) {
                if ([responseObject isKindOfClass:[NSDictionary class]]) {
                    id data = [responseObject objectForKey:@"data"];
                    // 在有配置resposeModelClass情况下 如果data是列表 则返回一个内容为该class的array
                    if ([data isKindOfClass:[NSArray class]]) {
                        rsp.result = [NSArray yy_modelArrayWithClass:request.resposeModelClass json:data];
                    } else {
                        rsp.result = [request.resposeModelClass yy_modelWithJSON:data];
                    }
                } else {
                    rsp.result = responseObject;
                }
            } else {
                // 没有配置resposeModelClass则在拿到数据后自己处理
                rsp.result = responseObject;
            }
        }
        completion(rsp);
    }];
    [request.task resume];
}

#pragma mark - Getter

- (AFURLSessionManager *)sessionManager {
    if(_sessionManager == nil) {
        _sessionManager = [[AFURLSessionManager alloc] init];
    }
    return _sessionManager;
}

@end
