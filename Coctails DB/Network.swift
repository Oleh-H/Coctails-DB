//
//  Network.swift
//  Coctails DB
//
//  Created by Oleh Haistruk on 20.06.2020.
//  Copyright © 2020 Oleh Haistruk. All rights reserved.
//

import Alamofire

class Network {
    func getDrinkCategories() /*-> Result<DrinkCategory, Error>*/ {
        AF.request(Constants.drinkCategoriesURL)
            .validate()
            .responseDecodable(of: DrinkCategory.self) { (responce) in
            guard let drinks = responce.value else { return }
            debugPrint(drinks.categories[0].strCategory)
        }
    }
    
    func getDrincsOf(category: String) /*->  */{
        let parameters: [String: String] = ["c": category]
        AF.request(Constants.drinksBaseURL, parameters: parameters).validate().responseDecodable(of: DrinkDetails.self) { (responce) in
            debugPrint(responce)
        }
    }
}
