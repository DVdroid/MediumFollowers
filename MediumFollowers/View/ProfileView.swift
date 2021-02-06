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

    var url: URL?
    @StateObject private var loader: ImageLoader
    @Environment(\.colorScheme) var colorScheme

    var textColor: Color {
        return colorScheme == .dark ? .yellow : .white
    }

    var backgroundColor: Color {
        return colorScheme == .dark ? Color(hex: "#3F2B1D") : Color(hex: "#0071BC")
    }

    var image: UIImage? {
        if url == nil {
            return UIImage(named: "default-profile-icon")
        }

        if let unwrappedUrl = url, unwrappedUrl.relativePath.contains("www.google.com") {
            return UIImage(named: "default-profile-icon")
        }

        do {
            return UIImage(data: try Data(contentsOf: url!))
        } catch {}
        return UIImage(named: "default-profile-icon")
    }

    init(url: URL?,
         title: String?,
         size: CGSize,
         titleFontSize: CGFloat,
         imageOffset: (CGFloat, CGFloat),
         titleOffset: (CGFloat, CGFloat)) {

        if let unwrappedUrl = url {
            _loader = StateObject(wrappedValue: ImageLoader(url: unwrappedUrl))
        } else {
            _loader = StateObject(wrappedValue: ImageLoader(url: URL(string: "https://www.google.com")!))
        }

        self.title = title
        self.size = size
        self.titleFontSize = titleFontSize
        self.imageOffset = imageOffset
        self.titleOffset = titleOffset
    }

    var body: some View {
        content
            .background(backgroundColor)
            .onAppear(perform: loader.load)
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

    static let defaultImageUrl = "https://www.google.com"
    static var previews: some View {

        Group {
            
            ProfileView(url: URL(string: defaultImageUrl)!,
                        title: nil ,
                        size: CGSize(width: 140, height: 140),
                        titleFontSize: 15,
                        imageOffset: (-50, 0),
                        titleOffset: (-15, 4))
                .environment(\.colorScheme, .light)

            ProfileView(url: URL(string: defaultImageUrl)!,
                        title: "Text1",
                        size: CGSize(width: 140, height: 160),
                        titleFontSize: 15,
                        imageOffset: (-50, 0),
                        titleOffset: (-15, 4))
                .environment(\.colorScheme, .light)

            ProfileView(url: URL(string: defaultImageUrl)!,
                        title: nil,
                        size: CGSize(width: 140, height: 140),
                        titleFontSize: 15,
                        imageOffset: (-50, 0),
                        titleOffset: (-15, 4))
                .environment(\.colorScheme, .dark)

            ProfileView(url: URL(string: defaultImageUrl)!,
                        title: "Text1",
                        size: CGSize(width: 140, height: 140),
                        titleFontSize: 15,
                        imageOffset: (-50, 0),
                        titleOffset: (-15, 4))
                .environment(\.colorScheme, .dark)
        }
    }
}


class ImageDownloader: ObservableObject {

    let imageUrlAsString: String
    @Published var imageData: Data?

    init(with imageUrl: String) {
        self.imageUrlAsString = imageUrl
        fetchImage(at: imageUrlAsString)
    }

    private func fetchImage(at urlAsString: String) {
        guard !urlAsString.isEmpty else { return }
        let imageUrl = URL(string: urlAsString)!
        URLSession.shared.dataTask(with: imageUrl, completionHandler: { [weak self] data, response, error in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.imageData = data
            }
        }).resume()
    }
}

