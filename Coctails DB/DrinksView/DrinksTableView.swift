//
//  DrinksTableView.swift
//  Coctails DB
//
//  Created by Oleh Haistruk on 20.06.2020.
//  Copyright © 2020 Oleh Haistruk. All rights reserved.
//

import UIKit

class DrinksTableView: UITableViewController, Storyboarded {
    
    weak var mainCoordinator: MainCoordinator?
    let network = Network()
    let networkDataManager = NetworkDataManager()
    
    private var listOfAllCategories: DrinkCategory?
    var categoriesSelectedInFilter: DrinkCategory?
    var drinks: DrinksParametersList?
    var drinksAssets: [[DrinksAssests]]?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let title = UILabel()
        title.textAlignment = .left
        title.font = UIFont(name: "Avenir", size: 26)
        title.text = "Drinks"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: title)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "funnel"), style: .plain, target: self, action: #selector(navigateToFilter))
        self.navigationItem.rightBarButtonItem?.tintColor = .black
        
        networkDataManager.getInitialData { (assets, categories) in
            if let assets = assets {
                self.drinksAssets = [assets]
                self.listOfAllCategories = categories
                self.categoriesSelectedInFilter = categories
                self.tableView.reloadData()
                debugPrint(self.drinksAssets)
            }
        }
    }

    @objc func navigateToFilter() {
        mainCoordinator?.displayFilter(allCategories: listOfAllCategories)
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let sections = drinksAssets?.count else { return 1 }
        return  sections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let rows = drinksAssets?[section].count else { return 1 }
        return rows
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "drinkCell", for: indexPath) as! DrinksTableViewCell
        
        guard let drinksAssets = drinksAssets?[indexPath.section] else {
            return cell
        }
        let assets = drinksAssets[indexPath.row]
        cell.drinkName.text = assets.name
        cell.drinkImage.image = assets.image
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let totalRowsNumber = drinksAssets?[indexPath.section].count  else { return }
        if indexPath.row == (totalRowsNumber - 1) {
            debugPrint(indexPath)
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let category = drinksAssets?[section].first?.category else { return "" }
        return category
    }
    
}


