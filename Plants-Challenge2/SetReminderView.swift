//
//  SetReminder.swift
//  Plants-Challenge2
//
//  Created by Abeer Jeilani Osman  on 25/04/1447 AH.
//

enum Rooms: String, CaseIterable, Identifiable {
    case Bedroom
    case LivingRoom
    case Kitchen
    case Balcony
    case Bathroom
    
    var id: String { self.rawValue }
}

enum Lights: String, CaseIterable, Identifiable {
    case FullSun
    case PartialSun
    case LowLight
    
    var id: String { self.rawValue }
}

struct PlantReminderList: Identifiable {
    var id = UUID()
    var name: String
    var room: String
    var light: String
    var WateringDays:String
    var water:String
    var ischecked: Bool = false
    
}


import SwiftUI

struct SetReminderView: View {
    
    @Binding var showSetReminderSheet: Bool
    @State private var showingAlert = false
    
    let wateringDays : [String] = [
        "Every day",
        "Every 2 days",
        "Every 3 days",
        "Once a week",
        "Every 10 days",
        "Every 2 weeks",
        ]
    
    
    let waterCount : [String] = [
        "20-50 ml",
        "50-100 ml",
        "100-200 ml",
        "200-300 ml",
        ]
    
    @State private var plantName: String = ""
    @State private var roomSelection: String = "Bedroom"
    @State private var lightSelection: String = "FullSun"
    @State private var wateringDaysSelection: String = "Every day"
    @State private var waterSelection: String = "20-50 ml"
    
    @State private var countReminders = 0.0
    
    @Binding var reminders: [PlantReminderList]

    var body: some View {
        NavigationStack {
            ZStack{
                Color(hex: "1C1C1E")
                    .ignoresSafeArea(edges: .all)
                
                
                VStack{
                    
                    Text("Set Reminder")
                        .foregroundStyle(.white)
                        .font(.system(size: 20))
                        .bold()
                        .padding(.top, 45)
                    
                    Spacer()
                    
                    VStack {
                        
                        //Name of Plant
                        HStack{
                            Text("Plant Name")
                                .foregroundStyle(.white)
                                .font(.system(size: 18))
                            HStack{
                                Rectangle()
                                    .frame(width: 2, height: 21)
                                    .foregroundStyle(Color(hex: "29DFA8").opacity(99))
                                    .cornerRadius(20)
                                TextField("Pothos", text: $plantName)
                                    .tint(Color.gray)
                                    .font(Font.system(size: 17))
                                    .foregroundStyle(Color(hex: "29DFA8"))
                                
                            }
                        }.background(Color(hex: "2C2C2E")
                            .frame(width: 388, height: 59).cornerRadius(30))
                        .padding()
                        .padding(.top, 40)
                        
                        
                        
                        
                        //Room & Light of Plant
                        VStack{
                            HStack{
                                Image(systemName: "location")
                                    .font(Font.system(size: 18))
                                    .foregroundStyle(.white)
                                Text("Room")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 18))
                                Spacer()
                                
                                //Picker
                                Picker(selection: $roomSelection){
                                    ForEach(Rooms.allCases){
                                        room in Text(room.rawValue)
                                    }
                                }label: {
                                }.tint(Color.gray)
                                
                            }//End of Room
                            Divider()
                                .frame(width: 368, height: 1)
                                .background(Color(hex: "414144"))
                            
                            HStack{
                                Image(systemName: "sun.max")
                                    .font(Font.system(size: 18))
                                    .foregroundStyle(.white)
                                Text("Light")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 18))
                                Spacer()
                                
                                //Picker
                                Picker(selection: $lightSelection){
                                    ForEach(Lights.allCases){
                                        room in Text(room.rawValue)
                                    }
                                }label: {
                                }.tint(Color.gray)
                            }//End of Light
                            
                        }.background(Color(hex: "2C2C2E")
                            .frame(width: 388, height: 95).cornerRadius(30))
                        .padding()
                        
                        //water of Plant
                        VStack{
                            HStack{
                                Image(systemName: "drop")
                                    .font(Font.system(size: 18))
                                    .foregroundStyle(.white)
                                Text("Watering Days")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 18))
                                Spacer()
                                
                                //Picker
                                Picker(selection: $wateringDaysSelection){
                                    ForEach(wateringDays, id: \.self){
                                        wateringDay in Text(wateringDay)
                                    }
                                }label: {
                                }.tint(Color.gray)
                            }//End of Watering day
                            Divider()
                                .frame(width: 368, height: 1)
                                .background(Color(hex: "414144"))
                            
                            HStack{
                                Image(systemName: "drop")
                                    .font(Font.system(size: 18))
                                    .foregroundStyle(.white)
                                Text("Water")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 18))
                                Spacer()
                                
                                //Picker
                                Picker(selection: $waterSelection){
                                    ForEach(waterCount, id: \.self){
                                        water in Text(water)
                                    }
                                }label: {
                                }.tint(Color.gray)
                            }//End of Water
                            
                        }.background(Color(hex: "2C2C2E")
                            .frame(width: 388, height: 95).cornerRadius(30))
                        .padding()
                        
                    }.padding(.bottom, 408)
                        .padding(.top, 40)
                    
                    
                    
                } //Vstack of all element in the sheet
                .padding(.horizontal, 24)
                
                .toolbar {
                    
                    //Add button
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            let newReminder = PlantReminderList(
                                name: plantName,
                                room: roomSelection,
                                light: lightSelection,
                                WateringDays: wateringDaysSelection,
                                water: waterSelection
                            )
                            reminders.append(newReminder)
                            countReminders+=1
                            print(reminders)
                            showSetReminderSheet = false
                        } label: {
                            Image(systemName: "checkmark")
                                
                        }
                    }//End of the add button
                    
                    
                    //Canselation button
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
                            Button("Cancel", role: .cancel) {
                                showSetReminderSheet = true
                            }
                        } message: {
                            Text("Are you sure you want to close this?")
                        }

                    }//End of the Cancelation button
                }
                
                
                
            }
        }// NavigationStack 
    }
}
#Preview {
    @Previewable @State var showSetReminderSheet = false
    return SetReminderView(showSetReminderSheet: $showSetReminderSheet, reminders: .constant([]))
}
