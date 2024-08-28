//
//  fetch_coding_challengeApp.swift
//  fetch-coding-challenge
//
//  Created by Yoseob Lee on 8/26/24.
//

import SwiftUI

@main
struct fetch_coding_challengeApp: App {

    let networkService = NetworkService()

    var body: some Scene {
        WindowGroup {
            RecipesListView(viewModel: .init(networkService: networkService))
                .environmentObject(networkService)
        }
    }
}
