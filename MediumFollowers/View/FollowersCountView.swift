//
//  FollowersCountView.swift
//  MediumFollowers
//
//  Created by Vikash Anand on 01/02/21.
//

import SwiftUI

struct FollowersCountView: View {

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
                HStack(alignment: .top) {

                    VStack(alignment: .leading) {
                        Text(accountHolder.firstName)
                            .scaledFont(name: nil, size: 15)
                            .foregroundColor(textColor)
                            .multilineTextAlignment(.leading)
                            .lineLimit(1)

                        Text(accountHolder.lastName)
                            .scaledFont(name: nil, size: 15)
                            .foregroundColor(textColor)
                            .multilineTextAlignment(.leading)
                            .lineLimit(1)
                    }
                    .offset(y: 15)

                    Spacer()

                    CircleImageView(imageData: imageData)
                        .frame(width: 70, height: 70)
                        .offset(y: 15)
                }

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
                .padding(.bottom, 10)

            }
            .padding()

        }
        .background(backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

struct FollowersCountView_Previews: PreviewProvider {
    static var previews: some View {

        Group {
            FollowersCountView(accountHolder:
                                AccountHolder(firstName: "First", lastName: "Last"),
                               followers: Followers(count: 0),
                               imageData: nil)
                .frame(width: 150, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                .environment(\.colorScheme, .light)

            FollowersCountView(accountHolder:
                                AccountHolder(firstName: "First", lastName: "Last"),
                               followers: Followers(count: 0),
                               imageData: nil)
                .frame(width: 150, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                .environment(\.colorScheme, .dark)
        }
    }
}
