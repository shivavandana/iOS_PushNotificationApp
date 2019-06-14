//
//  AppDelegate.swift
//  NotificationDemo
//
//  Created by Shiva Vandana on 6/21/17.
//  Copyright © 2017 Shiva Vandana. All rights reserved.
//

import UIKit
import UserNotifications
import Firebase
import FirebaseInstanceID
import FirebaseMessaging
import FirebaseAnalytics


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let gcmMessageIDKey = "gcm.message_id"
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //print("didFinishLaunchingWithOptions start")
        FirebaseApp.configure()
        
        // [START set_messaging_delegate]
        Messaging.messaging().delegate = self
       
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
       
            let content = UNMutableNotificationContent()
            let request = UNNotificationRequest(identifier: "fred", content: content, trigger: nil)
            UNUserNotificationCenter.current().add(request)
            {
                error in // called when message has been sent
                debugPrint("Error: \(error)")
            }
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        let pushSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
        UIApplication.shared.registerUserNotificationSettings(pushSettings)
        UIApplication.shared.registerForRemoteNotifications()
        //print("didFinishLaunchingWithOptions end")
        return true
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        //print("didReceiveRemoteNotification start")
      
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        Messaging.messaging().appDidReceiveMessage(userInfo)
       // print("userinfooooooo\(userInfo)")
        completionHandler(UIBackgroundFetchResult.newData)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "YesNoActivity")
        window?.rootViewController = vc
        let nc = NotificationCenter.default
        nc.post(name:Notification.Name(rawValue:"YesNoActivity"),
                object: nil,
                userInfo:userInfo)
        //print("didReceiveRemoteNotification end")
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Unable to register for remote notifications: \(error.localizedDescription)")
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        print("APNs device token: \(deviceTokenString)")
        let nc = NotificationCenter.default
        
        nc.post(name:Notification.Name(rawValue:"appletoken"),
                object: nil,
                userInfo:["appletoken":deviceTokenString])
        #if PROD_BUILD
            FIRInstanceID.instanceID().setAPNSToken(deviceToken, type: .prod)
        #else
            InstanceID.instanceID().setAPNSToken(deviceToken, type: .sandbox)
        #endif
        
    }
}

// [START ios_10_message_handling]
@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
    
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
    
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        // Print full message.
        print(userInfo)
        completionHandler([.alert])
        

    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
       // print(userInfo)
        
        completionHandler()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "YesNoActivity")
        window?.rootViewController = vc
        let nc = NotificationCenter.default
        nc.post(name:Notification.Name(rawValue:"YesNoActivity"),
                object: nil,
                userInfo:userInfo)
    }
}
// [END ios_10_message_handling]

extension AppDelegate : MessagingDelegate {
    // [START refresh_token]
    func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
    }
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print("Received data message: \(remoteMessage.appData)")
    }
    // [END ios_10_data_message]
}


