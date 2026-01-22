import SwiftUI
import SwiftData

@Model
final class Author {
    @Attribute(.unique) var id: UUID
    var name: String
    var bio: String
    var birthDate: Date
    
        // One-to-Many: One Author has many Books
    @Relationship(deleteRule: .cascade, inverse: \Book.author)
    var books: [Book] = []
    
    init(name: String, bio: String, birthDate: Date) {
        self.id = UUID()
        self.name = name
        self.bio = bio
        self.birthDate = birthDate
    }
}
