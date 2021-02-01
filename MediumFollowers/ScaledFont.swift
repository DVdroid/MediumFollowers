//
//  ScaledFont.swift
//  MediumFollowers
//
//  Created by Vikash Anand on 01/02/21.
//

import UIKit
import SwiftUI

@available(iOS 13, macCatalyst 13, tvOS 13, watchOS 6, *)
struct ScaledFont: ViewModifier {
    @Environment(\.sizeCategory) var sizeCategory
    var name: String?
    var size: CGFloat

    func body(content: Content) -> some View {
       let scaledSize = UIFontMetrics.default.scaledValue(for: size)
        if name != nil {
            return content.font(.custom(name!, size: scaledSize))
        } else {
            return content.font(.system(size: scaledSize, weight: .medium))
        }
    }
}

@available(iOS 13, macCatalyst 13, tvOS 13, watchOS 6, *)
extension View {
    func scaledFont(name: String?, size: CGFloat) -> some View {
        return self.modifier(ScaledFont(name: name, size: size))
    }
}
