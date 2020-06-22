//
//  DrinkDetails.swift
//  🍹 Database
//
//  Created by Oleh Haistruk on 20.06.2020.
//  Copyright © 2020 Oleh Haistruk. All rights reserved.
//


struct DrinksParametersList: Decodable {
    let drinks: [DrinkParameters]
}

struct DrinkParameters: Decodable {
    let drinkName: String
    let imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case drinkName = "strDrink"
        case imageURL = "strDrinkThumb"
    }
}
