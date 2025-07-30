import SwiftUI

struct ChapterListView: View {
    let bookTitle: String
    let chapters: [String]

    var body: some View {
        ZStack {
            HideTabBar() // 👈 Hides tab bar when this view is pushed

            List(chapters, id: \.self) { chapter in
                NavigationLink(destination: ChapterImageView(chapterURL: chapter)) {
                    Text(chapter)
                        .foregroundColor(.white)
                }
                .listRowBackground(Color.black)
            }
            .scrollContentBackground(.hidden)
            .background(Color.black)
            .navigationTitle(bookTitle)
        }
    }
}

#Preview {
    SavedView()
}


