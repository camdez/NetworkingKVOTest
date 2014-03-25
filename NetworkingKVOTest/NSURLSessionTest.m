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

  NSURLSessionDataTask *task = [session dataTaskWithURL:[NSURL URLWithString:@"http://camdez.com"] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    if (error) {
      NSLog(@"An error occurred: %@", error.localizedDescription);
    } else {
      NSLog(@"Success");
    }
  }];

  ActivityLogger *activityLogger = [[ActivityLogger alloc] init];
  [task addObserver:activityLogger forKeyPath:NSStringFromSelector(@selector(state)) options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:NULL];

  [task resume];

  sleep(5);

  [task removeObserver:activityLogger forKeyPath:NSStringFromSelector(@selector(state))];
}

@end
