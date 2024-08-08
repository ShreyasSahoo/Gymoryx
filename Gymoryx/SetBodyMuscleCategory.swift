import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
struct SetBodyMuscleCategory: View {
    @ObservedObject var userData: UserPreferencesData

    @Binding var selectedBodyMuscleCategory: String?

    @State private var selectedURL: URL? = URL(string: "https://gymoryx.in/staticapp/index/abs")
    
    var body: some View {
        VStack {
            HStack {
                Button("Abs") {
                    selectedURL = URL(string: "https://gymoryx.in/staticapp/index/abs")
                    selectedBodyMuscleCategory = "Abs"
                    userData.bodyMuscleType = "Abs"
                }
                .padding()
                
                Button("Hamstrings") {
                    selectedURL = URL(string: "https://gymoryx.in/staticapp/index/hamstrings")
                    selectedBodyMuscleCategory = "Hamstrings"
                    userData.bodyMuscleType = "Hamstrings"

                }
                .padding()
            }
            
            if let url = selectedURL {
                WebView(url: url)
                .frame(maxWidth: .infinity, maxHeight: .infinity)}
            else {
               Text("Select an option")
                   .frame(maxWidth: .infinity, maxHeight: .infinity)
           }
        }
    }
}
