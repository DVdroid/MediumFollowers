//
//  FollowersCountView.swift
//  MediumFollowers
//
//  Created by Vikash Anand on 01/02/21.
//

import SwiftUI

struct CounterView: View {

    let count: String
    let countType: String
    let size: CGSize
    @Environment(\.colorScheme) var colorScheme

    var textColor: Color {
        colorScheme == .dark ? .yellow : .white
    }

    var body: some View {
        VStack {
            MultilineTextView(textViews: [TextView(text: count, fontSize: size.width * 0.5),
                                          TextView(text: countType, fontSize:  size.width * 0.1)],
                              alignment: .center,
                              size: size)
        }
    }
}

struct FollowersCountView_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            CounterView(count: "0",
                        countType: "Followers",
                        size: CGSize(width: 200, height: 200))
                .background(Color(hex: "#0071BC"))
                .environment(\.colorScheme, .light)
            
            CounterView(count: "0",
                        countType: "Following",
                        size: CGSize(width: 200, height: 200))
                .background(Color(hex: "#3F2B1D"))
                .environment(\.colorScheme, .dark)
        }
    }
}
