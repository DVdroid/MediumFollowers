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
    let mediumAccountInfo: MediumAccountInfo
    let imageData: Data?
}

struct Provider: TimelineProvider {

    private var dummyEntry: MediumInfoEntry {
        let user = User(id: "",
                        username: MediumAccountInfo.Constant.userName,
                        name: "user name",
                        bio: "qwertyytrewq",
                        imageId: nil,
                        twitterScreenName: nil,
                        mediumMemberAt: nil,
                        socialStats: nil,
                        navItems: nil)
        return MediumInfoEntry(date: Date(), mediumAccountInfo: MediumAccountInfo(users: [user]), imageData: nil)
    }

    func placeholder(in context: Context) -> MediumInfoEntry {
        dummyEntry
    }

    func getSnapshot(in context: Context, completion: @escaping (MediumInfoEntry) -> Void) {
        completion(dummyEntry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<MediumInfoEntry>) -> Void) {

        // Use your "Medium" account user name
        MediumDataFetcher.getMediumAccountInfo(for: "@\(MediumAccountInfo.Constant.userName)") { (mediumAccountInfo, error) in

            guard let unwrappedMediumAccountInfo = mediumAccountInfo else {
                let timeLine = Timeline(entries: [dummyEntry],
                                        policy: TimelineReloadPolicy.after(Calendar.current.date(byAdding: .minute, value: 5, to: Date())!))
                completion(timeLine)
                return
            }

            // Use your "Medium" account user name
            MediumDataFetcher.getMediumAccountHolderIcon(for: "@\(MediumAccountInfo.Constant.userName)") { (data, response, error) in
                let entry = MediumInfoEntry(date: Date(), mediumAccountInfo: unwrappedMediumAccountInfo, imageData: data)
                let timeLine = Timeline(entries: [entry],
                                        policy: TimelineReloadPolicy.after(Calendar.current.date(byAdding: .day, value: 1, to: Date())!))
                completion(timeLine)
            }
        }

    }
}

struct WidgetEntryView: View {

    @Environment(\.widgetFamily) var family: WidgetFamily
    let entry: Provider.Entry

    var body: some View {

        GeometryReader { proxy in

            switch family {
            case .systemSmall:
                MediumAccountInfoView_Small(imageData: entry.imageData,
                                            size: proxy.size, mediumAccountInfo:
                                                entry.mediumAccountInfo)
            case .systemMedium:
                MediumAccountInfoView_Medium(imageData: entry.imageData,
                                             size: proxy.size, mediumAccountInfo:
                                                entry.mediumAccountInfo)
            case .systemLarge:
                MediumAccountInfoView_Large(imageData: entry.imageData,
                                            size: proxy.size, mediumAccountInfo:
                                                entry.mediumAccountInfo)

            @unknown default:
                MediumAccountInfoView_Small(imageData: entry.imageData,
                                            size: proxy.size, mediumAccountInfo:
                                                entry.mediumAccountInfo)
            }
        }
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
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}


struct MediumInfoWidget_Previews: PreviewProvider {

    private static let dummyEntry = MediumInfoEntry(date: Date(),
                                                    mediumAccountInfo: MediumAccountInfo(users: MediumAccountInfo.users),
                                                    imageData: nil)
    static var previews: some View {

        Group {
            WidgetEntryView(entry: dummyEntry)
                .environment(\.colorScheme, .light)
                .previewContext(WidgetPreviewContext(family: .systemSmall))

            WidgetEntryView(entry: dummyEntry)
                .environment(\.colorScheme, .light)
                .previewContext(WidgetPreviewContext(family: .systemMedium))

            WidgetEntryView(entry: dummyEntry)
                .environment(\.colorScheme, .light)
                .previewContext(WidgetPreviewContext(family: .systemLarge))
        }
    }
}
