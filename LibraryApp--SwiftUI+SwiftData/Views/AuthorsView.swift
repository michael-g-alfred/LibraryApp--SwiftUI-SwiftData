import SwiftUI
import SwiftData

struct AuthorsView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Author.name) private var authors: [Author]
    @State private var showingAddAuthor = false
    
    var body: some View {
        NavigationStack {
            Group {
                if authors.isEmpty {
                    ContentUnavailableView(
                        "No Authors",
                        systemImage: "person.3.fill",
                        description: Text("Add your first author to get started")
                    )
                } else {
                    List {
                        ForEach(authors) { author in
                            NavigationLink(destination: AuthorDetailView(author: author)) {
                                VStack(alignment: .leading) {
                                    Text(author.name)
                                        .font(.headline)
                                    Text("\(author.books.count) book\(author.books.count == 1 ? "" : "s")")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }
                        .onDelete(perform: deleteAuthors)
                    }
                }
            }
            .navigationTitle("Authors")
            .toolbar {
                Button {
                    showingAddAuthor = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddAuthor) {
                AddAuthorView()
            }
        }
    }
    
    private func deleteAuthors(offsets: IndexSet) {
        for index in offsets {
            context.delete(authors[index])
        }
        try? context.save()
    }
}
