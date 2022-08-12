//
//  TotalActivityReport.swift
//  myDeviceActivityReportExtension
//
//  Created by Tarık Yılıkoğlu on 7.07.2022.
//

import DeviceActivity
import SwiftUI

extension DeviceActivityReport.Context {
    // If your app initializes a DeviceActivityReport with this context, then the system will use
    // your extension's corresponding DeviceActivityReportScene to render the contents of the
    // report.
    static let totalActivity = Self("Total Activity")
}

struct TotalActivityReport: DeviceActivityReportScene {
    
    // Define which context your scene will represent.
    let context: DeviceActivityReport.Context = .totalActivity
    
    // Define the custom configuration and the resulting view for this report.
    let content: (ActivityReport) -> TotalActivityView
    
    func makeConfiguration(representing data: DeviceActivityResults<DeviceActivityData>) async -> ActivityReport {
        // Reformat the data into a configuration that can be used to create
        // the report's view.
        var res = ""
        var list: [AppDeviceActivity] = []
        let totalActivityDuration = await data.flatMap { $0.activitySegments }.reduce(0, {
            $0 + $1.totalActivityDuration
        })
        for await d in data {
            res += d.user.appleID!.debugDescription
            res += d.lastUpdatedDate.description
            for await a in d.activitySegments{
                res += a.totalActivityDuration.formatted()
                for await c in a.categories {
                    for await ap in c.applications {
                        let appName = (ap.application.localizedDisplayName ?? "nil")
                        let bundle = (ap.application.bundleIdentifier ?? "nil")
                        let duration = (ap.totalActivityDuration)
                        let app = AppDeviceActivity(id: bundle, displayName: appName, duration: duration)
                        list.append(app)
                    }
                }
            }
        }
        
        return ActivityReport(totalDuration: totalActivityDuration, apps: list)
    }
}

    
//    // You can extract the configuration creation logic into a generic function that can
//    // be tested with mock data types (see SampleData.swift for more details).
//    static func makeConfiguration<D: ActivityData, S: ActivitySegment>(representing data: [D]) -> String where D.Segment == S {
//        let formatter = DateComponentsFormatter()
//        formatter.allowedUnits = [.day, .hour, .minute, .second]
//        formatter.unitsStyle = .abbreviated
//        formatter.zeroFormattingBehavior = .dropAll
//        for d in data {
//            return d.activitySegments.description
//        }
//        let totalActivityDuration = data.flatMap { $0.activitySegments }.reduce(0, {
//            $0 + $1.totalActivityDuration
//        })
//        for d in data {
//            d.activitySegments[0].totalActivityDuration
//        }
//        for d in data {
//            if let dc = d as? DeviceActivityData {
//                return dc.device.name!
//            }
//        }
//
//        return formatter.string(from: totalActivityDuration) ?? "No activity data"
//    }

