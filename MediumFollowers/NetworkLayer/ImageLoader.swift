//
//  ImageLoader.swift
//  MediumFollowers
//
//  Created by Vikash Anand on 07/02/21.
//

import Foundation

import SwiftUI
import Combine
import Foundation

class ImageLoader: ObservableObject {

    @Published var image: UIImage?
    private let url: URL
    private var cancellable: AnyCancellable?

    init(url: URL) {
        self.url = url
    }

    deinit {
        cancel()
    }

    func load() {

        if url.relativePath.contains("www.google.com") {
            return
        }
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.image = $0 }
    }

    func cancel() {
        cancellable?.cancel()
    }
}
