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

    var body: some View {

        VStack {

            HStack {

                VStack {
                    Text("\(followers.count)")
                        .font(Font.system(size: 45))
                        .fontWeight(.heavy)
                        .foregroundColor(.yellow)

                    Text("Followers")
                        .font(Font.system(size: 8))
                        .foregroundColor(.yellow)
                        .bold()
                        .offset(x: -5)

                    Spacer()
                }

                Spacer()

                CircleImageView(imageData: imageData)
                    .frame(width: 70, height: 70)
                    .offset(y: -5)
                    .padding(.bottom, 30)
            }

            Text(accountHolder.fullName)
                .font(.footnote)
                .fontWeight(.heavy)
                .foregroundColor(.yellow)
        }
        .padding()
        .background(Color(hex: "#3F2B1D"))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

struct FollowersCountView_Previews: PreviewProvider {
    static var previews: some View {
        FollowersCountView(accountHolder:
                            AccountHolder(firstName: "First", lastName: "Last"),
                           followers: Followers(count: 0),
                           imageData: nil)
            .frame(width: 150, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
    }
}
