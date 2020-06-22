//
//  ViewController.swift
//  Coctails DB
//
//  Created by Oleh Haistruk on 20.06.2020.
//  Copyright © 2020 Oleh Haistruk. All rights reserved.
//

import UIKit

class FilerViewController: UIViewController, Storyboarded {
    weak var mainCoordinator: MainCoordinator?
    var allCategories: DrinkCategory?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let backImage = UIImage(systemName: "arrow.left")
        self.navigationController?.navigationBar.backIndicatorImage = backImage
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        let title = UILabel()
        title.textAlignment = .left
        title.font = UIFont(name: "Avenir", size: 26)
        title.text = "Drinks"
        self.navigationItem.titleView = title
        
        debugPrint(allCategories)
    }


}

