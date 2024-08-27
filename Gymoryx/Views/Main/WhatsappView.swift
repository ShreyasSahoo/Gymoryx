
import SwiftUI

struct WhatsappView: View {
    @State private var selectedCountry: String = "India (+91)"
    @State private var countryCodes = ["India (+91)", "USA (+1)", "UK (+44)", "Canada (+1)", "Australia (+61)"]

    var body: some View {
        NavigationView {
            VStack(spacing:0) {
                Image("whatsapp")
                    .resizable()
                    .frame(height: UIScreen.main.bounds.height / 2)
                    .background(Color(red: 0.171, green: 0.7, blue: 0.092))
                Rectangle()
                    .foregroundColor(.gray)
                    .opacity(0.2)
            }
            .edgesIgnoringSafeArea(.all)

            .overlay {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Setup Whatsapp Number")
                        .padding(.leading, UIScreen.main.bounds.width / 6)
                    Text("Enter Number")
                        .font(.title2)
                        .opacity(0.8)
                    
                    // Display only the country code in the TextField
                    TextField("", text: .constant(extractCountryCode(from: selectedCountry)+" "))
                    Rectangle()
                        .foregroundColor(.gray)
                        .frame(height: 1)
                        .opacity(0.8)
                        .offset(y: -10)
                    
                    // Dropdown for Country Code Selection
                    Text("Select Country Code")
                        .font(.title2)
                        .opacity(0.8)
                    
                    Menu {
                        Picker(selection: $selectedCountry, label: Text("Country Code")) {
                            ForEach(countryCodes, id: \.self) { code in
                                Text(code).tag(code)
                            }
                        }
                    } label: {
                        HStack {
                            Text(selectedCountry)
                                .foregroundColor(.black)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Image(systemName: "chevron.down")
                                .padding()
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.8), lineWidth: 1)
                                .background(Color.white)
                        )
                    }
                    
                    NavigationLink(destination: WhatsappView()) {
                        Text("SAVE AND CONTINUE")
                            .foregroundColor(.white)
                            .font(.title3)
                            .bold()
                    }
                    .padding()
                    .foregroundColor(.black)
                    .bold()
                    .frame(width: 275, height: 60)
                    .background {
                        Color("navyblue")
                            .cornerRadius(20)
                    }
                    .padding(.leading, 20)

                    Text("We will use your mobile number to send you health reports, reminders and updates on WhatsApp.")
                        .foregroundColor(.gray)
                        .font(.footnote)
                        .multilineTextAlignment(.center)
                }
                .bold()
                .padding()
                .background {
                    Color.white
                        .cornerRadius(20)
                        .shadow(color: .black, radius: 1)
                }
                .padding()
            }
        }
    }
    
    // Function to extract the country code from the selectedCountry string
    private func extractCountryCode(from country: String) -> String {
        if let codeStartIndex = country.firstIndex(of: "("),
           let codeEndIndex = country.firstIndex(of: ")") {
            let startIndex = country.index(after: codeStartIndex)
            return String(country[startIndex..<codeEndIndex])
        }
        return country
    }
}

#Preview {
    WhatsappView()
}
