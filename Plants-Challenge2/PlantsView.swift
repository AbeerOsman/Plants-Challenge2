//
//  ContentView.swift
//  Plants-Challenge2
//
//  Created by Abeer Jeilani Osman  on 25/04/1447 AH.
//

import SwiftUI

struct PlantsView: View {
    @State private var showSetReminderSheet = false
    @State private var reminders: [PlantReminderList] = []
    @Binding var countReminders : Double

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea(edges: .all)
            
            VStack (alignment: .leading){
                
              Text ("My Plants 🌱")
                    .font(.system(size: 34))
                    .bold()
                    .foregroundStyle(.white)
                    .padding(.bottom, 5) // space between text and divider
                        
                        Divider()
                            .frame(height: 2)
                            .background(Color(hex: "39393B").opacity(0.6))
                
                        Spacer()
                
            }.padding()
            
            VStack (spacing:37){
                
                if reminders.isEmpty {
                   Image(.plant)
                                    
                    Text("Start your plant journey!")
                      .font(.system(size: 25, weight: .semibold))
                      .foregroundStyle(.white)
                                    
                    Text("Now all your plants will be in one place and we will help you take care of them :)🪴")
                       .font(.system(size: 16, weight: .regular))
                       .multilineTextAlignment(.center)
                       .foregroundStyle(Color(hex: "#9F9F91"))
                       .padding(.bottom, 107)
                       .padding(.horizontal,25)
                       
                } else {
                   
                    TodayReminderView(reminders: $reminders, countReminders: $countReminders)
                            .padding(.top, 90)
                        
                    
                }
                if reminders.isEmpty {
                    VStack{
                        Button(action: {
                            showSetReminderSheet.toggle()
                        }) {
                            
                            Text("Set Plant Reminder")
                                .foregroundColor(.white)
                                .font(.system(size: 17, weight: .medium))
                                .padding()
                                .frame(width: 280, height: 44)
                                .background(Color(hex: "#19B183").opacity(45))
                                .glassEffect(.clear)
                                .cornerRadius(60)
                            
                        }.sheet(isPresented: $showSetReminderSheet) {
                            NavigationStack {
                                VStack {
                                    SetReminderView(showSetReminderSheet: $showSetReminderSheet, reminders: $reminders)
                                }
                            }
                        }
                    }// End of the add reminder button
                    
                }//end of the if statment of the add button
                else{
                    VStack(alignment: .trailing){
                        Button(action: {
                            showSetReminderSheet.toggle()
                        }) {
                            
                            Image(systemName: "plus")
                                .foregroundColor(.white)
                                .font(.system(size: 17, weight: .medium))
                                .padding()
                                .frame(width: 48, height: 48)
                                .background(Color(hex: "#19B183").opacity(45))
                                .cornerRadius(60)
                            
                        }.glassEffect()
                        .sheet(isPresented: $showSetReminderSheet) {
                            NavigationStack {
                                VStack {
                                    SetReminderView(showSetReminderSheet: $showSetReminderSheet, reminders: $reminders)
                                }
                            }
                        }
                    }// End of the add reminder  circle button
                    .frame(maxWidth: .infinity, alignment: .bottomTrailing)
                    .padding(.horizontal)
                }
            }.frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
        }
    }
}

#Preview {
    PlantsView(countReminders: .constant(0))
}


extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17,
                            (int >> 4 & 0xF) * 17,
                            (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16,
                            int >> 8 & 0xFF,
                            int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24,
                            int >> 16 & 0xFF,
                            int >> 8 & 0xFF,
                            int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

