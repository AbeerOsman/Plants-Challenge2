import SwiftUI

struct SetReminderView: View {
    
    @StateObject private var viewModel = SetReminderViewModel()
    
    @State private var showingAlert = false
    @Binding var showSetReminderSheet: Bool
    @Binding var reminders: [PlantReminderList]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(hex: "1C1C1E").ignoresSafeArea()
                
                VStack {
                    
                    ScrollView{
                        
                        VStack(spacing: 45) {
                            // Plant Name
                            plantNameSection
                            // Room & Light
                            roomAndLightSection
                            // Watering info
                            wateringSection
                        }
                        
                    }//ScrollView
                    .ignoresSafeArea(.keyboard, edges: .bottom)
                }
                .padding(.horizontal, 24)
                
                .toolbar {
                    ToolbarItem(placement: .principal) {
                            Text("Set Reminder")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                        }
                    toolbarItems
                }
                .toolbarBackground(Color(hex: "1C1C1E"), for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
            }

        }//End of the navigationStack
        
    }
    
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
                        Text(room.rawValue)
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
                        Text(light.rawValue)
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
            //Add button
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    reminders.append(viewModel.createReminder())
                    showSetReminderSheet = false
                } label: {
                    Image(systemName: "checkmark")
                        .foregroundStyle(.white)
                        .frame(width: 30, height: 40)
                }
                .buttonStyle(.borderedProminent)
                .tint(Color(hex: "#19B183"))
            }
            
            //Cancel button
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    showingAlert = true
                } label: {
                    Image(systemName: "multiply")
                }
                .alert("Confirm Exit", isPresented: $showingAlert) {
                    Button("Yes", role: .destructive) {
                        showSetReminderSheet = false
                    }
                    Button("Cancel", role: .cancel) {}
                } message: {
                    Text("Are you sure you want to close this?")
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var showSetReminderSheet = false
    SetReminderView(showSetReminderSheet: $showSetReminderSheet, reminders: .constant([]))
}
