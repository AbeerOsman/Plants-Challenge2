import SwiftUI

struct SetReminderViewForEdit: View {
    @Binding var showEditSheet: Bool
    @Binding var reminder: PlantReminderList
    @Binding var reminders: [PlantReminderList]
    
    @State private var showingAlert = false
    
    let wateringDays: [String] = [
        "Every day", "Every 2 days", "Every 3 days",
        "Once a week", "Every 10 days", "Every 2 weeks"
    ]
    
    let waterCount: [String] = [
        "20-50 ml", "50-100 ml", "100-200 ml", "200-300 ml"
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(hex: "1C1C1E")
                    .ignoresSafeArea(edges: .all)
                
                VStack {
                    Text("Edit Reminder")
                        .foregroundStyle(.white)
                        .font(.system(size: 20))
                        .bold()
                        .padding(.top, 80)
                    
                    Spacer()
                    
                    VStack(spacing: 45) {
                        // Plant Name
                        HStack {
                            Text("Plant Name")
                                .foregroundStyle(.white)
                                .font(.system(size: 18))
                            TextField("Pothos", text: $reminder.name)
                                .font(.system(size: 18))
                                .foregroundStyle(Color(hex: "29DFA8"))
                                .tint(Color(hex: "29DFA8"))
                        }
                        .padding(.horizontal)
                        .background(Color(hex: "2C2C2E")
                            .frame(width: 365, height: 59)
                            .cornerRadius(30))
                        .padding()
                        .padding(.top, 40)
                        
                        // Room & Light
                        VStack {
                            HStack {
                                Image(systemName: "location")
                                    .font(.system(size: 18))
                                    .foregroundStyle(.white)
                                Text("Room")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 18))
                                Spacer()
                                
                                Picker(selection: $reminder.room) {
                                    ForEach(Rooms.allCases) { room in
                                        Text(room.rawValue)
                                    }
                                } label: {}
                                .tint(.gray)
                            }
                            .padding(.horizontal)
                            
                            Divider()
                                .frame(width: 345, height: 1)
                                .background(Color(hex: "414144"))
                            
                            HStack {
                                Image(systemName: "sun.max")
                                    .font(.system(size: 18))
                                    .foregroundStyle(.white)
                                Text("Light")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 18))
                                Spacer()
                                
                                Picker(selection: $reminder.light) {
                                    ForEach(Lights.allCases) { light in
                                        Text(light.rawValue)
                                    }
                                } label: {}
                                .tint(.gray)
                            }
                            .padding(.horizontal)
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 30)
                                .fill(Color(hex: "2C2C2E"))
                                .frame(width: 370, height: 110)
                        )
                        .padding(.vertical, 4.5)
                        .padding(.horizontal)
                        
                        // Water Section
                        VStack {
                            HStack {
                                Image(systemName: "drop")
                                    .font(.system(size: 18))
                                    .foregroundStyle(.white)
                                Text("Watering Days")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 18))
                                Spacer()
                                
                                Picker(selection: $reminder.WateringDays) {
                                    ForEach(wateringDays, id: \.self) { day in
                                        Text(day)
                                    }
                                } label: {}
                                .tint(.gray)
                            }
                            .padding(.horizontal)
                            
                            Divider()
                                .frame(width: 345, height: 1)
                                .background(Color(hex: "414144"))
                            
                            HStack {
                                Image(systemName: "drop")
                                    .font(.system(size: 18))
                                    .foregroundStyle(.white)
                                Text("Water")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 18))
                                Spacer()
                                
                                Picker(selection: $reminder.water) {
                                    ForEach(waterCount, id: \.self) { water in
                                        Text(water)
                                    }
                                } label: {}
                                .tint(.gray)
                            }
                            .padding(.horizontal)
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 30)
                                .fill(Color(hex: "2C2C2E"))
                                .frame(width: 370, height: 110)
                        )
                        .padding(.vertical, 4.5)
                        .padding(.horizontal)
                       
                        VStack {
                            Button(action: {
                                if let index = reminders.firstIndex(where: { $0.id == reminder.id }) {
                                    reminders.remove(at: index)
                                }
                            }) {
                                Text("Delete Reminder")
                                    .foregroundColor(Color(hex: "#FF453A"))
                                    .font(.system(size: 17, weight: .medium))
                                    .padding()
                                    .frame(width: 350, height: 52)
                                   
                            }.background(
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(Color(hex: "2C2C2E"))
                                    .frame(width: 370, height: 59)
                            )
                            .padding(.vertical, 4.5)
                            .padding(.horizontal)

                        }
                        
                    }//End of the all inputs of edit
                    .padding(.bottom, 408)
                    .padding(.top, 40)
                }
                .padding(.horizontal, 24)
                
                .toolbar {
                    // Save Button
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            showEditSheet = false
                        } label: {
                            Image(systemName: "checkmark")
                                .foregroundStyle(.white)
                                .frame(width: 30, height: 40)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(Color(hex: "#19B183"))
                    }
                    
                    // Cancel Button
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            showingAlert = true
                        } label: {
                            Image(systemName: "multiply")
                        }
                        .alert("Confirm Exit", isPresented: $showingAlert) {
                            Button("Yes", role: .destructive) {
                                showEditSheet = false
                            }
                            Button("Cancel", role: .cancel) {}
                        } message: {
                            Text("Are you sure you want to close this?")
                        }
                        
                    }
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var showEditSheet = true
    @Previewable @State var reminder = PlantReminderList(
        name: "Pothos",
        room: "Bedroom",
        light: "FullSun",
        WateringDays: "Every day",
        water: "100-200 ml"
    )
    @Previewable @State var reminders: [PlantReminderList] = [
        PlantReminderList(
            name: "Pothos",
            room: "Bedroom",
            light: "FullSun",
            WateringDays: "Every day",
            water: "100-200 ml"
        )
    ]
    SetReminderViewForEdit(
        showEditSheet: $showEditSheet,
        reminder: $reminder,
        reminders: $reminders
    )
}
