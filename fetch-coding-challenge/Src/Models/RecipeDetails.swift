//
//  RecipeDetails.swift
//  fetch-coding-challenge
//
//  Created by Yoseob Lee on 8/26/24.
//

import Foundation

struct RecipeDetailsResponse: Decodable {
    var meals: [RecipeDetails]
}

struct RecipeDetails: Decodable {
    let id: String
    let name: String
    let instructions: String
    let thumbnailURL: URL?
    let videoURL: URL?
    let ingredients: [String]
    let measurements: [String]

    var measuredIngredients: [MeasuredIngredient] {
        Array(zip(ingredients, measurements))
            .map { MeasuredIngredient(ingredient: $0.0, measurement: $0.1) }
    }
}

extension RecipeDetails {

    private struct DynamicCodingKeys: CodingKey {
        var stringValue: String
        var intValue: Int?

        init?(stringValue: String) {
            self.stringValue = stringValue
        }

        init?(intValue: Int) {
            return nil
        }
    }

    private enum CodingKeys: String {
        case id = "idMeal"
        case name = "strMeal"
        case instructions = "strInstructions"
        case thumbnailURL = "strMealThumb"
        case videoURL = "strYoutube"
        case ingredient = "strIngredient"
        case measurement = "strMeasure"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
        var idValue = ""
        var nameValue = ""
        var instructionsValue = ""
        var thumbnailValue: URL?
        var videoValue: URL?

        // Cannot set directly as there are no guarantees that keys are unique
        for key in container.allKeys {
            switch key.stringValue {
            case CodingKeys.id.rawValue:
                idValue = try container.decode(String.self, forKey: .init(stringValue: key.stringValue)!)
            case CodingKeys.name.rawValue:
                nameValue = try container.decode(String.self, forKey: .init(stringValue: key.stringValue)!)
            case CodingKeys.instructions.rawValue:
                instructionsValue = try container.decode(String.self, forKey: .init(stringValue: key.stringValue)!)
            case CodingKeys.thumbnailURL.rawValue:
                thumbnailValue = try container.decode(URL.self, forKey: .init(stringValue: key.stringValue)!)
            case CodingKeys.videoURL.rawValue:
                videoValue = try container.decode(URL.self, forKey: .init(stringValue: key.stringValue)!)
            default: break
            }
        }

        // Instead of hardcoding 40+ properties, iterate over the expected number of supported ingredients/measurements
        var ingredientsValue = [String]()
        var measurementsValue = [String]()
        for i in 1...20 {
            ingredientsValue.append(try container.decode(String.self, forKey: .init(stringValue: "\(CodingKeys.ingredient.rawValue)\(i)")!))
            measurementsValue.append(try container.decode(String.self, forKey: .init(stringValue: "\(CodingKeys.measurement.rawValue)\(i)")!))
        }

        id = idValue
        name = nameValue
        instructions = instructionsValue
        thumbnailURL = thumbnailValue
        videoURL = videoValue
        ingredients = ingredientsValue.filter { !$0.isEmpty }
        measurements = measurementsValue.filter { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
    }
}
