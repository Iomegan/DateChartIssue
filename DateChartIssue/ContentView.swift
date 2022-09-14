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
    var temp: Double
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
        HourWeather(date: "2022-10-01-08".date(), temp: 34),
        HourWeather(date: "2022-10-01-09".date(), temp: 54),
        HourWeather(date: "2022-10-01-10".date(), temp: 11),
        HourWeather(date: "2022-10-01-11".date(), temp: 43),
        HourWeather(date: "2022-10-01-12".date(), temp: 23),
        HourWeather(date: "2022-10-01-13".date(), temp: 3),
        HourWeather(date: "2022-10-01-14".date(), temp: 55),
        HourWeather(date: "2022-10-01-15".date(), temp: 63),
        HourWeather(date: "2022-10-01-16".date(), temp: 64),
        HourWeather(date: "2022-10-01-17".date(), temp: 23),
        HourWeather(date: "2022-10-01-18".date(), temp: 4),
        HourWeather(date: "2022-10-02-08".date(), temp: 3),
        HourWeather(date: "2022-10-02-09".date(), temp: 2),
        HourWeather(date: "2022-10-02-10".date(), temp: 1),
        HourWeather(date: "2022-10-02-11".date(), temp: 34),
        HourWeather(date: "2022-10-02-12".date(), temp: 54),
        HourWeather(date: "2022-10-02-13".date(), temp: 66),
        HourWeather(date: "2022-10-02-14".date(), temp: 45),
        HourWeather(date: "2022-10-02-15".date(), temp: 22),
        HourWeather(date: "2022-10-02-16".date(), temp: 34),
        HourWeather(date: "2022-10-02-17".date(), temp: 36),
        HourWeather(date: "2022-10-02-18".date(), temp: 34),
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
            AxisMarks(position: .bottom, values: allDaytimeDates) { axisValue in
                if let date = axisValue.as(Date.self) {
                    AxisValueLabel(
                        "\(Self.shortTimeFormatter.calendar.component(.hour, from: date))"
                    )
                }
            }
        }
        .background(Color.white)
        .chartXScale(domain: .automatic(dataType: Date.self) { dates in
            dates = allDaytimeDates
        })
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
