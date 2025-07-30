import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            DownloadView()
                .tabItem {
                    Image(systemName: "arrow.down.circle")
                    Text("Download")
                }

            SavedView()
                .tabItem {
                    Image(systemName: "bookmark")
                    Text("Saved")
                }
        }
    }
}

#Preview {
    ContentView()
}
