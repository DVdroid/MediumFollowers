//
//  FollowersCountView.swift
//  MediumFollowers
//
//  Created by Vikash Anand on 01/02/21.
//

import SwiftUI

struct FollowersCountView: View {

    let followers: Followers

    @Environment(\.colorScheme) var colorScheme

    var textColor: Color {
        return colorScheme == .dark ? .yellow : .white
    }

    var body: some View {

        VStack {
            Text("\(followers.count)")
                .lineLimit(1)
                .scaledFont(name: nil, size: 45)
                .foregroundColor(textColor)

            Text("Followers")
                .font(Font.system(size: 10))
                .foregroundColor(textColor)
                .bold()
                .offset(x: -5)
        }

    }
}

struct FollowersCountView_Previews: PreviewProvider {
    static var previews: some View {

        Group {
            FollowersCountView(followers: Followers(count: 0))
                .frame(width: 200, height: 200)
                .background(Color(hex: "#0071BC"))
                .environment(\.colorScheme, .light)

            FollowersCountView(followers: Followers(count: 0))
                .frame(width: 200, height: 200)
                .background(Color(hex: "#3F2B1D"))
                .environment(\.colorScheme, .dark)
        }
    }
}
