//
//  TodayReminderView.swift
//  Plants-Challenge2
//
//  Created by Abeer Jeilani Osman  on 26/04/1447 AH.
//

import SwiftUI


struct TodayReminderView: View {
    @State private var tracker: Double = 0
    @Binding var reminders: [PlantReminderList]
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea(edges: .all)
            
            VStack{
                
//                VStack (alignment: .leading){
//                  Text ("My Plants 🌱")
//                        .font(.system(size: 34))
//                        .bold()
//                        .foregroundStyle(.white)
//                        .padding(.bottom, 5) // space between text and divider
//                            
//                            Divider()
//                                .frame(height: 2)
//                                .background(Color(hex: "39393B").opacity(0.6))
//                    
//                }.padding() // End of the title of the page (Vstack)
                
                VStack{
                    Text("Your plants are waiting for a sip 💦")
                        .foregroundStyle(.white)
                        .font(.system(size: 18, weight: .regular))
                    Slider(value: $tracker)
                        .padding()
                        .tint(Color(hex: "#19B183"))
                    //To Hide the visible thumb
    //                    .onAppear {
    //                        UISlider.appearance().setThumbImage(UIImage(), for: .normal)
    //                    }
                }// Vstack of tracker
                .padding(.top, 35)
                    
                
                
                VStack(alignment: .leading, spacing: 13){
                    
                    ForEach(reminders, id: \.name) { reminder in
                        //Start of the first reminder
                        HStack (spacing: 24){
                            Image(systemName: "circle")
                                .foregroundStyle(.gray)
                                .font(.system(size: 23))
                            
                            VStack(alignment: .leading, spacing: 8){
                                HStack{
                                    Image(systemName: "location")
                                        .font(Font.system(size: 15))
                                        .foregroundStyle(.gray)
                                    Text(reminder.room)
                                        .foregroundStyle(.gray)
                                        .font(.system(size: 15))
                                }
                                Text(reminder.name)
                                    .foregroundStyle(.white)
                                    .font(.system(size: 28))
                                
                                HStack (spacing: 13){
                                    //Light
                                    HStack{
                                        Image(systemName: "sun.max")
                                            .foregroundStyle(Color(hex: "CCC785"))
                                            .font(.system(size: 14))
                                        Text(reminder.light)
                                            .foregroundStyle(Color(hex: "CCC785"))
                                            .font(.system(size: 14))
                                    }.background(
                                        Color(hex: "18181D")
                                            .frame(width: 89, height: 23)
                                            .cornerRadius(8)
                                    )
                                    //water
                                    HStack{
                                        Image(systemName: "drop")
                                            .foregroundStyle(Color(hex: "CAF3FB"))
                                            .font(.system(size: 14, weight: .medium))
                                        Text(reminder.water)
                                            .foregroundStyle(Color(hex: "CAF3FB"))
                                            .font(.system(size: 14, weight: .medium))
                                    }.background(
                                        Color(hex: "18181D")
                                            .frame(width: 89, height: 23)
                                            .cornerRadius(8))
                                }
                            }
                        }//end of the first reminder
                        
                        Divider()
                            .frame(height: 2)
                            .background(Color(hex: "39393B").opacity(0.6))
                        
                        Spacer()
                        
                        // Here next reminder placed
                        
                    }// End of list
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                }
                

            }// Vstack of whoal screen
                            
            }//End of Zstack
            
        }
    }


#Preview {
    TodayReminderView(reminders: .constant([]))
}
