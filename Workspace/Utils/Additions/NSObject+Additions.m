//
//  SXNSObjectAdditions.m
//  TPO
//
//  Created by SunX on 14-5-14.
//  Copyright (c) 2014年 SunX. All rights reserved.
//

#import "NSObject+Additions.h"
#import <objc/runtime.h>

@implementation NSObject (ComNSObjectAdditions)

- (NSString*)comJsonEncode {
    if ([self isKindOfClass:[NSArray class]] ||
        [self isKindOfClass:[NSMutableArray class]] ||
        [self isKindOfClass:[NSDictionary class]] ||
        [self isKindOfClass:[NSMutableDictionary class]]) {
        NSError *error = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                           options:NSJSONWritingPrettyPrinted
                                                             error:&error];
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return nil;
}

- (id)comObjectFortKeySafe:(NSString *)key {
    if ([self isKindOfClass:[NSDictionary class]] || [self isKindOfClass:[NSMutableDictionary class]]) {
        return [(NSDictionary*)self objectForKey:key];
    }
    return nil;
}

- (id)comObjectIndexSafe:(NSUInteger)index {
    if ([self isKindOfClass:[NSArray class]] || [self isKindOfClass:[NSMutableArray class]]) {
        if (index < [(NSArray*)self count]) {
            return [(NSArray*)self objectAtIndex:index];
        }
        return nil;
    }
    return nil;
}

- (NSString *)safeString {
    return [self isKindOfClass:[NSObject class]]?[NSString stringWithFormat:@"%@",self]:@"";
}

- (NSArray *)comToArray {
    return [self isKindOfClass:[NSArray class]] ? (NSArray *)self : nil;
}

- (NSDictionary *)comToDictionary {
    return [self isKindOfClass:[NSDictionary class]] ? (NSDictionary *)self : nil;
}

- (NSMutableArray *)comToMutableArray {
    return [self isKindOfClass:[NSArray class]] || [self isKindOfClass:[NSMutableArray class]] ? [NSMutableArray arrayWithArray:(id)self] :nil;
}

- (NSMutableDictionary *)comToMutableDictionary {
    return [self isKindOfClass:[NSDictionary class]] || [self isKindOfClass:[NSMutableDictionary class]] ? [NSMutableDictionary dictionaryWithDictionary:(id)self] : nil;
}

@end
