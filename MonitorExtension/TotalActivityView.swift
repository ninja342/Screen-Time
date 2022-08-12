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

//var testApps = [
//    AppDeviceActivity(id: 1, name: "CAhit"),
//    AppDeviceActivity(id: 2, name: "Batu"),
//    AppDeviceActivity(id: 3, name: "Cihat"),
//    AppDeviceActivity(id: 4, name: "Furkan"),
//    AppDeviceActivity(id: 5, name: "Elma")
//]
//
//struct TotalActivityView_Previews: PreviewProvider {
//    static var previews: some View {
//        TotalActivityView(totalActivity: "aaa", apps: testApps)
//    }
//}
//

// In order to support previews for your extension's custom views, make sure its source files are
// members of your app's Xcode target as well as members of your extension's target. You can use
// Xcode's File Inspector to modify a file's Target Membership.
//struct TotalActivityView_Previews: PreviewProvider {
//    static let noActivity = TotalActivityReport.makeConfiguration(representing: MockActivityData.noData)
//    static let someActivity = TotalActivityReport.makeConfiguration(representing: MockActivityData.smallData)
//    static let lotsOfActivity = TotalActivityReport.makeConfiguration(representing: MockActivityData.bigData)
//
//    static var previews: some View {
//        TotalActivityView(totalActivity: someActivity)
//    }
//}
