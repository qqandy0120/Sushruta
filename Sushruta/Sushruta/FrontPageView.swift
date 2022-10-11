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
    
    var body: some View {
        NavigationView {
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
                  Section(header: Text("History Data")) {
                  ForEach(0..<6) { index in
                      HStack {
                          Button {
                              print("pressing history data\(index+1)")
                              self.showHistoryData.toggle()
                          } label: {
                              Text("2022/01/0\(index+1)")
                                  .multilineTextAlignment(.leading)
                                  .padding(8)
                          }
                          .sheet(isPresented: $showHistoryData) {
                              FinalReportView()
                          }
                        
                      }

                    }
                  }
                }  // List end
                
                HStack {
                    Spacer()
                    
                    NavigationLink{
                        ContentView()
                    } label: {
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
