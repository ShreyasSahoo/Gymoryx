//
//  HomeView.swift
//  Gymoryx
//
//  Created by Shreyas Sahoo on 08/08/24.
//

import SwiftUI



struct HomeView: View {

    @State private var showModal = false
    @State private var showModal2 = false
    
    var body: some View {
        ScrollView {
            VStack(spacing:25)
            {
                WorkoutView()
                
                VStack(alignment:.leading){
                    Text("Stay Updated, Stay Fit")
                        .font(.title3)
                        .fontWeight(.heavy)
                    VStack(alignment:.center,spacing: 10){
                        HStack(spacing:35){
                            Button(action:{
                                showModal = true
}){
                            
                                IconView(imageName: "gym_b", title : "Activity")
                            }
                            .fullScreenCover(isPresented: $showModal) {
                                HomeScreen_Activities()
                            }
                            Button(action:{
                                showModal2 = true
}){
                                IconView(imageName: "diet_b",title : "Meal")
                            }
                                                       
                            .fullScreenCover(isPresented: $showModal2) {
                                HomeScreen_Meals()
                            }
                            IconView(imageName: "health_b",title : "Tracker")
                            IconView(imageName: "weight_b",title : "Weight")
                        }
                        .frame(maxWidth: .infinity)
                            
                    }
                    
                }
                .foregroundStyle(Color("navyblue"))
                .frame(maxWidth: .infinity)
                
                VStack(alignment:.leading){
                    Text("Stay Connected")
                        .font(.title3)
                        .fontWeight(.heavy)
                    VStack(alignment:.center)
                    {
                        HStack{
                            CardView(name: "", role: "Goers", responsibility: "Connect")
                            Spacer()
                            CardView(name: "my_attendance" ,role: "Owners", responsibility: "Manage")
                        }
                        .frame(maxWidth: .infinity)
                       
                            
                    }
                    
                }
                .padding(.vertical)
                .foregroundStyle(Color("navyblue"))
                .frame(maxWidth: .infinity)
                
                VStack(alignment:.leading){
                    Text("Today's Target")
                        .font(.title3)
                        .fontWeight(.heavy)

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
        .background(.gray.opacity(0.08))
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
                
                VStack(alignment:.center,spacing: 10){
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
                .frame(width: UIScreen.main.bounds.width * 0.5)
                
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(.white)
        .clipShape(.rect(cornerRadius: 15))
        .shadow(radius: 1,x:0,y:-1)
    }
}

struct  IconView : View {
    @State var imageName : String
    @State var title : String
    var body: some View {
        VStack{
            VStack{
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 35)
                
            }
            .padding(10)
            .background(.white)
            .clipShape(.rect(cornerRadius: 20))
            .shadow(color: Color.gray,radius: 1,x: 0,y:1)
            Text(title)
                .bold()
                .font(.footnote)
        }
    }
}

struct CardView: View {
    @State var name : String
    @State var role : String
    @State var responsibility : String
    var body: some View {
        HStack{
            Spacer()
            if name.isEmpty{
                Image(systemName: "person.2.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 35)
                    .tint(Color("p1c1"))
            } else {
                Image(name)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 35)
            }
            Spacer()
            VStack(alignment:.leading){
                Text("Gym \(role)")
                    .foregroundStyle(Color("p1c3"))
                    .bold()
                Text("\(responsibility) Gym")
                    .foregroundStyle(Color("p1c1"))
                    .bold()
            }
            .font(.subheadline)
            
        }
        .padding(.vertical,10)
        .padding(8)
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
                .foregroundStyle(.orange)
                .frame(width: 10)
                .padding(5)
                .background(.white)
                .padding(10)
                .clipShape(Rectangle())
                .background(.orange)
                .clipShape(.rect(cornerRadius: 10))
            VStack(alignment:.leading){
                Text("Food Intake")
                    .foregroundStyle(.primary)
                    .font(.headline)
                    .fontWeight(.heavy)
                Text("14th March")
                    .foregroundStyle(.secondary)
                    .font(.footnote)
            }
            Spacer()
            VStack{
                Text("2500")
                    .foregroundStyle(.green)
                    .fontWeight(.heavy)
                Text("Calories")
                    .foregroundStyle(.secondary)
            }
            
        }
        .padding()
    }
}
