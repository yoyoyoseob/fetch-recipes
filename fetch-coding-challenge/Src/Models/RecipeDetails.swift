//
//  RecipeDetails.swift
//  fetch-coding-challenge
//
//  Created by Yoseob Lee on 8/26/24.
//

struct RecipeDetails: Codable {
    let id: String
    let name: String
    let cuisine: String
    let instructions: String
    let thumbnailURLString: String
    let videoURLString: String
    let source: String

    /*
     Need to extract and combine ingredients with measurements:

     Ingredients come back in the form of:
        "strIngredient1": <String>,
        "strIngredient2": <String>

     Measurements come back in the form of:
        "strMeasure1": <String>,
        "strMeasure2": <String>

     Documentation isn't exactly clear but the assumption is that they will match 1:1 (up to 20 ingredients)

     Approach 1 (extract into two arrays and zip them)
     Approach 2 (extract into a dictionary and remove null/empty values)
     Approach 3 (20 separate properties)

     1 + 2 will require custom decoding
     3 does not scale well
     */
}
