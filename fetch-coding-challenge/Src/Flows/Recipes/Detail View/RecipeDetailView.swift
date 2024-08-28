//
//  RecipeDetailView.swift
//  fetch-coding-challenge
//
//  Created by Yoseob Lee on 8/26/24.
//

import SwiftUI

struct RecipeDetailView: View {

    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            Text(viewModel.name)
            Text(viewModel.instructions)
            ForEach(viewModel.ingredients) { element in
                Text("\(element.ingredient): \(element.measurement)")
            }
        }
        .padding()
        .task {
            await viewModel.loadDetails()
        }
    }
}

#Preview {
    RecipeDetailView(viewModel: .init(id: "", networkService: .init()))
}
