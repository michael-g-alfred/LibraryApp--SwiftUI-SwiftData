import SwiftUI
import SwiftData

@Model
final class BookDetail {
    @Attribute(.unique) var id: UUID
    var pageCount: Int
    var synopsis: String
    var language: String
    
        // One-to-One: One BookDetail belongs to one Book
    var book: Book?
    
    init(pageCount: Int, synopsis: String, language: String) {
        self.id = UUID()
        self.pageCount = pageCount
        self.synopsis = synopsis
        self.language = language
    }
}
