import SwiftUI
import SwiftData

struct AuthorListView: View {
    @Environment(\.modelContext) var context
    @Query var authors: [Author]
    
    init(sort: SortDescriptor<Author>) {
        _authors = Query(sort: [sort], animation: .easeInOut)
    }
    
    var body: some View {
        List {
            ForEach(authors) { author in
                NavigationLink {
                    AuthorDetailView(author: author)
                } label: {
                    VStack(alignment: .leading) {
                        Text(author.name)
                        Text("\(author.books.count) books")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .onDelete(perform: deleteAuthors)
        }
    }
    
    private func deleteAuthors(offsets: IndexSet) {
        for index in offsets {
            context.delete(authors[index])
        }
        try? context.save()
    }
}
