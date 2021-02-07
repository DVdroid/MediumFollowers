//
//  ProfileView.swift
//  MediumFollowers
//
//  Created by Vikash Anand on 03/02/21.
//

import SwiftUI

struct ProfileView: View {

    let title: String?
    let size: CGSize
    let titleFontSize: CGFloat
    let imageOffset: (x: CGFloat, y: CGFloat)
    let titleOffset: (x: CGFloat, y: CGFloat)
    let image: UIImage?

    @Environment(\.colorScheme) var colorScheme

    var textColor: Color {
        return colorScheme == .dark ? .yellow : .white
    }

    var backgroundColor: Color {
        return colorScheme == .dark ? Color(hex: "#3F2B1D") : Color(hex: "#0071BC")
    }


    var body: some View {
        content
            .background(backgroundColor)
    }

    private var content: some View {

        Group {
            VStack(alignment: .leading) {
                CircleImageView(image: image)
                    .frame(width: title == nil ? size.width : size.width * 0.90,
                           height: title == nil ? size.height : size.height * 0.80)
                    .offset(x: imageOffset.x)

                if let unwrappedTitle = title {
                    TextView(text: unwrappedTitle, fontSize: titleFontSize)
                        .offset(x: titleOffset.x, y: titleOffset.y)
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {

    static var previews: some View {

        Group {
            
            ProfileView(title: nil ,
                        size: CGSize(width: 140, height: 140),
                        titleFontSize: 15,
                        imageOffset: (-50, 0),
                        titleOffset: (-15, 4),
                        image: nil)
                .environment(\.colorScheme, .light)

            ProfileView(title: "Text1",
                        size: CGSize(width: 140, height: 160),
                        titleFontSize: 15,
                        imageOffset: (-50, 0),
                        titleOffset: (-15, 4),
                        image: nil)
                .environment(\.colorScheme, .light)

            ProfileView(title: nil,
                        size: CGSize(width: 140, height: 140),
                        titleFontSize: 15,
                        imageOffset: (-50, 0),
                        titleOffset: (-15, 4),
                        image: nil)
                .environment(\.colorScheme, .dark)

            ProfileView(title: "Text1",
                        size: CGSize(width: 140, height: 140),
                        titleFontSize: 15,
                        imageOffset: (-50, 0),
                        titleOffset: (-15, 4),
                        image: nil)
                .environment(\.colorScheme, .dark)
        }
    }
}


