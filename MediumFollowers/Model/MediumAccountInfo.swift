//
//  MediumAccountInfo.swift
//  MediumFollowers
//
//  Created by Vikash Anand on 03/02/21.
//

import Foundation

struct MediumAccountInfo {

    let users: [User]

    private static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()

    var accountHolder: User? {
        users.filter({ $0.id == "1b20a0632a72" }).first
    }

    var followers: [User]? {
        users.filter({ $0.id != "1b20a0632a72" })
    }

    var profileUrl: URL? {
        guard let unwrappedProfileUrl = accountHolder?.navItems?.first?.url else { return nil }
        return URL(string: unwrappedProfileUrl)
    }

    var joiningDate: String? {
        guard let joiningTimeInSeconds = accountHolder?.mediumMemberAt else { return nil }
        let epochTime = TimeInterval(joiningTimeInSeconds) / 1000
        let date = Date(timeIntervalSince1970: epochTime)
        print(date)
        return MediumAccountInfo.dateFormatter.string(from: date)
    }
    
}
