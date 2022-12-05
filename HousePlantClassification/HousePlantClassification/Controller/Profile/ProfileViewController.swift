//
//  ProfileViewController.swift
//  HousePlantClassification
//
//  Created by Burak Emre gündeş on 26.10.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func configure(){
        configureNavBar()
    }
    
    private func configureNavBar(){
        self.navigationItem.title = "Profilim"
        self.navigationController?.configureNavigationForBaseGreen()
    }
    
    @IBAction func tappedLogout(_ sender: Any) {
        FirebaseAuthManager.shared.logOut { error in
            if let error = error {
                print(error)
            }else{
                guard let rootVC = UIStoryboard.init(name: "Authentication", bundle: nil).instantiateViewController(withIdentifier: "welcomeVC") as? WelcomeViewController else {
                    return
                }
                
                UIApplication.shared.windows.first?.rootViewController = UINavigationController(rootViewController: rootVC)
                UIApplication.shared.windows.first?.makeKeyAndVisible()
            }
        }
    }
    
}
