//
//  MayProfileView.swift
//  DevPoliChallenge-MeuPerfil
//
//  Created by Jessica Serqueira on 05/09/23.
//  Copyright © 2023 DevPoli. All rights reserved.
//

import UIKit

protocol MyProfileViewDelegate: AnyObject {
    func didTapCameraIcon()
}

class MyProfileView: UIView {
    let sections: [Section] = [
        Section(title: "MINHA CONTA", numberOfRows: 3, cells: [
            ProfileCell(
                title: "Dados pessoais",
                detais: ""),
            ProfileCell(
                title: "Endereços",
                detais: ""),
            ProfileCell(
                title: "Cartões",
                detais: "")
        ]),
        Section(title: "PEDIDOS", numberOfRows: 2, cells: [
            ProfileCell(
                title: "Meus pedidos",
                detais: ""),
            ProfileCell(
                title: "Estrato",
                detais: ""),
            ProfileCell(
                title: "Cartões",
                detais: "")
        ]),
        Section(title: "AJUDA", numberOfRows: 3, cells: [
            ProfileCell(
                title: "Termos de uso",
                detais: ""),
            ProfileCell(
                title: "Política de privacidade",
                detais: ""),
            ProfileCell(
                title: "Dúvidas frequentes",
                detais: "")
        ]),
    ]

    weak var delegate: MyProfileViewDelegate?

    var selectedImage: UIImage? {
        didSet {
            image.image = selectedImage
        }
    }

    private lazy var imageContainer: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        addSubview(container)
        container.addSubview(image)
        container.addSubview(imageContainerIcon)
        container.accessibilityIdentifier = "MyProfileView.imageContainer"
        return container
    }()

    private lazy var image: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "no-image")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 75
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.accessibilityIdentifier = "MyProfileView.image"
        return imageView
    }()

    private lazy var imageContainerIcon: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.layer.cornerRadius = 21
        container.backgroundColor = DesignSystem.Colors.primary
        container.accessibilityIdentifier = "MyProfileView.imageContainerIcon"
        addSubview(container)
        container.addSubview(buttonIcon)
        return container
    }()

    private lazy var buttonIcon: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "ic-camera"), for: .normal)
        button.contentMode = .scaleAspectFill
        button.translatesAutoresizingMaskIntoConstraints = false
        button.accessibilityIdentifier = "MyProfileView.buttonIcon"
        return button
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.accessibilityIdentifier = "MyProfileView.tableView"
        addSubview(tableView)
        return tableView
    }()

    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        setupActions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Actions
    
    func setupActions() {
        buttonIcon.addTarget(self, action: #selector(cameraIconTapped), for: .touchUpInside)
    }
    
    @objc func cameraIconTapped() {
        delegate?.didTapCameraIcon()
    }

    // MARK: - Constraints
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageContainer.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            imageContainer.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageContainer.widthAnchor.constraint(equalToConstant: 150),
            imageContainer.heightAnchor.constraint(equalToConstant: 150),

            image.topAnchor.constraint(equalTo: imageContainer.topAnchor),
            image.leadingAnchor.constraint(equalTo: imageContainer.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: imageContainer.trailingAnchor),
            image.bottomAnchor.constraint(equalTo: imageContainer.bottomAnchor),

            imageContainerIcon.bottomAnchor.constraint(equalTo: imageContainer.bottomAnchor, constant: -9),
            imageContainerIcon.trailingAnchor.constraint(equalTo: imageContainer.trailingAnchor, constant: -9),
            imageContainerIcon.heightAnchor.constraint(equalToConstant: 42),
            imageContainerIcon.widthAnchor.constraint(equalToConstant: 42),

            buttonIcon.centerXAnchor.constraint(equalTo: imageContainerIcon.centerXAnchor),
            buttonIcon.centerYAnchor.constraint(equalTo: imageContainerIcon.centerYAnchor),
            buttonIcon.heightAnchor.constraint(equalToConstant: 24),
            buttonIcon.widthAnchor.constraint(equalToConstant: 24),

            tableView.topAnchor.constraint(equalTo: imageContainer.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

extension MyProfileView: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].numberOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        let section = sections[indexPath.section]
        let cellData = section.cells[indexPath.row]
        cell.textLabel?.text = cellData.title
        cell.detailTextLabel?.text = cellData.title
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let label = UILabel()
        label.text = sections[section].title
        label.textColor = DesignSystem.Colors.primary
        label.font = UIFont.roboto(ofSize: 14, weight: .bold)
        headerView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 22).isActive = true
        return headerView
    }
}
