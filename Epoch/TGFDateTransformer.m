//
//  TGFDateTransformer.m
//  Epoch
//
//  Created by Chen Zhang on 1/4/14.
//  Copyright (c) 2014 Chen Zhang. All rights reserved.
//

#import "TGFDateTransformer.h"

@implementation TGFDateTransformer
- (id)transformedValue:(id)value {
    if ([value isKindOfClass:[NSDate class]]) {
        return [NSString stringWithFormat:@"%lld", (long long) [value timeIntervalSince1970]];
    } else {
        return @"Unsupported date";
    }
}
- (id)reverseTransformedValue:(id)value {
    if ([value isKindOfClass:[NSString class]]) {
        long long interval;
        [[NSScanner scannerWithString:value] scanLongLong:&interval];
        return [NSDate dateWithTimeIntervalSince1970:interval];
    } else {
        return nil;
    }
}

+ (BOOL)allowsReverseTransformation
{
    return YES;
}
+ (Class)transformedValueClass
{
    return [NSString class];
}
@end
