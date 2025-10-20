//
//  TodayReminderView.swift
//  Plants-Challenge2
//
//  Created by Abeer Jeilani Osman  on 26/04/1447 AH.
//

import SwiftUI


struct TodayReminderView: View {
    @Binding var reminders: [PlantReminderList]
    @Binding var countReminders : Double
    @State private var countOfCheck : Double = 0.0
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea(edges: .all)
            
            VStack{
                VStack{
                    Text("Your plants are waiting for a sip 💦")
                        .foregroundStyle(.white)
                        .font(.system(size: 18, weight: .regular))
                        .padding(.bottom, 18)
                    
                    ProgressView(value: countOfCheck, total: 10)
                        .progressViewStyle(LinearProgressViewStyle(tint: Color(hex: "19B183")))
                        .scaleEffect(x: 1, y: 2, anchor: .center)
                        .frame(width: 361)
                }// Vstack of tracker
                .padding(.top, 35)
                .padding(.bottom, 60)
                
                
            ScrollView(.vertical){
                VStack(alignment:.leading){
                    
                    ForEach($reminders) { $reminder in
                        //Start of the first reminder
                        HStack{
                            Image(systemName: $reminder.wrappedValue.ischecked ? "checkmark.circle.fill" :"circle")
                                .foregroundStyle($reminder.wrappedValue.ischecked ? Color(hex: "28E0A8") : .gray)
                                .font(.system(size: 23))
                                .onTapGesture {
                                    
                                    $reminder.ischecked.wrappedValue.toggle()

                                    if reminder.ischecked {
                                        countOfCheck += 1.0
                                    } else {
                                        countOfCheck -= 1.0
                                    }

                                }
                            
                            VStack(alignment: .leading, spacing: 8){
                                HStack{
                                    Image(systemName: "location")
                                        .font(Font.system(size: 15))
                                        .foregroundStyle(.gray)
                                    Text("in \($reminder.wrappedValue.room)")
                                        .foregroundStyle(.gray)
                                        .font(.system(size: 15))
                                }
                                Text($reminder.wrappedValue.name)
                                    .foregroundStyle(.white)
                                    .font(.system(size: 28))
                                
                                HStack (spacing: 13){
                                    //Light
                                    HStack{
                                        Image(systemName: "sun.max")
                                            .foregroundStyle(Color(hex: "CCC785"))
                                            .font(.system(size: 14))
                                        Text($reminder.wrappedValue.light)
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
                                        Text($reminder.wrappedValue.water)
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
                            .padding(.top, 10)
                        // Here next reminder placed
                        
                    }// End of list
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                }// End of the Vstack of the all reminders
                
            }//end of ScrollView
                

            }// Vstack of whoal screen
                            
            }//End of Zstack
            
        }
    }




#Preview {
    TodayReminderView(reminders: .constant([]), countReminders: .constant(0))
}
