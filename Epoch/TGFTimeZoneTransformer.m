//
//  TGFTimeZoneTransformer.m
//  Epoch
//
//  Created by Chen Zhang on 1/4/14.
//  Copyright (c) 2014 Chen Zhang. All rights reserved.
//

#import "TGFTimeZoneTransformer.h"

@implementation TGFTimeZoneTransformer
+ (Class)transformedValueClass
{
    return [NSString class];
}

+ (BOOL)allowsReverseTransformation
{
    return YES;
}

- (id)transformedValue:(id)value
{
    NSTimeZone *tz = value;
    float hourDelta = [tz secondsFromGMT] / 3600.0;
    return [NSString stringWithFormat:(hourDelta >= 0) ? @"+%.1f" : @"-%.1f", hourDelta];
}

- (id)reverseTransformedValue:(id)value
{
    float hourDelta;
    [[NSScanner scannerWithString:value] scanFloat:&hourDelta];
    NSTimeZone *tz = [NSTimeZone timeZoneForSecondsFromGMT:1800 * roundf(hourDelta * 2)];
    return tz;
}
@end
