//
//  OTPModifer.swift
//  Gymoryx
//
//  Created by Shreyas Sahoo on 15/08/24.
//


import SwiftUI
import Combine
import Foundation

struct OTPVerificationResponse: Codable {
    let status: String
    let userPic: String
    let email: String
    let name: String
    let token: String

    enum CodingKeys: String, CodingKey {
        case status
        case userPic
        case email
        case name
        case token
    }
}

struct OTPModifier: ViewModifier {
    @Binding var pin: String
    var textLimit = 1

    func body(content: Content) -> some View {
        content
            .multilineTextAlignment(.center)
            .keyboardType(.numberPad)
            .onReceive(Just(pin)) { _ in limitText(textLimit) }
            .frame(width: 45, height: 45)
            .background(Color.white.cornerRadius(5))
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.blue, lineWidth: 2)
            )
    }

    private func limitText(_ upper: Int) {
        pin = String(pin.prefix(upper))
    }
}

struct OTPFormFieldView: View {
    enum FocusPin {
        case pinOne, pinTwo, pinThree, pinFour
    }
    
    @FocusState private var pinFocusState: FocusPin?
    @State private var pinOne = ""
    @State private var pinTwo = ""
    @State private var pinThree = ""
    @State private var pinFour = ""
    @State private var isLoading = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var navigateToWhatsAppScreen = false
    
    @State var email: String
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Verify your Email Address")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text("Enter 4 digit code we'll text you on Email")
                    .font(.caption)
                    .fontWeight(.thin)
                    .padding(.top)
                
                HStack(spacing: 15) {
                    ForEach(0..<4, id: \.self) { index in
                        pinField(for: index)
                    }
                }
                .padding(.vertical)
                
                Button(action: verifyOTP) {
                    if isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    } else {
                        Text("Verify")
                            .font(.system(.title3, design: .rounded))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(15)
                .background(Color.accentColor)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding()
                .disabled(isLoading || !isOTPComplete)
                
                NavigationLink(destination: WhatsappView().navigationBarBackButtonHidden(), isActive: $navigateToWhatsAppScreen) {
                    EmptyView()
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("OTP Verification"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        }
    }
    
    private func pinField(for index: Int) -> some View {
        let binding = binding(for: index)
        return TextField("", text: binding)
            .modifier(OTPModifier(pin: binding))
            .focused($pinFocusState, equals: focusState(for: index))
            .onChange(of: binding.wrappedValue) { newValue in
                handlePinChange(index: index, newValue: newValue)
            }
            .onReceive(Just(binding.wrappedValue)) { _ in limitText(binding) }
    }
    
    private func binding(for index: Int) -> Binding<String> {
        switch index {
        case 0: return $pinOne
        case 1: return $pinTwo
        case 2: return $pinThree
        case 3: return $pinFour
        default: fatalError("Invalid index")
        }
    }
    
    private func focusState(for index: Int) -> FocusPin {
        switch index {
        case 0: return .pinOne
        case 1: return .pinTwo
        case 2: return .pinThree
        case 3: return .pinFour
        default: fatalError("Invalid index")
        }
    }
    
    private func handlePinChange(index: Int, newValue: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            if newValue.count == 1 {
                if index < 3 {
                    pinFocusState = focusState(for: index + 1)
                } else {
                    verifyOTP()
                }
            } else if newValue.isEmpty && index > 0 {
                pinFocusState = focusState(for: index - 1)
            }
        }
    }
    
    private func limitText(_ binding: Binding<String>) {
        if binding.wrappedValue.count > 1 {
            binding.wrappedValue = String(binding.wrappedValue.prefix(1))
        }
    }
    
    private var isOTPComplete: Bool {
        !pinOne.isEmpty && !pinTwo.isEmpty && !pinThree.isEmpty && !pinFour.isEmpty
    }
    
    private func verifyOTP() {
        Task {
            await performOTPVerification()
        }
    }
    
    private func performOTPVerification() async {
        isLoading = true
        defer { isLoading = false }
        
        let otp = pinOne + pinTwo + pinThree + pinFour
        
        do {
            let success = try await verifyOTPRequest(otp: otp, email: email)
            alertMessage = success ? "OTP verified successfully" : "OTP verification failed. Please try again."
            navigateToWhatsAppScreen = true
            
                
            
        } catch {
            alertMessage = "Error: \(error.localizedDescription)"
            showAlert = true
        }
    }
    
    private func verifyOTPRequest(otp: String, email: String) async throws -> Bool {
        let urlString = "https://gymoryx.in/app/getapi"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let parameters = [
            "otp": otp,
            "email": email,
            "api_key": "608DFF6wOyQQUvwAO6LwJ60KFDzjt4QE5prQ6",
            "method": "verify"
        ]
        
        request.httpBody = parameters.percentEncoded()
        let decoder = JSONDecoder()
        let (data, _) = try await URLSession.shared.data(for: request)
        let responseString = String(data: data, encoding: .utf8) ?? ""
        
        if responseString.contains("success") {
            
            do {
                let otpVerificationResponse = try decoder.decode(OTPVerificationResponse.self, from: data)

                
                
                UserDefaults.standard.set(true, forKey: "isSignIn")
                UserDefaults.standard.set(otpVerificationResponse.name, forKey: "userName")
                UserDefaults.standard.set(otpVerificationResponse.email, forKey: "userEmail")
                UserDefaults.standard.set(otpVerificationResponse.userPic, forKey: "userPic")
                let isSaved = KeychainHelper.saveToken(token: otpVerificationResponse.token)
                print(isSaved)
                
            } catch {
                print("Decoding error: \(error)")
            }
            
            return true
        } else {
            return false
        }
        
        
    }
    
}

extension Dictionary {
    func percentEncoded() -> Data? {
        return map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}

struct OTPFormFieldView_Previews: PreviewProvider {
    static var previews: some View {
        OTPFormFieldView(email: "shreyassahoo26@gmail.com")
    }
}
