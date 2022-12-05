//
//  RegisterViewController.swift
//  HousePlantClassification
//
//  Created by Burak Emre gündeş on 26.10.2022.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func tappedRegister(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else {return}
        
            FirebaseAuthManager.shared.register(with: { response in
                print(response.user.uid)
                guard let rootVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarVC") as? TabBarViewController else {
                    return
                }
                
                UIApplication.shared.windows.first?.rootViewController = rootVC
                UIApplication.shared.windows.first?.makeKeyAndVisible()
            }, with: { error in
                print(error)
            }, email: email, password: password)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    
}
