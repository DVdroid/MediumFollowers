//
//  ProfileView.swift
//  MediumFollowers
//
//  Created by Vikash Anand on 03/02/21.
//

import SwiftUI

struct ProfileView: View {

    let accountHolder: AccountHolder
    let imageData: Data?

    @Environment(\.colorScheme) var colorScheme

    var textColor: Color {
        return colorScheme == .dark ? .yellow : .white
    }

    var backgroundColor: Color {
        return colorScheme == .dark ? Color(hex: "#3F2B1D") : Color(hex: "#0071BC")
    }

    var body: some View {

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
            .offset(y: 10)

            Spacer()

            GeometryReader { geometry in
                CircleImageView(imageData: imageData)
                    .frame(width: geometry.size.width / 1.2, height: geometry.size.width / 1.2)
            }
            .offset(x: 15)

        }
        .background(backgroundColor)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {

        Group {
            ProfileView(accountHolder: AccountHolder(firstName: "First", lastName: "Last"),
                             imageData: nil)
                .frame(width: 200, height: 200)
                .environment(\.colorScheme, .light)

            ProfileView(accountHolder: AccountHolder(firstName: "First", lastName: "Last"),
                             imageData: nil)
                .frame(width: 200, height: 200)
                .environment(\.colorScheme, .dark)
        }

    }
}
