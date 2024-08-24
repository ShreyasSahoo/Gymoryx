//
//  HomeView.swift
//  Gymoryx
//
//  Created by Shreyas Sahoo on 08/08/24.
//

import SwiftUI
import Firebase
import GoogleSignIn
import FirebaseAuth
struct HomeView: View {
    @AppStorage("userName") private var userName: String = ""
    @AppStorage("userEmail") private var userEmail: String = ""
    @AppStorage("userPic") private var userPic: String = ""
    @AppStorage("isSignIn") private var isSignIn : Bool = true
    
    @State private var retrievedToken: String? = nil
    var body: some View {
        ScrollView {
            Text("Name: \(userName)")
            Text("Email: \(userEmail)")
            AsyncImage(url: URL(string: userPic)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            VStack {
                Button(action: logoutButtonPressed) {
                    Image(systemName: "power")
                        .foregroundColor(.red)
                        .font(.system(size: 24))
                }//this logout button is temporarily added so we can check the logout funcationality
                .padding()
                Text("Stored Token:")
                    .font(.headline)
                
                if let token = retrievedToken {
                    Text(token)
                        .font(.body)
                        .padding()
                } else {
                    Text("No token found")
                        .font(.body)
                        .padding()
                }
                
                Button("Retrieve Token") {
                    retrievedToken = KeychainHelper.getToken()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            .padding()
        }
        
    }
    
    func logoutButtonPressed() {
        do {
            try Auth.auth().signOut()
            isSignIn = false
            userPic = ""
            userEmail = ""
            userName = ""
            print("User logged out successfully")
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }}
#Preview {
    HomeView()
}
