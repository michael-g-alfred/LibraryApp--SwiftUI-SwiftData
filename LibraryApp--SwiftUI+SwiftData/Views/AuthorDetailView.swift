import SwiftUI

struct AuthorDetailView: View {
    let author: Author
    
    var body: some View {
        List {
            Section("Information") {
                LabeledContent("Name", value: author.name)
                LabeledContent("Bio", value: author.bio)
                LabeledContent("Birth Date", value: author.birthDate.formatted(date: .long, time: .omitted))
            }
            
            Section("Books (\(author.books.count))") {
                if author.books.isEmpty {
                    Text("No books yet")
                        .foregroundStyle(.secondary)
                } else {
                    ForEach(author.books) { book in
                        NavigationLink(destination: BookDetailView(book: book)) {
                            Text(book.title)
                        }
                    }
                }
            }
        }
        .navigationTitle(author.name)
    }
}
