//
//  FirebaseAuthManager.swift
//  HousePlantClassification
//
//  Created by Burak Emre gündeş on 17.10.2022.
//

import Foundation
import Firebase


class FirebaseAuthManager {
    
    static let shared = FirebaseAuthManager()
    
    func login(with completion: @escaping (AuthDataResult) -> Void,
               with completionError: @escaping (Error) -> Void,email:String,password:String){
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let e = error {
                completionError(e)
            }else {
                if let authResult = authResult{
                    completion(authResult)
                }
            }
        }
    }
    
    func register(with completion: @escaping (AuthDataResult) -> Void,
                  with completionError: @escaping (Error) -> Void,email : String, password : String){
        Auth.auth().createUser(withEmail: email, password: password){ authResult,error in
            if let e = error {
                completionError(e)
            }else{
                if let authResult = authResult {
                    completion(authResult)
                }
            }
        }
    }
    
    func logOut(with completionError: @escaping (Error?) -> Void){
        let firebaseAuth = Auth.auth()
        do{
            try firebaseAuth.signOut()
            completionError(nil)
        }catch let signOutError as NSError{
            completionError(signOutError)
        }
    }
    
    func checkCurrentUser() -> Bool{
        if let currentUser = Auth.auth().currentUser{
            return true
        }
        
        return false
    }
    
}
