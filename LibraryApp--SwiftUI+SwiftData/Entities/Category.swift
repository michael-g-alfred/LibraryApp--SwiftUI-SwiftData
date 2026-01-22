import SwiftUI
import SwiftData

@Model
final class Category {
    @Attribute(.unique) var id: UUID
    var name: String
    var categoryDescription: String
    
        // Many-to-Many: Categories can be assigned to multiple Books
    @Relationship(inverse: \Book.categories)
    var books: [Book] = []
    
    init(name: String, categoryDescription: String) {
        self.id = UUID()
        self.name = name
        self.categoryDescription = categoryDescription
    }
}



