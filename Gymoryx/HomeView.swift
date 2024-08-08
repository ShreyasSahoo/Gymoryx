//
//  HomeView.swift
//  Gymoryx
//
//  Created by Shreyas Sahoo on 08/08/24.
//

import SwiftUI

struct HomeView: View {
        @AppStorage("userName") private var userName: String = ""
       @AppStorage("userEmail") private var userEmail: String = ""
       @AppStorage("userPic") private var userPic: String = ""
    
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
}

#Preview {
    HomeView()
}
