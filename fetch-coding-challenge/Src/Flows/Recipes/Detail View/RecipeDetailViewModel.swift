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

        @Published private(set) var recipeDetails: RecipeDetails?

        var name: String { recipe.name }
        var instructions: [String] {
            guard let details = recipeDetails else { return ["<RecipeInstructions>"] }
            return details.instructions.split(whereSeparator: \.isNewline).map { String($0) }
        }
        var ingredients: [MeasuredIngredient] { recipeDetails?.measuredIngredients ?? [] }
        var imageURL: URL? { URL(string: recipe.thumbnailURLString) }
        var videoURL: URL? { recipeDetails?.videoURL }

        private let recipe: Recipe
        private let networkService: NetworkService

        init(recipe: Recipe, networkService: NetworkService) {
            self.recipe = recipe
            self.networkService = networkService
        }

        func loadDetails() async {
            do {
                let result: RecipeDetailsResponse = try await networkService.request(endpoint: RecipeEndpoints.recipeDetails(recipe.id))
                recipeDetails = result.meals.first
            } catch {
                print("RecipeDetailView.ViewModel<loadDetails>: \(error)")
            }
        }
    }
}
