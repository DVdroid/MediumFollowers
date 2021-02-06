//
//  MediumDataFetcher.swift
//  MediumFollowers
//
//  Created by Vikash Anand on 01/02/21.
//

import Foundation
import SwiftSoup

enum MediumDataFetcher {

    static func getMediumAccountInfo(for username: String,
                                     completion: @escaping (MediumAccountInfo?, Error?) -> Void) {
 
        do {
            let url = URL(string: "https://medium.com/\(username)/followers")!
            let html = try String(contentsOf: url)
            let doc = try SwiftSoup.parse(html)
            let followersData = try doc.body()!.select("script")

            for follower in followersData.array() {

                let htmlText = try follower.html()
                let type = htmlText.components(separatedBy: "=")
                if let firstItem = type.first, firstItem.hasPrefix("window.__APOLLO_STATE__") {
                    let jsonData = Data(type.last!.utf8)
                    let decodedResult = try! JSONDecoder().decode(DecodedUsers.self, from: jsonData)
                    let mediumAccountInfo = MediumAccountInfo(users: decodedResult.allUsers)

                    #if DEBUG
                    print(mediumAccountInfo.accountHolder ?? "")
                    print(mediumAccountInfo.followers ?? "")
                    #endif

                    completion(mediumAccountInfo, nil)
                }
            }
        } catch {
            completion(nil, error)
        }
    }

    static func getMediumAccountHolderIcon(for username: String,
                                           completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        do {
            let feedUrl = URL(string: "https://medium.com/feed/\(username)")!
            let html = try String(contentsOf: feedUrl)
            let doc = try SwiftSoup.parse(html)
            let imageUrlString = try doc.select("url").first()!.text()
            let imageUrl = URL(string: imageUrlString)!
            URLSession.shared.dataTask(with: imageUrl, completionHandler: completion).resume()
        } catch {
            completion(nil, nil, error)
        }
    }
}
