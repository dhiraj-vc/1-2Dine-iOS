//
//  AppDelegate.swift
//  1-2-Dine
//
//  Created by God on 23/01/20.
//  Copyright © 2020 vibrantcubes. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,GIDSignInDelegate {

    var window: UIWindow?
    var networkOff = false
    var currentViewCont = UIViewController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
         self.window = UIWindow(frame: UIScreen.main.bounds)
         ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        GIDSignIn.sharedInstance().clientID = "757472004374-bc9sslv6cih9d1cc4tbp3ogqoc4da2gn.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
       //CreateAccountVC
//            let initialViewController = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC

            let navigationController = UINavigationController(rootViewController: initialViewController)
        
            navigationController.navigationBar.tintColor=UIColor.clear
            navigationController.interactivePopGestureRecognizer?.isEnabled = false
            self.window?.rootViewController = navigationController
            self.window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        AppEvents.activateApp()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    @available(iOS 9.0, *)
    func application(_ application: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any]) -> Bool {
        
        let googleDidHandle = GIDSignIn.sharedInstance().handle(url)
        
        let facebookDidHandle = ApplicationDelegate.shared.application(application, open: url, options: options)
        
        return googleDidHandle || facebookDidHandle
        
        
        
       
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        
        let googleDidHandle = GIDSignIn.sharedInstance().handle(url)
    
        
        let facebookDidHandle = ApplicationDelegate.shared.application(
            application,
            open: url,
            sourceApplication: sourceApplication,
            annotation: annotation)
        
        return googleDidHandle || facebookDidHandle
        
        
        
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
        } else {
            // Perform any operations on signed in user here.
            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            // ...
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
    
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        print("dismissing Google SignIn")
    }
    
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        print("presenting Google SignIn")
    }
}

