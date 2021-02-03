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
                                     completion: @escaping (AccountHolder?, Followers?, Error?) -> Void) {
 
        do {
            let url = URL(string: "https://medium.com/\(username)/followers")!
            let html = try String(contentsOf: url)
            let doc = try SwiftSoup.parse(html)
            let head = doc.head()!
            let metaData: Elements = try head.select("meta")
            let followersData = try doc.body()!.select("script")

            for follower in followersData.array() {
                let htmlText = try follower.html()
                let type = htmlText.components(separatedBy: "=")
                if let firstItem = type.first, firstItem.hasPrefix("window.__APOLLO_STATE__") {
                    let jsonData = Data(type.last!.utf8)
                    let decodedResult = try! JSONDecoder().decode(DecodedUsers.self, from: jsonData)
                    let _ = MediumAccountInfo(users: decodedResult.allUsers)
                    //print(mediumAccountInfo.accountHolder ?? "")
                    //print(mediumAccountInfo.followers ?? "")

                    //for follower in mediumAccountInfo.followers! {
                        //print(follower.profilePictureFullUrl ?? "")
                    //}
                }
            }

            var firstName: String?
            var lastName: String?
            for element in metaData.array() where element.hasAttr("property") {
                if try element.attr("property") == "profile:first_name" {
                    firstName = try element.attr("content")
                }
                if try element.attr("property") == "profile:last_name" {
                    lastName = try element.attr("content")
                }
            }

            var followersCount: String?
            for element in metaData.array() where element.hasAttr("name") {
                if try element.attr("name") == "description" {
                    followersCount = try element.attr("content").components(separatedBy: " ").first!
                }
            }

            guard let unwrappedFirstName = firstName,
                  let unwrappedLastName = lastName,
                  let unwrappedFollowersCount = followersCount else {
                completion(nil, nil, nil)
                return
            }

            let accountHolder = AccountHolder(firstName: unwrappedFirstName, lastName: unwrappedLastName)
            let followers = Followers(count: Int(unwrappedFollowersCount)!)
            completion(accountHolder, followers, nil)
        } catch {
            completion(nil, nil, error)
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
