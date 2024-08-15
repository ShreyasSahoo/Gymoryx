//
//  GymoryxApp.swift
//  Gymoryx
//
//  Created by Shreyas Sahoo on 07/08/24.
//

import SwiftUI
import FirebaseAuth
@main
struct GymoryxApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @AppStorage("signIn") var isSignIn = false
    
    var body: some Scene {
        WindowGroup {
SetGoalsTabBar(userData: UserPreferencesData())//            if !isSignIn {
//                ContentView()
//
//            } else {
//                HomeView()  
//                    .onAppear {
//                    checkSignInStatus()
//                }
//            }
        }
    }
    func checkSignInStatus() {
        if let user = Auth.auth().currentUser {
            print("User is signed in: \(user.email ?? "Unknown Email")")
            isSignIn = true
        } else {
            print("No user is signed in")
            isSignIn = false
        }
        print("isSignIn is now \(isSignIn)")
    }
}
