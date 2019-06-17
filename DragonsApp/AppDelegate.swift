//
//  AppDelegate.swift
//  DragonsApp
//
//  Created by Gabriel Silveira on 11/06/19.
//  Copyright © 2019 Gabriel Silveira. All rights reserved.
//
// swiftlint:disable discouraged_optional_collection
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    private var appCoordinator: Coordinator?
    
    class var isIphoneXOrBigger: Bool {
        // 812.0 on iPhone X, XS.
        // 896.0 on iPhone XS Max, XR.
        return UIScreen.main.bounds.height >= 812
    }
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        appCoordinator = AppCoordinator(window: window)
        appCoordinator?.start()
        self.window = window
        
        return true
    }
}
