//
//  ImageDownloader.swift
//  MediumFollowers
//
//  Created by Vikash Anand on 07/02/21.
//

import Foundation

final class ImageDownloader {

    let imageId: String
    let imageUrlAsString: String

    init(with imageId: String, imageUrl url: String) {
        self.imageId = imageId
        self.imageUrlAsString = url
    }

    func fetch(image atUrlAsString: String,
               with completion: @escaping(Data?, URLResponse?, Error?) -> Void) {

        guard let unwrappedURL = URL(string: atUrlAsString) else {
            completion(nil, nil, nil)
            return
        }
        URLSession.shared.dataTask(with: unwrappedURL, completionHandler: completion).resume()
    }
}
