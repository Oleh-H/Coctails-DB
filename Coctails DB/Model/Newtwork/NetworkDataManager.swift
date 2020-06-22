//
//  NetworkDataManager.swift
//  Coctails DB
//
//  Created by Oleh Haistruk on 21.06.2020.
//  Copyright © 2020 Oleh Haistruk. All rights reserved.
//
import UIKit

class NetworkDataManager {
    
    let network = Network()
    typealias InitialReturnType = ([DrinksAssests]?, DrinkCategory?) -> Void
    
    
    func getInitialData(completion: @escaping InitialReturnType) {
        var listOfAllCategories: DrinkCategory?
        
        let queue = OperationQueue()
        
        let categoriesOpreation = BlockOperation {
            let dispatchGroup = DispatchGroup()
            dispatchGroup.enter()
            
            self.network.getDrinkCategories { (result) in
                switch result {
                case .success(let drinkCategories):
                    listOfAllCategories = drinkCategories
                    dispatchGroup.leave()
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                }
            }
            dispatchGroup.wait()
        }
        
        let getAssetsOperation  = BlockOperation {
            let dispatchGroup = DispatchGroup()
            dispatchGroup.enter()
            self.getCategoryAssets(category: (listOfAllCategories?.categories.first?.drinkCategory)!) { (assets) in
                completion(assets, listOfAllCategories)
                dispatchGroup.leave()
                }
        }
        
        queue.addOperation(categoriesOpreation)
        getAssetsOperation.addDependency(categoriesOpreation)
        queue.addOperation(getAssetsOperation)

    }
    
    
    func getCategoryAssets(category: String, completion: @escaping ([DrinksAssests]?) -> Void) {
        var drinks: DrinksParametersList?
        let queue = OperationQueue()
        
        let drinksOperation = BlockOperation {
            let dispatchGroup = DispatchGroup()
            dispatchGroup.enter()
            
            self.network.getDrincsOf(category: category) { (result) in
                switch result {
                case .success(let drinksData):
                    drinks = drinksData
                    dispatchGroup.leave()
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                }
            }
            dispatchGroup.wait()
        }
        
        let drinksAssetsOperation = BlockOperation {
            let dispatchGroup = DispatchGroup()
            dispatchGroup.enter()
            
            guard let drinksList = drinks else { return }
            self.network.getDrinksAssets(drinksList: drinksList, category: category) { (assets) in
                completion(assets)
                dispatchGroup.leave()
            }
            dispatchGroup.wait()
            
        }
        
        queue.addOperation(drinksOperation)
        drinksAssetsOperation.addDependency(drinksOperation)
        queue.addOperation(drinksAssetsOperation)
    }
}
