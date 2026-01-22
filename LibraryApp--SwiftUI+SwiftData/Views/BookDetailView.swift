import SwiftUI

struct BookDetailView: View {
    let book: Book
    
    var body: some View {
        List {
            Section {
                HStack {
                    Spacer()
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(hex: book.coverColor))
                        .frame(width: 120, height: 180)
                        .shadow(radius: 5)
                    Spacer()
                }
                .listRowBackground(Color.clear)
            }
            
            Section("Information") {
                LabeledContent("Title", value: book.title)
                LabeledContent("ISBN", value: book.isbn)
                LabeledContent("Author", value: book.author?.name ?? "Unknown")
                LabeledContent("Published", value: book.publishedDate.formatted(date: .long, time: .omitted))
            }
            
            if let detail = book.detail {
                Section("Details") {
                    LabeledContent("Pages", value: "\(detail.pageCount)")
                    LabeledContent("Language", value: detail.language)
                    LabeledContent("Synopsis", value: detail.synopsis)
                }
            }
            
            Section("Categories") {
                if book.categories.isEmpty {
                    Text("No categories")
                        .foregroundStyle(.secondary)
                } else {
                    ForEach(book.categories) { category in
                        HStack {
                            Text(category.name)
                            Spacer()
                            Text("\(category.books.count) books")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
            
            Section("Borrow History") {
                if book.borrowRecords.isEmpty {
                    Text("Never borrowed")
                        .foregroundStyle(.secondary)
                } else {
                    ForEach(book.borrowRecords.sorted(by: { $0.borrowDate > $1.borrowDate })) { record in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(record.member?.name ?? "Unknown Member")
                                .font(.headline)
                            Text("Borrowed: \(record.borrowDate.formatted(date: .abbreviated, time: .omitted))")
                                .font(.caption)
                            if let returnDate = record.returnDate {
                                Text("Returned: \(returnDate.formatted(date: .abbreviated, time: .omitted))")
                                    .font(.caption)
                                    .foregroundStyle(.green)
                            } else {
                                Text("Not returned yet")
                                    .font(.caption)
                                    .foregroundStyle(.orange)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
        }
        .navigationTitle(book.title)
    }
}
