//
//  TGFComponentsTransformer.m
//  Epoch
//
//  Created by Chen Zhang on 1/4/14.
//  Copyright (c) 2014 Chen Zhang. All rights reserved.
//

#import "TGFComponentsTransformer.h"

@interface TGFComponentsTransformer ()
@property (nonatomic, strong) NSCalendar *gregorian;
@end
@interface TGFReverseComponentsTransformer ()
@property (strong) NSCalendar *gregorian;
@end

@implementation TGFComponentsTransformer
@synthesize timeZone=_timeZone;
+ (Class)transformedValueClass {
    return [NSDate class];
}

+ (BOOL)allowsReverseTransformation {
    return YES;
}

- (id)init
{
    self = [super init];
    if (self) {
        _gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    }
    return self;
}

- (NSTimeZone *)timeZone
{
    NSTimeZone *tz;
    @synchronized(self) {
        tz = self->_timeZone;
    }
    return tz;
}
- (void)setTimeZone:(NSTimeZone *)timeZone
{
    @synchronized(self){
    _timeZone = timeZone;
    if (timeZone) {
        _gregorian.timeZone = timeZone;
    } else {
        _gregorian.timeZone = [NSTimeZone defaultTimeZone];
    }
    }
}

- (id)transformedValue:(id)value
{
    NSDateComponents *comp = value;
    return [self.gregorian dateFromComponents:comp];
}

- (id)reverseTransformedValue:(id)value
{
    NSDate *date = value;
    return [self.gregorian components:NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit fromDate:date];
}
@end


@implementation TGFReverseComponentsTransformer
@synthesize timeZone=_timeZone;

+ (Class)transformedValueClass {
    return [NSDateComponents class];
}

+ (BOOL)allowsReverseTransformation {
    return YES;
}

- (id)init
{
    self = [super init];
    if (self) {
        _gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    }
    return self;
}
- (NSTimeZone *)timeZone
{
    NSTimeZone *tz;
    @synchronized(self) {
        tz = self->_timeZone;
    }
    return tz;
}
- (void)setTimeZone:(NSTimeZone *)timeZone
{
    @synchronized(self){
        _timeZone = timeZone;
        if (timeZone) {
            _gregorian.timeZone = timeZone;
        } else {
            _gregorian.timeZone = [NSTimeZone defaultTimeZone];
        }
    }
}

- (id)transformedValue:(id)value
{
    NSDate *date = value;
    return [self.gregorian components:NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit fromDate:date];
}

- (id)reverseTransformedValue:(id)value
{
    NSDateComponents *comp = value;
    return [self.gregorian dateFromComponents:comp];
}
@end
