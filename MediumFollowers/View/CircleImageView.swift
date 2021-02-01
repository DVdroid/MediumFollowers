//
//  CircleImageView.swift
//  MediumFollowers
//
//  Created by Vikash Anand on 01/02/21.
//

import SwiftUI

struct CircleImageView: View {

    @Environment(\.colorScheme) var colorScheme
    var imageData: Data?
    var borderColor: Color {
        return colorScheme == .dark ? .yellow : .white
    }

    var body: some View {

        if imageData != nil {
            Image(uiImage: UIImage(data: imageData!)!)
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

struct CircleImageView_Previews: PreviewProvider {
    static var previews: some View {

        Group {
            CircleImageView()
                .frame(width: 200, height: 200)
                .environment(\.colorScheme, .light)

            CircleImageView()
                .frame(width: 200, height: 200)
                .environment(\.colorScheme, .dark)
        }

    }
}
