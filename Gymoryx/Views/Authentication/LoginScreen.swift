import SwiftUI

struct LoginScreen: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isPasswordVisible: Bool = false 
    @State private var isLoginSuccessful: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                Image("gymoryx")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.height / 6)
                
                VStack(alignment: .leading) {
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
                        .foregroundColor(Color(.gray))
                        .padding(.vertical)
                    
                    HStack {
                        if isPasswordVisible {
                            TextField("", text: $password)
                                .frame(height: 30)
                        } else {
                            SecureField("", text: $password)
                                .frame(height: 30)
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
                }
                .padding()
                .padding(.horizontal)
                
                NavigationLink(
                    destination: ForgotPasswordScreen(),
                    label: {
                        Text("Forgot Password?")
                    })
                .font(.callout)
                .fontWeight(.bold)
                .padding(.leading, 175)
                .foregroundColor(Color("navyblue"))
                
                NavigationLink(
                    destination: SetGoalsTabBar(userData: UserPreferencesData()),
                    isActive: $isLoginSuccessful,
                    label: {
                        Button {
                            loginButtonPressed()
                        } label: {
                            Text("LOGIN")
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
                
                NavigationLink(
                    destination: RegisterUserScreen(),
                    label: {
                        Text("Don't have an account? Sign Up")
                            .font(.subheadline)
                            .fontWeight(.heavy)
                            .foregroundColor(Color("navyblue"))
                    })
                .padding([.top, .horizontal])
                
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
                
                Button(action: {
                    // Add your Google login logic here
                }) {
                    HStack {
                        Image("google")
                            .resizable()
                            .frame(width: 40, height: 40)
                        
                        Text("Connect with Google")
                    }
                    .foregroundColor(Color(.gray))
                    .fontWeight(.heavy)
                    .font(.callout)
                    .frame(width: 275, height: 50)
                    .background(
                        Color.white
                            .cornerRadius(15)
                            .shadow(radius: 2, y: 2)
                    )
                }
                Spacer()
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func loginButtonPressed() {
        NetworkManager.shared.fetchUserData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            isLoginSuccessful = true
        }
    }
}

#Preview {
    LoginScreen()
}
