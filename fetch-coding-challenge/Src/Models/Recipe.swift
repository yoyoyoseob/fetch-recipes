//
//  Recipe.swift
//  fetch-coding-challenge
//
//  Created by Yoseob Lee on 8/26/24.
//

struct Recipes: Codable {
    let meals: [Recipe]
}

struct Recipe: Codable, Identifiable {
    let id: String
    let name: String
    let thumbnailURLString: String

    private enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case thumbnailURLString = "strMealThumb"
    }
}
