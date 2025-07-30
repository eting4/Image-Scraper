import SwiftUI

struct ZoomableImage: View {
    let url: String
    @State private var scale: CGFloat = 1.0
    @State private var lastScale: CGFloat = 1.0

    var body: some View {
        AsyncImage(url: URL(string: url)) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(scale)
                    .gesture(
                        MagnificationGesture()
                            .onChanged { value in
                                scale = lastScale * value
                            }
                            .onEnded { _ in
                                lastScale = scale
                            }
                    )
                    .animation(.easeInOut(duration: 0.2), value: scale)
            case .failure(_):
                Color.red.frame(height: 200)
            case .empty:
                ProgressView()
            @unknown default:
                EmptyView()
            }
        }
    }
}
