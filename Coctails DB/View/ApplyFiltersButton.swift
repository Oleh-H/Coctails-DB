//
//  ApplyFiltersButton.swift
//  Coctails DB
//
//  Created by Oleh Haistruk on 22.06.2020.
//  Copyright © 2020 Oleh Haistruk. All rights reserved.
//

import UIKit

class ApplyFiltersButton: UIButton {

    required public init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)

        self.titleLabel?.textColor = .white
        self.setTitleColor(.white, for: .normal)
        self.backgroundColor = UIColor.black
        self.setTitle("APPLY", for: .normal)

    }

}
