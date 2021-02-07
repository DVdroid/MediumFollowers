//
//  ContentView.swift
//  MediumFollowers
//
//  Created by Vikash Anand on 31/01/21.
//

import SwiftUI

struct ContentView: View {

    @StateObject var viewModel = ViewModel()

    var body: some View {

        GeometryReader { proxy in

            if let unwrappedMediumAccountInfo = viewModel.mediumAccountInfo {
                MediumAccountInfoView_Large(images: nil,
                                            size: CGSize(width: proxy.size.width, height: proxy.size.height),
                                            mediumAccountInfo:unwrappedMediumAccountInfo)
                    .frame(width: proxy.size.width, height: proxy.size.height)
            } else {

                let user = User(id: "",
                                username: MediumAccountInfo.Constant.userName,
                                name: "user name",
                                bio: "qwertyytrewq",
                                imageId: nil,
                                twitterScreenName: nil,
                                mediumMemberAt: nil,
                                socialStats: nil,
                                navItems: nil)

                MediumAccountInfoView_Large(images: nil,
                                            size: CGSize(width: proxy.size.width, height: proxy.size.height),
                                            mediumAccountInfo: MediumAccountInfo(users: [user]))
                    .frame(width: proxy.size.width, height: proxy.size.height)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .environment(\.colorScheme, .light)
            
            ContentView()
                .environment(\.colorScheme, .dark)
        }
    }
}

extension ContentView {

    class ViewModel: ObservableObject {
        @Published var mediumAccountInfo: MediumAccountInfo?
        @Published var imageData: Data?

        init(){
            getMediumAccountInfo()
        }

        // Use your "Medium" account user name
        private func getMediumAccountInfo() {
            MediumDataFetcher.getMediumAccountInfo(for: "@\(MediumAccountInfo.Constant.userName)") { [weak self] (mediumAccountInfo, error) in
                guard let self = self, error == nil else { return }
                self.mediumAccountInfo = mediumAccountInfo
            }
        }
    }
}
