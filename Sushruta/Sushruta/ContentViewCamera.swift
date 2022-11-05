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

struct DisplaceData: Identifiable {
    let id: Int
    let tool: String
    let rate: Double
    let second: Int
 
    init(id: Int, minute: Int, second: Int, rate: Double, tool: String) {
        self.rate = rate
        self.id = id
        self.tool = tool
        self.second = minute*60 + second
    }
}

let toolDisplaceData = [
    DisplaceData(id: 7, minute: 1, second: 1, rate: 5.0, tool: "Scissor"),
    DisplaceData(id: 8, minute: 2, second: 1, rate: 8.0, tool: "Hook"),
    DisplaceData(id: 9, minute: 3, second: 1, rate: 9.0, tool: "Grasper"),
    DisplaceData(id: 10, minute: 4, second: 1, rate: 11.0, tool: "Grasper"),
    DisplaceData(id: 11, minute: 5, second: 1, rate: 15.0, tool: "Grasper"),
    DisplaceData(id: 12, minute: 6, second: 1, rate: 18.0, tool: "Grasper"),
    DisplaceData(id: 1, minute: 7, second: 1, rate: 19.0, tool: "Grasper"),
    DisplaceData(id: 2, minute: 8, second: 1, rate: 17.0, tool: "Grasper"),
    DisplaceData(id: 3, minute: 9, second: 1, rate: 17.0, tool: "Scissor"),
    DisplaceData(id: 4, minute: 10, second: 1, rate: 13.0, tool: "Hook"),
    DisplaceData(id: 5, minute: 11, second: 1, rate: 8.0, tool: "Grasper"),
    DisplaceData(id: 6, minute: 12, second: 1, rate: 8.0, tool: "Grasper")
]

var dataByTool = Dictionary(grouping: toolDisplaceData, by: { $0.tool })

var chartData = Array(dataByTool.values).map{ (tool: $0[0].tool, data: $0) }

let percentileColors = [
    Color.blue.opacity(0.2),
    Color.green.opacity(0.2),
    Color.orange.opacity(1)
]

struct SimpleLineChartView: View {
    var body: some View {
        VStack {
            Chart {
                ForEach(chartData, id: \.tool) { series in
                    ForEach(series.data) { item in
                        LineMark(
                            x: .value("Month", item.second),
                            y: .value("Temp", item.rate)
                        )
                    }
                    .foregroundStyle(by: .value("Tool", series.tool))
                }
                
            }
            .chartForegroundStyleScale(
                range: Gradient (colors: percentileColors)
            )
            .frame(height: 300)
            .chartYAxis {
                AxisMarks(position: .leading)
            }
        }
    }
}


struct ContentViewCamera: View {
    
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
                    
                    // video information
                    HStack{
                        Text("48033C-20220909")
                            .font(.system(size: 24))
                        Spacer()
                        Text("Processing Time: 21mins58secs")
                    }
                    .frame(width: 500)
                    .offset(y: /*@START_MENU_TOKEN@*/14.0/*@END_MENU_TOKEN@*/)
                    
                    
                    
                    Image("videosample")
                        .resizable()
                        .frame(width: 500, height: 350)
                        .cornerRadius(10.0)
                        
                    
                    
                    
                     // Start and Pause Button
                    Button(action: {
                        isPlaying.toggle()
                        if isPlaying {
                            //                                        player.pause()
                        } else {
                            //                                        player.play()
                        }
                    }) {
                        Image(systemName: isPlaying ? "pause" : "play.fill")
                            .padding(3.0)
                            .border(Color.accentColor, width: 2)
                    }
                    .frame(width: 0.0, height: 0.0)

                    .offset(x:220, y:-44)
                    .font(.system(size:34))
                    
                    
                    
                    //                                VideoPlayer(player: player)
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
                .listRowSeparatorTint(.purple)
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
                        
                        
                        NavigationLink{
                            FinalReportView()
                        } label:{
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
//            .padding(5.0)
            
            
            
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

func date(_ second: Int) -> Time {
    return Time().dayStart.adding(seconds: Double(second))
}


struct ContentView_Previews: PreviewProvider {
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

