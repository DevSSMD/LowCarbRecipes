//
//  NetworkManager.swift
//  LowCarbRecipes
//
//  Created by Sana Siddiqui on 3/25/24.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    private let apiKey = "e0109196c4msh8d97e2b9e32e168p1398e8jsn4d464ec7bf55"
    private let baseURL = "https://low-carb-recipes.p.rapidapi.com/search?rapidapi-key="

    public func getRecipes(completed: @escaping (Result<[Recipe], LCError>) -> Void) {
        let endpoint = "\(baseURL)\(apiKey)&name=cake&limit=20"
        
        guard let url = URL(string: endpoint ) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let recipes = try decoder.decode([Recipe].self, from: data)
//                print(recipes)
                completed(.success(recipes))
            }
            catch {
                print(error)
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    
    
    public func downloadImage(from url: URL?, completed: @escaping (UIImage?) -> Void) {
    
        guard let url = url else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let _ = self,
                error == nil,
                let response = response as? HTTPURLResponse, response.statusCode == 200,
                let data = data,
                let image = UIImage(data: data)  else {
                completed(nil)
                return
            }
            completed(image)
        }
        task.resume()
    }
}
