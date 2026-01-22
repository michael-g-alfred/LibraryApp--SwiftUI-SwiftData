import SwiftUI
import SwiftData

@Model
final class Book {
    @Attribute(.unique) var id: UUID
    var title: String
    var isbn: String
    var publishedDate: Date
    var coverColor: String
    
        // Many-to-One: Many Books belong to one Author
    var author: Author?
    
        // One-to-One: One Book has one BookDetail
    @Relationship(deleteRule: .cascade, inverse: \BookDetail.book)
    var detail: BookDetail?
    
        // Many-to-Many: Books can have multiple Categories
    var categories: [Category] = []
    
        // One-to-Many: One Book has many BorrowRecords
    @Relationship(deleteRule: .cascade, inverse: \BorrowRecord.book)
    var borrowRecords: [BorrowRecord] = []
    
    init(title: String, isbn: String, publishedDate: Date, coverColor: String) {
        self.id = UUID()
        self.title = title
        self.isbn = isbn
        self.publishedDate = publishedDate
        self.coverColor = coverColor
    }
}
