import SwiftUI

struct TodayReminderView: View {
    @Binding var reminders: [PlantReminderList]
    @Binding var countReminders: Double
    @Binding var showSetReminderSheet: Bool
    @State private var editingIndex: Int? = nil
    @Environment(\.colorScheme) var colorScheme
    
    // Computed properties
    private var countOfCheck: Double {
        Double(reminders.filter { $0.ischecked }.count)
    }

    private var allDone: Bool {
        !reminders.isEmpty && countOfCheck == Double(reminders.count)
    }

    var body: some View {
        ZStack {
            if colorScheme == .dark {
                            Color(hex: "000000")
                                .ignoresSafeArea()
                        } else {
                            Color(hex: "FFFFFF")
                                .ignoresSafeArea()
                        }
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
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                                .font(.system(size: 25, weight: .semibold))
                            Text("All Reminders Completed")
                                .foregroundColor(Color(hex: "9F9F91"))
                                .font(.system(size: 16))
                        }
                    }
                } else {
                    VStack {
                        Text(countOfCheck == 0 ? "Your plants are waiting for a sip 💦" : "\(Int(countOfCheck)) of your plants feel loved today ✨" )
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                            .font(.system(size: 18, weight: .regular))
                            .padding(.bottom, 18)

                        ProgressView(value: countOfCheck, total: Double(reminders.count))
                            .progressViewStyle(LinearProgressViewStyle(tint: Color(hex: "19B183")))
                            .scaleEffect(x: 1, y: 2, anchor: .center)
                            .frame(width: 361, height: 8)
                            .cornerRadius(4)
                    }
                    .padding(.top, 35)
                    .padding(.bottom, 20)

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
                                            .foregroundColor(colorScheme == .dark ? .white : .black)
                                            .font(.system(size: 28))
                                            .contentShape(Rectangle())
                                            .onTapGesture {
                                                editingIndex = index
                                            }

                                        HStack(spacing: 13) {
                                            
                                            HStack (spacing: 4){
                                                Image(systemName: "sun.max")
                                                Text(reminder.light)
                                            }
                                            .foregroundStyle(Color(hex: "CCC785"))
                                            .font(.caption)
                                            .padding(.horizontal,8)
                                            .padding(.vertical,4)
                                            .background(Color(hex: "18181D"))
                                            .cornerRadius(10)
                                            
                                            HStack (spacing: 4){
                                                Image(systemName: "drop")
                                                Text(reminder.water.rawValue)
                                            }
                                            .foregroundStyle(Color(hex: "CAF3FB"))
                                            .font(.caption)
                                            .padding(.horizontal,8)
                                            .padding(.vertical,4)
                                            .background(Color(hex: "18181D"))
                                            .cornerRadius(10)
                                                
                                            
                                        }
                                    }// box contain (room, name, amount of water, and lght)
                                    Divider()
                                        .frame(height: 1)
                                        .background(Color(hex: "39393B").opacity(0.6))
                                        .padding(.top, 10)
                                }
                            }//  this is the end of all reminders
                            .listRowBackground(colorScheme == .dark ? Color.black : Color.white)
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
                    .background(colorScheme == .dark ? Color.black : Color.white)
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
