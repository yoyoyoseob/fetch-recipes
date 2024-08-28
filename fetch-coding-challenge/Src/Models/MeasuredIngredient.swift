//
//  MeasuredIngredient.swift
//  fetch-coding-challenge
//
//  Created by Yoseob Lee on 8/27/24.
//

import Foundation

struct MeasuredIngredient: Identifiable {
    let id = UUID()
    let ingredient: String
    let measurement: String
}
