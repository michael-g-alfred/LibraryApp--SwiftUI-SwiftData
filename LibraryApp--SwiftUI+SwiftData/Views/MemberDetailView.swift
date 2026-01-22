import SwiftUI

struct MemberDetailView: View {
    let member: Member
    
    var body: some View {
        List {
            Section("Information") {
                LabeledContent("Name", value: member.name)
                LabeledContent("Email", value: member.email)
                LabeledContent("Member Since", value: member.membershipDate.formatted(date: .long, time: .omitted))
            }
            
            Section("Currently Borrowed Books") {
                let activeBorrows = member.borrowRecords.filter { !$0.isReturned }
                if activeBorrows.isEmpty {
                    Text("No active borrows")
                        .foregroundStyle(.secondary)
                } else {
                    ForEach(activeBorrows) { record in
                        if let book = record.book {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(book.title)
                                    .font(.headline)
                                Text("Borrowed: \(record.borrowDate.formatted(date: .abbreviated, time: .omitted))")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
            }
            
            Section("Borrow History") {
                let returnedBorrows = member.borrowRecords.filter { $0.isReturned }
                if returnedBorrows.isEmpty {
                    Text("No history")
                        .foregroundStyle(.secondary)
                } else {
                    ForEach(returnedBorrows) { record in
                        if let book = record.book {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(book.title)
                                    .font(.headline)
                                HStack {
                                    Text("Borrowed: \(record.borrowDate.formatted(date: .abbreviated, time: .omitted))")
                                    Spacer()
                                    if let returnDate = record.returnDate {
                                        Text("Returned: \(returnDate.formatted(date: .abbreviated, time: .omitted))")
                                    }
                                }
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            }
                            .padding(.vertical, 2)
                        }
                    }
                }
            }
        }
        .navigationTitle(member.name)
    }
}
