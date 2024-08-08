import SwiftUI

struct WheelPicker: View {
    var config: Config
    @Binding var value: CGFloat
    @State private var isLoaded: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            let horizontalPadding = size.width / 2
            
            ScrollView(.horizontal) {
                HStack(spacing: config.spacing) {
                    let totalSteps = config.steps * config.count
                    ForEach(0...totalSteps, id: \.self) { index in
                        let remainder = index % config.steps
                        Divider()
                            .rotationEffect(.degrees(90))
                            .frame(width: 0, height: 0, alignment: .center)
                            .overlay(alignment: .bottom) {
                                if remainder == 0 && config.showText {
                                    Text("\((index / config.steps) * config.multiplier)")
                                        .font(.title)
                                        .foregroundColor(.black)
                                        .fontWeight(.semibold)
                                        .fixedSize()
                                }
                            }
                    }
                }
                .frame(height: size.height / 2)
                .padding(.vertical)
                .scrollTargetLayout()
            }
            .scrollIndicators(.hidden)
            .frame(height: size.height / 2)

            .scrollTargetBehavior(.viewAligned)
            .scrollPosition(
                id: .init(
                    get: {
                        isLoaded ? Int((value / CGFloat(config.multiplier)) * CGFloat(config.steps)) : nil
                    },
                    set: { newValue in
                        if let newValue {
                            value = CGFloat(newValue) / CGFloat(config.steps) * CGFloat(config.multiplier)
                        }
                    }
                )
            )
            .overlay(alignment: .center) {
                Rectangle()
                    .frame(width: 60, height: 5)
                    .padding(.top, 20)
                    .foregroundColor(Color("navyblue")) // Custom color
            }
            .safeAreaPadding(.horizontal, horizontalPadding)
            .onAppear {
                if !isLoaded { isLoaded = true }
            }   
        }
        .frame(height: 100)
    }
    
    struct Config: Equatable {
        var count: Int
        var steps: Int = 10
        var spacing: CGFloat = 5
        var multiplier: Int = 10
        var showText: Bool = true
    }
}

struct SetBodyMeasurement: View {
    @ObservedObject var userData: UserPreferencesData
    
    @State private var config: WheelPicker.Config = .init(count: 30, steps: 5, spacing: 15, multiplier: 10)
    @State private var weight: CGFloat = 60
    @State private var height: CGFloat = 160
    
    var body: some View {
        VStack {
            Text("Select Your Weight")
                .font(.title3.bold())
                .padding(.vertical)
            
            HStack(alignment: .lastTextBaseline, spacing: 5) {
                Text(verbatim: "\(Int(weight))")
                    .font(.system(size: 50))
                    .bold()
                    .contentTransition(.numericText(value: weight))
                    .animation(.snappy, value: weight)
                
                Text("kg")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .textScale(.secondary)
            }
            
            WheelPicker(config: config, value: $weight)
                .onChange(of: weight) { newValue in
                    userData.weight = newValue
                }
            
            Rectangle()
                .fill(.gray)
                .frame(width: UIScreen.main.bounds.width * 0.9, height: 1)
                .padding()
            
            Text("Select Your Height")
                .font(.title3.bold())
                .padding()
            
            HStack(alignment: .lastTextBaseline, spacing: 5) {
                Text(verbatim: "\(Int(height))")
                    .font(.system(size: 50))
                    .bold()
                    .contentTransition(.numericText(value: height))
                    .animation(.snappy, value: height)
                
                Text("cm")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .textScale(.secondary)
            }
            
            WheelPicker(config: config, value: $height)
                .onChange(of: height) { newValue in
                    userData.height = newValue
                }
        }
        .foregroundColor(Color("navyblue"))
        .padding(.vertical, 20)
    }
}

#Preview {
    SetBodyMeasurement(userData: UserPreferencesData())
}
