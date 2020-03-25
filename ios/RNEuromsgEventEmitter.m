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

@implementation RNEuromsgEventEmitter

RCT_EXPORT_MODULE(RNEuromsg);

+ (EuroManager *)sharedEuroManager:(NSString *)key {
    static EuroManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appKey = key;
        sharedMyManager = [EuroManager sharedManager:key];
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
        //[[RNEuromsgEventEmitter sharedEuroManager] handlePush:initialNotification];
        resolve(initialNotification);
    } else if (initialLocalNotification) {
        resolve([initialLocalNotification userInfo]);
    } else {
        resolve((id)kCFNull);
    }
}

RCT_EXPORT_METHOD(initWithAppId:(NSString*)appId{
    // @TODO
    // We need method swizzling, I guess
})

RCT_EXPORT_METHOD(setBadgeNumber:(int) count ){
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:count];
    });
}

RCT_EXPORT_METHOD(setPermit:(BOOL) permission
{
    NSString *p = @"N";
    if(permission){
        p=@"A";
    }

                  [[RNEuromsgEventEmitter sharedEuroManager:appKey] addParams:@"pushPermit" value:p];
    [[RNEuromsgEventEmitter sharedEuroManager:appKey] synchronize];
})

RCT_EXPORT_METHOD(configUser:(NSDictionary*) config
{
    NSLog(@"configUser %@ %@", config[@"email"], config[@"userKey"]);
    if(config[@"email"]){
       [RNEuromsgEventEmitter sharedEuroManager:appKey].userEmail = config[@"email"];
    }
    
    if(config[@"userKey"]){
        [[RNEuromsgEventEmitter sharedEuroManager:appKey] setUserKey:config[@"userKey"]];
    }
    
    [[RNEuromsgEventEmitter sharedEuroManager:appKey] synchronize];
})

RCT_EXPORT_METHOD(setDebug:(BOOL) isDebug
{
    [[RNEuromsgEventEmitter sharedEuroManager:appKey] setDebug:isDebug];
})

@end
