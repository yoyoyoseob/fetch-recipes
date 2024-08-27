//
//  RecipesListViewModel.swift
//  fetch-coding-challenge
//
//  Created by Yoseob Lee on 8/26/24.
//

import SwiftUI

extension RecipesListView {
    @MainActor
    final class ViewModel: ObservableObject {
        @Published private(set) var recipes = [Recipe]()

        private let networkService: NetworkService

        init(networkService: NetworkService) {
            self.networkService = networkService
        }

        func loadRecipes() async {
            do {
                let result: RecipesResponse = try await networkService.request(endpoint: RecipeEndpoints.fetchRecipes("dessert"))
                recipes = result.meals.sorted { $0.name < $1.name }
            } catch {
                print("RecipesListView.ViewModel<loadRecipes>: \(error)")
            }
        }
    }
}
