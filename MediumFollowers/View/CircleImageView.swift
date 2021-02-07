//
//  CircleImageView.swift
//  MediumFollowers
//
//  Created by Vikash Anand on 01/02/21.
//

import SwiftUI

struct CircleImageView: View {

    let image: UIImage?
    @Environment(\.colorScheme) var colorScheme

    var borderColor: Color {
        return colorScheme == .dark ? .yellow : .white
    }

    var body: some View {
        content
    }

    private var content: some View {
        VStack {
            if let unwrappedImage = image {
                Image(uiImage: unwrappedImage)
                    .resizable()
                    .clipShape(Circle())
                    .overlay(Circle().stroke(borderColor, lineWidth: 2.0))
                    .shadow(radius: 7)

            } else {
                Image("default-profile-icon")
                    .resizable()
                    .clipShape(Circle())
                    .overlay(Circle().stroke(borderColor, lineWidth: 2.0))
                    .shadow(radius: 7)
            }
        }
    }
}

struct CircleImageView_Previews: PreviewProvider {
    static var previews: some View {

        Group {

            CircleImageView(image: nil)
                .frame(width: 200, height: 200)
                .background(Color(hex: "#0071BC"))
                .environment(\.colorScheme, .light)

            CircleImageView(image: nil)
                .frame(width: 200, height: 200)
                .background(Color(hex: "#3F2B1D"))
                .environment(\.colorScheme, .dark)

        }
    }
}
