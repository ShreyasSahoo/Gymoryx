//
//  ContentView.swift
//  Gymoryx
//
//  Created by Shreyas Sahoo on 07/08/24.
//

import SwiftUI

struct ContentView: View {
    @State private var showSplash = true

    var body: some View {
        Group {
            if showSplash {
                SplashScreenView()
                    .onAppear {
                       
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            withAnimation {
                                showSplash = false
                            }
                        }
                    }
            } else {
                
                    SplashScreenTabBar()
                               
            }
        }
        
    }
}

#Preview {
    ContentView()
}
