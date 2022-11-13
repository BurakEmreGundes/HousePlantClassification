//
//  WelcomeViewController.swift
//  HousePlantClassification
//
//  Created by Burak Emre gündeş on 27.10.2022.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var registerButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

       configure()
    }
    
    func configure(){
        configureLayoutAttributes()
    }
    
    func configureLayoutAttributes(){
        topView.layer.cornerRadius = 32.0
        topView.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
        view.bringSubviewToFront(topView)
        
        loginButton.layer.cornerRadius = 12.0
        registerButton.layer.cornerRadius = 12.0
    }
    

}
