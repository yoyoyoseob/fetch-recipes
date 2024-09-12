//
//  RecipeDetailsUI.swift
//  fetch-coding-challenge
//
//  Created by Yoseob Lee on 9/12/24.
//

import Foundation

struct RecipeDetailsUI {
    let instructions: [String]
    let ingredients: [MeasuredIngredient]
    let imageURL: URL?
    let videoURL: URL?
}

extension RecipeDetails {
    static func mapToUI(_ details: RecipeDetails) -> RecipeDetailsUI {
        return .init(instructions: details.instructions
            .split(whereSeparator: \.isNewline)
            .map { String($0) },
                     ingredients: details.measuredIngredients,
                     imageURL: details.thumbnailURL,
                     videoURL: details.videoURL)
    }
}
