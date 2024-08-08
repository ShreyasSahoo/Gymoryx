//
//  NetworkManager.swift
//  Gymoryx
//
//  Created by Shreyas Sahoo on 08/08/24.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchUserData() {
        guard let url = URL(string: "https://66b4cc499f9169621ea45fb3.mockapi.io/login/user") else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Failed to fetch data: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let users = try JSONDecoder().decode([User].self, from: data)
                if let user = users.first {
                    self.saveUserData(user: user)
                }
            } catch {
                print("Failed to decode data: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    private func saveUserData(user: User) {
        // Save token securely in Keychain
        KeychainHelper.saveToken(token: user.token)
        
        // Save other properties in UserDefaults
        UserDefaults.standard.set(user.name, forKey: "userName")
        UserDefaults.standard.set(user.email, forKey: "userEmail")
        UserDefaults.standard.set(user.userPic, forKey: "userPic")
        
        print("User data saved successfully")
    }
}


