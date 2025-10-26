import SwiftUI

struct SetReminderView: View {
    
    @StateObject private var viewModel = SetReminderViewModel()
    
    @Environment(\.colorScheme) var colorScheme
    @State private var showingAlert = false
    @State private var showingNameAlert = false
    @Binding var showSetReminderSheet: Bool
    @Binding var reminders: [PlantReminderList]
    
    var body: some View {
        NavigationStack {
            ZStack {
                //change the color of background
                if colorScheme == .dark {
                                Color(hex: "1C1C1E") 
                                    .ignoresSafeArea()
                            } else {
                                Color(hex: "9F9F91")
                                    .ignoresSafeArea()
                            }
                //main inputs of set reminder
                    ScrollView{
                        VStack(spacing: 45) {
                            // Plant Name
                            plantNameSection
                            // Room & Light
                            roomAndLightSection
                            // Watering info
                            wateringSection
                         
                        }.padding(.horizontal, 24)
                    }//ScrollView
                    .ignoresSafeArea(.keyboard, edges: .bottom)
                    
                
                //tool bar for Add & Cancel button
                .toolbar {
                    ToolbarItem(placement: .principal) {
                            Text("Set Reminder")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                        }
                    toolbarItems
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(colorScheme == .dark ? Color(hex: "1C1C1E") : Color(hex: "9F9F91") , for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
            }//End of the Zstack

        }//End of the navigationStack
        
    }//End of the body view
    
//Inputs of the set reminder
    
    //plant Name Input section
    private var plantNameSection: some View {
        HStack {
            Text("Plant Name")
                .foregroundStyle(colorScheme == .dark ? .white : .black)
                .font(.system(size: 18))
            TextField("Pothos", text: $viewModel.plantName)
                .font(.system(size: 18))
                .foregroundStyle(Color(hex: "29DFA8"))
                .tint(Color(hex: "29DFA8"))
                .submitLabel(.done)
            
        }
        .padding(.horizontal)
        .background(
                RoundedRectangle(cornerRadius: 30)
                    .fill(colorScheme == .dark ? Color(hex: "2C2C2E") : Color(hex: "E9E9E9"))
                    .frame(width: 365, height: 59)
                
        )
//        .background( Color(hex: "2C2C2E")
//            .frame(width: 365, height: 59).cornerRadius(30))
        .padding()
        .padding(.top, 40)
    }
    
    //plant location & light Inputs section
    private var roomAndLightSection: some View {
        VStack {
            HStack {
                Image(systemName: "location").foregroundStyle(colorScheme == .dark ? .white : .black)
                Text("Room").foregroundStyle(colorScheme == .dark ? .white : .black)
                Spacer()
                Picker("", selection: $viewModel.roomSelection) {
                    ForEach(Rooms.allCases) { room in
                        Text(room.rawValue)
                    }
                }.tint(colorScheme == .dark ? .gray : .black)
            }.padding(.horizontal)
            
            Divider().frame(width: 345).background(Color(hex: "414144"))
            
            HStack {
                Image(systemName: "sun.max").foregroundStyle(colorScheme == .dark ? .white : .black)
                Text("Light").foregroundStyle(colorScheme == .dark ? .white : .black)
                Spacer()
                Picker("", selection: $viewModel.lightSelection) {
                    ForEach(Lights.allCases) { light in
                        Text(light.rawValue)
                    }
                }.tint(colorScheme == .dark ? .gray : .black)
            }.padding(.horizontal)
        }
        .background(
                RoundedRectangle(cornerRadius: 30)
                    .fill(colorScheme == .dark ? Color(hex: "2C2C2E") : Color(hex: "E9E9E9"))
                    .frame(width: 370, height: 110)
                
        )
//        .background(RoundedRectangle(cornerRadius: 30).fill(Color(hex: "2C2C2E")).frame(width: 370, height: 110))
        .padding(.vertical, 4.5)
        .padding(.horizontal)
    }
    
    //plant Water day and amount Inputs section
    private var wateringSection: some View {
        VStack {
            HStack {
                Image(systemName: "drop").foregroundStyle(colorScheme == .dark ? .white : .black)
                Text("Watering Days").foregroundStyle(colorScheme == .dark ? .white : .black)
                Spacer()
                Picker("", selection: $viewModel.wateringDaysSelection) {
                    ForEach(WateringDays.allCases, id: \.self) { day in
                        Text(day.rawValue).tag(day)
                    }
                }
                .tint(colorScheme == .dark ? .gray : .black)
            }.padding(.horizontal)
            
            Divider().frame(width: 345).background(Color(hex: "414144"))
            
            HStack {
                Image(systemName: "drop").foregroundStyle(colorScheme == .dark ? .white : .black)
                Text("Water").foregroundStyle(colorScheme == .dark ? .white : .black)
                Spacer()
                Picker("", selection: $viewModel.waterSelection) {
                    ForEach(WaterAmount.allCases) { amount in
                        Text(amount.rawValue).tag(amount)
                    }
                }
                .tint(colorScheme == .dark ? .gray : .black)
            }.padding(.horizontal)
        }
        .background(
                RoundedRectangle(cornerRadius: 30)
                    .fill(colorScheme == .dark ? Color(hex: "2C2C2E") : Color(hex: "E9E9E9"))
                    .frame(width: 370, height: 110)
                
        )
//        .background(RoundedRectangle(cornerRadius: 30).fill(Color(hex: "2C2C2E")).frame(width: 370, height: 110))
        .padding(.vertical, 4.5)
        .padding(.horizontal)
    }
    
    // Add & Cancel buttons section
    private var toolbarItems: some ToolbarContent {
        Group {
            //Add button
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    if viewModel.plantName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
                        showingNameAlert = true
                    }else{
                        reminders.append(viewModel.createReminder())
                        showSetReminderSheet = false
                    }
                } label: {
                    Image(systemName: "checkmark")
                        .foregroundStyle(.white)
                        .frame(width: 30, height: 40)
                }
                .alert("Plant Name is Required", isPresented: $showingNameAlert) {
                    Button("OK", role: .cancel){
                        showSetReminderSheet = true
                    }
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
        }//End of the group
    }
    
}//End of the Struct of this set reminder view

#Preview {
    @Previewable @State var showSetReminderSheet = false
    SetReminderView(showSetReminderSheet: $showSetReminderSheet, reminders: .constant([]))
}
