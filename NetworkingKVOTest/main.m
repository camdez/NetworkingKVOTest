//
//  main.m
//  NetworkingKVOTest
//
//  Created by Cameron Desautels on 3/25/14.
//  Copyright (c) 2014 Cameron Desautels. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityLogger : NSObject
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context;
- (NSString *)nameForState:(NSURLSessionTaskState)state;
@end

@implementation ActivityLogger

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
  NSLog(@"Change: %@ -> %@",
        [self nameForState:[[change valueForKey:NSKeyValueChangeOldKey] integerValue]],
        [self nameForState:[[change valueForKey:NSKeyValueChangeNewKey] integerValue]]);
}

- (NSString *)nameForState:(NSURLSessionTaskState)state {
  return @{@(NSURLSessionTaskStateRunning):   @"running",
           @(NSURLSessionTaskStateSuspended): @"suspended",
           @(NSURLSessionTaskStateCanceling): @"canceling",
           @(NSURLSessionTaskStateCompleted): @"completed"}[@(state)];
}

@end


int main(int argc, const char * argv[]) {
  @autoreleasepool {
    NSURLSession *session = [NSURLSession sharedSession];

    NSURLSessionDataTask *task = [session dataTaskWithURL:[NSURL URLWithString:@"http://camdez.com"] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
      if (error) {
        NSLog(@"An error occurred: %@", error.localizedDescription);
      } else {
        //NSString *responseBody = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        //NSLog(@"Success: %@", responseBody);
        NSLog(@"Success");
      }
    }];

    ActivityLogger *activityLogger = [[ActivityLogger alloc] init];
    [task addObserver:activityLogger forKeyPath:NSStringFromSelector(@selector(state)) options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:NULL];

    [task resume];

    sleep(5);

    [task removeObserver:activityLogger forKeyPath:NSStringFromSelector(@selector(state))];
  }

  return 0;
}

