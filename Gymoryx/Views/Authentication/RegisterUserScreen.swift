import SwiftUI

struct RegisterUserScreen: View {
    @State private var userName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var reTypePassword: String = ""
    @State private var isPasswordVisible: Bool = false
    @State private var isReTypePasswordVisible: Bool = false
    @State private var showWarning: Bool = false
    @State private var navigateToNextScreen: Bool = false
    @State private var showToast: Bool = false
    @State private var toastMessage: String = ""
    
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
                
                // Register Button
                Button(action: {
                    if password != reTypePassword {
                        showWarning = true
                        navigateToNextScreen = false // Do not navigate if passwords don't match
                    } else {
                        showWarning = false
                        registerUser()
                    }
                }) {
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
                NavigationLink(destination: OTPView(), isActive: $navigateToNextScreen) {
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
                
                // Toast View
                if showToast {
                    Text(toastMessage)
                        .padding()
                        .background(Color.black.opacity(0.7))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .transition(.opacity)
                        .padding()
                }
            }
            .onChange(of: showToast) { newValue in
                if newValue {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            showToast = false
                        }
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func registerUser() {
        // URL to the server
        let urlString = "https://gymoryx.in/app/getapi"
        
        // Create the URL object
        guard let url = URL(string: urlString) else {
            showToastMessage("Invalid URL")
            return
        }
        
        // Prepare the parameters
        // Prepare the parameters
        let emailEncoded = email.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let passwordEncoded = password.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let nameEncoded = userName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let apiKey = "608DFF6wOyQQUvwAO6LwJ60KFDzjt4QE5prQ6"
        let apiKeyEncoded = apiKey.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let method = "register"
        
        // Create the request body
        let postData = "email=\(emailEncoded)&password=\(passwordEncoded)&name=\(nameEncoded)&api_key=\(apiKeyEncoded)&method=\(method)"
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = postData.data(using: .utf8)
        
        // Send the request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    showToastMessage("Error: \(error.localizedDescription)")
                    print("Error: \(error.localizedDescription)")
                }
                return
            }
            
            if let data = data, let responseString = String(data: data, encoding: .utf8) {
                DispatchQueue.main.async {
                    print("Response: \(responseString)")
                    if responseString.contains("success") { // Adjust based on actual success criteria
                        navigateToNextScreen = true
                    } else {
                        showToastMessage("Registration failed. Please try again.")
                    }
                }
            }
        }
        
        task.resume()
    }
    
    func showToastMessage(_ message: String) {
        toastMessage = message
        showToast = true
    }
}

struct OTPView: View {
    var body: some View {
        Text("OTP Screen")
    }
}

