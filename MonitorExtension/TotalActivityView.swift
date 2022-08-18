//
//  TotalActivityView.swift
//  myDeviceActivityReportExtension
//
//  Created by Tarık Yılıkoğlu on 7.07.2022.
//

import SwiftUI

struct TotalActivityView: View {
    var activityReport: ActivityReport
    
    var body: some View {
        VStack {
            Spacer(minLength: 50)
            Text("Total Screen Time")
            Spacer(minLength: 10)
            Text(activityReport.totalDuration.stringFromTimeInterval())
            List(activityReport.apps) { app in
                ListRow(eachApp: app)
            }
        }
    }
}

struct ListRow: View {
    var eachApp: AppDeviceActivity
    var body: some View {
        HStack {
            Text(eachApp.displayName)
            Spacer()
            Text(eachApp.id)
            Spacer()
            Text("\(eachApp.numberOfPickups)")
            Spacer()
            Text(String(eachApp.duration.formatted()))
        }
    }
}
