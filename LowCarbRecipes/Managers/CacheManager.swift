//
//  CacheManager.swift
//  LowCarbRecipes
//
//  Created by Sana Siddiqui on 3/28/24.
//

import UIKit

final class CacheManager {
    public static let shared = CacheManager()
    let cacheKey = "cache"
    var imageCache: [String : UIImage] = [:]
    
    private init() {}
    
    func saveRecipes(_ recipes: [Recipe]) {
        do {
            let data = try JSONEncoder().encode(recipes)
            UserDefaults.standard.set(data, forKey: cacheKey)
        } catch {
            print(error)
        }
    }
    
    
    func retrieveRecipes() -> [Recipe]? {
        guard let data = UserDefaults.standard.data(forKey: cacheKey) else { return nil }
        
        do {
            let recipes = try JSONDecoder().decode([Recipe].self, from: data)
            return recipes
        } catch {
            print("error loading recipes")
            return nil
        }
    }
    
    func saveImage(_ image: UIImage, forURL url: URL) {
        imageCache[url.absoluteString] = image
       }

       func retrieveImage(forURL url: URL) -> UIImage? {
           return imageCache[url.absoluteString]
       }
}
