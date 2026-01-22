import SwiftUI
import SwiftData

@Model
final class Member {
    @Attribute(.unique) var id: UUID
    var name: String
    var email: String
    var membershipDate: Date
    
        // One-to-Many: One Member has many BorrowRecords
    @Relationship(deleteRule: .cascade, inverse: \BorrowRecord.member)
    var borrowRecords: [BorrowRecord] = []
    
    init(name: String, email: String, membershipDate: Date) {
        self.id = UUID()
        self.name = name
        self.email = email
        self.membershipDate = membershipDate
    }
}
