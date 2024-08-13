import SwiftUI

struct LoginScreen: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isPasswordVisible: Bool = false 
    @State private var isLoginSuccessful: Bool = false
    @State private var showToast: Bool = false
    @State private var toastMessage: String = ""
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
         // URL to the server
         let urlString = "https://gymoryx.in/app/getapi"
         
         // Create the URL object
         guard let url = URL(string: urlString) else {
             showToastMessage("Invalid URL")
             return
         }
         
         // Prepare the parameters
         let passwordEncoded = password.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
         let emailEncoded = email.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
         let apiKey = "608DFF6wOyQQUvwAO6LwJ60KFDzjt4QE5prQ6"
         let apiKeyEncoded = apiKey.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
         let method = "login"
         
         // Create the request body
         let postData = "password=\(passwordEncoded)&email=\(emailEncoded)&api_key=\(apiKeyEncoded)&method=\(method)"
         
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
                 print("Response: \(responseString)")
                 DispatchQueue.main.async {
                     
                     if responseString.contains("success") { // Adjust based on actual success criteria
                         isLoginSuccessful = true
                     } else {
                         showToastMessage("Login failed. Please try again.")
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


#Preview {
    LoginScreen()
}
