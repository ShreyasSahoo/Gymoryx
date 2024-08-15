import SwiftUI

enum Gender {
    case male
    case female
}
struct SetGenderView: View {
    @ObservedObject var userData: UserPreferencesData

    @State private var selectedGender: Gender? = nil
    @State private var selectedDate: Date = .distantPast
    @State private var age: String = ""
    @State private var showToast = false
    
    let startingDate: Date = Calendar.current.date(from: DateComponents(year: 1980)) ?? Date()
    let endingDate: Date = Date()
    
    var isSelectionComplete: Bool {
        // Both gender should be selected and date should be changed from distantPast
        return selectedGender != nil && selectedDate != .distantPast
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 20) {
                Text("Select Your Gender")
                    .font(.title2)
                    .bold()
                    .foregroundColor(Color.accentColor)
                
                HStack(spacing: 16) {
                    VStack {
                        Button {
                            setGender(gender: .female)
                        } label: {
                            Image("Female")
                                .resizable()
                                .scaledToFit()
                                .frame(width: (UIScreen.main.bounds.width / 2) - 20)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .shadow(radius: 2)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(selectedGender == .female ? Color.gray.opacity(0.3) : Color.clear)
                                )
                        }
                        Text("Female")
                    }
                    VStack {
                        Button {
                            setGender(gender: .male)
                        } label: {
                            Image("Male")
                                .resizable()
                                .scaledToFit()
                                .frame(width: (UIScreen.main.bounds.width / 2) - 20)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .shadow(radius: 2)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(selectedGender == .male ? Color.gray.opacity(0.3) : Color.clear)
                                )
                        }
                        Text("Male")
                    }
                }
                .font(.title2)
                .bold()
                .foregroundColor(Color.accentColor)
                
                Rectangle()
                    .frame(width: UIScreen.main.bounds.width * 0.9, height: 1)
                
                Text("Select Your Birth Date")
                    .font(.title2)
                    .bold()
                    .foregroundColor(Color.accentColor)
                
                DatePicker("", selection: $selectedDate, in: startingDate...endingDate, displayedComponents: [.date])
                    .labelsHidden()
                    .datePickerStyle(WheelDatePickerStyle())
                    .onChange(of: selectedDate) { newValue in
                        userData.selectedDate = newValue
                    }
//                HStack(spacing:40){
//                    Text("Enter Your Age")
//                        .font(.title2)
//                        .bold()
//                        .foregroundColor(Color.accentColor)
//                    TextField("", text: $age)
//                        .font(.title2)
//                        .bold()
//                        .frame(width: 50)
//                        .foregroundColor(.white)
//                        .overlay(
//                            Rectangle()
//                                .frame(width: 45, height: 2)
//                                .foregroundColor(.white)
//                                .padding(.top,40)
//                        )
//
//                        .background(
//                            Rectangle()
//                                .frame(width: 50)
//                                .frame(height: 50).padding()
//                                .foregroundColor(Color("navyblue"))
//                            
//                        )
//                }
                    
                
                Spacer()
            }
            .onChange(of: selectedGender) { _ in
                if let gender = selectedGender {
                    userData.selectedGender = gender == .female ? "Female" : "Male"
                }
            }
        }
        .onAppear {
            // Ensure the selected gender and date are updated in userData
            if let gender = selectedGender {
                userData.selectedGender = gender == .female ? "Female" : "Male"
            }
            userData.selectedDate = selectedDate
        }
    }
    
    private func setGender(gender: Gender) {
        selectedGender = gender
    }
}


#Preview {
    SetGenderView(userData: UserPreferencesData())
}
