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
    private(set) var isLoading = false
    private let url: URL?
    private var cancellable: AnyCancellable?

    private static let imageProcessingQueue = DispatchQueue(label: "image-processing")

    init(url: URL?) {
        self.url = url
    }

    deinit {
        cancel()
    }

    func load() {

        guard let unwrappedUrl = self.url else {
            return
        }

        cancellable = URLSession.shared.dataTaskPublisher(for: unwrappedUrl)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .handleEvents(receiveSubscription: { [weak self] _ in self?.onStart() },
                          receiveCompletion: { [weak self] _ in self?.onFinish(isCancelled: false) },
                          receiveCancel: { [weak self] in self?.onFinish(isCancelled: true) })
            .subscribe(on: Self.imageProcessingQueue)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (status) in
                switch status {
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    break
                }
            })
            { [weak self] in self?.process(image: $0) }
    }

    func cancel() {
        print("cancel")
        cancellable?.cancel()
    }

    private func onStart() {
        print("onStart")
        isLoading = true
    }

    private func process(image: UIImage?) {
        print(image ?? "")
        self.image = image
    }

    private func onFinish(isCancelled: Bool) {
        print("onFinish with isCancelled: \(isCancelled)")
        isLoading = false
    }

    
}
