//
//  SetGoalsTabBar.swift
//  Gymoryx
//
//  Created by Shreyas Sahoo on 08/08/24.
//

import SwiftUI


struct SetGoalsTabBar: View {
    @ObservedObject var userData: UserPreferencesData
    
    @State private var selectedIndex = 0
    @State private var isLoading: Bool = false
    @State private var successMessage: String? = nil
    @State private var errorMessage: String? = nil
    @State private var isSubmissionSuccess: Bool = false // State to trigger navigation
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                TabView(selection: $selectedIndex) {
                    SetYourGoal(userData: userData)
                        .tag(0)
                    SetGenderView(userData: userData)
                        .tag(1)
                    SetBodyMeasurement(userData: userData)
                        .tag(2)
                    SetBodyMuscleCategory(userData: userData, selectedBodyMuscleCategory: .constant(""))
                        .tag(3)
                    SetBodyFatView(userData: userData)
                        .tag(4)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                HStack {
                    PageIndicator(currentIndex: $selectedIndex, total: 5)
                    
                    Spacer()
                    
                    if selectedIndex != 4{
                        Button {
                            withAnimation {
                                selectedIndex = (selectedIndex + 1) % 5
                            }
                        } label: {
                            Text("NEXT")
                                .foregroundColor(.black)
                                .bold()
                        }
                    } else {            
                        Button(action: {
                            submitData()
                        }) {
                            Text("LET'S GO")
                                .foregroundColor(.black)
                                .bold()
                        }
                    }
                    
                }
                .padding()
                if isLoading {
                    ProgressView()
                }
                
                if let successMessage = successMessage {
                    Text(successMessage)
                        .foregroundColor(.green)
                }
                
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
            }
            .background(
                NavigationLink(
                    destination: HomeView(),
                    isActive: $isSubmissionSuccess,
                    label: { EmptyView() }
                )
            )
        }
        
        .navigationBarBackButtonHidden(true)
    }
    
    private func submitData() {
        isLoading = true
        let url = URL(string: "https://66b53e3eb5ae2d11eb632337.mockapi.io/usersPreferencesData")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let payload = [
            "goal": userData.goal,
            "selectedGender": userData.selectedGender,
            "selectedDate": ISO8601DateFormatter().string(from: userData.selectedDate),
            "weight": userData.weight,
            "height": userData.height,
            "bodyFat": userData.bodyFat,
            "bodyMuscleType": userData.bodyMuscleType
        ] as [String : Any]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: payload, options: [])
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                isLoading = false
                
                if let error = error {
                    errorMessage = "Error: \(error.localizedDescription)"
                } else if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 {
                    successMessage = "Data submitted successfully!"
                    isSubmissionSuccess = true // Trigger navigation
                    
                } else {
                    errorMessage = "Failed to submit data."
                    print(response)
                    print(error)
                }
            }
        }.resume()
    }}


#Preview {
    SetGoalsTabBar(userData: UserPreferencesData())
}

