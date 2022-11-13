//
//  ContentView.swift
//  Sushruta
//
//  Created by 莊翔安 on 2022/9/27.
//

import SwiftUI
import GanttisTouch
import PhotosUI
import Charts


struct ContentViewVideo: View {
    
    @State var Start = false
    @State private var selectedPhotoData: Data?
    
    @State var isPlaying = false
    @State var showPhaseDetail = false
    @State var showFinalReport = false
    
    @State var items = [GanttChartViewItem]()
    @State var dependencies = [GanttChartViewDependency]()
    @State var rowHeaders: [String?]? = nil
    @State var schedule = Schedule.continuous
    //    @State var theme = Theme.jewel
    @State var theme = Theme.standard
    
    @State var lastChange = "none"
    @State var dateToAddTo = 2
    
    @State var showHistoryMessage = false
    @State var finish = true
    @State private var selectedItem: PhotosPickerItem?
    
    let labels = (1...10).map { "Phase" + String($0) }
    
    
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
                    if let selectedPhotoData,
                       let image = UIImage(data: selectedPhotoData) {
                        
                        Image(uiImage: image)
                            .resizable()
                        
                    }
                    
                    HStack{
                        
                        //check button
                        if selectedItem != nil{
                            Button {
                                print("pressing Check")
                                Start.toggle()
                            } label: {
                                Text("Start !")
                                    .multilineTextAlignment(.leading)
                                    .padding(.horizontal,7)
                            }
                            .buttonStyle(.borderedProminent)
                        }
                        
                        PhotosPicker(selection: $selectedItem, matching: .any(of: [.images, .videos])) {
                            if selectedItem == nil{
                                Label("Select a video", systemImage: "video")
                                    .padding(10)
                                    .border(Color("AccentColor"), width: 2)
                                    .cornerRadius(5)
                            }
                            else{
                                Text("Select another video")
                            }
                        }
                        
                        .onChange(of: selectedItem) { newItem in
                            Task {
                                if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                    selectedPhotoData = data
                                }
                            }
                        }
                    }
                    
                    
                    
                    // Start and Pause Button
                    //                    Button(action: {
                    //                        isPlaying.toggle()
                    //                        if isPlaying {
                    ////                                        player.pause()
                    //                        } else {
                    ////                                        player.play()
                    //                        }
                    //                    }) {
                    //                        Image(systemName: isPlaying ? "pause" : "play.fill")
                    //                            .padding(3.0)
                    //                            .border(Color.accentColor, width: 2)
                    //                    }
                    //                    .frame(width: 0.0, height: 0.0)
                    //                    .font(.system(size:34))
                    
                    
                    
                    //                                VideoPlayer(player: player)
                }
                .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 400)
                
                
                
                
                // phase
                
                VStack {
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
                    .listRowSeparatorTint(.purple)
                    .offset(y:-5)
                }
                
                
                
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
                                Text("This is Message.")
                                Text("This is Message.")
                                Text("This is Message.")
                                Text("This is Message.")
                                Text("This is Message.")
                                Text("This is Message.")
                                Text("This is Message.")
                                Text("This is Message.")
                                Text("This is Message.")
                                Text("This is Message.")
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
                                    .background(Color("AccentColor"))
                                    .cornerRadius(8)
                                
                                
                            }
                        } else{
                            Text("Final Report")
                                .padding(.horizontal, 15.0)
                                .padding(.vertical,10)
                                .foregroundColor(.white)
                                .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.834))
                                .cornerRadius(8)
                            
                            
                        }
                        
                        
                        
                    }
                    .frame(width: 300, height: 50.0)
                    
                }
                
                
            }
            .padding(5.0)
            
            
            
            
            HStack{
                
                // Gantt Chart
                VStack{
                    HStack {
                        Text("Gantt Chart")
                            .font(.headline)
                        Spacer()
                    }
                    GanttChartView(
                        items: $items,
                        dependencies: $dependencies,
                        schedule: schedule,
                        headerRows: [
                            GanttChartHeaderRow(TimeSelector(.seconds))
                        ],
                        rowHeight: 50,
                        hourWidth: 21600,
                        
                        scrollableTimeline: TimeRange(from: Time.current.dayStart,
                                                      to: Time.current.adding(hours: 10)),
                        
                        //                scheduleHighlighters: [ScheduleTimeSelector(.weekends)],
                        //                intervalHighlighters: [TimeSelector(.weeks(startingOn: .monday)), TimeSelector(.time)],
                        //                timeScale: .intervalsWith(period: 15, in: .minutes),
                        desiredScrollableRowCount: 5,
                        rowHeaders: rowHeaders,
                        rowHeadersWidth: 150,
                        theme: theme,
                        onItemAdded: { item in
                            lastChange = "\(item.label ?? "item") added"
                        },
                        onItemRemoved: { _ in
                            lastChange = "item removed"
                        },
                        onDependencyAdded: { dependency in
                            lastChange = "dependency added from \(dependency.from(considering: items)!.label ?? "item") to \(dependency.to(considering: items)!.label ?? "item")"
                        },
                        onDependencyRemoved: { _ in
                            lastChange = "dependency removed"
                        },
                        onTimeChanged: { item, _ in
                            lastChange = "time updated for \(item.label ?? "item")"
                        },
                        onCompletionChanged: { item, _ in
                            lastChange = "completion updated for \(item.label ?? "item")"
                        },
                        onRowChanged: { item, _ in
                            lastChange = "row updated for \(item.label ?? "item")"
                        }
                    )
                    
                    
                }
                .toolbar {
                    ToolbarItemGroup(placement: .bottomBar) {
                        Button("Add new") {
                            addNewItem()
                            lastChange = "added new item"
                            dateToAddTo += 1
                        }
                        Button("Update") {
                            updateAnItem()
                            lastChange = "updated an item"
                        }
                        Button("Remove dep.") {
                            removeAllDependencies()
                            lastChange = "removed all dependencies"
                        }
                        Spacer()
                        Button("Theme") {
                            changeTheme()
                        }
                    }
                }
                .onAppear() {
                    let color_list = [Color.darkGreen, Color.lightBlue, Color.red, Color.orange, Color.black, Color.darkBlue]
                    var item_list = [
                        GanttChartViewItem(label: "A", row: 0, start: date(1), finish: date(2)),
                        GanttChartViewItem(label: "A", row: 0, start: date(10), finish: date(15)),
                        GanttChartViewItem(label: "B", row: 1, start: date(1), finish: date(2)),
                        GanttChartViewItem(label: "C", row: 1, start: date(4), finish: date(5)),
                        GanttChartViewItem(row: 1, start: date(10), finish: date(11)),
                        GanttChartViewItem(row: 2, start: date(2), finish: date(4))]
                    item_list[0].style.barFillColor = .darkGreen
                    item_list[4].details = "Special item"
                    item_list[1].completion = 1
                    item_list[2].completion = 0.25
                    item_list[2].type = .summary
                    item_list[4].completion = 0.08
                    for i in 3..<500 {
                        let tmp = Int.random(in:0..<6)
                        if (tmp == item_list.last?.row) {
                            item_list[item_list.count-1].finish = item_list.last?.finish.adding(seconds: 1) ?? Time().dayStart
                        }
                        else {
                            item_list.append(GanttChartViewItem(row: tmp,
                                                                start: date(i), finish: date(i + 1)))
                            
                            item_list[item_list.count-1].style.barFillColor = color_list[tmp]
                        }
                        
                    }
                    
                    self.items = item_list.filter { $0.finish.second -  $0.start.second  > 1 }
                    self.dependencies = dependencies
                    let rowHeaders = [
                        "grasper",
                        "hook",
                        "scissors",
                        "clipper",
                        "irrigator"
                    ]
                    self.rowHeaders = rowHeaders
                    
                    
                }
                
                // instrument displacement ratio
                VStack{
                    HStack {
                        Text("Instrument Displacemetn Ratio")
                            .font(.headline)
                        Spacer()
                    }
                    HStack {
                        VStack {
                            SimpleLineChartView()
                        }
                        .padding()
                        Spacer()
                    }
                    .offset(y:-10)
                    
                }
                
            }
            .padding(5.0)
            .padding(.bottom, 5.0)
        }
        
    }
    
    func addNewItem() {
        let start = Int.random(in:0..<500)
        let end = Int.random(in:start..<500)
        items.append(
            GanttChartViewItem(label: "New", row: Int.random(in:0..<6),
                               start: date(start), finish: date(end)))
    }
    func updateAnItem() {
        items[1].label = "Updated at :\(String(format: "%02d", Time.current.second))"
    }
    func removeAllDependencies() {
        dependencies.removeAll()
    }
    func changeTheme() {
        theme = theme == .standard ? .jewel : .standard
    }
}

struct ContentViewVideo_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewVideo()
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
