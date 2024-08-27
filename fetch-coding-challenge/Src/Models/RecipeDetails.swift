//
//  RecipeDetails.swift
//  fetch-coding-challenge
//
//  Created by Yoseob Lee on 8/26/24.
//

struct RecipeDetailsResponse: Decodable {
    var meals: [RecipeDetails]
}

struct RecipeDetails: Decodable {
    let id: String
    let name: String
    let cuisine: String
    let instructions: String
    let thumbnailURLString: String
    let videoURLString: String
    let source: String
    let ingredients: [String]
    let measurements: [String]

    var measuredIngredients: [(String, String)] {
        Array(zip(ingredients, measurements))
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
        case cuisine = "strArea"
        case instructions = "strInstructions"
        case thumbnailURLString = "strMealThumb"
        case videoURLString = "strYoutube"
        case source = "strSource"
        case ingredient = "strIngredient"
        case measurement = "strMeasure"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
        var idValue = ""
        var nameValue = ""
        var cuisineValue = ""
        var instructionsValue = ""
        var thumbnailValue = ""
        var videoURLValue = ""
        var sourceValue = ""

        // Cannot set directly as there are no guarantees that keys are unique
        for key in container.allKeys {
            switch key.stringValue {
            case CodingKeys.id.rawValue:
                idValue = try container.decode(String.self, forKey: .init(stringValue: key.stringValue)!)
            case CodingKeys.name.rawValue:
                nameValue = try container.decode(String.self, forKey: .init(stringValue: key.stringValue)!)
            case CodingKeys.cuisine.rawValue:
                cuisineValue = try container.decode(String.self, forKey: .init(stringValue: key.stringValue)!)
            case CodingKeys.instructions.rawValue:
                instructionsValue = try container.decode(String.self, forKey: .init(stringValue: key.stringValue)!)
            case CodingKeys.thumbnailURLString.rawValue:
                thumbnailValue = try container.decode(String.self, forKey: .init(stringValue: key.stringValue)!)
            case CodingKeys.videoURLString.rawValue:
                videoURLValue = try container.decode(String.self, forKey: .init(stringValue: key.stringValue)!)
            case CodingKeys.source.rawValue:
                sourceValue = try container.decode(String.self, forKey: .init(stringValue: key.stringValue)!)
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
        cuisine = cuisineValue
        instructions = instructionsValue
        thumbnailURLString = thumbnailValue
        videoURLString = videoURLValue
        source = sourceValue
        ingredients = ingredientsValue.filter { !$0.isEmpty }
        measurements = measurementsValue.filter { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
    }
}
