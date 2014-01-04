//
//  TGFComponentsTransformer.h
//  Epoch
//
//  Created by Chen Zhang on 1/4/14.
//  Copyright (c) 2014 Chen Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TGFComponentsTransformer : NSValueTransformer
@property (strong) NSTimeZone *timeZone;
@end

@interface TGFReverseComponentsTransformer : NSValueTransformer
@property (strong) NSTimeZone *timeZone;
@end

@interface TGFComponentDigitTransformer : NSValueTransformer
@end