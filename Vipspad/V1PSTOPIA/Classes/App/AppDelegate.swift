//
//  AppDelegate.swift
//  Vipspad
//
//  Created by Azure on 27/12/22.
//

import UIKit
import FirebaseCore
import FirebaseMessaging

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UIWindowSceneDelegate {
    
    internal var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        AlamofireService.configure(application: self)
        let viewController = LoginRouter.createModule()
        Navigation.shared.setRoot(viewController)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.overrideUserInterfaceStyle = .dark
        window?.makeKeyAndVisible()
        self.window?.rootViewController = Navigation.shared.navigationController
        FirebaseApp.configure()
        subscribeToTopic(topic: "Main")
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: {_, _ in })
        application.registerForRemoteNotifications()
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        var viewController = HomeModuleRouter.createModule()
        if (!KeyChainService.shared.checkApiToken()) {
            viewController = LoginRouter.createModule()
        }
        Navigation.shared.setRoot(viewController)
        window.overrideUserInterfaceStyle = .dark
        window.makeKeyAndVisible()
        self.window = window
        self.window?.rootViewController = Navigation.shared.navigationController
    }
    
    func subscribeToTopic(topic: String) {
      let messaging = Messaging.messaging()
      messaging.subscribe(toTopic: topic) { error in
        if let error = error {
          print("Subscription failed: \(error)")
        } else {
          print("Subscribed to topic: \(topic)")
        }
      }
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {

  func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    completionHandler([.badge, .banner, .sound])
  }

  func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    if response.notification.request.identifier == "testIdentifier" {
      print("handling notifications with the testIdentifier Identifier")
    }
    completionHandler()
  }

}
