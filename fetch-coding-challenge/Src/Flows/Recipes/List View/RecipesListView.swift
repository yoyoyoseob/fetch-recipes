//
//  RecipesListView.swift
//  fetch-coding-challenge
//
//  Created by Yoseob Lee on 8/26/24.
//

import SwiftUI

struct RecipesListView: View {

    @EnvironmentObject var networkService: NetworkService
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.recipes) { recipe in
                    NavigationLink {
                        RecipeDetailView(viewModel: .init(recipe: recipe, networkService: networkService))
                    } label: {
                        LazyVStack(alignment: .leading) {
                            HStack {
                                AsyncImage(url: recipe.thumbnailPreviewURL) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height: 44)
                                } placeholder: {
                                    ProgressView()
                                }
                                Text(recipe.name)
                            }
                        }
                    }
                    .listRowInsets(.init(top: 0,
                                         leading: 0,
                                         bottom: 0,
                                         trailing: 16))
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
        .environmentObject(NetworkService())
}
