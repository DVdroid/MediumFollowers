//
//  Not_Medium_Widget.swift
//  Not Medium Widget
//
//  Created by Vikash Anand on 01/02/21.
//

import WidgetKit
import SwiftUI

struct MediumInfoEntry: TimelineEntry {
    var date: Date
    let accountHolder: AccountHolder
    let followers: Followers
    let imageData: Data?
}

struct Provider: TimelineProvider {

    private var dummyEntry: MediumInfoEntry {
        MediumInfoEntry(date: Date(),
                        accountHolder: AccountHolder(firstName: "First", lastName: "Last"),
                        followers: Followers(count: 0),
                        imageData: nil)
    }

    func placeholder(in context: Context) -> MediumInfoEntry {
        dummyEntry
    }

    func getSnapshot(in context: Context, completion: @escaping (MediumInfoEntry) -> Void) {
        completion(dummyEntry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<MediumInfoEntry>) -> Void) {

        // Use your "Medium" account user name
        MediumDataFetcher.getMediumAccountInfo(for: "{username}") { (accountHolder, followers, error) in

            guard let unwrappedAccountHolder = accountHolder, let unwrappedFollowers = followers else {
                let timeLine = Timeline(entries: [dummyEntry],
                                        policy: TimelineReloadPolicy.after(Calendar.current.date(byAdding: .minute, value: 5, to: Date())!))
                completion(timeLine)
                return
            }

            // Use your "Medium" account user name
            MediumDataFetcher.getMediumAccountHolderIcon(for: "{username}") { (data, response, error) in
                let entry = MediumInfoEntry(date: Date(), accountHolder: unwrappedAccountHolder,
                                            followers: unwrappedFollowers, imageData: data)
                let timeLine = Timeline(entries: [entry],
                                        policy: TimelineReloadPolicy.after(Calendar.current.date(byAdding: .day, value: 1, to: Date())!))
                completion(timeLine)
            }
        }

    }
}

struct WidgetEntryView: View {
    let entry: Provider.Entry

    var body: some View {
        FollowersCountView(accountHolder: entry.accountHolder, followers: entry.followers, imageData: entry.imageData)
    }
}


@main
struct MediumInfoWidget: Widget {
    private let kind = "Not_Medium_Widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Your Profile")
        .description("Keep a tab on the count of your followers")
        .supportedFamilies([.systemSmall])
    }
}
