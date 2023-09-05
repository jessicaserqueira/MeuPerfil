//
//  ViewController.swift
//  DevPoliChallenge
//
//  Created by DevPoli on 29/07/23.
//  Copyright © 2023 DevPoli. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.textColor = DesignSystem.Colors.secondary
        descriptionLabel.textColor = DesignSystem.Colors.tertiary
        view.backgroundColor = DesignSystem.Colors.background
    }

}

