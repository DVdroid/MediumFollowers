//
//  User.swift
//  MediumFollowers
//
//  Created by Vikash Anand on 03/02/21.
//

import Foundation

struct User: Decodable, Hashable, Equatable {

    static func == (lhs: User, rhs: User) -> Bool {
        lhs.id == rhs.id
    }

    private static let profilePictureUrl = "https://cdn-images-1.medium.com/fit/c/150/150/"

    let id: String?
    let username: String?
    let name: String?
    let bio: String?
    let imageId: String?
    let twitterScreenName: String?
    let mediumMemberAt: Int?
    let socialStats: SocialStats?
    let navItems: [NavItem]?

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    var firstName: String {
        guard let unwrappedName = name else { return "" }
        return unwrappedName.components(separatedBy: " ").first ?? ""
    }

    var lastName: String {
        guard let unwrappedName = name else { return "" }
        return unwrappedName.components(separatedBy: " ").last ?? ""
    }

    var profilePictureFullUrl: String {
        guard let unwrappedImageId = imageId else { return "" }
        return User.profilePictureUrl + unwrappedImageId
    }
}

struct SocialStats: Decodable {
    let followerCount: Int?
    let followingCount: Int?
}

struct NavItem: Decodable {
    let title: String?
    var url: String?
}

struct DecodedUsers: Decodable {

    var allUsers: [User]

    // Define DynamicCodingKeys type needed for creating
    // decoding container from JSONDecoder
    private struct DynamicCodingKeys: CodingKey {

        // Use for string-keyed dictionary
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }

        // Use for integer-keyed dictionary
        var intValue: Int?
        init?(intValue: Int) {
            // We are not using this, thus just return nil
            return nil
        }
    }

    init(from decoder: Decoder) throws {

        // 1
        // Create a decoding container using DynamicCodingKeys
        // The container will contain all the JSON first level key
        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)

        var tempArray = [User]()

        // 2
        // Loop through each key (student ID) in container
        for key in container.allKeys {

            guard key.stringValue.hasPrefix("User:") else { continue }

            // Decode Student using key & keep decoded Student object in tempArray
            let decodedObject = try container.decode(User.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
            tempArray.append(decodedObject)
        }

        // 3
        // Finish decoding all User objects. Thus assign tempArray to array.
        allUsers = tempArray
    }
}

struct DecodedProfiles: Decodable {

    var allProfiles: [NavItem]

    // Define DynamicCodingKeys type needed for creating
    // decoding container from JSONDecoder
    private struct DynamicCodingKeys: CodingKey {

        // Use for string-keyed dictionary
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }

        // Use for integer-keyed dictionary
        var intValue: Int?
        init?(intValue: Int) {
            // We are not using this, thus just return nil
            return nil
        }
    }

    init(from decoder: Decoder) throws {

        // 1
        // Create a decoding container using DynamicCodingKeys
        // The container will contain all the JSON first level key
        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)

        var tempArray = [NavItem]()

        // 2
        // Loop through each key (student ID) in container
        for key in container.allKeys {

            // Decode Student using key & keep decoded Student object in tempArray
            let decodedObject = try container.decode(NavItem.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
            tempArray.append(decodedObject)
        }

        // 3
        // Finish decoding all User objects. Thus assign tempArray to array.
        allProfiles = tempArray
    }
}
