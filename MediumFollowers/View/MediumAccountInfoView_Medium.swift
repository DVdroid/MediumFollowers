//
//  MediumAccountInfoView_Medium.swift
//  MediumFollowers
//
//  Created by Vikash Anand on 06/02/21.
//

import SwiftUI

struct MediumAccountInfoView_Medium: View {

    let images: [UIImage]?
    let size: CGSize
    let mediumAccountInfo: MediumAccountInfo

    @Environment(\.colorScheme) var colorScheme

    var backgroundColor: Color {
        colorScheme == .dark ? Color(hex: "#3F2B1D") : Color(hex: "#0071BC")
    }

    var textColor: Color {
        colorScheme == .dark ? .yellow : .white
    }

    var fontSize: CGFloat {
        size.width * 0.075
    }


    var body: some View {
        VStack {
            if let unwrappedAccountHolder = mediumAccountInfo.accountHolder {

                HStack(alignment: .top) {

                    VStack(alignment: .leading) {
                        TextView(text: unwrappedAccountHolder.name ?? "", fontSize: fontSize)
                            .offset(x: 20)

                        HStack(alignment: .top) {

                            CounterView(count: String(mediumAccountInfo.followersCount),
                                        countType: "Followers",
                                        size: CGSize(width: size.width * 0.2, height: size.height * 0.1))
                                .padding(.top, 10)

                            Spacer()

                            CounterView(count: String(mediumAccountInfo.followingCount),
                                        countType: "Following",
                                        size: CGSize(width: size.width * 0.2, height: size.height * 0.1))
                                .padding(.top, 10)
                        }
                        .padding(.top, 20)
                    }

                    Spacer()

                    if let unwrappedImages = images {
                        ProfileView(title: "Joined : \(mediumAccountInfo.joiningDate)",
                                    size: CGSize(width: size.width * 0.35, height: size.height * 0.8),
                                    titleFontSize: (size.height * 0.06),
                                    imageOffset: (-(size.height * 0.075), 0),
                                    titleOffset: (-15, 4),
                                    image: unwrappedImages.first)
                    } else {
                        ProfileView(title: "Joined : \(mediumAccountInfo.joiningDate)",
                                    size: CGSize(width: size.width * 0.35, height: size.height * 0.8),
                                    titleFontSize: (size.height * 0.06),
                                    imageOffset: (-(size.height * 0.075), 0),
                                    titleOffset: (-15, 4),
                                    image: nil)
                    }
                }.padding(.top, -20)
            }
            else {
                Text("Something went wrong")
            }
        }
        .padding(.top, 20)
        .frame(width: size.width, height: size.height)
        .background(backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

struct MediumAccountInfoView_Medium_Previews: PreviewProvider {

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
            MediumAccountInfoView_Medium(images: nil,
                                         size: CGSize(width: 350, height: 150),
                                         mediumAccountInfo: MediumAccountInfo(users: [user]))
                .environment(\.colorScheme, .light)

            MediumAccountInfoView_Medium(images: nil,
                                         size: CGSize(width: 350, height: 150),
                                         mediumAccountInfo: MediumAccountInfo(users: [user]))
                .environment(\.colorScheme, .dark)
        }
    }
}
