import SwiftUI

struct SetBodyFatView: View {
    @ObservedObject var userData: UserPreferencesData

    @State var bodyFat: String = ""
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    let bodyFatTypesMale = [
        ("5% - 8%", "body_fat_one_male"),
        ("9% - 12%", "body_fat_two_male"),
        ("13% - 15%", "body_fat_three_male"),
        ("16% - 18%", "body_fat_four_male"),
        ("19% - 23%", "body_fat_five_male"),
        ("24% - 28%", "body_fat_six_male"),
        ("29% - 33%", "body_fat_seven_male"),
        ("34% - 40%", "body_fat_eight_male"),
        ("40%+", "body_fat_nine_male")
    ]

    let bodyFatTypesFemale = [
        ("10% - 14%", "body_fat_one_female"),
        ("15% - 17%", "body_fat_two_female"),
        ("18% - 20%", "body_fat_three_female"),
        ("21% - 23%", "body_fat_four_female"),
        ("24% - 26%", "body_fat_five_female"),
        ("27% - 30%", "body_fat_six_female"),
        ("31% - 38%", "body_fat_seven_female"),
        ("39% - 45%", "body_fat_eight_female"),
        ("45%+", "body_fat_nine_female")
    ]
    
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
                        .frame(width: UIScreen.main.bounds.width / 3, height: 2)
                    Text("OR")
                    Rectangle()
                        .frame(width: UIScreen.main.bounds.width / 3, height: 2)
                }
                
                Text("Set Your Body Type")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(Color.accentColor)
                
                LazyVGrid(columns: columns, spacing: 15) {
                    ForEach(userData.selectedGender == "Female" ? bodyFatTypesFemale : bodyFatTypesMale, id: \.0) { bodyFatType in
                        BodyTypeCard(bodyFat: $bodyFat, bodyType: bodyFatType.0, bodyTypeImage: bodyFatType.1)
                    }
                }
                .onChange(of: bodyFat) { newValue in
                    userData.bodyFat = newValue
                }
                
                Spacer()
            }
            .padding()
        }
        .scrollIndicators(.never)
    }
}

#Preview {
    SetBodyFatView(userData: UserPreferencesData())
}

struct BodyTypeCard: View {
    @Binding var bodyFat: String
    var bodyType: String
    var bodyTypeImage: String
    
    var body: some View {
        Button {
            bodyFat = bodyType
            print(bodyFat)
        } label: {
            HStack {
                VStack(spacing: 0) {
                    Text(bodyType)
                }
                
                Spacer()
                Image(bodyTypeImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .foregroundStyle(.accent)
            .bold()
            .padding(.leading, 10)
            .frame(width: UIScreen.main.bounds.width / 2 - 15)
            .background(bodyFat == bodyType ? Color.accentColor.opacity(0.2) : Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2)
        }
    }
}
