//
//  SplashScreen.swift
//  Gymoryx
//
//  Created by Shreyas Sahoo on 08/08/24.
//

import SwiftUI

struct SplashScreenTabBar: View {
    @State private var selectedIndex = 0
    @State private var dragOffset: CGFloat = 0.0

    var body: some View {
        NavigationView {
            VStack {
                Spacer()

                TabView(selection: $selectedIndex) {
                    SplashScreenOne()
                        .tag(0)
                    SplashScreenTwo()
                        .tag(1)
                    SplashScreenThree()
                        .tag(2)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    dragOffset = value.translation.width
                                }
                                .onEnded { value in
                                    if dragOffset < -100 {
                                        selectedIndex = 3
                                    }
                                    dragOffset = 0
                                }
                        )
                        .background(
                            NavigationLink(destination: LoginScreen(), isActive: .constant(selectedIndex == 3)) {
                                EmptyView()
                            }
                        )
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) // Disable default page indicator

                HStack {
                    PageIndicator(currentIndex: $selectedIndex, total: 3)

                    Spacer()

                    if selectedIndex != 2 {
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
                        NavigationLink(destination: LoginScreen()) {
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
    SplashScreenTabBar()
}
