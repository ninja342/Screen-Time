//
//  MonitorExtension.swift
//  MonitorExtension
//
//  Created by Tarık Yılıkoğlu on 28.07.2022.
//

import DeviceActivity
import SwiftUI

@main
struct MonitorExtension: DeviceActivityReportExtension {
    var body: some DeviceActivityReportScene {
        // Create a report for each DeviceActivityReport.Context that your app supports.
        TotalActivityReport { totalActivity in
            return TotalActivityView(activityReport: totalActivity)
        }
        // Add more reports here...
    }
}
