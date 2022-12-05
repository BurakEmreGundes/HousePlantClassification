//
//  TabBarViewController.swift
//  HousePlantClassification
//
//  Created by Burak Emre gündeş on 16.10.2022.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.selectedIndex = 1
        self.tabBar.barTintColor = .baseGreenLight
        self.tabBar.backgroundColor = .baseGreenLight
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print(self.navigationController?.viewControllers)
    }


}
