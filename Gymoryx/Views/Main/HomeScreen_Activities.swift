import SwiftUI

struct HomeScreen_Activities: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedActivity: String? = nil
    @State private var selectedIntensity: String? = nil
    @State private var selectedHours: Int = 0
    @State private var selectedMinutes: Int = 0

    var activities = ["Running", "Walking", "Swimming", "Cycling", "Dancing", "Yoga", "Sports"]
    var intensities = ["Light", "Moderate", "Intense"]

    // Adaptive grid item to adjust width based on content
    var columns: [GridItem] = [
        GridItem(.adaptive(minimum: 85)) // Adjust minimum width as needed
    ]

    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title)
                        .foregroundColor(Color("navyblue"))
                        .padding()
                }
                Spacer()
                Text("Activity Tracker")
                    .font(.title)
                    .foregroundColor(Color("navyblue"))
                    .bold()
                Spacer()
                // Empty space for alignment
                Image(systemName: "chevron.left")
                    .font(.title)
                    .foregroundColor(.clear)
                    .padding()
            }

            VStack(spacing: 20) {
                Text("Select Activity")
                    .font(.title2)
            }
            .foregroundColor(Color("navyblue"))
            .bold()

            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(activities, id: \.self) { activity in
                    Button(action: {
                        selectedActivity = activity
                    }) {
                        Text(activity)
                            .lineLimit(1)
                            .font(.subheadline)
                            .padding()
                            .fixedSize()
                            .background(selectedActivity == activity ? Color("navyblue").opacity(0.5) : Color.gray.opacity(0.2))
                            .cornerRadius(20)
                    }
                    .frame(maxWidth: .infinity) // Ensures button can grow as needed
                }
            }
            .foregroundColor(.black)
            .padding(.horizontal)

            Text("Select Intensity")
                .font(.title2)
                .foregroundColor(Color("navyblue"))

            HStack(spacing: 20) {
                ForEach(intensities, id: \.self) { intensity in
                    Button(action: {
                        selectedIntensity = intensity
                    }) {
                        Text(intensity)
                            .padding()
                            .background(selectedIntensity == intensity ? Color("navyblue").opacity(0.5) : Color.clear)
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(lineWidth: 3)
                            )
                    }
                }
            }
            .foregroundColor(Color("navyblue"))

            Text("Select Duration")
                .font(.title2)
                .foregroundColor(Color("navyblue"))

            HStack(spacing: 20) {
                Text("Hours")
                Picker(selection: $selectedHours, label: Text("")) {
                    ForEach(0..<24) { hour in
                        Text("\(hour)").tag(hour)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: 60, height: 100)

                Text("Minutes")
                Picker(selection: $selectedMinutes, label: Text("")) {
                    ForEach(0..<60) { minute in
                        Text("\(minute)").tag(minute)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: 60, height: 100)
            }
            .padding()
            .font(.title3)
            .foregroundColor(Color("navyblue"))

            Button(action: {
                // Perform update action here
            }) {
                Text("UPDATE")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
            }
            .background {
                Color("navyblue")
                    .frame(width: 250)
                    .cornerRadius(20)
            }
            Spacer()
        }
        .bold()
    }
}

#Preview {
    HomeScreen_Activities()
}
