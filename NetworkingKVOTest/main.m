//
//  main.m
//  NetworkingKVOTest
//
//  Created by Cameron Desautels on 3/25/14.
//  Copyright (c) 2014 Cameron Desautels. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSURLSessionTest.h"
#import "AFNetworkingTest.h"

int main(int argc, const char * argv[]) {
  @autoreleasepool {
    NSLog(@"Testing NSURLSession");
    [NSURLSessionTest run];

    NSLog(@"Testing AFNetworking");
    [AFNetworkingTest run];
  }

  return 0;
}
