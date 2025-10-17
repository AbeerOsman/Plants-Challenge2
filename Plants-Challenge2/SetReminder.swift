//
//  SetReminder.swift
//  Plants-Challenge2
//
//  Created by Abeer Jeilani Osman  on 25/04/1447 AH.
//

import SwiftUI

struct SetReminder: View {
    var body: some View {
        ZStack{
            Color(hex: "1C1C1E")
                .ignoresSafeArea(edges: .all)
            
            
            VStack{
                
                Text("Set Reminder")
                    .foregroundStyle(.white)
                    .font(.system(size: 20))
                    .bold()
                    .padding(.top, 40)
                
                Spacer()
                
                VStack (spacing:45){
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
                            TextField("Pothos", text: .constant(""))
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
                        }
                        Divider()
                            .frame(width: 368, height: 1)
                            .background(Color(hex: "414144"))
                        
                        HStack{
                            Image(systemName: "sun.max")
                                .font(Font.system(size: 18))
                                .foregroundStyle(.white)
                            Text("Room")
                                .foregroundStyle(.white)
                                .font(.system(size: 18))
                            Spacer()
                            
                            //Picker
                        }
                        
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
                        }
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
                        }
                        
                    }.background(Color(hex: "2C2C2E")
                        .frame(width: 388, height: 95).cornerRadius(30))
                    .padding()
                    
                }.padding(.bottom, 408)
                   
                
                
            } .padding() //Vstack of all element in the sheet
            
            
        }
    }
}

#Preview {
    SetReminder()
}
