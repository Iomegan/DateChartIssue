//
//  ContentView.swift
//  DateChartIssue
//
//  Created by Daniel Witt on 10.09.22.
//

import Charts
import SwiftUI

struct HourWeather {
    var date: Date
    var temp = Double.random(in: 0 ... 60)
}

extension String {
    func date() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd-HH"
        return formatter.date(from: self)!
    }
}

struct ContentView: View {
    let myDataSeperatedByHours = [
        HourWeather(date: "2022-10-01-08".date()),
        HourWeather(date: "2022-10-01-09".date()),
        HourWeather(date: "2022-10-01-10".date()),
        HourWeather(date: "2022-10-01-11".date()),
        HourWeather(date: "2022-10-01-12".date()),
        HourWeather(date: "2022-10-01-13".date()),
        HourWeather(date: "2022-10-01-14".date()),
        HourWeather(date: "2022-10-01-15".date()),
        HourWeather(date: "2022-10-01-16".date()),
        HourWeather(date: "2022-10-01-17".date()),
        HourWeather(date: "2022-10-01-18".date()),
        HourWeather(date: "2022-10-02-08".date()),
        HourWeather(date: "2022-10-02-09".date()),
        HourWeather(date: "2022-10-02-10".date()),
        HourWeather(date: "2022-10-02-11".date()),
        HourWeather(date: "2022-10-02-12".date()),
        HourWeather(date: "2022-10-02-13".date()),
        HourWeather(date: "2022-10-02-14".date()),
        HourWeather(date: "2022-10-02-15".date()),
        HourWeather(date: "2022-10-02-16".date()),
        HourWeather(date: "2022-10-02-17".date()),
        HourWeather(date: "2022-10-02-18".date()),
    ]

    static var shortTimeFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        return dateFormatter
    }()

    var body: some View {
        let allDaytimeDates = myDataSeperatedByHours.map { $0.date } // only the Date objects

        Chart {
            ForEach(myDataSeperatedByHours, id: \.date) { hourData in
                LineMark(
                    x: .value("hour", hourData.date),
                    y: .value("value", hourData.temp)
                )
                .foregroundStyle(Color(.red))
            }
        }
        .chartYAxis {
            AxisMarks(position: .leading, values: .automatic()) { _ in
                AxisValueLabel()
            }
        }
        .chartXAxis {
            AxisMarks(position: .bottom, values: .automatic(desiredCount: myDataSeperatedByHours.count)) { axisValue in
                if let date = axisValue.as(Date.self) {
                    AxisValueLabel(
                        "\(Self.shortTimeFormatter.calendar.component(.hour, from: date))"
                    )
                }
            }
        }
        .frame(width: 500, height: 350)
        .background(Color.white)
        .chartXScale(domain: allDaytimeDates, type: .date) // MARK: Charts/ChartInternal+Scale.swift:102: Fatal error: The specified scale type is incompatible with the data values and visual property.
//        .chartXScale( type: .date)
        .onAppear {
            print("myDataSeperatedByHours: \(myDataSeperatedByHours)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
