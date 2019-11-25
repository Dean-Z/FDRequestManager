//
//  ViewController.m
//  FDRequestManager
//
//  Created by Jason on 2019/11/25.
//  Copyright © 2019 Jason. All rights reserved.
//

#import "ViewController.h"
#import "FDHTTPRequestManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FDRequest *request = [FDRequest new];
    request.urlString = @"xxx";
    [request addParam:@"xxx" forKey:@"xxx"];
    request.method = FDRequestMethodGET;
    [[FDHTTPRequestManager shareManager] request:request completion:^(FDResponed *response) {
        
    }];
}


@end
