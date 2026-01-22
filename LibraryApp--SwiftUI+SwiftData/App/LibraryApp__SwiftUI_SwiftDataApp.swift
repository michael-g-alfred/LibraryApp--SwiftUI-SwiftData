import SwiftUI
import SwiftData

@main
struct LibraryApp: App {
    
    let container: ModelContainer
    init() {
        do {
            let config = ModelConfiguration(
                schema: Schema([
                    Author.self,
                    Book.self,
                    BookDetail.self,
                    Category.self,
                    Member.self,
                    BorrowRecord.self
                ]),
                url: URL.documentsDirectory.appending(path: "LibraryDB.sqlite")
            )
            
            container = try ModelContainer(
                for: Author.self,
                Book.self,
                BookDetail.self,
                Category.self,
                Member.self,
                BorrowRecord.self,
                configurations: config
            )
            
            print("📦 SwiftData DB Path:")
            print(config.url.path)
            
        } catch {
            fatalError("Failed to create ModelContainer: \(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .modelContainer(container)
        }
    }
}
