//
//  HomeView.swift
//  Gymoryx
//
//  Created by Shreyas Sahoo on 08/08/24.
//

import SwiftUI

struct HomeView: View {

    
    var body: some View {
        ScrollView {
            VStack(spacing:25) {
                WorkoutView()
                
                VStack(alignment:.leading){
                    Text("Stay Updated, Stay Fit")
                        .font(.title3)
                        .bold()
                    VStack(alignment:.center,spacing: 10){
                        HStack{
                            IconView()
                            IconView()
                            IconView()
                            IconView()
                        }
                       
                            
                    }
                    
                }
                .foregroundStyle(Color("navyblue"))
                .frame(maxWidth: .infinity)
                
                VStack(alignment:.leading){
                    Text("Stay Connected")
                        .font(.title3)
                        .bold()
                    VStack(alignment:.center,spacing: 10){
                        HStack{
                            CardView()
                            CardView()
                        }
                       
                            
                    }
                    
                }
                .foregroundStyle(Color("navyblue"))
                .frame(maxWidth: .infinity)
                
                VStack(alignment:.leading){
                    Text("Today's Target")
                        .font(.title3)
                        .bold()
                    
                    ZStack{
                        Color.white
                            .frame(maxWidth: .infinity)
                            .clipShape(.rect(cornerRadius: 20))
                        VStack{
                            
                            TargetView()
                            TargetView()
                            TargetView()
                        }
                    }
                    
                    
                }
                .foregroundStyle(Color("navyblue"))
                .frame(maxWidth: .infinity)
                
                
            }
            .padding(.horizontal)
            
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(.gray.opacity(0.1))
        .scrollIndicators(.never)
        }
        
    
    
    }
#Preview {
    HomeView()
}

struct WorkoutView: View {
    var body: some View {
        VStack{
            Text("Today's Workout")
                .bold()
            HStack{
                VStack{
                    WebView(url: URL(string: "https://gymoryx.in/staticapp/index/abs")!)
                        .frame(width: 120)
                        .background(.red)
                }
                
                Spacer()
                
                VStack(alignment:.center){
                    Text("Biceps and Back")
                        .font(.title3)
                        .bold()
                        .foregroundStyle(Color("navyblue"))
                    HStack{
                        Text("Start")
                        Spacer()
                        Text("8:30 AM")
                    }
                    HStack{
                        Text("Calories")
                        Spacer()
                        Text("1250 Cal")
                    }
                    Button("Start"){
                        
                    }
                    .buttonStyle(BorderedProminentButtonStyle())
                }
                .frame(width: UIScreen.main.bounds.width * 0.4)
                
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(.white)
        .clipShape(.rect(cornerRadius: 15))
    }
}

struct  IconView : View {
    var body: some View {
        VStack{
            VStack{
                Image(systemName : "dumbbell.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50)
                
            }
            .padding()
            .frame(width: 80,height: 80)
            .background(.white)
            .clipShape(.rect(cornerRadius: 10))
            
            Text("Activity")
        }
    }
}

struct CardView: View {
    var body: some View {
        HStack{
            Image(systemName: "person.2.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 50)
            VStack{
                Text("Gym Goers")
                    .foregroundStyle(.teal)
                Text("Connect Gym")
                    .bold()
            }
            .font(.callout)
            
        }
        .padding(.horizontal,5)
        .padding(.vertical)
        .background(.white)
        .clipShape(.rect(cornerRadius: 10))
    }
}

struct TargetView: View {
    var body: some View {
        HStack{
            Image(systemName: "fork.knife")
                .resizable()
                .scaledToFit()
                .frame(width: 20)
            VStack(alignment:.leading){
                Text("Food Intake")
                    .foregroundStyle(.primary)
                    .font(.title3)
                    .bold()
                Text("14th March")
                    .foregroundStyle(.secondary)
            }
            Spacer()
            VStack{
                Text("2500")
                    .foregroundStyle(.green)
                    .bold()
                Text("Calories")
                    .foregroundStyle(.secondary)
            }
            
        }
        .padding()
    }
}
