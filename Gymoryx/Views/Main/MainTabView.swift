//
//  MainTabView.swift
//  Gymoryx
//
//  Created by Shreyas Sahoo on 23/08/24.
//

import SwiftUI
import Firebase
import GoogleSignIn
import FirebaseAuth
struct MainTabView: View {
    @State private var selectedTab = 0
    @AppStorage("userName") private var userName: String = ""
    @AppStorage("userEmail") private var userEmail: String = ""
    @AppStorage("userPic") private var userPic: String = ""
    @AppStorage("isSignIn") private var isSignIn : Bool = true
    @State private var retrievedToken: String? = nil
    var body: some View {
        VStack{
            HStack(spacing:10){
                Image("gymoryx")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30)
                Spacer()
                Image(systemName: "heart.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30)
                    .foregroundStyle(Color("navyblue"))
                
                Button{
                    logoutButtonPressed()
                } label : {
                    Image(systemName:"bookmark.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30)
                        .foregroundStyle(Color("navyblue"))
                }
                
            }
            .frame(maxWidth: .infinity)
            .padding([.horizontal,.bottom],5)
            .background(.white)
            
            TabView(selection: $selectedTab,
                    content:  {
                
                HomeView()
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }
                    .tag(0)
                
                Text("Exercise")
                    .tabItem {
                        Image(systemName: "figure.run.circle.fill")
                        Text("Run")
                    }
                    .tag(1)
                
                Text("Diet")
                    .tabItem {
                        Image(systemName: "fork.knife.circle.fill")
                        Text("Diet")
                    }
                    .tag(2)
                

                
                Text("Activity")
                    .tabItem {
                        Image(systemName: "wave.3.left.circle")
                        Text("Act")
                    }
                    .tag(3)
                
                Text("Play")
                    .tabItem {
                        Image(systemName: "play.square.stack.fill")
                        Text("Play")
                    }
                    .tag(4)
                

            })
        }
        .navigationBarBackButtonHidden()
        .background(.gray.opacity(0.1))
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
    }
}

#Preview {
    MainTabView()
}
