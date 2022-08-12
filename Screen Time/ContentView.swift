//
//  ContentView.swift
//  TestDeviceActivity2
//
//  Created by Tarık Yılıkoğlu on 6.07.2022.
//

import SwiftUI
import DeviceActivity
import FamilyControls
import ManagedSettings
import MonitorExtension


struct ContentView: View {
    var body: some View {
        VStack {
            selectorView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct selectorView: View {
    @State var selection = FamilyActivitySelection()
    @State var isPresented = false
    @State var presentingModal = false

    var body: some View {
        VStack {
            ChartView()
            
        }
    }
}

struct ChartView: View {

    @State private var context: DeviceActivityReport.Context = .init(rawValue: "Total Activity")
    @State private var filter = DeviceActivityFilter(
        segment: .daily(
            during: Calendar.current.dateInterval(
               of: .day, for: .now
            )!
        ),
        users: .all,
        devices: .init([.iPhone, .iPad])
    )


    var body: some View {
        ZStack {
            STProgressView()
            DeviceActivityReport(context, filter: filter)
                
                // A picker used to change the filter's segment interval.
//                Picker(
//                    selection: $filter.segmentInterval,
//                    label: Text("Segment Interval: ")
//                ) {
//                    Text("Hourly")
//                        .tag(DeviceActivityFilter.SegmentInterval.hourly())
//                    Text("Daily")
//                        .tag(DeviceActivityFilter.SegmentInterval.daily(
//                            during: Calendar.current.dateInterval(
//                                of: .day, for: .now
//                            )!
//                        ))
//                    Text("Weekly")
//                        .tag(DeviceActivityFilter.SegmentInterval.weekly(
//                            during: Calendar.current.dateInterval(
//                                of: .month, for: .now
//                            )!
//                        ))
//                }

        }
    }
}


