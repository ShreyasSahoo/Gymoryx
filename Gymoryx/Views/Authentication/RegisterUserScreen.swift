import SwiftUI

struct RegisterUserScreen: View {
    @State var userName: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var reTypePassword: String = ""
    @State var isPasswordVisible: Bool = false
    @State var isReTypePasswordVisible: Bool = false
    @State var showWarning: Bool = false
    @State var navigateToNextScreen: Bool = false 
    
    var body: some View {
        NavigationView {
            VStack {
                Image("gymoryx")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.height / 6)
                
                VStack(alignment: .leading) {
                    Text("Name")
                        .fontWeight(.bold)
                        .foregroundColor(Color(.gray))
                    TextField("", text: $userName).frame(height: 30)
                        .overlay(
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.gray),
                            alignment: .bottom
                        )
                    
                    Text("Email")
                        .fontWeight(.bold)
                        .foregroundColor(Color(.gray))
                        .padding(.top)
                    TextField("", text: $email).frame(height: 30)
                        .overlay(
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.gray),
                            alignment: .bottom
                        )
                    
                    Text("Password")
                        .fontWeight(.bold)
                        .foregroundColor(Color(.gray))
                        .padding(.top)
                    
                    HStack {
                        if isPasswordVisible {
                            TextField("", text: $password).frame(height: 30)
                        } else {
                            SecureField("", text: $password).frame(height: 30)
                        }
                        Button(action: {
                            isPasswordVisible.toggle()
                        }) {
                            Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                                .foregroundColor(.gray)
                        }
                    }
                    .overlay(
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray),
                        alignment: .bottom
                    )
                    
                    Text("Retype Password")
                        .fontWeight(.bold)
                        .foregroundColor(Color(.gray))
                        .padding(.top)
                    
                    HStack {
                        if isReTypePasswordVisible {
                            TextField("", text: $reTypePassword).frame(height: 30)
                        } else {
                            SecureField("", text: $reTypePassword).frame(height: 30)
                        }
                        Button(action: {
                            isReTypePasswordVisible.toggle()
                        }) {
                            Image(systemName: isReTypePasswordVisible ? "eye.slash" : "eye")
                                .foregroundColor(.gray)
                        }
                    }
                    .overlay(
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray),
                        alignment: .bottom
                    )
                    
                    if showWarning {
                        Text("Passwords do not match!")
                            .foregroundColor(.red)
                            .fontWeight(.bold)
                            .padding(.top, 5)
                    }
                }
                .padding()
                .padding(.horizontal)
                
                // Button to check passwords and navigate
                Button {
                    if password != reTypePassword {
                        showWarning = true
                        navigateToNextScreen = false // Do not navigate if passwords don't match
                    } else {
                        showWarning = false
                        navigateToNextScreen = true // Allow navigation
                    }
                } label: {
                    Text("VERIFY")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                        .opacity(0.8)
                }
                .frame(width: 300, height: 60)
                .padding(.horizontal, 5)
                .background(Color("navyblue"))
                .cornerRadius(15)
                .padding(.top)
                
                // NavigationLink controlled by `navigateToNextScreen`
                NavigationLink(destination: Text("OTP"), isActive: $navigateToNextScreen) {
                    EmptyView()
                }
                
                NavigationLink(destination: LoginScreen(), label: {
                    Text("Already have an account? Sign In")
                })
                .font(.callout)
                .fontWeight(.bold)
                .foregroundColor(Color("navyblue"))
                .padding([.top, .horizontal])
                
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    RegisterUserScreen()
}
