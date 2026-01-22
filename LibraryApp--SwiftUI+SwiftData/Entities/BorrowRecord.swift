import SwiftUI
import SwiftData

@Model
final class BorrowRecord {
    @Attribute(.unique) var id: UUID
    var borrowDate: Date
    var returnDate: Date?
    var isReturned: Bool
    
        // Many-to-One relationships
    var book: Book?
    var member: Member?
    
    init(borrowDate: Date, isReturned: Bool = false) {
        self.id = UUID()
        self.borrowDate = borrowDate
        self.isReturned = isReturned
    }
}
