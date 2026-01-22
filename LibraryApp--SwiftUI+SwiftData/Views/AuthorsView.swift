import SwiftUI
import SwiftData

struct AuthorsView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Author.name) private var authors: [Author]
    @State private var showingAddAuthor = false
    @State private var sortOrder = SortDescriptor(\Author.name)
    
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
                    AuthorListView(sort: sortOrder)
                }
            }
            .navigationTitle("Authors")
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Menu {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Name")
                                .tag(SortDescriptor(\Author.name))
                            Text("Books Count")
                                .tag(SortDescriptor(\Author.cachedBooksCount, order: .reverse))
                            Text("Birth Date")
                                .tag(SortDescriptor(\Author.birthDate))
                        }
                    } label: {
                        Image(systemName: "arrow.up.arrow.down")
                    }
                    Button {
                        showingAddAuthor = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddAuthor) {
                AddAuthorView()
            }
        }
    }
}
