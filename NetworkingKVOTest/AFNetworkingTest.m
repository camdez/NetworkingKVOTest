//
//  AFNetworkingTest.m
//  NetworkingKVOTest
//
//  Created by Cameron Desautels on 3/25/14.
//  Copyright (c) 2014 Cameron Desautels. All rights reserved.
//

#import "AFNetworkingTest.h"
#import "AFNetworking.h"
#import "ActivityLogger.h"

@implementation AFNetworkingTest

+ (void)run {
  AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];

  __block BOOL done = NO;

  NSURLSessionDataTask *task = [sessionManager GET:@"http://fuzzy-octo-bear.herokuapp.com/movies" parameters:@{} success:^(NSURLSessionDataTask *task, id responseObject) {
    NSLog(@"Success: %@", task);
    done = YES;
  } failure:^(NSURLSessionDataTask *task, NSError *error) {
    NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
    NSLog(@"Failure (%ld): %@", (long)response.statusCode, error.localizedDescription);
    done = YES;
  }];

  ActivityLogger *activityLogger = [[ActivityLogger alloc] init];
  [task addObserver:activityLogger forKeyPath:NSStringFromSelector(@selector(state)) options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:NULL];

  while (!done) {
    [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                             beforeDate:[NSDate date]];
  }

  [task removeObserver:activityLogger forKeyPath:NSStringFromSelector(@selector(state))];
}

@end
