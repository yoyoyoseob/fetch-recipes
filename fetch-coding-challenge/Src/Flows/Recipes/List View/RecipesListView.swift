//
//  RecipesListView.swift
//  fetch-coding-challenge
//
//  Created by Yoseob Lee on 8/26/24.
//

import SwiftUI

struct RecipesListView: View {

    @ObservedObject var viewModel: ViewModel

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.recipes) { recipe in
                    NavigationLink {
                        RecipeDetailView(viewModel: .init(id: recipe.id, networkService: .init()))
                    } label: {
                        Text(recipe.name)
                    }
                }
            }
            .navigationTitle("Desserts")
        }.task {
            await viewModel.loadRecipes()
        }
    }
}

#Preview {
    RecipesListView(viewModel: .init(networkService: .init()))
}
