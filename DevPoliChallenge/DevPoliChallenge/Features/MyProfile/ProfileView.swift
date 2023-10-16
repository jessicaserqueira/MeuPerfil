//
//  MayProfileView.swift
//  DevPoliChallenge-MeuPerfil
//
//  Created by Jessica Serqueira on 05/09/23.
//  Copyright © 2023 DevPoli. All rights reserved.
//

import UIKit

protocol ProfileViewDelegate: AnyObject {
    func didTapCameraIcon()
    func didTapProfileMenuOption(_ option: ProfileMenuOption)
    func didTapLogout()
    func didTapLocalPhone()
    func didTapotherLocationsPhone()
    func didTapWebview()
}

class ProfileView: UIView {
    
    var isSessionClosed = false
    weak var delegate: ProfileViewDelegate?
    
    let sections: [Section] = [
        Section(title: "MINHA CONTA", numberOfRows: 3, cells: [
            .personalData,
            .addresses,
            .cards
        ]),
        Section(title: "PEDIDOS", numberOfRows: 2, cells: [
            .myRequests,
            .extract
        ]),
        Section(title: "AJUDA", numberOfRows: 3, cells: [
            .termsOfUse,
            .privacyPolicy,
            .faq
        ])
    ]
    
    var selectedImage: UIImage? {
        didSet {
            imageContainer.profileImage.image = selectedImage
        }
    }
    
    private lazy var scrollView: UIScrollView = {
        let container = UIScrollView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.accessibilityIdentifier = "ProfileView.containerImage"
        addSubview(container)
        container.addSubview(imageView)
        container.addSubview(labelName)
        container.addSubview(tableView)
        container.addSubview(view)
        
        return container
    }()
    
    private lazy var imageView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.accessibilityIdentifier = "ProfileView.view"
        view.addSubview(imageContainer)
        return  view
    }()
    
    private lazy var imageContainer: ImageView = {
        let container = ImageView()
        container.delegate = self
        container.backgroundColor = .clear
        container.translatesAutoresizingMaskIntoConstraints = false
        container.accessibilityIdentifier = "ProfileView.containerImage"
        addSubview(container)
        return container
    }()

    private lazy var labelName: UILabel = {
        let label = UILabel()
        label.text = "Sample Name"
        label.font = UIFont.roboto(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "ProfileView.labelName"
        addSubview(label)
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = DesignSystem.Colors.background
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.accessibilityIdentifier = "ProfileView.tableView"
        addSubview(tableView)
        return tableView
    }()
    
    private lazy var view: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.accessibilityIdentifier = "ProfileView.view"
        view.addSubview(footerView)
        return  view
    }()
    
    private lazy var footerView: FooterView = {
        let footerView = FooterView()
        let view = UIView()
        footerView.delegate = self
        view.backgroundColor = DesignSystem.Colors.background
        footerView.translatesAutoresizingMaskIntoConstraints = false
        footerView.accessibilityIdentifier = "ProfileView.footerView"
        return footerView
    }()
    
    private lazy var closedButton: UIButton = {
        let button = UIButton()
        button.setTitle("Encerrar Sessão", for: .normal)
        button.titleLabel?.font = UIFont.roboto(ofSize: 18, weight: .bold)
        button.backgroundColor = DesignSystem.Colors.backgroundButton
        button.contentMode = .scaleAspectFill
        button.translatesAutoresizingMaskIntoConstraints = false
        button.accessibilityIdentifier = "ProfileView.closedButton"
        button.addTarget(self, action: #selector(closedButtonTapped), for: .touchUpInside)
        scrollView.addSubview(button)
        return button
    }()
    
    //MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Constraints
    func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 150),
            imageView.heightAnchor.constraint(equalToConstant: 150),
            
            imageContainer.topAnchor.constraint(equalTo: imageView.topAnchor),
            imageContainer.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            imageContainer.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            imageContainer.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            
            labelName.topAnchor.constraint(equalTo: imageContainer.bottomAnchor, constant: 11),
            labelName.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            tableView.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: closedButton.topAnchor, constant: -10),
            
            closedButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            closedButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            closedButton.heightAnchor.constraint(equalToConstant: 70.0),
            
            view.topAnchor.constraint(equalTo: closedButton.bottomAnchor, constant: 10),
            view.heightAnchor.constraint(equalToConstant: 200),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            footerView.topAnchor.constraint(equalTo: view.topAnchor),
            footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            footerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    //MARK: - Actions
    func updateProfileImage(image: UIImage?) {
        imageContainer.profileImage.image = image
    }
    
    @objc func closedButtonTapped() {
        delegate?.didTapLogout()
    }
}

// MARK: - UITableViewDataSource and UITableViewDelegate

extension ProfileView: UITableViewDataSource, UITableViewDelegate {
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
        cell.backgroundColor = DesignSystem.Colors.background
        cell.textLabel?.text = cellData.rawValue
        cell.textLabel?.font = UIFont.roboto(ofSize: 18, weight: .regular)
        cell.detailTextLabel?.text = cellData.rawValue
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let label = UILabel()
        label.text = sections[section].title
        label.font = UIFont.roboto(ofSize: 14, weight: .bold)
        label.textColor = DesignSystem.Colors.primary
        headerView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 22).isActive = true
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = sections[indexPath.section]
        let cellData = section.cells[indexPath.row]
        
        if let option = ProfileMenuOption(rawValue: cellData.rawValue) {
            switch option {
            case .personalData, .addresses, .cards, .myRequests, .extract, .termsOfUse, .privacyPolicy, .faq:
                delegate?.didTapProfileMenuOption(option)                
            }
        }
    }
}

extension ProfileView: FooterViewDelegate {
    func didTapLocalPhone() {
        delegate?.didTapLocalPhone()
    }
    
    func didTapOtherLocationsPhone() {
        delegate?.didTapotherLocationsPhone()
    }
    
    func didTapWebsite() {
        delegate?.didTapWebview()
    }
}

extension ProfileView: ImageViewDelegate {
    func didTapCameraIcon() {
        delegate?.didTapCameraIcon()
    }
}
