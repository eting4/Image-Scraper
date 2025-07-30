import SwiftUI

struct SimpleTemplate: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Hello, SwiftUI!")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("This is a simple frontend template.")
                .foregroundColor(.gray)

            Button(action: {
                print("Button tapped!")
            }) {
                Text("Tap Me")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}

struct SimpleTemplate_Previews: PreviewProvider {
    static var previews: some View {
        SimpleTemplate()
            .previewDevice("iPhone 14")
    }
}

