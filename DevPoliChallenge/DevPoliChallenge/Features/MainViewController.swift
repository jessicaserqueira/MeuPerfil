//
//  ViewController.swift
//  DevPoliChallenge
//
//  Created by DevPoli on 29/07/23.
//  Copyright © 2023 DevPoli. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    var customView = MainView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = customView
        customView.backgroundColor = .white
    }
}
