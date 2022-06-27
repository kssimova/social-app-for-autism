//
//  AppDelegate.swift
//  SocialApp
//
//  Created by Kristina Simova on 21.05.22.
//

import UIKit
import FirebaseCore
import Firebase
import IQKeyboardManagerSwift
import DropDown

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var mainCoordinator = MainCoordinator()
    
    var ref: DatabaseReference!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        ref = Database.database().reference()
        
        IQKeyboardManager.shared.enable = true
        DropDown.startListeningToKeyboard()
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = mainCoordinator.start()
        self.window?.makeKeyAndVisible()
        
        return true
    }

}

