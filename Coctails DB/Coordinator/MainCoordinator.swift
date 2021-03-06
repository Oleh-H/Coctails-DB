//
//  MainCoordinator.swift
//  Cat Breeds Directory
//
//  Created by Oleh Haistruk on 18.05.2020.
//  Copyright © 2020 Oleh Haistruk. All rights reserved.
//

import Foundation
import UIKit

///The `MainCoordinator` class manages navigation in the App's UI.
class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    ///Receives a `UINavigationController` initialized at `SceneDelegate` class on app start.
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = DrinksTableView.instantiate()
        vc.mainCoordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    ///Perform navigation to `FilerViewController`
    
    func displayFilter(allCategories: DrinkCategory?, parrent: FilterViewControllerDelegate) {
        let vc = FilterViewController.instantiate()
        vc.mainCoordinator = self
        vc.allCategories = allCategories
        vc.delegate = parrent
        navigationController.pushViewController(vc, animated: true)
    }
    
    func backToDrinksTable() {
        navigationController.popViewController(animated: true)
    }
}
