//
//  TGFAppDelegate.m
//  Epoch
//
//  Created by Chen Zhang on 1/4/14.
//  Copyright (c) 2014 Chen Zhang. All rights reserved.
//

#import "TGFAppDelegate.h"
#import "TGFComponentsTransformer.h"

@implementation TGFAppDelegate

- (void)awakeFromNib
{
    self.epoch = [NSDate date];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSTimeZone *GMTTimeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    NSTimeZone *defaultTimeZone = [NSTimeZone defaultTimeZone];
    
    self.localComponents = [gregorian components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit fromDate:self.epoch];
    TGFReverseComponentsTransformer *localTransformer = [TGFReverseComponentsTransformer new];
    localTransformer.timeZone = defaultTimeZone;
    self.localTimeZone = defaultTimeZone;

    gregorian.timeZone = GMTTimeZone;
    self.GMTComponents = [gregorian components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit fromDate:self.epoch];
    TGFReverseComponentsTransformer *GMTTransformer = [TGFReverseComponentsTransformer new];
    GMTTransformer.timeZone = GMTTimeZone;
    [self bind:@"GMTComponents" toObject:self withKeyPath:@"epoch" options:@{NSValueTransformerBindingOption : GMTTransformer}];
    
    [self bind:@"localComponents" toObject:self withKeyPath:@"epoch" options:@{NSValueTransformerBindingOption : localTransformer}];
    [localTransformer bind:@"timeZone" toObject:self withKeyPath:@"localTimeZone" options:@{}];
    self.localTransformer = localTransformer;
    self.GMTTransformer = GMTTransformer;

//    [self addObserver:self forKeyPath:@"GMTComponents" options:NSKeyValueObservingOptionNew context:"appdel"];
    [self addObserver:self forKeyPath:@"GMTComponents.year" options:NSKeyValueObservingOptionNew context:"appdel"];
    [self addObserver:self forKeyPath:@"GMTComponents.month" options:NSKeyValueObservingOptionNew context:"appdel"];
    [self addObserver:self forKeyPath:@"GMTComponents.day" options:NSKeyValueObservingOptionNew context:"appdel"];
    [self addObserver:self forKeyPath:@"GMTComponents.hour" options:NSKeyValueObservingOptionNew context:"appdel"];
    [self addObserver:self forKeyPath:@"GMTComponents.minute" options:NSKeyValueObservingOptionNew context:"appdel"];
    [self addObserver:self forKeyPath:@"GMTComponents.second" options:NSKeyValueObservingOptionNew context:"appdel"];
    [self addObserver:self forKeyPath:@"localTimeZone" options:NSKeyValueObservingOptionNew context:"appdel"];
}
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    
    [self inspect];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication {
    return YES;
}

- (void)inspect
{
    NSLog(@"self.epoch:%@", self.epoch);
    NSLog(@"self.gmtcomp:%@", self.GMTComponents);
}

- (void)didTapNowButton:(id)sender
{
    [self willChangeValueForKey:@"epoch"];
    self.epoch = [NSDate date];
    [self didChangeValueForKey:@"epoch"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([object isEqual:self] && [keyPath hasPrefix:@"GMTComponents."]) {
        [self willChangeValueForKey:@"epoch"];
        self.epoch = [self.GMTTransformer reverseTransformedValue:self.GMTComponents];
        [self didChangeValueForKey:@"epoch"];
    } else if ([object isEqual:self] && [keyPath hasPrefix:@"localTimeZone"]) {
        [self removeObserver:self forKeyPath:@"localTimeZone"];
        [self willChangeValueForKey:@"localComponents"];
        //self.localTimeZone = change[NSKeyValueChangeNewKey];
        [(TGFReverseComponentsTransformer *)self.localTransformer setTimeZone:self.localTimeZone];
        _localComponents = [self.localTransformer transformedValue:self.epoch];
        [self didChangeValueForKey:@"localComponents"];
        [self addObserver:self forKeyPath:@"localTimeZone" options:NSKeyValueObservingOptionNew context:"appdel"];
    }
}
@end
