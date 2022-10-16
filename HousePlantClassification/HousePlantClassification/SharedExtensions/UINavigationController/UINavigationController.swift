//
//  UINavigationController.swift
//  HousePlantClassification
//
//  Created by Burak Emre gündeş on 16.10.2022.
//

import UIKit

extension UINavigationController{
    
    func configureNavigationForBaseGreen() {
        navigationBar.tintColor = .white
        //navigationBar.backIndicatorImage = UIImage(named: "arrowback")
        //navigationBar.backItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.backgroundColor = .baseGreenLight
            navBarAppearance.backgroundEffect = nil
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.boldSystemFont(ofSize: 16)]
            navigationBar.scrollEdgeAppearance = navBarAppearance
            navigationBar.standardAppearance = navBarAppearance
        }
    }
}
