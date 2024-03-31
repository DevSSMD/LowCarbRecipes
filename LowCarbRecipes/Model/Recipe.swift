//
//  Recipe.swift
//  LowCarbRecipes
//
//  Created by Sana Siddiqui on 3/25/24.
//

import UIKit

struct Recipe: Codable {
    let name: String
    let description: String
    let prepareTime: Int
    let cookTime: Int
    let ingredients: [Ingredients]
    let steps: [String]
    let servings: Int
    let image: URL
}

struct Ingredients: Codable {
    let name: String
    let servingSize: ServingSize
}

struct ServingSize: Codable {
    let desc: String? 
}
