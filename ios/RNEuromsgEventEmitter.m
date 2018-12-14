//
//  RNEuromsgEventEmitter.m
//  RNEuromsg
//
//  Created by Sait Banazılı on 19.11.2018.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RNEuromsgEventEmitter.h"
#import "euroiosframework/EMMessage.h"

#define INTEGRATION_ID @"APP_ID"

@implementation RNEuromsgEventEmitter

RCT_EXPORT_MODULE(RNEuromsg);

+ (EuroManager *)sharedEuroManager {
    static EuroManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [EuroManager sharedManager:INTEGRATION_ID];
    });
    return sharedMyManager;
}

+ (id)allocWithZone:(NSZone *)zone {
    static RNEuromsgEventEmitter *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [super allocWithZone:zone];
    });
    return sharedInstance;
}

- (NSArray<NSString *> *)supportedEvents {
    return @[@"didReceivePushMessage", @"didReceiveImageMessage", @"didReceiveVideoMessage", @"opened"];
}

- (void)tellJS:(NSString*)name withBody:(NSDictionary*)body {
    [self sendEventWithName:name body:body];
}

RCT_EXPORT_METHOD(getInitialNotification:(RCTPromiseResolveBlock)resolve
                  reject:(__unused RCTPromiseRejectBlock)reject)
{
    NSMutableDictionary<NSString *, id> *initialNotification =
    [self.bridge.launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey] mutableCopy];

    UILocalNotification *initialLocalNotification =
    self.bridge.launchOptions[UIApplicationLaunchOptionsLocalNotificationKey];

    if (initialNotification) {
        initialNotification[@"remote"] = @YES;

        resolve(initialNotification);
    } else if (initialLocalNotification) {
        resolve([initialLocalNotification userInfo]);
    } else {
        resolve((id)kCFNull);
    }
}

RCT_EXPORT_METHOD(initWithAppId:(NSString*)appId{
    // TODO
    // We need method swizzling, I guess
})

RCT_EXPORT_METHOD(configUser:(NSDictionary*) config
{
    NSLog(@"configUser %@ %@", config[@"email"], config[@"userKey"]);
    if(config[@"email"]){
       [RNEuromsgEventEmitter sharedEuroManager].userEmail = config[@"email"];
    }
    
    if(config[@"userKey"]){
        [[RNEuromsgEventEmitter sharedEuroManager] setUserKey:config[@"userKey"]];
    }
    
    [[RNEuromsgEventEmitter sharedEuroManager] synchronize];
})

RCT_EXPORT_METHOD(setDebug:(BOOL) isDebug
{
    [[RNEuromsgEventEmitter sharedEuroManager] setDebug:isDebug];
})

@end
