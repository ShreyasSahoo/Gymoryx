//
//  SetBodyFatMaleView.swift
//  Gymoryx
//
//  Created by Shreyas Sahoo on 07/08/24.
//

import SwiftUI

struct SetBodyFatMaleView: View {
    @State var bodyFat : String = ""
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    
    var body: some View {
        
            ScrollView {
                VStack(){
                    Text("Body Fat Percent")
                        .font(.title2)
                        .bold()
                        .foregroundStyle(Color.accentColor)
                    HStack{
                        Spacer()
                          

                        TextField("Body Fat", text: $bodyFat, prompt: Text("Enter Body Fat Percent")
                            .foregroundStyle(.black) 
                            
                        )
                            .multilineTextAlignment(.center)
                            .padding()
                            .frame(width: UIScreen.main.bounds.width * 0.75)
                            .background(
                                                       Capsule()
                                                           .foregroundColor(Color.gray.opacity(0.3))
                                                   )
                                                   .overlay(
                                                       Capsule()
                                                           .stroke(Color.accentColor, lineWidth: 1)
                                                   )
                            
                            
                        Spacer()
                    }
                   
                        
                    HStack(spacing: 20){
                        Rectangle()
                            .frame(width: UIScreen.main.bounds.width / 3,height: 2)
                        Text("OR")
                        Rectangle()
                            .frame(width: UIScreen.main.bounds.width / 3,height: 2)
                    }
                       
                    Text("Set Your Body Type")
                        .font(.title2)
                        .bold()
                        .foregroundStyle(Color.accentColor)
                    
                    LazyVGrid(columns: columns,spacing: 15) {
                        ForEach(1..<10){ _ in
                            BodyTypeCard()
                               
                        }
                    }
                    
                    
                    Spacer()
                }
                .padding()
            }
            .scrollIndicators(.never)
        
    }
}

#Preview {
    SetBodyFatMaleView()
}

struct BodyTypeCard: View {
    var body: some View {
        HStack {
            VStack(spacing:0){
                Text("5 %")
                Text("-")
                Text("8 %")
            }
            
            Spacer()
            Image("BodyFat")
                .resizable()
                .scaledToFit()
                .frame(width: 100)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .foregroundStyle(.accent)
        .bold()
        .padding(.leading, 10)
        .frame(width: UIScreen.main.bounds.width / 2 - 15)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2)
    }
}
