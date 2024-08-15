import SwiftUI

struct SetYourGoal: View {
    
    @ObservedObject var userData: UserPreferencesData
    @State private var showToast = false
    
    var goals: [String] = ["Weight Loss", "Gain Weight", "Community Connect", "Bodybuilding", "Stamina & Mobility", "Lifestyle Management", "Strength & Conditioning", "Injury Rehab"]
    var images: [String] = ["weight_lose", "weight_gain", "community", "body", "stamina", "lifestyle", "strength", "rehab", "community"]
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        VStack {
            Text("Set Your Goal")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(Color("navyblue"))
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(0..<goals.count, id: \.self) { index in
                        Button(action: {
                            userData.goal = goals[index]
                            print("\(userData.goal)") // testing if button name is passing on click
                        }) {
                            ZStack {
                                Text(goals[index])
                                    .padding(.trailing, 50)
                                    .padding(.leading, 5)
                                    .fontWeight(.heavy)
                                    .font(.footnote)
                                    .foregroundColor(Color("navyblue"))

                                Image(images[index])
                                    .resizable()
                                    .frame(width: 50, height: 75)
                                    .padding(.leading, 120)
                                    .cornerRadius(10)
                            }
                            .frame(width: 100, height: 75)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(
                            userData.goal == goals[index] ? Color.blue.opacity(0.2) : Color.white // Highlight selected button
                        )
                        .cornerRadius(10)
                        .shadow(radius: 3)
                        .padding(.trailing)
                    }
                }
                .padding()
            }
        }
    }
}
