//
//  SectionViewController.swift
//  DevPoliChallenge-MeuPerfil
//
//  Created by Jessica Serqueira on 20/09/23.
//  Copyright © 2023 DevPoli. All rights reserved.
//

import UIKit

class SectionViewController: UIViewController {
    
// MARK: - Properties
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Página em construção"
        label.textColor = DesignSystem.Colors.secondary
        label.font = UIFont.roboto(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "SectionViewController.label"
        return label
    }()
    
// MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
// MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .white
        setupNavigationBar()
        setupLabel()
    }
    
    private func setupNavigationBar() {
        let backButton = UIBarButtonItem(
            image: UIImage(named: "left"),
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
        navigationItem.leftBarButtonItem = backButton
    }
    
    private func setupLabel() {
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
// MARK: - Actions
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
