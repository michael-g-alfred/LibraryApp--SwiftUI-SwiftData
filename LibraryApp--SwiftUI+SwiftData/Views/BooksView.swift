import SwiftUI
import SwiftData

struct BooksView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Book.title) private var books: [Book]
    @Query(sort: \Author.name) private var authors: [Author]
    @State private var showingAddBook = false
    
    var body: some View {
        NavigationStack {
            Group {
                if books.isEmpty {
                    ContentUnavailableView(
                        "No Books",
                        systemImage: "books.vertical.fill",
                        description: Text("Add your first book to get started")
                    )
                } else {
                    List {
                        ForEach(books) { book in
                            NavigationLink(destination: BookDetailView(book: book)) {
                                HStack {
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(Color(hex: book.coverColor))
                                        .frame(width: 40, height: 60)
                                    
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(book.title)
                                            .font(.headline)
                                        Text(book.author?.name ?? "Unknown Author")
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                        if !book.categories.isEmpty {
                                            Text(book.categories.map { $0.name }.joined(separator: ", "))
                                                .font(.caption2)
                                                .foregroundStyle(.blue)
                                        }
                                    }
                                }
                            }
                        }
                        .onDelete(perform: deleteBooks)
                    }
                }
            }
            .navigationTitle("Books")
            .toolbar {
                Button {
                    showingAddBook = true
                } label: {
                    Image(systemName: "plus")
                }
                .disabled(authors.isEmpty)
            }
            .sheet(isPresented: $showingAddBook) {
                AddBookView()
            }
        }
    }
    
    private func deleteBooks(offsets: IndexSet) {
        for index in offsets {
            context.delete(books[index])
        }
        try? context.save()
    }
}
