//
//  SetGenderView.swift
//  Gymoryx
//
//  Created by Shreyas Sahoo on 07/08/24.
//

import SwiftUI

enum Gender {
    case male
    case female
}

struct SetGenderView: View {
    @State private var selectedGender : Gender? = nil
    @State private var selectedDate : Date = Date()
    
    let startingDate : Date = Calendar.current.date(from: DateComponents(
        year: 1980
    )) ?? Date()
    let endingDate : Date = Date()
    var body: some View {
        NavigationView{
            VStack(alignment:.center,spacing: 20){
                Text("Select Your Gender")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(Color.accentColor)
                
                HStack(spacing:16){
                    VStack{
                        Button{
                            setGender(gender: .female)
                        } label : {
                            Image("Female")
                                .resizable()
                                .scaledToFit()
                                .frame(width: (UIScreen.main.bounds.width/2) - 20)
                                .clipShape(.rect(cornerRadius: 10))
                                .shadow(radius: 2)
                        }
                        Text("Female")
                    }
                    VStack{
                        Button{
                            setGender(gender: .male)
                        } label : {
                            Image("Male")
                                .resizable()
                                .scaledToFit()
                                .frame(width: (UIScreen.main.bounds.width/2) - 20)
                                .clipShape(.rect(cornerRadius: 10))
                                .shadow(radius: 2)
                        }
                        
                        Text("Male")
                    }
                }
                .font(.title2)
                .bold()
                .foregroundStyle(Color.accentColor)
                
                Rectangle()
                    .frame(width: UIScreen.main.bounds.width*0.9,height: 1)
                    
                Text("Select Your Birth Date")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(Color.accentColor)
                
                DatePicker("", selection: $selectedDate,
                           in: startingDate...endingDate, displayedComponents: [.date]
                )
                .labelsHidden()
                    .datePickerStyle(WheelDatePickerStyle())
                Spacer()
            }
        }
    }
        
    
    private func setGender(gender : Gender){
        selectedGender = gender
    }
}

struct CustomDatePickerView: View {
    @State private var selectedDay = 1
    @State private var selectedMonth = 1
    @State private var selectedYear = 2000

    var body: some View {
        VStack {
            Text("Select Your Birth Date")
                .font(.title2)
                .bold()
                .padding(.bottom, 20)
            
            HStack {
                Picker("Day", selection: $selectedDay) {
                    ForEach(1...31, id: \.self) {
                        Text("\($0)").tag($0)
                    }
                }
                .frame(maxWidth: .infinity)
                .clipped()
                
                Picker("Month", selection: $selectedMonth) {
                    ForEach(1...12, id: \.self) { index in
                        Text(DateFormatter().monthSymbols[index - 1]).tag(index)
                    }
                }
                .frame(maxWidth: .infinity)
                .clipped()
                
                Picker("Year", selection: $selectedYear) {
                    ForEach(1900...2023, id: \.self) {
                        Text("\($0)").tag($0)
                    }
                }
                .frame(maxWidth: .infinity)
                .clipped()
            }
            .pickerStyle(WheelPickerStyle())
        }
        .padding()
    }
}



#Preview {
    SetGenderView()
}
