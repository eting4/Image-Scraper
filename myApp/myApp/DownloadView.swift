import SwiftUI

struct DownloadView: View {
    @State private var inputText: String = "http://127.0.0.1:5000/load-chapters?link=https://vinlandsagachapter.com/"
    @AppStorage("savedChapters") private var savedChaptersJSON: String = "{}"
    @State private var showNamePrompt = false
    @State private var newBookName = ""
    @State private var latestChapters: [String] = []

    var body: some View {
        NavigationView {
            ZStack {
                Color.black
                    .ignoresSafeArea() // Make the black background go edge-to-edge

                VStack {
                    Spacer()

                    TextField("Enter URL", text: $inputText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 40)
                        .padding(.vertical, 10)

                    Button(action: { handleURL(inputText) }) {
                        Text("Submit")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .padding(.horizontal, 40)
                    }

                    Button("Clear Saved Chapters") {
                        clearArray()
                    }
                    .padding()
                    .foregroundColor(.red)

                    Spacer()
                }
            }
            .navigationTitle("Download")
            .alert("Enter Book Name", isPresented: $showNamePrompt, actions: {
                TextField("Book Name", text: $newBookName)
                Button("Save", action: saveChapters)
                Button("Cancel", role: .cancel) {}
            })
        }
    }


    func handleURL(_ url: String) {
        guard url.lowercased().starts(with: "http"),
              let requestURL = URL(string: url) else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: requestURL) { data, response, error in
            if let error = error {
                print("Request error: \(error)")
                return
            }

            guard let data = data else {
                print("No data received")
                return
            }

            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let chapters = json["chapters"] as? [String] {

                    print("✅ Fetched \(chapters.count) chapter URLs")
                    DispatchQueue.main.async {
                        latestChapters = chapters
                        showNamePrompt = true
                    }

                } else {
                    print("Could not parse 'chapters' from JSON")
                }
            } catch {
                print("Failed to parse JSON: \(error)")
            }
        }.resume()
    }

    func saveChapters() {
        guard !newBookName.isEmpty else { return }

        var bookDict = (try? JSONDecoder().decode([String: [String]].self, from: Data(savedChaptersJSON.utf8))) ?? [:]
        if bookDict[newBookName] != nil {
            return
        }
        
        let uniqueChapters = latestChapters.reduce(into: [String]()) { result, url in
            let containsChapter = url.lowercased().contains("chapter")
            let containsNumber = url.range(of: #"\d+"#, options: .regularExpression) != nil
            
            if containsChapter && containsNumber && !result.contains(url) {
                result.append(url)
            }
        }
        bookDict[newBookName] = uniqueChapters

        if let updatedData = try? JSONEncoder().encode(bookDict),
           let updatedJSON = String(data: updatedData, encoding: .utf8) {
            savedChaptersJSON = updatedJSON
            print("✅ Saved under book name: \(newBookName)")
            print(savedChaptersJSON)
        }

        newBookName = ""
    }

    func clearArray() {
        savedChaptersJSON = "{}"
    }
}


