//
//  DrinkCategory.swift
//  🍹 Database
//
//  Created by Oleh Haistruk on 20.06.2020.
//  Copyright © 2020 Oleh Haistruk. All rights reserved.
//

struct DrinkCategory: Decodable {
    let categories: [CategoryName]
    
    enum CodingKeys: String, CodingKey {
        case categories = "drinks"
    }
}

struct CategoryName: Decodable {
    let drinkCategory: String
    
    enum CodingKeys: String, CodingKey {
        case drinkCategory = "strCategory"
    }
}
