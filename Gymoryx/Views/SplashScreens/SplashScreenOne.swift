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
            Image("sa3")
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width)
           
        }
    }
}

#Preview {
    SplashScreenOne()
}
