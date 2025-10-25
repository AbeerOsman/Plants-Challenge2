import SwiftUI

struct TodayReminderView: View {
    @Binding var reminders: [PlantReminderList]
    @Binding var countReminders: Double
    @Binding var showSetReminderSheet: Bool
    @State private var editingIndex: Int? = nil
    
    // Computed properties
    private var countOfCheck: Double {
        Double(reminders.filter { $0.ischecked }.count)
    }

    private var allDone: Bool {
        !reminders.isEmpty && countOfCheck == Double(reminders.count)
    }

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea(edges: .all)

            VStack {
                if allDone {
                    VStack {
                        Image(.plants2)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 219, height: 227)
                            .padding(.bottom, 28)
                        VStack(spacing: 14) {
                            Text("All Done! 🎉")
                                .foregroundColor(.white)
                                .font(.system(size: 25, weight: .semibold))
                            Text("All Reminders Completed")
                                .foregroundColor(Color(hex: "9F9F91"))
                                .font(.system(size: 16))
                        }
                    }
                } else {
                    VStack {
                        Text("Your plants are waiting for a sip 💦")
                            .foregroundStyle(.white)
                            .font(.system(size: 18, weight: .regular))
                            .padding(.bottom, 18)

                        ProgressView(value: countOfCheck, total: Double(reminders.count))
                            .progressViewStyle(LinearProgressViewStyle(tint: Color(hex: "19B183")))
                            .scaleEffect(x: 1, y: 2, anchor: .center)
                            .frame(width: 361)
                    }
                    .padding(.top, 35)
                    .padding(.bottom, 60)

                    // List of reminders
                    List {
                        ForEach(Array(reminders.enumerated()), id: \.element.id) { index, reminder in
                            VStack(alignment: .leading, spacing: 10) {
                                HStack {
                                    Image(systemName: reminder.ischecked ? "checkmark.circle.fill" : "circle")
                                        .foregroundStyle(reminder.ischecked ? Color(hex: "28E0A8") : .gray)
                                        .font(.system(size: 23))
                                        .padding(.trailing, 23)
                                        .onTapGesture {
                                            reminders[index].ischecked.toggle()
                                        }

                                    VStack(alignment: .leading, spacing: 8) {
                                        HStack {
                                            Image(systemName: "location")
                                                .font(.system(size: 15))
                                                .foregroundStyle(.gray)
                                            Text("in \(reminder.room)")
                                                .foregroundStyle(.gray)
                                                .font(.system(size: 15))
                                        }

                                        Text(reminder.name)
                                            .foregroundStyle(.white)
                                            .font(.system(size: 28))
                                            .contentShape(Rectangle())
                                            .onTapGesture {
                                                editingIndex = index
                                            }

                                        HStack(spacing: 13) {
                                            HStack {
                                                Image(systemName: "sun.max")
                                                    .foregroundStyle(Color(hex: "CCC785"))
                                                    .font(.system(size: 14))
                                                Text(reminder.light)
                                                    .foregroundStyle(Color(hex: "CCC785"))
                                                    .font(.system(size: 14))
                                            }
                                            .background(Color(hex: "18181D").frame(width: 89, height: 23).cornerRadius(8))

                                            HStack {
                                                Image(systemName: "drop")
                                                    .foregroundStyle(Color(hex: "CAF3FB"))
                                                    .font(.system(size: 14, weight: .medium))
                                                Text(reminder.water.rawValue)
                                                    .foregroundStyle(Color(hex: "CAF3FB"))
                                                    .font(.system(size: 14, weight: .medium))
                                            }
                                            .background(Color(hex: "18181D").frame(width: 89, height: 23).cornerRadius(8))
                                        }
                                    }// box contain (room, name, amount of water, and lght)
                                    Divider()
                                        .frame(height: 1)
                                        .background(Color(hex: "39393B").opacity(0.6))
                                        .padding(.top, 10)
                                }
                            }//  this is the end of all reminders
                            .listRowBackground(Color.black)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button(role: .destructive) {
                                    reminders.remove(at: index)
                                } label: {
                                    Image(systemName: "trash")
                                }
                            }
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .background(Color.black)
                    .listStyle(PlainListStyle())
                }
            }
        }
        // Edit sheet
        .sheet(
            isPresented: Binding(
                get: { editingIndex != nil },
                set: { newValue in
                    if !newValue { editingIndex = nil }
                }
            )
        ) {
            if let index = editingIndex, reminders.indices.contains(index) {
                let reminderBinding = Binding<PlantReminderList>(
                    get: { reminders[index] },
                    set: { reminders[index] = $0 }
                )

                SetReminderViewForEdit(
                    showEditSheet: Binding(
                        get: { editingIndex != nil },
                        set: { newValue in
                            if !newValue { editingIndex = nil }
                        }
                    ),
                    reminder: reminderBinding,
                    reminders: $reminders
                )
            }
        }

        // Auto-clear reminders when all are checked
        .onChange(of: reminders) {
            if reminders.allSatisfy({ $0.ischecked }) && !reminders.isEmpty {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    reminders.removeAll()
                    countReminders = 0
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var reminders: [PlantReminderList] = []
    @Previewable @State var countReminders: Double = 0
    @Previewable @State var showSetReminderSheet: Bool = false

    TodayReminderView(
        reminders: $reminders,
        countReminders: $countReminders,
        showSetReminderSheet: $showSetReminderSheet
    )
}
