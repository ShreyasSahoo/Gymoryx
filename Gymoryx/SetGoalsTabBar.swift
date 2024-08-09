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
                    SetBodyFatView(userData: userData)
                        .tag(3)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                HStack {
                    PageIndicator(currentIndex: $selectedIndex, total: 4)
                    
                    Spacer()
                    
                    Button(action: {
                        handleNextButtonTap()
                    }) {
                        Text(selectedIndex == 3 ? "LET'S GO" : "NEXT")
                            .foregroundColor(isCurrentStepComplete() ? .black : .gray)
                            .bold()
                            .padding()
                        
                    }
                    .disabled(!isCurrentStepComplete())
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
    
    private func handleNextButtonTap() {
        if selectedIndex == 3 {
            submitData()
        } else {
            withAnimation {
                selectedIndex = (selectedIndex + 1) % 4
            }
        }
    }
    
    private func isCurrentStepComplete() -> Bool {
        switch selectedIndex {
        case 0:
            return !userData.goal.isEmpty
        case 1:
            return !userData.selectedGender.isEmpty && userData.selectedDate != Date.distantPast
        case 2:
            return userData.weight > 0 && userData.height > 0
        case 3:
            return !userData.bodyFat.isEmpty
        default:
            return false
        }
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
                    print(response ?? "No response")
                    print(error ?? "No error")
                }
            }
        }.resume()
    }
}

#Preview {
    SetGoalsTabBar(userData: UserPreferencesData())
}
