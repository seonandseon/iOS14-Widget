//
//  Widget.swift
//  Widget
//
//  Created by bibi lim on 2020/12/10.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry()
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry()
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for minuteOffset in 0 ..< 60 {
            let entryDate = Calendar.current.date(byAdding: .minute, value: minuteOffset, to: currentDate)!
            let entry = SimpleEntry(TimeToGoHome: Date(), CurrentTime: Date())
            entries.append(entry)
        }
       

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
    

}

func GetLeftTime (_: Void) -> (DateComponents) {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    let currentTime = Date() // now
    let endTime = DateComponents(calendar: Calendar.current, hour: 7, minute: 0, second: 0, nanosecond: 0)

    //let calendar = Calendar.current
    //let gap = endTime.timeIntervalSince(currentTime)
    
    return gap
    
}

struct SimpleEntry: TimelineEntry {
    var date: Date
    
    let TimeToGoHome : Date
    let CurrentTime: Date
}

struct WidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        Text("Time Left To Go Home :")
        Text(entry.leftTime, style: .time)
    }
}

@main
struct HomeWidget: SwiftUI.Widget {
    let kind: String = "Widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct Widget_Previews: PreviewProvider {
    static var previews: some View {
        WidgetEntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
