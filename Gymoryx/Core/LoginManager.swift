//
//  LoginManager.swift
//  Gymoryx
//
//  Created by Shreyas Sahoo on 26/08/24.
//

import Foundation

import FirebaseAuth

class LoginManager {
    
    static let shared = LoginManager() // Singleton
    
    private init() {} // Private initializer to ensure the singleton pattern
    
    func saveUserData(for user: UserResponse) {
        // Save token securely in Keychain
        let isSaved = KeychainHelper.saveToken(token: user.token)
        print(isSaved)
        
        // Save other properties in UserDefaults
        UserDefaults.standard.set(true, forKey: "isSignIn")
        UserDefaults.standard.set(user.name, forKey: "userName")
        UserDefaults.standard.set(user.email, forKey: "userEmail")
        UserDefaults.standard.set(user.userPic, forKey: "userPic")
        UserDefaults.standard.set(user.userCover, forKey: "userCover")
        
        print("User data saved successfully")
    }
    
    func loginUser(email: String, password: String) async throws -> UserResponse {
        // URL to the server
        let urlString = "https://gymoryx.in/app/getapi"
        
        // Create the URL object
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        // Prepare the parameters
        let passwordEncoded = password.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let emailEncoded = email.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let apiKey = "608DFF6wOyQQUvwAO6LwJ60KFDzjt4QE5prQ6"
        let apiKeyEncoded = apiKey.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let method = "login"
        
        // Create the request body
        let postData = "password=\(passwordEncoded)&email=\(emailEncoded)&api_key=\(apiKeyEncoded)&method=\(method)"
        
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = postData.data(using: .utf8)
        
        // Send the request and decode the response
        let (data, _) = try await URLSession.shared.data(for: request)
        let userResponse = try JSONDecoder().decode(UserResponse.self, from: data)
        
        return userResponse
    }
}
