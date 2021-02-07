//
//  Not_Medium_Widget.swift
//  Not Medium Widget
//
//  Created by Vikash Anand on 01/02/21.
//

import WidgetKit
import SwiftUI

struct MediumInfoEntry: TimelineEntry {
    let images: [UIImage]?
    var date: Date
    let mediumAccountInfo: MediumAccountInfo
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
        return MediumInfoEntry(images: nil, date: Date(), mediumAccountInfo: MediumAccountInfo(users: [user]))
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

            var images: [UIImage] = []
            var imageUrls: [String] = []
            if let unwrappedProfilePictureFullUrl = unwrappedMediumAccountInfo.accountHolder?.profilePictureFullUrl {
                imageUrls.append(unwrappedProfilePictureFullUrl)
            }
            if let unwrappedFollowers = unwrappedMediumAccountInfo.followers {
                for follower in unwrappedFollowers {
                    imageUrls.append(follower.profilePictureFullUrl)
                }
            }

            let group = DispatchGroup()
            for imageUrl in imageUrls {
                guard let url = URL(string: imageUrl) else { continue }

                group.enter()
                guard let imageData = try? Data(contentsOf: url),
                      let image = UIImage(data: imageData) else {
                    group.leave()
                    continue
                }

                images.append(image)
                group.leave()
            }

            group.notify(queue: .main) {

                let entry = MediumInfoEntry(images: images,
                                            date: Date(),
                                            mediumAccountInfo: unwrappedMediumAccountInfo)
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
                MediumAccountInfoView_Small(images: entry.images,
                                            size: proxy.size,
                                            mediumAccountInfo: entry.mediumAccountInfo)
                    .widgetURL(entry.mediumAccountInfo.profileUrl)
            case .systemMedium:
                MediumAccountInfoView_Medium(images: entry.images,
                                             size: proxy.size,
                                             mediumAccountInfo: entry.mediumAccountInfo)
                    .widgetURL(entry.mediumAccountInfo.profileUrl)
            case .systemLarge:
                MediumAccountInfoView_Large(images: entry.images,
                                            size: proxy.size,
                                            mediumAccountInfo: entry.mediumAccountInfo)
                    .widgetURL(entry.mediumAccountInfo.profileUrl)
            @unknown default:
                fatalError()
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

    private static let dummyEntry = MediumInfoEntry(images: nil,
                                                    date: Date(),
                                                    mediumAccountInfo: MediumAccountInfo(users: MediumAccountInfo.users))
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
