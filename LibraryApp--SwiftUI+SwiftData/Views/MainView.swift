import SwiftUI

struct MainView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            AuthorsView()
                .tabItem {
                    Label("Authors", systemImage: "person.3.fill")
                }
                .tag(0)
            
            BooksView()
                .tabItem {
                    Label("Books", systemImage: "books.vertical")
                }
                .tag(1)
            
            MembersView()
                .tabItem {
                    Label("Members", systemImage: "person.2.fill")
                }
                .tag(2)
            
            CategoriesView()
                .tabItem {
                    Label("Categories", systemImage: "tag.fill")
                }
                .tag(3)
        }
    }
}

