//
//  NSURLSessionTest.m
//  NetworkingKVOTest
//
//  Created by Cameron Desautels on 3/25/14.
//  Copyright (c) 2014 Cameron Desautels. All rights reserved.
//

#import "NSURLSessionTest.h"
#import "ActivityLogger.h"

@implementation NSURLSessionTest

+ (void)run {
  NSURLSession *session = [NSURLSession sharedSession];

  __block BOOL done = NO;

  NSURLSessionDataTask *task = [session dataTaskWithURL:[NSURL URLWithString:@"http://fuzzy-octo-bear.herokuapp.com/movies"] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    if (error) {
      NSLog(@"An error occurred: %@", error.localizedDescription);
      done = YES;
    } else {
      NSLog(@"Success");
      done = YES;
    }
  }];

  ActivityLogger *activityLogger = [[ActivityLogger alloc] init];
  [task addObserver:activityLogger forKeyPath:NSStringFromSelector(@selector(state)) options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:NULL];

  [task resume];

  while (!done) {
    [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                             beforeDate:[NSDate date]];
  }

  [task removeObserver:activityLogger forKeyPath:NSStringFromSelector(@selector(state))];
}

@end
