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
    @ObservedObject var userData: UserPreferencesData

    @State private var selectedGender : Gender? = nil
    @State private var selectedDate : Date = Date()
    
    let startingDate : Date = Calendar.current.date(from: DateComponents(
        year: 1980
    )) ?? Date()
    let endingDate : Date = Date()
    var body: some View {
       
            ScrollView{
                VStack(alignment:.center,spacing: 20){
                    Text("Select Your Gender")
                        .font(.title2)
                        .bold()
                        .foregroundStyle(Color.accentColor)
                    
                    HStack(spacing:16){
                        VStack{
                            Button{
                                setGender(gender: .female)
                                userData.selectedGender = "Female"

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
                                userData.selectedGender = "Male"

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
                    .onChange(of: selectedDate) { newValue in
                                           userData.selectedDate = newValue
                                       }
                    Spacer()
                }
            }
        
    }
        
    
    private func setGender(gender : Gender){
        selectedGender = gender
    }
}


