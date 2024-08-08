//
//  SetBodyMeasurement.swift
//  Gymoryx
//
//  Created by Divyansh Kaushik on 08/08/24.
//
//navyblue is a custom color

import SwiftUI


struct WheelPicker:View {
    //this is the section for wheelpicker below struct is for the layout this one is for logic and funcationality
    var config : Config
    @Binding var value:CGFloat
    @State private var isLoaded:Bool = false
    var body: some View {
        GeometryReader{
            let size = $0.size
            let horizontalPadding = size.width/2
            
            ScrollView(.horizontal)
            {
                HStack(spacing:config.spacing)
                {
                    let totalSteps = config.steps * config.count
                    ForEach(0...totalSteps,id: \.self) { index in
                        
                        let remainder = index % config.steps
                        Divider()
                            .rotationEffect(.degrees(90))
                            .frame(width: 0, height: 0,alignment: .center)
                            .overlay(alignment:.bottom)
                        {
                                if remainder == 0 && config.showText
                            {
                                    Text("\((index / config.steps)*config.multiplier)")
                                        .font(.title)
                                        .foregroundColor(.black)
                                        .fontWeight(.semibold)
                                        .fixedSize()
                                }
                            }
                    }
                }.frame(height: size.height/2)
                    .padding()
                    .scrollTargetLayout()
            }
            .scrollIndicators(.hidden)
            .scrollTargetBehavior(.viewAligned)
            .scrollPosition(id: .init(get:
                                        {
                    let position:Int? = isLoaded ? (Int(value) * config.steps) / config.multiplier: nil
                    return position
                }
                                      ,
                                      set:  {newValue in
                if let newValue{value = CGFloat(newValue)/CGFloat(config.steps)*CGFloat(config.multiplier)
                }
                }))
            
                .overlay(alignment:.center,content: {
                    Rectangle()
                        .frame(width: 60,height: 5)
                        .padding(.top,20)
                        .foregroundColor(Color("navyblue"))//custom color

                })
                .safeAreaPadding(.horizontal,horizontalPadding)
                .onAppear
            {
                    if !isLoaded{ isLoaded = true }
                }
        }.frame(height: 100)
    }
    
    
    struct Config:Equatable
    {
        var count:Int
        var steps:Int = 10
        var spacing:CGFloat = 5
        var multiplier:Int = 10
        var showText:Bool = true
    }
}

struct SetBodyMeasurement:View {
    //this struct is for layout of the screen
    @State private var config : WheelPicker.Config = .init(count: 30, steps: 5, spacing: 15, multiplier: 10)
    @State private var value:CGFloat = 60
    @State private var value1:CGFloat = 160
    var body: some View 
    {
       
            VStack
            {
                Text("Select Your Weight")
                    .font(.title3.bold())
                    .padding(.vertical)
                
                HStack(alignment:.lastTextBaseline,spacing: 5)
                {
                    let lbs = CGFloat(config.steps) * CGFloat(value)
                    Text(verbatim: "\(Int(value))")
                        .font(.system(size: 50))
                        .bold()
                        .contentTransition(.numericText(value: value))
                        .animation(.snappy, value: value)
                  
                    Text("kg")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .textScale(.secondary)
                    
                }
                WheelPicker(config: config, value: $value)
                
                Rectangle()
                    .fill(.gray)
                    .frame(width: UIScreen.main.bounds.width*0.9, height: 1)
                    .padding()
                
                    Text("Select Your Height")
                        .font(.title3.bold())
                        .padding()
                
                HStack(alignment:.lastTextBaseline,spacing: 5,content: 
                        {
                    let lbs = CGFloat(config.steps) * CGFloat(value1)
                    Text(verbatim: "\(Int(value1))")
                        .font(.system(size: 50))
                        .bold()
                        .contentTransition(.numericText(value: value1))
                        .animation(.snappy, value: value1)
                   
                    Text("cm")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .textScale(.secondary)
                    
                })
                WheelPicker(config: config, value: $value1)
            }              
            .foregroundColor(Color("navyblue"))

                .padding(.vertical,20)
        
    }
}

#Preview {
    SetBodyMeasurement()
}
