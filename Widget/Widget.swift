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
    let currentTime = dateFormatter.date(from:"2018-03-01")! // now
    let endTime = dateFormatter.date(from:"2018-05-15")! //today 7:00

    

    let calendar = Calendar.current
    let gap = calendar.dateComponents([.year,.month,.day,.hour, .minute, .second], from: currentTime, to: endTime)

    return gap
    /*
    if case let (y?, m?, d?, h?) = (dateGap.year, dateGap.month, dateGap.day, dateGap.hour)
    {
      print("\(y)년 \(m)개월 \(d)일 \(h)시간 후")
    }*/
}

struct SimpleEntry: TimelineEntry {
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
