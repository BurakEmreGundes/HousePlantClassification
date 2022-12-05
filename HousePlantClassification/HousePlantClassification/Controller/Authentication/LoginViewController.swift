//
//  LoginViewController.swift
//  HousePlantClassification
//
//  Created by Burak Emre gündeş on 3.11.2022.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    @IBAction func tappedLogin(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else {return}
        FirebaseAuthManager.shared.login(with: { result in
            guard let rootVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarVC") as? TabBarViewController else {
                return
            }
            
            UIApplication.shared.windows.first?.rootViewController = rootVC
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }, with: { error in
            print(error)
        }, email: email, password: password)
    }
}
