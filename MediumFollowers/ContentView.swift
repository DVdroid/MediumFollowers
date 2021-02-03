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

        GeometryReader { geometry in

            VStack {
                let accountHolder: AccountHolder = viewModel.accountHolder ?? AccountHolder(firstName: "First", lastName: "last")
                let followers: Followers = viewModel.followers ?? Followers(count: 0)

                MediumAccountInfoView(accountHolder: accountHolder,
                                      followers: followers,
                                      imageData: viewModel.imageData)
            }
            .padding()
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
        @Published var accountHolder: AccountHolder?
        @Published var followers: Followers?
        @Published var imageData: Data?

        init(){
            getMediumAccountProfilePicture()
            getMediumAccountInfo()
        }

        // Use your "Medium" account user name
        private func getMediumAccountInfo() {
            MediumDataFetcher.getMediumAccountInfo(for: "") { [weak self] (accountHolder, followers, error) in
                guard let self = self, error == nil else { return }
                self.accountHolder = accountHolder
                self.followers = followers
            }
        }

        // Use your "Medium" account user name
        private func getMediumAccountProfilePicture() {
            MediumDataFetcher.getMediumAccountHolderIcon(for: "") { [weak self] (imageData, response, error)  in
                guard let self = self, error == nil else { return }

                DispatchQueue.main.async {
                    self.imageData = imageData
                }
            }
        }
    }
}
