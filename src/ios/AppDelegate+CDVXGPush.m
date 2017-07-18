#import "AppDelegate+CDVXGPush.h"
#import "XGPush.h"

@implementation AppDelegate (CDVXGPush)

/**
 * 追加推送事件
 */
- (void) application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary*)userInfo {
  NSLog(@"[AppDelegate] receive remote notification");
  [[NSNotificationCenter defaultCenter] postNotificationName: @"receivenotification" object:userInfo];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    NSString *deviceTokenStr = [XGPush registerDevice:deviceToken account:nil successCallback:^{
        NSLog(@"[XGDemo] register push success");
    } errorCallback:^{
        NSLog(@"[XGDemo] register push error");
    }];
    NSLog(@"[XGDemo] device token is %@", deviceTokenStr);
    [[NSNotificationCenter defaultCenter] postNotificationName: @"CDVRemoteNotification" object:deviceTokenStr];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"[XGDemo] register APNS fail.\n[XGDemo] reason : %@", error);
    [[NSNotificationCenter defaultCenter] postNotificationName: @"CDVRemoteNotificationError" object:error];
}

@end
