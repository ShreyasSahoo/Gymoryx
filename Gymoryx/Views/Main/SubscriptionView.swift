//
//  SubscriptionView.swift
//  Gymoryx
//
//  Created by Divyansh Kaushik on 23/08/24.
//

import SwiftUI
struct Plan:Identifiable{
    var id = UUID()
    var imageName : String? = "gymoryx"
    var name : String
    var price : Int
    
}
struct SubscriptionView: View {
    @State var promo : String = ""
    @State var amount : Int = 0
    var body: some View {
        let plans = [Plan(imageName : "google",name: "1 Month", price: 699),
                     Plan(name: "1 Month", price: 699),
                     Plan(name: "1 Month", price: 699),
                     Plan(name: "1 Month", price: 699)]

        let columns : [GridItem] =
        [
            GridItem(.flexible())
            ,GridItem(.flexible())
        ]
        NavigationView{
            ScrollView(showsIndicators: false){
            VStack(spacing:20){
            
                //: Section 1 Label
                Text("Gymoryx Subscription")
                    .foregroundColor(Color("navyblue"))
                    .font(.title2)
                    .bold()
                    .padding()
                
                //: Section 2 Choose Your Plan
                HStack{
                    Rectangle()
                    Text("Choose Your Plan")
                        .bold()
                        .fixedSize(horizontal: true, vertical: false)
                    Rectangle()
                }
                .frame(height: 3)
                .foregroundColor(.gray)
                .padding()
                
                LazyVGrid(columns : columns , spacing : 20){
                    ForEach(plans){ plan in
                        Button(action:{ amount = amount + plan.price}){
                                VStack
                            {
                                    Image(plan.imageName ?? "gymoryx")
                                        .resizable()
                                        .frame(width: 60, height: 60)
                                
                                    Text(plan.name)
                                    .font(.title3)
                                    Text("INR \(plan.price)")
                                    .font(.callout)

                                }
                                .foregroundColor(Color("navyblue"))
                                .bold()
                                .padding(.horizontal)
                                .frame(width: 175, height: 125)
                                .background{
                                    Color.white
                                        .cornerRadius(10)
                                        .shadow(color: .black, radius: 2)
                                    
                                }
                            }
                    }
                    
                    }
                
                //: Section 3 Avail Discount
                HStack{
                    Rectangle()
                    Text("Avail Discount")
                        .bold()
                        .fixedSize(horizontal: true, vertical: false)
                    Rectangle()
                }
                .frame(height: 3)
                .foregroundColor(.gray)
                .padding()
                HStack{
                    TextField("Enter Promo Code", text: $promo).padding()
                        .foregroundColor(.black)
                        .bold()
                        .frame(height: 50)
                        .background{
                            Color.gray
                                .cornerRadius(30)
                                .opacity(0.3)
                        }
                    Button(action:{}){
                        Text("Apply")
                    }
                    .padding()
                    .foregroundColor(.black)
                        .bold()
                        .frame(height: 50)
                        .background{
                            Color("navyblue").saturation(10)
                                .cornerRadius(30)
                                .opacity(0.3)
                        }
                }
                .padding(.horizontal,20)

                
                //: Section 4 Purchase Details
                HStack{
                    Rectangle()
                    Text("Purchase Details")
                        .bold()
                        .fixedSize(horizontal: true, vertical: false)
                    Rectangle()
                }
                .frame(height: 3)
                .foregroundColor(.gray)
                .padding()
                Text("Final Amount : INR \(amount)")                    .foregroundColor(Color("navyblue"))
                    .font(.title3)
                    .bold()
                Button(action:{}){
                    Text("PURCHASE")
                        .foregroundColor(.white)
                        .font(.title)
                        .bold()
                }
                .padding()
                .foregroundColor(.black)
                    .bold()
                    .frame(width : 325, height: 60)
                    .background{
                        Color("navyblue")
                            .cornerRadius(20)
                    }
                NavigationLink( destination: WhatsappView()){
                 
                        Text("Skip for now")
                            .font(.callout)
                            .foregroundColor(Color("navyblue"))
                            .bold()
                    }
        }
        }}
    }
}

#Preview {
    SubscriptionView()
}
