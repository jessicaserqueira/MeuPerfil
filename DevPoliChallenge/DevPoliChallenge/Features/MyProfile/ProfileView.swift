//
//  MayProfileView.swift
//  DevPoliChallenge-MeuPerfil
//
//  Created by Jessica Serqueira on 05/09/23.
//  Copyright © 2023 DevPoli. All rights reserved.
//

import UIKit
import WebKit

protocol ProfileViewDelegate: AnyObject {
    func didTapCameraIcon()
    func didTapTermsOfUseURL()
    func didTapPrivacyPolicyURL()
    func didTapFrequentlyAskedQuestionsURL()
    func didTapPersonalData()
    func didTapAdresses()
    func didTaoCards()
    func didTapMyRequests()
    func didTapExtract()
}

class ProfileView: UIView, WKNavigationDelegate {
    
    weak var delegate: ProfileViewDelegate?
    
    let sections: [Section] = [
        Section(title: "MINHA CONTA", numberOfRows: 3, cells: [
            Cell(title: "Dados pessoais"),
            Cell(title: "Endereços"),
            Cell(title: "Cartões")
        ]),
        Section(title: "PEDIDOS", numberOfRows: 2, cells: [
            Cell(title: "Meus pedidos"),
            Cell(title: "Extrato")
        ]),
        Section(title: "AJUDA", numberOfRows: 3, cells: [
            Cell(title: "Termos de uso"),
            Cell(title: "Política de privacidade"),
            Cell(title: "Dúvidas frequentes")
        ]),
    ]
    
    var selectedImage: UIImage? {
        didSet {
            profileImage.image = selectedImage
        }
    }
    
    private lazy var imageContainer: UIView = {
        let container = UIView()
        container.backgroundColor = .clear
        container.translatesAutoresizingMaskIntoConstraints = false
        container.accessibilityIdentifier = "ProfileView.containerImage"
        addSubview(container)
        container.addSubview(profileImage)
        container.addSubview(imageContainerIcon)
        return container
    }()
    
    private lazy var profileImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "no-image")
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 75
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.accessibilityIdentifier = "ProfileView.profileImage"
        return image
    }()
    
    private lazy var imageContainerIcon: UIView = {
        let container = UIView()
        container.backgroundColor = DesignSystem.Colors.primary
        container.layer.cornerRadius = 21
        container.translatesAutoresizingMaskIntoConstraints = false
        container.accessibilityIdentifier = "ProfileView.containerImageIcon"
        container.addSubview(buttonIcon)
        return container
    }()
    
    private lazy var buttonIcon: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "ic-camera"), for: .normal)
        button.contentMode = .scaleAspectFill
        button.translatesAutoresizingMaskIntoConstraints = false
        button.accessibilityIdentifier = "ProfileView.imageIcon"
        return button
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
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.accessibilityIdentifier = "ProfileView.tableView"
        addSubview(tableView)
        return tableView
    }()
    
    //MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Constraints
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageContainer.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            imageContainer.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageContainer.widthAnchor.constraint(equalToConstant: 150),
            imageContainer.heightAnchor.constraint(equalToConstant: 150),
            
            profileImage.topAnchor.constraint(equalTo: imageContainer.topAnchor),
            profileImage.leadingAnchor.constraint(equalTo: imageContainer.leadingAnchor),
            profileImage.trailingAnchor.constraint(equalTo: imageContainer.trailingAnchor),
            profileImage.bottomAnchor.constraint(equalTo: imageContainer.bottomAnchor),
            
            imageContainerIcon.bottomAnchor.constraint(equalTo: imageContainer.bottomAnchor, constant: -9),
            imageContainerIcon.trailingAnchor.constraint(equalTo: imageContainer.trailingAnchor, constant: -9),
            imageContainerIcon.heightAnchor.constraint(equalToConstant: 42),
            imageContainerIcon.widthAnchor.constraint(equalToConstant: 42),
            
            buttonIcon.centerXAnchor.constraint(equalTo: imageContainerIcon.centerXAnchor),
            buttonIcon.centerYAnchor.constraint(equalTo: imageContainerIcon.centerYAnchor),
            buttonIcon.heightAnchor.constraint(equalToConstant: 24),
            buttonIcon.widthAnchor.constraint(equalToConstant: 24),
            
            labelName.topAnchor.constraint(equalTo: imageContainer.bottomAnchor, constant: 11),
            labelName.centerXAnchor.constraint(equalTo: imageContainer.centerXAnchor),
            
            tableView.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
    }
    
    //MARK: - Actions
    
    func setupActions() {
        buttonIcon.addTarget(self, action: #selector(buttonIconTapped), for: .touchUpInside)
    }
    
    @objc func buttonIconTapped() {
        delegate?.didTapCameraIcon()
    }
}

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
        cell.textLabel?.text = cellData.title
        cell.textLabel?.font = UIFont.roboto(ofSize: 18, weight: .regular)
        cell.detailTextLabel?.text = cellData.title
        
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
        
        switch cellData.title {
        case "Dados pessoais":
            delegate?.didTapPersonalData()
        case "Endereços":
            delegate?.didTapAdresses()
        case "Cartões":
            delegate?.didTaoCards()
        case "Meus pedidos":
            delegate?.didTapMyRequests()
        case "Extrato":
            delegate?.didTapExtract()
        case "Termos de uso":
            delegate?.didTapTermsOfUseURL()
        case  "Política de privacidade":
            delegate?.didTapPrivacyPolicyURL()
        case "Dúvidas frequentes":
            delegate?.didTapFrequentlyAskedQuestionsURL()
        default:
            break
        }
    }
}
