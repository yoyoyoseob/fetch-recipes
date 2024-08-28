//
//  Recipe.swift
//  fetch-coding-challenge
//
//  Created by Yoseob Lee on 8/26/24.
//

import Foundation

struct RecipesResponse: Decodable {
    let meals: [Recipe]
}

struct Recipe: Decodable, Identifiable {
    let id: String
    let name: String
    let thumbnailURLString: String

    private enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case thumbnailURLString = "strMealThumb"
    }
}

extension Recipe {
    var thumbnailPreviewURL: URL? {
        let previewStr = thumbnailURLString + "/preview"
        return URL(string: previewStr)
    }
}
