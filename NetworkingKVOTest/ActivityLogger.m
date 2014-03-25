//
//  ActivityLogger.m
//  NetworkingKVOTest
//
//  Created by Cameron Desautels on 3/25/14.
//  Copyright (c) 2014 Cameron Desautels. All rights reserved.
//

#import "ActivityLogger.h"

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
