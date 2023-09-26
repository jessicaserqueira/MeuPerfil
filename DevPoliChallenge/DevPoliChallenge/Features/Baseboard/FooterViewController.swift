//
//  BaseboardViewController.swift
//  DevPoliChallenge-MeuPerfil
//
//  Created by Jessica Serqueira on 25/09/23.
//  Copyright © 2023 DevPoli. All rights reserved.
//

import UIKit

class FooterViewController: UIViewController {
    
    var customView = FooterView()
    var viewModel = FooterViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = customView
        customView.backgroundColor = DesignSystem.Colors.background
    }
}
