//
//  ContentView.swift
//  Sushruta
//
//  Created by 莊翔安 on 2022/9/27.
//

import SwiftUI
import PhotosUI


struct ContentViewCamera: View {
    
    @State var isPlaying = false
    @State var showPhaseDetail = false
    @State var showFinalReport = false
    @State var showHistoryMessage = false
    @State var finish = true
    @State private var selectedItem: PhotosPickerItem?
    @StateObject private var model = VisionObjectClassificationFrameHandler()

    
    var body: some View {

        VStack(spacing:0){
            Text("Sushruta")
                .font(.largeTitle)
                .foregroundColor(.accentColor)
            
            Divider()
                .padding(.top,10)


            

            HStack{
                
        
                // camera
                VStack{
                    
                    // video information
                    HStack{
                        Text("48033C-20220909")
                            .font(.system(size: 24))
                        Spacer()
                        Text("Processing Time: 21mins58secs")
                    }
                    .frame(width: 500)
                    .offset(y: /*@START_MENU_TOKEN@*/14.0/*@END_MENU_TOKEN@*/)
                    
                    
                    FrameView(
                        image: model.frame,
                        bbox: model.bbox
                    ).ignoresSafeArea()
//                    Image("videosample")
//                        .resizable()
//                        .frame(width: 500, height: 350)
//                        .cornerRadius(10.0)
                    
                    
                    
                     // Start and Pause Button
                    Button(action: {
                        isPlaying.toggle()
                        if isPlaying {
                            model.startRunning()
                        } else {
                            model.endRunning()
                        }
                    }) {
                        Image(systemName: isPlaying ? "pause" : "play.fill")
                            .padding(3.0)
                            .border(Color.accentColor, width: 2)
                    }
                    .frame(width: 0.0, height: 0.0)

                    .offset(x:220, y:-44)
                    .font(.system(size:34))
                    
                }
                
                
                // phase
                List {
                  Section(header: Text("Phase")) {
                      ForEach(0..<6) { index in
                          HStack {
                              Button {
                                  print("pressing Button\(index+1)")
                                  self.showPhaseDetail.toggle()
                              } label: {
                                  Text("Phase-\(index+1)")
                                      .multilineTextAlignment(.leading)
                                      .padding(7)
                              }
                              .sheet(isPresented: $showPhaseDetail) {
                                  DetailView()
                              }

                          }

                        }
                  }
                }
                .listStyle(.plain)
                .offset(y:-5)
        

                
                // instruction and final report
                VStack{
                    // instruction
                    GroupBox(label:
                                HStack{
                        Text("Model Message")
                            .fontWeight(.bold)
                    }){
                        Divider().padding(.vertical, 10)
                        
                        HStack{
                            VStack {
                                Text("Classification: ")
                                Text(model.label)
                                Text("Detection: ")
                                Text(model.detectionlabel)
                            }
                            Spacer()
                            
                        }
                    }
                    .frame(width:300, height:300)
                    // two button
                    HStack{
                        
                        Button {
                            print("pressing history instruction")
                            self.showHistoryMessage.toggle()
                        } label: {
                            Text("History Message")
                                .padding(3)
                        }
                        .sheet(isPresented: $showHistoryMessage, content: {
                            HistoryMessageView()
                        })
                        .buttonStyle(.borderedProminent)
                        
            
                        if finish {
                            NavigationLink{
                                FinalReportView()
                            } label:{
                                Text("Final Report")
                                    .padding(.horizontal, 15.0)
                                    .padding(.vertical,10)
                                    .foregroundColor(.white)
                                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("AccentColor")/*@END_MENU_TOKEN@*/)
                                    .cornerRadius(8)
                                
                                    
                            }
                        } else{
                            Text("Final Report")
                                .padding(.horizontal, 15.0)
                                .padding(.vertical,10)
                                .foregroundColor(.white)
                                .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(hue: 1.0, saturation: 0.0, brightness: 0.834)/*@END_MENU_TOKEN@*/)
                                .cornerRadius(8)


                        }
                        
                        

                    }
                    .frame(width: 300, height: 50.0)
                    
                }
                
                
            }
            .padding(5.0)

            
            
            HStack{
                
                // gannt graph
                VStack{
                    
                    HStack {
                        Text("Gantt Graph")
                            .font(.headline)
                            .padding(0.0)
                            
                        Spacer()
                    }
                    HStack {
                        Image("ganntsample")
                            .resizable()
//                            .frame(width: 550, height: 300)
                            .cornerRadius(10.0)
                        Spacer()
                    }
                    .offset(y:-10)
                        
                }
                Spacer()
                // instrument displacement ratio
                VStack{
                    HStack {
                        Text("Instrument Displacemetn Ratio")
                            .font(.headline)
                        Spacer()
                    }
                    HStack {
                        Image("instrumentdisplacesample")
                            .resizable()
//                            .frame(width: 550, height: 300)
                            .cornerRadius(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                        Spacer()
                    }
                    .offset(y:-10)
                        
                }
                
            }
            .padding(5.0)
            .padding(.bottom, 5.0)
        }
    }
}

struct ContentViewCamera_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewCamera()
    }
}





//back-up

//struct DetailView: View{
//
//    @Environment(\.presentationMode) var presentationMode
//
//    var body: some View{
//
//        NavigationView{
//
//            Text("This is the detail for this phase.")
//                .navigationBarItems(trailing: Button(action: {
//                    self.presentationMode.wrappedValue.dismiss()
//                }, label: {
//                    Image(systemName: "chevron.down.circle.fill")
//                        .foregroundColor(.accentColor)
//                }))
//        }
//    }
//}
