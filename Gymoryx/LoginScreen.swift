//
//  loginScreen.swift
//  Gymoryx
//
//  Created by Divyansh Kaushik on 07/08/24.
//

import SwiftUI

struct LoginScreen: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    var body: some View {
        
        NavigationView{
            
            VStack{
    
                Image("gymoryx")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width/2,height: UIScreen.main.bounds.height/4)
                VStack(alignment:.leading){
                    
                    Text("Enter Email")
                        .fontWeight(.bold)
                        .foregroundColor(Color(.gray))
                        .padding(.bottom)
                    
                    TextField("", text: $email)
                        .overlay(
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.gray),
                                alignment: .bottom
                        )
                    
                    Text("Enter Password")
                        .fontWeight(.bold)
                        .foregroundColor(Color(.gray))//red: 0.4, green: 0.4, blue: 0.4
                        .padding(.vertical)
                    
                    SecureField("", text: $password)
                        .overlay(
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.gray),
                            alignment: .bottom
                        )
                }
                .padding()
                .padding(.horizontal)
                
                NavigationLink(
                    destination: Text("Forget pass"),label: {Text("Forgot Password?")})
                .font(.callout)
                .fontWeight(.bold)
                .padding(.leading,175)
                .foregroundColor(Color("navyblue"))

                NavigationLink(
                        destination: SetGoalsTabBar(),label:
                {
                    Text("LOGIN")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                        .opacity(0.8)
                    })
                .frame(width: 300,height: 60)
                .padding(.horizontal,5)
                .background(Color("navyblue"))
                .cornerRadius(15)

                NavigationLink(
                    destination: Text("No account"),label: {Text("Don't have an account? Sign Up")
                        .font(.subheadline)
                        .fontWeight(.heavy)
                        .foregroundColor(Color("navyblue"))
                    })
                .padding([.top,.horizontal]
                )
                
                HStack {
                    VStack { 
                        Divider()
                            .frame(height: 2)
                            .background(Color.gray)
                            }
                    Text("OR")
                        .foregroundColor(.gray)
                        .font(.headline)
                    VStack {
                        Divider()
                            .frame(height: 2)
                            .background(Color.gray)
                    }
                }
                .padding()
                
                
                Button(action:{
                    
                })
                {
                    HStack{
                        Image("google")
                            .resizable()
                            .frame(width: 40, height: 40)
                        
                        Text("Connect with Google")
                    }
                    .foregroundColor(Color(.gray))//red: 0.4, green: 0.4, blue: 0.4 can also use this
                    .fontWeight(.heavy)
                    .font(.callout)
                    .frame(width: 275,height: 50)
                    .background()
                    {
                        Color.white
                            .cornerRadius(15)
                            .shadow(radius: 2,y: 2)
                    }
                }
            }.padding()
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    LoginScreen()
}
