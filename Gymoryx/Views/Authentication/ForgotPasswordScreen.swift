//
//  ForgotPasswordScreen.swift
//  Gymoryx
//
//  Created by Divyansh Kaushik on 12/08/24.
//

import SwiftUI

struct ForgotPasswordScreen: View {

        @State var email:String = ""
        var body: some View {
            NavigationView{
                VStack{
                    Image("gymoryx")
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width/3,height: UIScreen.main.bounds.height/6)
                    VStack(alignment:.leading)
                    {
                        


                        Text("Enter Your Email ID")
                            .fontWeight(.bold)
                            .foregroundColor(Color(.gray))//red: 0.4, green: 0.4, blue: 0.4
                            .padding(.top)
                        TextField("", text: $email).frame(height: 30)
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
                                     destination: Text("OTP"),
                                     label: {
                                         Button{
                                         } label: {
                                             Text("SEND OTP")
                                                 .font(.title2)
                                                 .bold()
                                                 .foregroundColor(.white)
                                                 .opacity(0.8)
                                         }
                                         .frame(width: 300, height: 60)
                                         .padding(.horizontal, 5)
                                         .background(Color("navyblue"))
                                         .cornerRadius(15)
                                     }
                                 )
                    .padding(.top)


                    NavigationLink(destination: RegisterUserScreen(), label: {Text("Dont have an account?Sign Up")})
                        .font(.callout)
                        .fontWeight(.bold)
                        .foregroundColor(Color("navyblue"))
                        .padding([.top,.horizontal])
                    Spacer()
                }
            }.navigationBarBackButtonHidden(true)

        }
    }


#Preview {
    ForgotPasswordScreen()
}
