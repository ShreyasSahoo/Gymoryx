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
    @AppStorage("isSignIn") var isSignIn = false
    @AppStorage("userName") private var userName: String = ""
    var body: some Scene {
        WindowGroup {
//SetGoalsTabBar(userData: UserPreferencesData())
            Group {
                if !isSignIn {
        ContentView()
                } else {
        MainTabView()
            .onAppear {
//            checkSignInStatus()
                print(isSignIn)
        }
            }
                       
            }
            .onChange(of: isSignIn) { oldValue, newValue in
                print(newValue)
            }
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
