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
                        let duration = ap.totalActivityDuration
                        let numberOfPickups = ap.numberOfPickups
                        let app = AppDeviceActivity(id: bundle, displayName: appName, duration: duration, numberOfPickups: numberOfPickups)
                        list.append(app)
                    }
                }
            }
        }
        
        return ActivityReport(totalDuration: totalActivityDuration, apps: list)
    }
}


