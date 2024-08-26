//
//  ContentView.swift
//  fetch-coding-challenge
//
//  Created by Yoseob Lee on 8/26/24.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        NavigationStack {
            Text("Hello World!")
        }.task {
            do {
                let service = NetworkService()
                // Test Case: 52970 (Tunisian Orange Cake)
                let detail: RecipeDetails = try await service.request(endpoint: RecipeEndpoints.recipeDetails("52970"))
                print(detail)
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    ContentView()
}
