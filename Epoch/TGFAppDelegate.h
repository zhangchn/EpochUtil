//
//  TGFAppDelegate.h
//  Epoch
//
//  Created by Chen Zhang on 1/4/14.
//  Copyright (c) 2014 Chen Zhang. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface TGFAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (strong) NSDate *epoch;
@property (strong) NSDateComponents *GMTComponents;
@property (strong) NSDateComponents *localComponents;
@property (strong) NSTimeZone *localTimeZone;
@property (strong) NSValueTransformer *GMTTransformer;
@property (strong) NSValueTransformer *localTransformer;
@property (strong) NSValueTransformer *componentsTransformer;
- (IBAction)didTapNowButton:(id)sender;
@end
