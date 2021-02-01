//
//  CircleImageView.swift
//  MediumFollowers
//
//  Created by Vikash Anand on 01/02/21.
//

import SwiftUI

struct CircleImageView: View {

    var imageData: Data?
    var body: some View {

        if imageData != nil {
            Image(uiImage: UIImage(data: imageData!)!)
                .resizable()
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 2.0))
                .shadow(radius: 7)
        } else {
            Image("default-profile-icon")
                .resizable()
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 2.0))
                .shadow(radius: 7)
        }

    }
}

struct CircleImageView_Previews: PreviewProvider {
    static var previews: some View {
        CircleImageView()
            .frame(width: 200, height: 200)
    }
}
