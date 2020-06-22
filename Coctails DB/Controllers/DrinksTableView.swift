//
//  DrinksTableView.swift
//  Coctails DB
//
//  Created by Oleh Haistruk on 20.06.2020.
//  Copyright © 2020 Oleh Haistruk. All rights reserved.
//

import UIKit

class DrinksTableView: UITableViewController, Storyboarded, FilterViewControllerDelegate {
    
    weak var mainCoordinator: MainCoordinator?
//    let network = Network()
    let networkDataManager = NetworkDataManager()
    
    private var listOfAllCategories: DrinkCategory?
    var categoriesSelectedInFilter: DrinkCategory? {
        willSet(newList) {
            guard let categoriesCount = newList?.categories.count else { return }
            selectedCategoriesNumber = categoriesCount
            categoryCounter = 0
           
        }
    }
    var drinks: DrinksParametersList?
    var drinksAssets: [[DrinksAssests]]?
    ///Contains the number for last loaded category
    var categoryCounter = 0
    ///Number of categories selected in filter
    var selectedCategoriesNumber = 0
    var firstLoad = true
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //set for next viewController
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        let title = UILabel()
        title.textAlignment = .left
        title.font = UIFont(name: "Avenir", size: 26)
        title.text = "Drinks"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: title)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "funnel"), style: .plain, target: self, action: #selector(navigateToFilter))
        self.navigationItem.rightBarButtonItem?.tintColor = .black
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        
        networkDataManager.getInitialData { (assets, categories) in
            if let assets = assets {
                self.drinksAssets = [assets]
                self.listOfAllCategories = categories
                self.categoriesSelectedInFilter = categories
                self.tableView.reloadData()
                self.navigationItem.rightBarButtonItem?.isEnabled = true
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if !firstLoad {
            drinksAssets = []
            tableView.reloadData()
            fetchCategoryAndUpdateTable()
        } else {
            firstLoad = !firstLoad
        }
    }
    
    ///Fetches data for displaying in table, apply and reload table.
    func fetchCategoryAndUpdateTable() {
        
        guard let category = categoriesSelectedInFilter?.categories[categoryCounter].drinkCategory else { return }
        networkDataManager.getCategoryAssets(category: category) { (assets) in
            self.drinksAssets?.append(assets!)
            self.tableView.reloadData()
        }
    }

    @objc func navigateToFilter() {
        mainCoordinator?.displayFilter(allCategories: listOfAllCategories, parrent: self)
        
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
        if indexPath.section == categoryCounter && indexPath.row == (totalRowsNumber - 1) && selectedCategoriesNumber != (categoryCounter + 1) {
            categoryCounter += 1
            fetchCategoryAndUpdateTable()
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let category = drinksAssets?[section].first?.category else { return "" }
        return category
    }
    
}


