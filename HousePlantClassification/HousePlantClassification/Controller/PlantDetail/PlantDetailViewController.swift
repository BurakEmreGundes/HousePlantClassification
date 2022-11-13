//
//  PlantDetailViewController.swift
//  HousePlantClassification
//
//  Created by Burak Emre gündeş on 26.10.2022.
//

import UIKit

class PlantDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(self.navigationController?.viewControllers)
    }
}
