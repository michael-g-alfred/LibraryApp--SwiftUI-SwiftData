import SwiftUI
import SwiftData

struct MembersView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Member.name) private var members: [Member]
    @State private var showingAddMember = false
    
    var body: some View {
        NavigationStack {
            Group {
                if members.isEmpty {
                    ContentUnavailableView(
                        "No Members",
                        systemImage: "person.2.fill",
                        description: Text("Add your first member to get started")
                    )
                } else {
                    List {
                        ForEach(members) { member in
                            NavigationLink(destination: MemberDetailView(member: member)) {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(member.name)
                                        .font(.headline)
                                    Text(member.email)
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                    let activeBorrows = member.borrowRecords.filter { !$0.isReturned }.count
                                    if activeBorrows > 0 {
                                        Text("Currently borrowed: \(activeBorrows) book\(activeBorrows == 1 ? "" : "s")")
                                            .font(.caption2)
                                            .foregroundStyle(.blue)
                                    }
                                }
                            }
                        }
                        .onDelete(perform: deleteMembers)
                    }
                }
            }
            .navigationTitle("Members")
            .toolbar {
                Button {
                    showingAddMember = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddMember) {
                AddMemberView()
            }
        }
    }
    
    private func deleteMembers(offsets: IndexSet) {
        for index in offsets {
            context.delete(members[index])
        }
        try? context.save()
    }
}
