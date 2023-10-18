//
//  ImageView.swift
//  DevPoliChallenge-MeuPerfil
//
//  Created by Jessica Serqueira on 16/10/23.
//  Copyright © 2023 DevPoli. All rights reserved.
//

import UIKit
protocol ImageViewDelegate: AnyObject {
    func didTapCameraIcon()
    func updateProfileImage(image: UIImage?)
}

class ImageView: UIView {
    weak var delegate: ImageViewDelegate?

    private lazy var imageContainer: UIView = {
        let container = UIView()
        container.backgroundColor = .clear
        container.heightAnchor.constraint(equalToConstant: 150).isActive = true
        container.widthAnchor.constraint(equalToConstant: 150).isActive = true
        container.translatesAutoresizingMaskIntoConstraints = false
        container.accessibilityIdentifier = "ProfileView.containerImage"
        addSubview(container)
        container.addSubview(profileImage)
        container.addSubview(imageContainerIcon)
        return container
    }()
    
    lazy var profileImage: UIImageView = {
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
    
// MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: - Constraints
    func setupConstraints() {
        NSLayoutConstraint.activate([
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
            buttonIcon.widthAnchor.constraint(equalToConstant: 24)            
        ])
    }
    
// MARK: - Actions
    func setupActions() {
        buttonIcon.addTarget(self, action: #selector(buttonIconTapped), for: .touchUpInside)
    }
    
    @objc func buttonIconTapped() {
        delegate?.didTapCameraIcon()
    }
    
    func updateProfileImage(image: UIImage?) {
        profileImage.image = image
        delegate?.updateProfileImage(image: image)
    }
}
