import SwiftUI
import SwiftData

struct AddBookView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @Query(sort: \Author.name) private var authors: [Author]
    @Query(sort: \Category.name) private var categories: [Category]
    
    @State private var title = ""
    @State private var isbn = ""
    @State private var publishedDate = Date()
    @State private var selectedAuthor: Author?
    @State private var pageCount = 100
    @State private var synopsis = ""
    @State private var selectedCategories: Set<Category> = []
    @State private var coverColor = "#3498db"
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Book Information") {
                    TextField("Title", text: $title)
                    TextField("ISBN", text: $isbn)
                    DatePicker("Published Date", selection: $publishedDate, displayedComponents: .date)
                    
                    Picker("Author", selection: $selectedAuthor) {
                        Text("Select Author").tag(nil as Author?)
                        ForEach(authors) { author in
                            Text(author.name).tag(author as Author?)
                        }
                    }
                }
                
                Section("Book Details (One-to-One)") {
                    Stepper("Pages: \(pageCount)", value: $pageCount, in: 1...2000)
                    TextField("Synopsis", text: $synopsis, axis: .vertical)
                        .lineLimit(3...6)
                }
                
                Section("Categories (Many-to-Many)") {
                    if categories.isEmpty {
                        Text("No categories available")
                            .foregroundStyle(.secondary)
                    } else {
                        ForEach(categories) { category in
                            Toggle(category.name, isOn: Binding(
                                get: { selectedCategories.contains(category) },
                                set: {
                                    if $0 {
                                        selectedCategories.insert(category)
                                    } else {
                                        selectedCategories.remove(category)
                                    }
                                }
                            ))
                        }
                    }
                }
                
                Section("Appearance") {
                    ColorPicker("Cover Color", selection: Binding(
                        get: { Color(hex: coverColor) },
                        set: { coverColor = $0.toHex() }
                    ))
                }
            }
            .navigationTitle("Add Book")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        guard let author = selectedAuthor else { return }
                        
                        let book = Book(
                            title: title,
                            isbn: isbn,
                            publishedDate: publishedDate,
                            coverColor: coverColor
                        )
                        book.author = author
                        
                        let detail = BookDetail(
                            pageCount: pageCount,
                            synopsis: synopsis,
                            language: "English"
                        )
                        book.detail = detail
                        book.categories = Array(selectedCategories)
                        
                        context.insert(book)
                        try? context.save()
                        dismiss()
                    }
                    .disabled(title.isEmpty || selectedAuthor == nil)
                }
            }
        }
    }
}
