//
//  SplashScreen.swift
//  Gymoryx
//
//  Created by Shreyas Sahoo on 08/08/24.
//

import SwiftUI


struct SplashScreen: View {
    @State private var selectedIndex = 0

    var body: some View {
        VStack {
            Spacer()
            
            TabView(selection: $selectedIndex) {
               SplashScreenOne()
                    .tag(0)
                SplashScreenTwo()
                    .tag(1)
                SplashScreenThree()
                    .tag(2)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) // Disable default page indicator
            
            HStack {
                PageIndicator(currentIndex: $selectedIndex, total: 3)
                
                Spacer()
                
                if selectedIndex != 2{
                    Button {
                        withAnimation {
                            selectedIndex = (selectedIndex + 1) % 3
                        }
                    } label: {
                        Text("NEXT")
                            .foregroundColor(.black)
                            .bold()
                    }
                } else {
                    
                    Button {
                       
                    } label: {
                        Text("GET STARTED")
                            .foregroundColor(.black)
                            .bold()
                    }
                    
                }
                
            }
            .padding()
        }
    }
}

struct PageIndicator: View {
    @Binding var currentIndex: Int
    let total: Int

    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<total, id: \.self) { index in
                Circle()
                    .fill(index == currentIndex ? Color.black : Color.gray)
                    .scaleEffect(index == currentIndex ? 1.3 : 1)
                    .frame(width: 8, height: 8)
            }
        }
    }
}


#Preview {
    SplashScreen()
}
