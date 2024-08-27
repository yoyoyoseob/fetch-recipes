//
//  RecipeEndpoints.swift
//  fetch-coding-challenge
//
//  Created by Yoseob Lee on 8/26/24.
//

import Foundation

enum RecipeEndpoints: EndpointProviding {
    case fetchRecipes(String)
    case recipeDetails(String)
}

extension RecipeEndpoints {
    var baseURL: String { "themealdb.com" }

    var path: String {
        switch self {
        case .fetchRecipes: "/api/json/v1/1/filter.php"
        case .recipeDetails: "/api/json/v1/1/lookup.php"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .fetchRecipes, .recipeDetails: .get
        }
    }

    var queryItems: [URLQueryItem]? {
        switch self {
        case .fetchRecipes(let type):
            [URLQueryItem(name: "c", value: type.capitalized)]
        case .recipeDetails(let id):
            [URLQueryItem(name: "i", value: id)]
        }
    }

    var body: [String : Any]? { nil }
}
