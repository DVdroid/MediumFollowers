//
//  MediumAccountInfo.swift
//  MediumFollowers
//
//  Created by Vikash Anand on 03/02/21.
//

import Foundation

struct MediumAccountInfo {

    static let users: [User] = [User(id: "",
                                     username: MediumAccountInfo.Constant.userName,
                                     name: "user name",
                                     bio: "qwertyytrewq",
                                     imageId: nil,
                                     twitterScreenName: nil,
                                     mediumMemberAt: nil,
                                     socialStats: nil,
                                     navItems: nil),
                                User(id: "",
                                     username: "username",
                                     name: "user name",
                                     bio: "qwertyytrewq",
                                     imageId: nil,
                                     twitterScreenName: nil,
                                     mediumMemberAt: nil,
                                     socialStats: nil,
                                     navItems: nil),
                                User(id: "",
                                     username: "username",
                                     name: "user name",
                                     bio: "qwertyytrewq",
                                     imageId: nil,
                                     twitterScreenName: nil,
                                     mediumMemberAt: nil,
                                     socialStats: nil,
                                     navItems: nil),
                                User(id: "",
                                     username: "username",
                                     name: "user name",
                                     bio: "qwertyytrewq",
                                     imageId: nil,
                                     twitterScreenName: nil,
                                     mediumMemberAt: nil,
                                     socialStats: nil,
                                     navItems: nil),
                                User(id: "",
                                     username: "username",
                                     name: "user name",
                                     bio: "qwertyytrewq",
                                     imageId: nil,
                                     twitterScreenName: nil,
                                     mediumMemberAt: nil,
                                     socialStats: nil,
                                     navItems: nil)]

    enum Constant {
        static let userName = "anandin02"
    }

    let users: [User]

    private static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()

    var accountHolder: User? {
        users.filter({ $0.username == MediumAccountInfo.Constant.userName }).first
    }

    var accountHolderFirstName: String {
        users.filter({ $0.username == MediumAccountInfo.Constant.userName }).first?.firstName ?? ""
    }

    var accountHolderLastName: String {
        users.filter({ $0.username == MediumAccountInfo.Constant.userName }).first?.lastName ?? ""
    }

    var followers: [User]? {
        users.filter({ $0.username != MediumAccountInfo.Constant.userName })
    }

    var followersCount: Int {
        accountHolder?.socialStats?.followerCount ?? 0
    }

    var followingCount: Int {
        accountHolder?.socialStats?.followingCount ?? 0
    }

    var profileUrl: URL? {
        guard let unwrappedProfileUrl = accountHolder?.navItems?.first?.url else { return nil }
        return URL(string: unwrappedProfileUrl)
    }

    var joiningDate: String {
        guard let joiningTimeInSeconds = accountHolder?.mediumMemberAt else { return "" }
        let epochTime = TimeInterval(joiningTimeInSeconds) / 1000
        let date = Date(timeIntervalSince1970: epochTime)
        print(date)
        return MediumAccountInfo.dateFormatter.string(from: date)
    }
    
}
