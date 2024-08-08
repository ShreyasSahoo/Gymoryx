//
//  SplashScreenOne.swift
//  Gymoryx
//
//  Created by Shreyas Sahoo on 08/08/24.
//

import SwiftUI

struct SplashScreenOne: View {
    var body: some View {
        VStack{
            Text("Health \nAnalytics")
                .font(.largeTitle)
                .multilineTextAlignment(.center)
                .foregroundStyle(.accent)
                .bold()
            
            Image("S1")
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width)
            
            VStack{
                Text("Push yourself to greatness and")
                HStack{
                    Text("acheive your fitness goals with ")
                    Text("AI")
                        .bold()
                }
                HStack{
                    Text("powered")
                        .bold()
                    Text("workouts.")
                        
                }
            }
            
            .font(.title3)
           
        }
    }
}

#Preview {
    SplashScreenOne()
}
