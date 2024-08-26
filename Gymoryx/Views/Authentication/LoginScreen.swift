import SwiftUI
import Firebase
import GoogleSignIn
import FirebaseAuth

struct LoginScreen: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isPasswordVisible: Bool = false
    @State private var isLoginSuccessful: Bool = false
    @State private var showToast: Bool = false
    @State private var toastMessage: String = ""
    @State private var navigateToHome = false
    @State private var navigateToGoals = false
    
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
                        .autocapitalization(.none)
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
                
                Button {
                    Task{
                        await loginButtonPressed()
                    }
                   
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

                NavigationLink(
                    destination: SetGoalsTabBar(userData: UserPreferencesData()),
                    isActive: $navigateToGoals,
                    label: {
                        EmptyView()
                    }
                )
                
                NavigationLink(destination: MainTabView(), isActive: $navigateToHome) {
                    EmptyView()
                }
              
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
                    FirebaseAuth.share.signInWithGoogle(presenting: getRootViewController()) { error in
                        if let error = error {
                            print("Google Sign-In Error: \(error.localizedDescription)")
                        } else {
                            print("Google Sign-In Successful")
                        }
                    }
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
                if showToast {
                               Text(toastMessage)
                                   .padding()
                                   .background(Color.red.opacity(0.8))
                                   .cornerRadius(8)
                                   .foregroundColor(.white)
                                   .transition(.slide)
                                   .animation(.easeInOut)
                           }
                Spacer()
            }
            .onAppear {
                        NetworkManager.shared
                    }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func loginButtonPressed() async {
            if NetworkManager.shared.isConnected {
                do {
                    let userResponse = try await LoginManager.shared.loginUser(email: email, password: password)
                    LoginManager.shared.saveUserData(for: userResponse)
                    
                    await MainActor.run {
                        if userResponse.status == "success" {
                            if userResponse.newUser {
                                navigateToGoals = true
                            } else {
                                navigateToHome = true
                            }
                        }
                    }
                } catch {
                    print("Error: \(error.localizedDescription)")
                }
            } else {
                await MainActor.run {
                    showToast = true
                    toastMessage = "No internet connection. Please try again later."
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        showToast = false
                    }
                }
            }
        }
 }


#Preview {
    LoginScreen()
}
