//
//  FrontPageView.swift
//  Sushruta
//
//  Created by 莊翔安 on 2022/10/10.
//

import SwiftUI

struct FrontPageView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var showHistoryData = false
    @State var shouldPresentActionScheet = false
    @State var goContentViewCamera = false
    @State var goContentViewVideo = false
    
    var body: some View {
        NavigationView {
            
            //switching page
            if goContentViewVideo{
                NavigationLink("", destination: ContentView(), isActive: $goContentViewVideo)
            }
            if goContentViewCamera{
                NavigationLink("", destination: ContentView(), isActive: $goContentViewCamera)
            }
            
            
            VStack(spacing: 0) {
                HStack {
                    
                    Button(action:{
                        print("pressing logo")
                    }) {
                        HStack(alignment: .bottom){
                            
                            Image("logo")
                                .padding(.leading, 5.0)
                            Text("Sushruta")
                                .font(.largeTitle)
        //                        .foregroundColor(Color.white)
                        }
                    }
                    .padding(.horizontal,5)
                    Spacer()

                }
                .padding(.vertical)
                .frame(maxWidth: .infinity)
                .accentColor(Color.black)
                .background(Color.accentColor)
                
                
                List {
                    ForEach(1..<5) { index in
                        NavigationLink{
                            FinalReportView()
                        } label: {
                            HStack {
                                Image("history-data-photo-\(index)")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 50)
                                    .cornerRadius(10)

                                Text("48033C-2022090\(index)")
                                    .bold()
                            }
                        }
                        
                    }
                }
//                List {
//                  Section(header: Text("History Data")) {
//                  ForEach(0..<6) { index in
//                      HStack {
//                          Button {
//                              print("pressing history data\(index+1)")
//                              self.showHistoryData.toggle()
//                          } label: {
//                              Text("2022/01/0\(index+1)")
//                                  .multilineTextAlignment(.leading)
//                                  .padding(8)
//                          }
//                          .sheet(isPresented: $showHistoryData) {
//                              FinalReportView()
//                          }
//
//                      }
//
//                    }
//                  }
//                }  // List end
                
                HStack {
                    Spacer()
                    
//                    NavigationLink{
//                        ContentView()
//                    } label: {
//                        Text("New Video")
//                            .font(.system(size: 40))
//                            .fontWeight(.bold)
//                            .font(.title)
//                            .foregroundColor(.accentColor)
//                            .padding()
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 20)
//                                    .stroke(Color.accentColor, lineWidth: 8)
//                            )
//                            .background(Color.white)
//                            .cornerRadius(20)
//                    }
                    
                    Text("New Video")
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                        .font(.title)
                        .foregroundColor(.accentColor)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.accentColor, lineWidth: 8)
                        )
                        .background(Color.white)
                        .cornerRadius(20)
                        .onTapGesture {shouldPresentActionScheet = true}
                        .actionSheet(isPresented: $shouldPresentActionScheet) { () -> ActionSheet in
                            ActionSheet(title: Text("Choose mode"), message: Text("Please choose your preferred mode to start."), buttons: [ActionSheet.Button.default(Text("Camera"), action: {
                                goContentViewCamera = true
                            }), ActionSheet.Button.default(Text("Video Library"), action: {
                                goContentViewVideo = true
                            }), ActionSheet.Button.cancel()])
                        }
                    
                    
                    
                    Spacer()
                }
                .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(red: 0.95, green: 0.945, blue: 0.971)/*@END_MENU_TOKEN@*/)  // HStack end
                
                Spacer()
                Spacer()
                

                
                
            }  // VStack end
            .ignoresSafeArea(.all, edges: .bottom)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
    }  // body View end
}  // View end

struct FrontPageView_Previews: PreviewProvider {
    static var previews: some View {
        FrontPageView()
    }
}
