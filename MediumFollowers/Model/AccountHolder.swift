//
//  AccountHolder.swift
//  MediumFollowers
//
//  Created by Vikash Anand on 01/02/21.
//

import Foundation

struct AccountHolder {
    let firstName: String
    let lastName: String

    var fullName: String {
        firstName + " " + lastName
    }
}
