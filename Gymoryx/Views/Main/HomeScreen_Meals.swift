import SwiftUI

struct HomeScreen_Meals: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedMeal: String? = nil
    @State private var selectedDiet: String? = nil
    @State private var selectedHours: Int = 0
    @State private var selectedMinutes: Int = 0

    @State private var freshFoodInput: String = ""
    @State private var portionInput: String = ""
    @State private var freshFoods: [(food: String, portion: Int)] = []

    var mealType = ["Breakfast", "Lunch", "Dinner", "Snack", "Sports"]
    var dietType = ["Recommended", "Fresh Food"]

    var columns: [GridItem] =
    [
        GridItem(.flexible()) ,
        GridItem(.flexible()) ,
        GridItem(.flexible())
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
                Text("Meal Tracker")
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

            Text("Select Meal Type")
                .font(.title2)
                .foregroundColor(Color("navyblue"))
                .bold()

            LazyVGrid(columns: columns) {
                ForEach(mealType, id: \.self) { meal in
                    Button(action: {
                        selectedMeal = meal
                    }) {
                        Text(meal)
                            .lineLimit(1)
                            .font(.subheadline)
                            .padding()
                            .background(selectedMeal == meal ? Color("navyblue").opacity(0.5) : Color.gray.opacity(0.2))
                            .cornerRadius(20)
                    }
                }
            }
            .foregroundColor(.black)

            Text("Select Diet Type")
                .font(.title2)
                .foregroundColor(Color("navyblue"))

            HStack(spacing: 20) {
                ForEach(dietType, id: \.self) { diet in
                    Button(action: {
                        selectedDiet = diet
                    }) {
                        Text(diet)
                            .padding()
                            .background(selectedDiet == diet ? Color("navyblue").opacity(0.5) : Color.clear)
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(lineWidth: 3)
                            )
                    }
                }
            }
            .foregroundColor(Color("navyblue"))

            ZStack {
                Rectangle()
                    .frame(width: 130, height: 3)
                    .foregroundColor(.gray).opacity(0.4)
                    .offset(x: -100.0, y: 20)
                Rectangle()
                    .frame(width: 100, height: 3)
                    .foregroundColor(.gray).opacity(0.4)
                    .offset(x: 25, y: 20)
                HStack (spacing: 15) {
                    TextField("Add Fresh Food", text: $freshFoodInput)
                        .frame(width: 125)

                    TextField("Portion", text: $portionInput)
                        .frame(width: 100)
                        .keyboardType(.numberPad)  // Only allow number input

                    Button(action: {
                        addFreshFood()
                    }) {
                        Text("ADD")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                    }
                    .background {
                        Color("navyblue").cornerRadius(20)
                    }
                }
                .padding()
            }

            VStack(alignment: .leading, spacing: 10) {
                ForEach(freshFoods.indices, id: \.self) { index in
                    HStack {
                        Text("\(freshFoods[index].food) ")
                            .foregroundColor(.black)
                        Spacer()

                        Text(" \(freshFoods[index].portion)")
                            .foregroundColor(.black)
                        Spacer()

                        Button(action: {
                            removeFreshFood(at: index)
                        }) {
                            Text("Remove")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                        }
                        .background {
                            Color("navyblue").cornerRadius(20)
                        }
                    }
                }
            }
            .padding(.horizontal)

            Button(action: {
                // Submit action
            }) {
                Text("SUBMIT")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
            }
            .background {
                Color("navyblue")
                    .frame(width: 250)
                    .cornerRadius(20)
            }
            Spacer()        }
        .bold()
        .padding()
    }

    private func addFreshFood() {
        guard !freshFoodInput.isEmpty, let portion = Int(portionInput), portion > 0 else { return }
        freshFoods.append((food: freshFoodInput, portion: portion))
        freshFoodInput = ""
        portionInput = ""
    }

    private func removeFreshFood(at index: Int) {
        freshFoods.remove(at: index)
    }
}

#Preview {
    HomeScreen_Meals()
}
