//
//  PlantSearchViewController.swift
//  HousePlantClassification
//
//  Created by Burak Emre gündeş on 16.10.2022.
//

import UIKit

class PlantSearchViewController: UIViewController {

    @IBOutlet weak var selectImageButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure(){
        configureNavBar()
        configureLayoutAttributes()
    }
    
    private func configureLayoutAttributes(){
        selectImageButton.layer.cornerRadius = 12.0
    }
    
    private func configureNavBar(){
        self.navigationItem.title = "Bitkileri Keşfet"
        self.navigationController?.configureNavigationForBaseGreen()
    }

    @IBAction func tappedSelectImage(_ sender: Any) {
        print("show action picker")
    }
    
    @IBAction func tappedInfo(_ sender: Any) {
        print("screen for info plants")
    }
}
