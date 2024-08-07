//
//  SplashScreenThree.swift
//  Gymoryx
//
//  Created by Shreyas Sahoo on 08/08/24.
//

import SwiftUI

struct SplashScreenThree: View {
    var body: some View {
        VStack{
            Text("Health \n Analytics")
                .font(.largeTitle)
                .multilineTextAlignment(.center)
                .foregroundStyle(.accent)
                .bold()
            Image("S3")
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width)
            
            VStack{
                Text("Vital Metric Calculations")
                HStack{
                    Text("Empowered by AI")
                        .bold()
                    Text("and more!")
                }
            }
            
            .font(.title3)
           
        }    }
}

#Preview {
    SplashScreenThree()
}
