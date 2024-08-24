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
                Spacer()
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func saveUserData(for user: UserResponse) {
        // Save token securely in Keychain
        let isSaved = KeychainHelper.saveToken(token: user.token)
        print(isSaved)
        // Save other properties in UserDefaults
        UserDefaults.standard.set(true, forKey: "isSignIn")

        UserDefaults.standard.set(user.name, forKey: "userName")
        UserDefaults.standard.set(user.email, forKey: "userEmail")
        UserDefaults.standard.set(user.userPic, forKey: "userPic")
        UserDefaults.standard.set(user.userCover, forKey: "userCover")
        
        print("User data saved successfully")
    }
    

    func loginButtonPressed() async {
        
        // URL to the server
        let urlString = "https://gymoryx.in/app/getapi"
        
        // Create the URL object
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        // Prepare the parameters
        let passwordEncoded = password.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let emailEncoded = email.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let apiKey = "608DFF6wOyQQUvwAO6LwJ60KFDzjt4QE5prQ6"
        let apiKeyEncoded = apiKey.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let method = "login"
        
        print(passwordEncoded, emailEncoded)
        
        // Create the request body
        let postData = "password=\(passwordEncoded)&email=\(emailEncoded)&api_key=\(apiKeyEncoded)&method=\(method)"
        
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = postData.data(using: .utf8)
        
        do {
            // Send the request using async/await
            let (data, _) = try await URLSession.shared.data(for: request)
            
            // Decode the JSON response into the UserResponse model
            let userResponse = try JSONDecoder().decode(UserResponse.self, from: data)
            print("Decoded Response: \(userResponse)")
            
            // Save user data and update UI on the main thread
            saveUserData(for: userResponse)
            if userResponse.status == "success"{
                if userResponse.newUser{
                    
                    await MainActor.run {
                        navigateToGoals = true
                    }
                } else {
                    
                    await MainActor.run {
                        navigateToHome = true
                    }
                }
                
            }
            
            
        } catch {
            // Handle errors (e.g., network issues, decoding errors)
            print("Error: \(error.localizedDescription)")
        }
    }

    


 }


#Preview {
    LoginScreen()
}
