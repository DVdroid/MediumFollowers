//
//  MultilineTextView.swift
//  MediumFollowers
//
//  Created by Vikash Anand on 06/02/21.
//

import SwiftUI

struct MultilineTextView: View {

    @Environment(\.colorScheme) var colorScheme
    var textViews: [TextView]
    var alignment: HorizontalAlignment
    let size: CGSize

    var textColor: Color {
        return colorScheme == .dark ? .yellow : .white
    }

    var body: some View {
        VStack(alignment: alignment) {
            ForEach(textViews, id: \.id) {
                $0
            }
        }
        .frame(width: size.width, height: size.height)
        .padding()
    }
}

struct MultilineTextView_Previews: PreviewProvider {
    static var previews: some View {

        Group {
            MultilineTextView(textViews: [TextView(text: "Text1", fontSize: 15),
                                          TextView(text: "Text2", fontSize: 45)],
                              alignment: .leading,
                              size: CGSize(width: 200, height: 200))

                .background(Color(hex: "#0071BC"))
                .environment(\.colorScheme, .light)

            MultilineTextView(textViews: [TextView(text: "Text1", fontSize: 15),
                                          TextView(text: "Text2", fontSize: 45)],
                              alignment: .leading,
                              size: CGSize(width: 200, height: 200))
                .background(Color(hex: "#3F2B1D"))
                .environment(\.colorScheme, .dark)
        }
    }
}
