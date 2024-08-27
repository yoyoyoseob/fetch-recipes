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

        var name: String { recipe?.name ?? "<RecipeName>"}
        var instructions: String { recipe?.instructions ?? "<RecipeInstructions>"}
        var ingredients: [(String, String)] { recipe?.measuredIngredients ?? [] }
        @Published private(set) var recipe: RecipeDetails?

        private let id: String
        private let networkService: NetworkService

        init(id: String, networkService: NetworkService) {
            self.id = id
            self.networkService = networkService
        }

        func loadDetails() async {
            do {
                let result: RecipeDetailsResponse = try await networkService.request(endpoint: RecipeEndpoints.recipeDetails(id))
                recipe = result.meals.first
            } catch {
                print("RecipeDetailView.ViewModel<loadDetails>: \(error)")
            }
        }
    }
}
