//
//  OTPModifer.swift
//  Gymoryx
//
//  Created by Shreyas Sahoo on 15/08/24.
//


import SwiftUI
import Combine

struct OTPModifer: ViewModifier {
    
    @Binding var pin : String
    
    var textLimt = 1

    func limitText(_ upper : Int) {
        if pin.count > upper {
            self.pin = String(pin.prefix(upper))
        }
    }
    
    
    //MARK -> BODY
    func body(content: Content) -> some View {
        content
            .multilineTextAlignment(.center)
            .keyboardType(.numberPad)
            .onReceive(Just(pin)) {_ in limitText(textLimt)}
            .frame(width: 45, height: 45)
            .background(Color.white.cornerRadius(5))
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.blue, lineWidth: 2)
            )
    }
}

struct OtpView: View {
    @State private var pin1: String = ""
    
    var body: some View {
        HStack {
            TextField("", text: $pin1)
                .modifier(OTPModifer(pin: $pin1))
        }
        .padding()
        .background(Color.gray.opacity(0.1))
    }
}

// Preview
struct OtpView_Previews: PreviewProvider {
    static var previews: some View {
        OtpView()
    }
}
