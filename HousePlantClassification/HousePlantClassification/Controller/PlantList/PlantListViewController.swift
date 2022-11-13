//
//  PlantListViewController.swift
//  HousePlantClassification
//
//  Created by Burak Emre gündeş on 26.10.2022.
//

import UIKit

class PlantListViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tappedPlantDetails(_ sender: Any) {
        
        let sb = UIStoryboard(name: "PlantDetail", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "plantDetailVC") as? PlantDetailViewController else { return }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(self.navigationController?.viewControllers)
    }


}
