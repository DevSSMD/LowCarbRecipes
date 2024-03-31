//
//  LCError.swift
//  LowCarbRecipes
//
//  Created by Sana Siddiqui on 3/25/24.
//

import Foundation

enum LCError: String, Error {
    case invalidURL = "Wrong URL."
    case unableToComplete = "Unable to complete ypur request. Please check your internet connection"
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
    case unableToFavorite = "Error retrieving favorites."
    case alreadyInFavorites = "Already in favorites!"
}
