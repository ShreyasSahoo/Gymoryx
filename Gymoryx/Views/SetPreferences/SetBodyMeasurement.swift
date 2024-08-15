import SwiftUI

struct WheelPicker: View {
    var config: Config
    @Binding var value: CGFloat
    @Binding var add: CGFloat
    @State private var contentOffset: CGFloat = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            let totalSteps = config.steps * config.count
            let stepWidth = config.spacing + 0.5 // Assuming the width of Divider is minimal
            let rectangleWidth: CGFloat = 50 // Width of the selection rectangle
            
            ScrollViewReader { scrollViewProxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: config.spacing) {
                        ForEach(0...totalSteps, id: \.self) { index in
                            let remainder = index % config.steps
                            Divider().opacity(0)
                                .rotationEffect(.degrees(90))
                                .frame(width: 0.5, height: 50)
                                .overlay(alignment: .bottom) {
                                    if remainder == 0 && config.showText {
                                        // Calculate bounds for color change
                                        let lowerBound = contentOffset + (size.width / 2) - (rectangleWidth / 2)
                                        let upperBound = contentOffset + (size.width / 2) + (rectangleWidth / 2)
                                        let position = CGFloat(index) * stepWidth // Calculate position of current item
                                        
                                        // Check if the position is within the bounds
                                        let isInRectangle = position >= lowerBound && position <= upperBound
                                        
                                        Text("\(Int(getDisplayValue(for: index)))")
                                            .font(.title)
                                            .foregroundColor(isInRectangle ? .white : .black) // Change color based on position
                                            .fontWeight(.semibold)
                                            .fixedSize()
                                            .padding(.bottom, 5)
                                    }
                                }
                        }
                    }
                    .background(GeometryReader {
                        Color.clear.preference(key: ScrollViewOffsetKey.self,
                                               value: -$0.frame(in: .global).origin.x)
                    })
                    .onPreferenceChange(ScrollViewOffsetKey.self) { value in
                        contentOffset = value
                        let lowerBound = contentOffset + (size.width / 2) + (rectangleWidth / 2)
                        let upperBound = contentOffset + (size.width / 2) - (rectangleWidth / 2)
                        
                        // Find the closest step that falls within the rectangle or touches its edges
                        let index = Int((lowerBound + stepWidth / 2) / stepWidth)
                        
                        // Snap to the closest valid position
                        let snappedIndex = index - (index % config.steps)
                        self.value = CGFloat(snappedIndex / config.steps) * CGFloat(config.multiplier)
                        
//                        // Scroll to the snapped position with faster animation
                        withAnimation(.linear(duration: 0.01)) {
                            scrollViewProxy.scrollTo(snappedIndex, anchor: .center)
                        }                    }

                }
                .frame(height: size.height / 2)
                .background(alignment: .center) {
                    // Selection rectangle
                    Rectangle()
                        .fill(Color("navyblue"))
                        .stroke(Color("navyblue"), lineWidth: 5)
                        .frame(width: rectangleWidth, height: 50)
                }
                .safeAreaPadding(.horizontal, size.width / 2)
            }
        }
        .frame(height: 100)
    }
    
    private func getDisplayValue(for index: Int) -> CGFloat {
        return CGFloat(Int(index / config.steps)) * CGFloat(Int(config.multiplier)) + add
    }
    
    struct Config: Equatable {
        var count: Int = 50
        var steps: Int = 1 // Show every single value
        var spacing: CGFloat = 15
        var multiplier: Int = 1
        var showText: Bool = true
    }
}

private struct ScrollViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue: Value = 0
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

struct SetBodyMeasurement: View {
    @ObservedObject var userData: UserPreferencesData
    
    // Updated initial values
    @State private var weight: CGFloat = 40 // Start with 40 kg
    @State private var height: CGFloat = 100 // Start with 100 cm
    var addWeight: CGFloat = 40
    var addHeight: CGFloat = 100
    
    var body: some View {
        VStack {
            Text("Select Your Weight")
                .font(.title3.bold())
                .padding(.vertical)
            
            HStack(alignment: .lastTextBaseline, spacing: 5) {
                Text(verbatim: "\(Int(weight + addWeight))")
                    .font(.system(size: 50))
                    .bold()
                    .contentTransition(.numericText(value: weight))
                    .animation(.snappy, value: weight)
                
                Text("kg")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .textScale(.secondary)
            }
            
            WheelPicker(config: .init(count: 200, steps: 10, spacing: 15, multiplier: 1), value: $weight, add: .constant(addWeight))
                .onChange(of: weight) { newValue in
                    userData.weight = newValue
                }
                .onAppear {
                    // Ensure that the userData is updated when the view appears
                    userData.weight = weight
                }
            
            Rectangle()
                .fill(.gray)
                .frame(width: UIScreen.main.bounds.width * 0.9, height: 1)
                .padding()
            
            Text("Select Your Height")
                .font(.title3.bold())
                .padding()
            
            HStack(alignment: .lastTextBaseline, spacing: 5) {
                Text(verbatim: "\(Int(height + addHeight))")
                    .font(.system(size: 50))
                    .bold()
                    .contentTransition(.numericText(value: height))
                    .animation(.snappy, value: height)
                
                Text("cm")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .textScale(.secondary)
            }
            
            WheelPicker(config: .init(count: 200, steps: 10, spacing: 15, multiplier: 1), value: $height, add: .constant(addHeight))
                .onChange(of: height) { newValue in
                    userData.height = newValue
                }
                .onAppear {
                    // Ensure that the userData is updated when the view appears
                    userData.height = height
                }
        }
        .foregroundColor(Color("navyblue"))
        .padding(.vertical, 20)
    }
}

#Preview {
    SetBodyMeasurement(userData: UserPreferencesData())
}
