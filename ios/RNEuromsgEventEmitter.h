//
//  RNEuromsgEventEmitter.h
//  RNEuromsg
//
//  Created by Sait Banazılı on 19.11.2018.
//  Copyright © 2018 Facebook. All rights reserved.
//

#ifndef RNEuromsgEventEmitter_h
#define RNEuromsgEventEmitter_h
#import <React/RCTEventEmitter.h>
#import <React/RCTBridgeModule.h>
#import "euroiosframework/EuroManager.h"
#endif /* RNEuromsgEventEmitter_h */

@interface RNEuromsgEventEmitter : RCTEventEmitter <RCTBridgeModule>

extern NSDictionary *initalNotification;

+ (EuroManager *)sharedEuroManager;
+ (id)allocWithZone:(struct _NSZone *)zone;
- (void)tellJS:(NSString*)name withBody:(NSDictionary*)body;

@end

