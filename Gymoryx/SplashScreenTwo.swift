//
//  SplashScreenTwo.swift
//  Gymoryx
//
//  Created by Shreyas Sahoo on 08/08/24.
//

import SwiftUI

struct SplashScreenTwo: View {
    var body: some View {
        VStack{
            Text("Custom \n Diet Plan")
                .font(.largeTitle)
                .multilineTextAlignment(.center)
                .foregroundStyle(.accent)
                .bold()
            Image("S2")
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width)
            VStack{
                Text("Make your diet healthy and")
                HStack{
                    Text("balanced with")
                    Text("AI Powered")
                        .bold()
                   
                }
                Text("customizable diet plan.")
            }
            
            .font(.title3)
           
        }
    }
}

#Preview {
    SplashScreenTwo()
}
