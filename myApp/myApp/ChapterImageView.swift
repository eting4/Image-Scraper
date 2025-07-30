import SwiftUI

struct ChapterImageView: View {
    let chapterURL: String
    @State private var imageUrls: [String] = []
    @State private var isLoading = true

    var body: some View {
        ZStack {
            HideTabBar() // 👈 This hides the tab bar when this view is shown

            ScrollView {
                if isLoading {
                    ProgressView("Loading images...")
                        .foregroundColor(.white)
                        .padding()
                } else if imageUrls.isEmpty {
                    Text("No images found.")
                        .foregroundColor(.gray)
                } else {
                    VStack(spacing: 20) {
                        ForEach(imageUrls, id: \.self) { url in
                            ZoomableImage(url: url)
                        }
                    }
                    .padding()
                }
            }
            .background(Color.black.ignoresSafeArea())
            .navigationTitle("Chapter Images")
            .foregroundColor(.white)
            .onAppear {
                fetchImages()
            }
        }
    }

    private func fetchImages() {
        guard let encodedLink = chapterURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "http://127.0.0.1:5000/extract-images?link=\(encodedLink)") else {
            print("❌ Invalid URL")
            isLoading = false
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            defer { isLoading = false }

            guard error == nil, let data = data else {
                print("❌ Network error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
               let images = json["images"] as? [String] {
                DispatchQueue.main.async {
                    self.imageUrls = images
                }
            } else {
                print("❌ Failed to parse JSON")
            }
        }.resume()
    }
}
