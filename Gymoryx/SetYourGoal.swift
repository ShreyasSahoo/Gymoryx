//
//  SetYourGoal.swift
//  Gymoryx
//
//  Created by Divyansh Kaushik on 08/08/24.
//

import SwiftUI


struct SetYourGoal:View {
    @ObservedObject var userData: UserPreferencesData

    var goals:[String] = ["Weight Loss","Gain Weight","Community Connect","Bodybuilding","Stamina & Mobility","Lifestyle Management","Strength & Conditioning","Injury Rehab"]
    var images:[String] = ["weight_lose","weight_gain","community","body","stamina","lifestyle","strength","work","community"]

    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        VStack{
            Text("Set Your Goal")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(Color("navyblue"))
            ScrollView
            {
                       LazyVGrid(columns: columns, spacing: 20)
                        {
                            ForEach(0..<goals.count, id: \.self) { index in
                            
                                Button(action:
                                        {
                                    userData.goal = goals[index]
                                    print("\(userData.goal)")//testing if button name is passing on click
                             //testing if button name is passing on click
                                })
                                {
                                   ZStack{
                                       Text(goals[index])
                                           .padding(.trailing,50)
                                           .padding(.leading,5)
                                           .fontWeight(.heavy)
                                           .font(.footnote)
                                           .foregroundColor(Color("navyblue"))

                                       Image(images[index])//add image var here
                                           .resizable()
                                           .frame(width: 50, height: 75)
                                           .padding(.leading,100)
                                           .cornerRadius(10)
                                   }
                                   .frame(width: 100, height: 75)
                               }
                                
                           }
                           .frame(maxWidth: .infinity, maxHeight: .infinity)
                           .background()
                            {
                               Color.white
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
