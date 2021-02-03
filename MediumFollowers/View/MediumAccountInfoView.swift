//
//  MediumAccountInfoView.swift
//  MediumFollowers
//
//  Created by Vikash Anand on 03/02/21.
//

import SwiftUI

struct MediumAccountInfoView: View {

    let accountHolder: AccountHolder
    let followers: Followers
    let imageData: Data?

    @Environment(\.colorScheme) var colorScheme

    var backgroundColor: Color {
        return colorScheme == .dark ? Color(hex: "#3F2B1D") : Color(hex: "#0071BC")
    }

    var textColor: Color {
        return colorScheme == .dark ? .yellow : .white
    }

    var body: some View {
        VStack {

            VStack {

                ProfileView(accountHolder: accountHolder,
                                 imageData: imageData)

                FollowersCountView(followers: followers)
            }
            .padding()

        }
        .background(backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

struct MediumAccountInfoView_Previews: PreviewProvider {
    static var previews: some View {

        Group {
            MediumAccountInfoView(accountHolder:
                                    AccountHolder(firstName: "First", lastName: "Last"),
                                   followers: Followers(count: 0),
                                   imageData: nil)
                    .frame(width: 200, height: 200)
                    .environment(\.colorScheme, .light)

            MediumAccountInfoView(accountHolder:
                                    AccountHolder(firstName: "First", lastName: "Last"),
                                   followers: Followers(count: 0),
                                   imageData: nil)
                    .frame(width: 200, height: 200)
                    .environment(\.colorScheme, .dark)
        }
    }
}
