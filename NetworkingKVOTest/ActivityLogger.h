//
//  ActivityLogger.h
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
