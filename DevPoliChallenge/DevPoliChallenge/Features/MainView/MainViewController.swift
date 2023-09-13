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
        customView.delegate = self
        customView.backgroundColor = .white
    }
}

extension MainViewController: MainViewDelegate {
    func showMyProfile() {
        let VC = ProfileViewController()
        navigationController?.pushViewController(VC, animated: true)
    }
}
