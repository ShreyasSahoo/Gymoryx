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
            Image("sa2")
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width)
        }
    }
}

#Preview {
    SplashScreenTwo()
}
