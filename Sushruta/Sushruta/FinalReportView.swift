//
//  FinalReport.swift
//  Sushruta
//
//  Created by 莊翔安 on 2022/10/5.
//

import SwiftUI

struct FinalReportView: View {
    
    
    struct Instrument {
        var name: String
        var MovementImg: String
    }
    
    
    @State var imgHeight = 300.0
    @State var imgWidth = 550.0
    let instruments = [
        Instrument(name: "Grasper", MovementImg: "grasper"),
        Instrument(name: "Bipplar", MovementImg: "scissor"),
        Instrument(name: "Hook", MovementImg: "grasper"),
        Instrument(name: "Scissor", MovementImg: "scissor"),
        Instrument(name: "Clipper", MovementImg: "grasper"),
        Instrument(name: "Irrigator", MovementImg: "scissor"),
    ]
        @State private var selectedIndex = 0
    
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Final Report")
                .font(.largeTitle)
                .bold()
                .foregroundColor(Color.accentColor)
                .padding(.bottom)
            Divider()
            HStack(alignment: .top){
                Spacer()
                Spacer()
                Spacer()
                VStack{
                    
                    //information
                    HStack(spacing: 0){
                        VStack(alignment: .leading){
                            Text("Surgery Name:").bold().foregroundColor(.accentColor)
                            Divider()
                            Text("Surgeon:").bold().foregroundColor(.accentColor)
                            Divider()
                            Text("Date:").bold().foregroundColor(.accentColor)
                            Divider()
                            

                        }  // VStack end
                        VStack(alignment: .trailing){
                            Text("48033C-20220909")
                            Divider()
                            Text("Benson Starward")
                            Divider()
                            Text("2022/02/08")
                            Divider()

                        }  // VStasck end
                        Spacer()
                        
                    }  // Hstack end
                    .font(.title2)
                    HStack(spacing: 0){
                        VStack(alignment: .leading){
                            Text("Start Time:").bold().foregroundColor(.accentColor)
                            Divider()
                            Text("End Times:").bold().foregroundColor(.accentColor)
                            Divider()
                            Text("Time Consumption:").bold().foregroundColor(.accentColor)
                            Divider()
                            

                        }  // VStack end
                        VStack(alignment: .trailing){
                            Text("07:21:01")
                            Divider()
                            Text("13:58:59")
                            Divider()
                            Text("6 hours 37 mins 58 secs")
                            Divider()

                        }  // VStasck end
                        Spacer()
                        
                    }  // Hstack end
                    .font(.title2)
                    .padding(.bottom)
                    
                    // instrument tracking summary
                    VStack{
                        
                        HStack {
                            Text("Instrument Movement Summary")
                                .font(.system(size: 24))
                                .bold()
                                .padding(.bottom,10)
                                
                            Spacer()
                        }
                        HStack {
                            Image("\(instruments[selectedIndex].MovementImg)")
                                .resizable()
                            //                                .frame(width: imgWidth, height: imgHeight)
                                .cornerRadius(10.0)
                            Spacer()
                        }
                        .offset(y:-10)
                            
                    }
                    Picker(selection: $selectedIndex) {
                                    ForEach(instruments.indices) { item in
                                        Text(instruments[item].name)
                                    }
                                } label: {
                                    Text("Choose an instrument")
                                }
                                .pickerStyle(.segmented)
                    
                    
                }  // Vstack end
                
                Spacer()
                Spacer()
                
                VStack{
                    
                    // Instrument Usage Summary
                    VStack{
                        
                        HStack {
                            Text("Instrument Usage Summary")
                                .font(.system(size: 24))
                                .bold()
                                .padding(.bottom,10)

                            Spacer()
                        }
                        HStack {
                            Image("ganntsample")
                                .resizable()
//                                .frame(width: imgWidth, height: imgHeight)
                                .cornerRadius(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                            Spacer()
                        }
                        .offset(y:-10)
                        
                    }
                    
                    
                    // Phase Summary
                    VStack{
                        
                        HStack {
                            Text("Phase Summary")
                                .font(.system(size: 24))
                                .bold()
                                .padding(.bottom,10)

                            Spacer()
                        }
                        HStack {
                            Image("ganntsample")
                                .resizable()
                            //                                .frame(width: imgWidth, height: imgHeight)
                                .cornerRadius(10.0)
                            Spacer()
                        }
                        .offset(y:-10)
                            
                    }
                    
                    
                    
                }  // Vstack end
            
                Spacer()
                Spacer()
                Spacer()
            }  // HStack end
            .padding(.top)
        Spacer()
        Spacer()
        }  // VStack end
    }
}

struct FinalReportView_Previews: PreviewProvider {
    static var previews: some View {
        FinalReportView()
    }
}
