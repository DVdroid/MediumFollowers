//
//  MediumAccountInfoView_Small.swift
//  MediumFollowers
//
//  Created by Vikash Anand on 03/02/21.
//

import SwiftUI

struct MediumAccountInfoView_Small: View {

    let images: [UIImage]?
    let size: CGSize
    let mediumAccountInfo: MediumAccountInfo

    @Environment(\.colorScheme) var colorScheme

    var backgroundColor: Color {
        return colorScheme == .dark ? Color(hex: "#3F2B1D") : Color(hex: "#0071BC")
    }

    var textColor: Color {
        return colorScheme == .dark ? .yellow : .white
    }

    var body: some View {

        VStack {
            if let unwrappedAccountHolder = mediumAccountInfo.accountHolder {

                HStack(alignment: .top) {
                    let fontSize = size.width * 0.075
                    MultilineTextView(textViews: [TextView(text: unwrappedAccountHolder.firstName, fontSize: fontSize),
                                                  TextView(text: unwrappedAccountHolder.lastName, fontSize: fontSize)],
                                      alignment: .leading,
                                      size: CGSize(width: size.width * 0.25, height: size.height * 0.1))
                    Spacer()

                    if let unwrappedImages = images {
                        ProfileView(title: nil,
                                    size: CGSize(width: size.width * 0.4, height: size.height * 0.4),
                                    titleFontSize: (size.height * 0.08),
                                    imageOffset: (-(size.height * 0.1), 0),
                                    titleOffset: (-15, 4),
                                    image: unwrappedImages.first)
                    } else {
                        ProfileView(title: nil,
                                    size: CGSize(width: size.width * 0.4, height: size.height * 0.4),
                                    titleFontSize: (size.height * 0.08),
                                    imageOffset: (-(size.height * 0.1), 0),
                                    titleOffset: (-15, 4),
                                    image: nil)
                    }
                }.padding(.top, -20)

                CounterView(count: String(mediumAccountInfo.followersCount),
                            countType: "Following",
                            size: CGSize(width: size.width * 0.5, height: size.height * 0.1))
                    .padding(.top, 10)
            }
            else { Text("Something went wrong") }
        }
        .padding(.top, 20)
        .frame(width: size.width, height: size.height)
        .background(backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

struct MediumAccountInfoView_Small_Previews: PreviewProvider {

    private static let user = User(id: "",
                                   username: MediumAccountInfo.Constant.userName,
                                   name: "user name",
                                   bio: "qwertyytrewq",
                                   imageId: nil,
                                   twitterScreenName: nil,
                                   mediumMemberAt: nil,
                                   socialStats: nil,
                                   navItems: nil)

    static var previews: some View {

        Group {
            MediumAccountInfoView_Small(images: nil,
                                        size: CGSize(width: 180, height: 180),
                                        mediumAccountInfo: MediumAccountInfo(users: [user]))
                .environment(\.colorScheme, .light)

            MediumAccountInfoView_Small(images: nil,
                                        size: CGSize(width: 180, height: 180),
                                        mediumAccountInfo: MediumAccountInfo(users: [user]))
                .environment(\.colorScheme, .dark)
        }
    }
}
