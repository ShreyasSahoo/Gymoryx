//
//  SplashScreen.swift
//  Gymoryx
//
//  Created by Shreyas Sahoo on 09/08/24.
//

import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        VStack {
            Spacer()
            Image("gymoryx")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
            Spacer()
        }
    }
}
#Preview {
    SplashScreenView()
}
