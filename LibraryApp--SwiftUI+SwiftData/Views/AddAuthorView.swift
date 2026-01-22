import SwiftUI
import SwiftData

struct AddAuthorView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @State private var name = ""
    @State private var bio = ""
    @State private var birthDate = Date()
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                TextField("Bio", text: $bio, axis: .vertical)
                    .lineLimit(3...6)
                DatePicker("Birth Date", selection: $birthDate, displayedComponents: .date)
            }
            .navigationTitle("Add Author")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let author = Author(name: name, bio: bio, birthDate: birthDate)
                        context.insert(author)
                        try? context.save()
                        dismiss()
                    }
                    .disabled(name.isEmpty)
                }
            }
        }
    }
}
