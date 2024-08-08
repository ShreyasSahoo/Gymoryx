//
//  SetGoalsTabBar.swift
//  Gymoryx
//
//  Created by Shreyas Sahoo on 08/08/24.
//

import SwiftUI


struct SetGoalsTabBar: View {
    @State private var selectedIndex = 1

    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                TabView(selection: $selectedIndex) {
                   SetYourGoal()
                        .tag(0)
                    SetGenderView()
                        .tag(1)
                    SetBodyMeasurement()
                        .tag(2)
                    SetBodyFatMaleView()
                        .tag(3)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                HStack {
                    PageIndicator(currentIndex: $selectedIndex, total: 4)
                    
                    Spacer()
                    
                    if selectedIndex != 3{
                        Button {
                            withAnimation {
                                selectedIndex = (selectedIndex + 1) % 4
                            }
                        } label: {
                            Text("NEXT")
                                .foregroundColor(.black)
                                .bold()
                        }
                    } else {            
                        NavigationLink(destination: Text("Home")) {
                            Text("LETS GO")
                                .foregroundColor(.black)
                                .bold()
                        }
                    }
                    
                }
                .padding()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}



#Preview {
    SetGoalsTabBar()
}

