import SwiftUI
import SwiftData

struct CategoriesView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Category.name) private var categories: [Category]
    @State private var showingAddCategory = false
    
    var body: some View {
        NavigationStack {
            Group {
                if categories.isEmpty {
                    ContentUnavailableView(
                        "No Categories",
                        systemImage: "tag.fill",
                        description: Text("Add your first category to get started")
                    )
                } else {
                    List {
                        ForEach(categories) { category in
                            VStack(alignment: .leading, spacing: 4) {
                                Text(category.name)
                                    .font(.headline)
                                Text(category.categoryDescription)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                Text("\(category.books.count) book\(category.books.count == 1 ? "" : "s")")
                                    .font(.caption2)
                                    .foregroundStyle(.blue)
                            }
                        }
                        .onDelete(perform: deleteCategories)
                    }
                }
            }
            .navigationTitle("Categories")
            .toolbar {
                Button {
                    showingAddCategory = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddCategory) {
                AddCategoryView()
            }
        }
    }
    
    private func deleteCategories(offsets: IndexSet) {
        for index in offsets {
            context.delete(categories[index])
        }
        try? context.save()
    }
}
