//
//  ViewController.swift
//  Coctails DB
//
//  Created by Oleh Haistruk on 20.06.2020.
//  Copyright © 2020 Oleh Haistruk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let network = Network()

    override func viewDidLoad() {
        super.viewDidLoad()
        network.getDrinkCategories()
        network.getDrincsOf(category: "Ordinary Drink")
    }


}

