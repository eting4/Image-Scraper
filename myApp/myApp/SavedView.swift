import SwiftUI

struct SavedView: View {
    
    @AppStorage("savedChapters") private var savedChapters: String = "{}"
    
    // Decode savedChapters into a usable dictionary
    var savedManga: [String: [String]] {
        guard let data = savedChapters.data(using: .utf8),
              let dict = try? JSONDecoder().decode([String: [String]].self, from: data) else {
            return [:]
        }
        return dict
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    if savedManga.isEmpty {
                        Text("No saved chapters.")
                            .foregroundColor(.gray)
                            .padding(.top, 40)
                            .frame(maxWidth: .infinity, alignment: .center)
                    } else {
                        ForEach(savedManga.sorted(by: { $0.key < $1.key }), id: \.key) { (key, chapters) in
                            NavigationLink(
                                destination: ChapterListView(bookTitle: key, chapters: chapters)
                                    .navigationBarTitleDisplayMode(.inline)
                                    .toolbarBackground(Color.black, for: .navigationBar)
                                    .toolbarBackground(.visible, for: .navigationBar)
                            ) {
                                displayManga(forKey: key)
                            }
                        }
                    }
                }
                .padding(.top, 0)
                .padding(.horizontal)
            }
            .background(.black)
            .navigationTitle("Your Saved Manga")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(.visible, for: .tabBar) // 👈 Keeps tab bar visible on root
        }
    }

    // Display a single chapter view
    func displayManga(forKey key: String) -> some View {
        Text("📘 \(key)")
            .font(.headline)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(8)
    }
}

#Preview {
    ContentView()
}
