//
//  FirebaseAuth.swift
//  Gymoryx
//
//  Created by Divyansh Kaushik on 14/08/24.
//

import Foundation
import Firebase
import FirebaseAuth
import GoogleSignIn

struct FirebaseAuth {
    static let share = FirebaseAuth()
    private init() {}
    
    func signInWithGoogle(presenting: UIViewController, completion: @escaping (Error?) -> Void) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
                
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
                
        GIDSignIn.sharedInstance.signIn(withPresenting: presenting) { signResult, error in
                    
            if let error = error {
                // If there's an error, ensure isSignIn is false
                DispatchQueue.main.async {
                    UserDefaults.standard.set(false, forKey: "isSignIn")
                }
                completion(error)
                return
            }
                    
            guard let user = signResult?.user,
                  let idToken = user.idToken else {
                DispatchQueue.main.async {
                    UserDefaults.standard.set(false, forKey: "isSignIn")
                }
                return
            }

            let accessToken = user.accessToken
            let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { authResult, error in
                guard error == nil else {
                    DispatchQueue.main.async {
                        UserDefaults.standard.set(false, forKey: "isSignIn")
                    }
                    completion(error)
                    return
                }
                // If sign-in is successful, set isSignIn to true
                DispatchQueue.main.async {
                    UserDefaults.standard.set(true, forKey: "isSignIn")
                }
            }
        }
    }
}

//google
//slider
//toast
//age
