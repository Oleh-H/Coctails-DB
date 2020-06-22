//
//  ViewController.swift
//  Coctails DB
//
//  Created by Oleh Haistruk on 20.06.2020.
//  Copyright © 2020 Oleh Haistruk. All rights reserved.
//

import UIKit

protocol FilterViewControllerDelegate: class {
    var categoriesSelectedInFilter: DrinkCategory? { get set }
}

class FilterViewController: UIViewController, Storyboarded {
    weak var mainCoordinator: MainCoordinator?
    weak var delegate: FilterViewControllerDelegate?
    
    var allCategories: DrinkCategory?
    ///Contains array of bull that means category selected or not.
    var ticks = [Bool]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let backImage = UIImage(systemName: "arrow.left")
        self.navigationController?.navigationBar.backIndicatorImage = backImage
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        let title = UILabel()
        title.textAlignment = .left
        title.font = UIFont(name: "Avenir", size: 26)
        title.text = "Drinks"
        self.navigationItem.titleView = title
        
        putTicks()
    }
    
    func putTicks() {
        guard let categories = allCategories?.categories else { return }
        categories.forEach { (_) in
            ticks.append(true)
        }
    }

    @IBAction func applyButton(_ sender: Any) {
        guard let categories = allCategories?.categories else { return }
        var selected = [CategoryName]()
        for (index, bool) in ticks.enumerated() {
            if bool == true {
                let categoryName = CategoryName(drinkCategory: categories[index].drinkCategory)
                selected.append(categoryName)
            }
        }
        let selectedCategories = DrinkCategory(categories: selected)
        delegate?.categoriesSelectedInFilter = selectedCategories
        mainCoordinator?.backToDrinksTable()
    }

}



extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let rowsNumber = allCategories?.categories.count else { return 1 }
        return rowsNumber
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "filterCell", for: indexPath) as! FilterCell
        
        cell.categoryName.text = allCategories?.categories[indexPath.row].drinkCategory
        cell.tick.isHidden = !ticks[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedTick = ticks[indexPath.row]
        ticks[indexPath.row] = !selectedTick
        tableView.reloadData()
    }
    
}

