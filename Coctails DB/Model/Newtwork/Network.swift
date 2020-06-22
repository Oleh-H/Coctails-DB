//
//  Network.swift
//  Coctails DB
//
//  Created by Oleh Haistruk on 20.06.2020.
//  Copyright © 2020 Oleh Haistruk. All rights reserved.
//

import Alamofire

class Network {
    
    func getDrinkCategories(completion: @escaping (Result<DrinkCategory, Error>) -> Void) {
        AF.request(Constants.drinkCategoriesURL)
            .validate()
            .responseDecodable(of: DrinkCategory.self) { (responce) in
                if let categories = responce.value {
                    completion(.success(categories))
                } else if let error = responce.error {
                    completion(.failure(error))
                }
        }
    }
    
    func getDrincsOf(category: String, completion: @escaping (Result<DrinksParametersList, Error>) -> Void) {
        let parameters: [String: String] = ["c": category]
        AF.request(Constants.drinksBaseURL, parameters: parameters)
            .validate()
            .responseDecodable(of: DrinksParametersList.self) { (responce) in
                if let drinks = responce.value {
                    completion(.success(drinks))
                } else if let error = responce.error {
                    completion(.failure(error))
                }
        }
    }
    
    
    func getDrinksAssets(drinksList: DrinksParametersList, category: String, completion: @escaping ([DrinksAssests]) -> Void) {
        
        var items: [DrinksAssests] = []
        let fetchGroup = DispatchGroup()
        
        drinksList.drinks.forEach { (parameters) in
            
            fetchGroup.enter()
            
            let url = parameters.imageURL
            let name = parameters.drinkName
            AF.request(url).validate().responseData { (data) in
                if let data = data.value, let image = UIImage(data: data) {
                    let drink = DrinksAssests(name: name, image: image, category: category)
                    items.append(drink)
                }
                fetchGroup.leave()
            }
        }
        fetchGroup.notify(queue: .main) {
            completion(items)
        }
    }
}
