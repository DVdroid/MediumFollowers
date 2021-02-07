//
//  FollowersView.swift
//  MediumFollowers
//
//  Created by Vikash Anand on 07/02/21.
//

import SwiftUI

struct FollowersView: View {

    let images: [UIImage]?
    let size: CGSize
    let mediumAccountInfo: MediumAccountInfo

    let rows = [
        GridItem(.fixed(200)),
    ]
    
    var body: some View {

        if let unwrappedFollowers = mediumAccountInfo.followers {

            VStack {
                TextView(text: "Recent Followers", fontSize: size.width * 0.075)
                    .offset(x: -65)
                HStack(alignment: .bottom) {
                    
                    ForEach(unwrappedFollowers, id: \.self) { follower in

                        if let unwrappedImages = images {
                            ProfileView(title: "\(String(describing: follower.firstName))",
                                        size: CGSize(width: size.width * 0.15, height: size.height * 0.18),
                                        titleFontSize: (size.height * 0.022),
                                        imageOffset: (0, 0),
                                        titleOffset: (5, 0),
                                        image: unwrappedImages[Int.random(in: 1...5)])
                                .padding()
                        } else {
                            ProfileView(title: "\(String(describing: follower.firstName))",
                                        size: CGSize(width: size.width * 0.15, height: size.height * 0.18),
                                        titleFontSize: (size.height * 0.022),
                                        imageOffset: (0, 0),
                                        titleOffset: (5, 0),
                                        image: nil)
                                .padding()
                        }
                    }
                }
            }
            .frame(width: size.width * 1.1, height: size.height * 0.35)
        } else {
            TextView(text: "Something went wrong.", fontSize: 15)
        }
    }

}

struct FollowersView_Previews: PreviewProvider {

    static var previews: some View {
        FollowersView(images: nil,
                      size: CGSize(width: 350, height: 350),
                      mediumAccountInfo: MediumAccountInfo(users: MediumAccountInfo.users))
            .background(Color(hex: "#3F2B1D"))
            .environment(\.colorScheme, .dark)
    }
}
