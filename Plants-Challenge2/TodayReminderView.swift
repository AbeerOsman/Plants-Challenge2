import SwiftUI

struct TodayReminderView: View {
    @Binding var reminders: [PlantReminderList]
    @Binding var countReminders: Double
    @Binding var showSetReminderSheet: Bool

    @State private var editingIndex: Int? = nil   // <-- new: which reminder we are editing

    private var countOfCheck: Double {
        Double(reminders.filter { $0.ischecked }.count)
    }

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea(edges: .all)

            VStack {
                if countOfCheck == Double(reminders.count) && !reminders.isEmpty {
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
                        ForEach(Array(reminders.enumerated()), id: \.element.id) { index, _ in
                            // We need the binding when toggling ischecked; we will use the index
                            let binding = Binding<PlantReminderList>(
                                get: { reminders[index] },
                                set: { reminders[index] = $0 }
                            )

                            VStack(alignment: .leading, spacing: 10) {
                                HStack {
                                    Image(systemName: binding.wrappedValue.ischecked ? "checkmark.circle.fill" : "circle")
                                        .foregroundStyle(binding.wrappedValue.ischecked ? Color(hex: "28E0A8") : .gray)
                                        .font(.system(size: 23))
                                        .onTapGesture {
                                            // toggle checked
                                            reminders[index].ischecked.toggle()
                                        }

                                    VStack(alignment: .leading, spacing: 8) {
                                        HStack {
                                            Image(systemName: "location")
                                                .font(.system(size: 15))
                                                .foregroundStyle(.gray)
                                            Text("in \(binding.wrappedValue.room)")
                                                .foregroundStyle(.gray)
                                                .font(.system(size: 15))
                                        }

                                        // Tap the name to edit — we also set contentShape to make whole row tappable
                                        Text(binding.wrappedValue.name)
                                            .foregroundStyle(.white)
                                            .font(.system(size: 28))
                                            .contentShape(Rectangle()) // make the whole text area tappable
                                            .onTapGesture {
                                                // set index to open edit sheet
                                                editingIndex = index
                                            }

                                        HStack(spacing: 13) {
                                            HStack {
                                                Image(systemName: "sun.max")
                                                    .foregroundStyle(Color(hex: "CCC785"))
                                                    .font(.system(size: 14))
                                                Text(binding.wrappedValue.light)
                                                    .foregroundStyle(Color(hex: "CCC785"))
                                                    .font(.system(size: 14))
                                            }
                                            .background(Color(hex: "18181D").frame(width: 89, height: 23).cornerRadius(8))

                                            HStack {
                                                Image(systemName: "drop")
                                                    .foregroundStyle(Color(hex: "CAF3FB"))
                                                    .font(.system(size: 14, weight: .medium))
                                                Text(binding.wrappedValue.water)
                                                    .foregroundStyle(Color(hex: "CAF3FB"))
                                                    .font(.system(size: 14, weight: .medium))
                                            }
                                            .background(Color(hex: "18181D").frame(width: 89, height: 23).cornerRadius(8))
                                        }
                                    }
                                }

                                Divider().frame(height: 2).background(Color(hex: "39393B").opacity(0.6)).padding(.top, 10)
                            }
                            .listRowBackground(Color.black)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button(role: .destructive) {
                                    reminders.remove(at: index)
                                } label: {
                                    Image(systemName: "trash")
                                }
                            }
                        } // end ForEach
                        .onDelete { indexSet in
                            reminders.remove(atOffsets: indexSet)
                        }
                    } // end List
                    .scrollContentBackground(.hidden)
                    .background(Color.black)
                    .listStyle(PlainListStyle())
                } // else
            } // VStack
        } // ZStack
        // Drive the sheet with isPresented based on whether editingIndex is non-nil
        .sheet(
            isPresented: Binding(
                get: { editingIndex != nil },
                set: { newValue in
                    if !newValue { editingIndex = nil }
                }
            ),
            content: {
                // Safely unwrap index and build the binding
                if let index = editingIndex, reminders.indices.contains(index) {
                    let reminderBinding = Binding<PlantReminderList>(
                        get: { reminders[index] },
                        set: { reminders[index] = $0 }
                    )
                    // Map editingIndex presence to the expected showEditSheet binding
                    let showEditSheetBinding = Binding<Bool>(
                        get: { editingIndex != nil },
                        set: { newValue in
                            if !newValue { editingIndex = nil }
                        }
                    )
                    SetReminderViewForEdit(
                        showEditSheet: showEditSheetBinding,
                        reminder: reminderBinding,
                        reminders: $reminders // 👈 use $ here!
                    )
                } else {
                    // Fallback view if index is invalid; dismiss immediately
                    Color.clear
                        .onAppear {
                            editingIndex = nil
                        }
                }
            }
        )
    }
}
