//
//  RecipeDetailViewModel.swift
//  fetch-coding-challenge
//
//  Created by Yoseob Lee on 8/26/24.
//

import SwiftUI

extension RecipeDetailView {

    @MainActor
    final class ViewModel: ObservableObject {

        @Published private(set) var state: ViewState<RecipeDetailsUI> = .idle
        var title: String { recipe.name }

        private let recipe: Recipe
        private let networkService: NetworkService

        init(recipe: Recipe, networkService: NetworkService) {
            self.recipe = recipe
            self.networkService = networkService
        }

        func loadDetails() async {
            state = .loading

            do {
                let result: RecipeDetailsResponse = try await networkService.request(endpoint: RecipeEndpoints.recipeDetails(recipe.id))

                if let details = result.meals.first {
                    state = .loaded(RecipeDetails.mapToUI(details))
                } else {
                    state = .error(APIError(errorCode: "Error-0", message: "Unable to fetch recipe details"))
                }
            } catch {
                state = .error(error)
            }
        }
    }
}
