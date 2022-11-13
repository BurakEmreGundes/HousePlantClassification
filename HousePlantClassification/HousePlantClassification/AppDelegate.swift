//
//  AppDelegate.swift
//  HousePlantClassification
//
//  Created by Burak Emre gündeş on 16.10.2022.
//

import UIKit
import Firebase


@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        return true
    }


}

