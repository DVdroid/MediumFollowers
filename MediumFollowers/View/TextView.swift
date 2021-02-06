//
//  TextView.swift
//  MediumFollowers
//
//  Created by Vikash Anand on 06/02/21.
//

import SwiftUI

struct TextView: View, Identifiable {

    let id = UUID()
    @Environment(\.colorScheme) var colorScheme

    let text: String
    let fontSize: CGFloat

    var textColor: Color {
        colorScheme == .dark ? .yellow : .white
    }

    var body: some View {
        Text(text)
            .scaledFont(name: nil, size: fontSize)
            .foregroundColor(textColor)
            .multilineTextAlignment(.center)
            .lineLimit(1)
    }
}

struct TextView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TextView(text: "Text", fontSize: 20)
                .background(Color(hex: "#0071BC"))
                .environment(\.colorScheme, .light)
            
            TextView(text: "Text", fontSize: 45)
                .background(Color(hex: "#3F2B1D"))
                .environment(\.colorScheme, .dark)
        }
    }
}
