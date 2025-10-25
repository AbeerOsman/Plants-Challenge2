import SwiftUI

struct SetReminderViewForEdit: View {
    @Binding var reminders: [PlantReminderList]
    @Binding var showEditSheet: Bool
    @StateObject private var viewModel: EditReminderViewModel


    init(showEditSheet: Binding<Bool>, reminder: Binding<PlantReminderList>, reminders: Binding<[PlantReminderList]>) {
        _showEditSheet = showEditSheet
        _reminders = reminders
        _viewModel = StateObject(wrappedValue: EditReminderViewModel(reminder: reminder, reminders: reminders))
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color(hex: "1C1C1E")
                    .ignoresSafeArea()
               
                VStack {
                    ScrollView{
                        VStack(spacing: 45) {
                        // Plant Name
                        plantNameSection
                        
                        // Room & Light
                        roomAndLightSection
                        
                        // Watering info
                        wateringSection
                        
                        // Delete button
                        Button {
                            viewModel.deleteReminder()
                            showEditSheet = false
                        } label: {
                            Text("Delete Reminder")
                                .foregroundColor(Color(hex: "#FF453A"))
                                .font(.system(size: 17, weight: .medium))
                                .padding()
                        }
                        .background(Color(hex: "2C2C2E").frame(width: 370, height: 52).cornerRadius(30))
                    }//End of Vstack
                }//scrollview
                }
                .padding(.horizontal, 24)
                .onAppear {
                    viewModel.loadReminderData(
                        plantName: $viewModel.plantName,
                        room: $viewModel.roomSelection,
                        light: $viewModel.lightSelection,
                        days: $viewModel.wateringDaysSelection,
                        water: $viewModel.waterSelection
                    )
                }
                .toolbar {
                    ToolbarItem(placement: .principal) {
                            Text("Edit Reminder")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                        }
                    toolbarItems
                }
                .toolbarBackground(Color(hex: "1C1C1E"), for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
            }
        }
    }// View
    
    private var plantNameSection: some View {
        HStack {
            Text("Plant Name")
                .foregroundStyle(.white)
                .font(.system(size: 18))
            TextField("Pothos", text: $viewModel.plantName)
                .font(.system(size: 18))
                .foregroundStyle(Color(hex: "29DFA8"))
                .tint(Color(hex: "29DFA8"))
        }
        .padding(.horizontal)
        .background(Color(hex: "2C2C2E").frame(width: 365, height: 59).cornerRadius(30))
        .padding()
        .padding(.top, 40)
    }
    
    private var roomAndLightSection: some View {
        VStack {
            HStack {
                Image(systemName: "location").foregroundStyle(.white)
                Text("Room").foregroundStyle(.white)
                Spacer()
                Picker("", selection: $viewModel.roomSelection) {
                    ForEach(Rooms.allCases) { room in
                        Text(room.rawValue).tag(room)
                    }
                }.tint(.gray)
            }.padding(.horizontal)
            
            Divider().frame(width: 345).background(Color(hex: "414144"))
            
            HStack {
                Image(systemName: "sun.max").foregroundStyle(.white)
                Text("Light").foregroundStyle(.white)
                Spacer()
                Picker("", selection: $viewModel.lightSelection) {
                    ForEach(Lights.allCases) { light in
                        Text(light.rawValue).tag(light)
                    }
                }.tint(.gray)
            }.padding(.horizontal)
        }
        .background(RoundedRectangle(cornerRadius: 30).fill(Color(hex: "2C2C2E")).frame(width: 370, height: 110))
        .padding(.vertical, 4.5)
        .padding(.horizontal)
    }
    
    private var wateringSection: some View {
        VStack {
            HStack {
                Image(systemName: "drop").foregroundStyle(.white)
                Text("Watering Days").foregroundStyle(.white)
                Spacer()
                Picker("", selection: $viewModel.wateringDaysSelection) {
                    ForEach(WateringDays.allCases, id: \.self) { day in
                        Text(day.rawValue).tag(day)
                    }
                }
                .tint(.gray)
            }.padding(.horizontal)
            
            Divider().frame(width: 345).background(Color(hex: "414144"))
            
            HStack {
                Image(systemName: "drop").foregroundStyle(.white)
                Text("Water").foregroundStyle(.white)
                Spacer()
                Picker("", selection: $viewModel.waterSelection) {
                    ForEach(WaterAmount.allCases) { amount in
                        Text(amount.rawValue).tag(amount)
                    }
                }
                .tint(.gray)
            }.padding(.horizontal)
        }
        .background(RoundedRectangle(cornerRadius: 30).fill(Color(hex: "2C2C2E")).frame(width: 370, height: 110))
        .padding(.vertical, 4.5)
        .padding(.horizontal)
    }
    
    private var toolbarItems: some ToolbarContent {
        Group {
            // Save Button
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    viewModel.saveEdits(
                        plantName: viewModel.plantName,
                        room: viewModel.roomSelection,
                        light: viewModel.lightSelection,
                        days: viewModel.wateringDaysSelection,
                        water: viewModel.waterSelection
                    )
                    showEditSheet = false
                } label: {
                    Image(systemName: "checkmark").foregroundStyle(.white)
                }
                .buttonStyle(.borderedProminent)
                .tint(Color(hex: "#19B183"))
            }

            // Cancel Button
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    viewModel.showingAlert = true
                } label: {
                    Image(systemName: "multiply")
                }
                .alert("Confirm Exit", isPresented: $viewModel.showingAlert) {
                    Button("Yes", role: .destructive) { showEditSheet = false }
                    Button("Cancel", role: .cancel) {}
                } message: {
                    Text("Are you sure you want to close this?")
                }
            }
        }
    }
}

