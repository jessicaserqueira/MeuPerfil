//
//  BaseboardView.swift
//  DevPoliChallenge-MeuPerfil
//
//  Created by Jessica Serqueira on 25/09/23.
//  Copyright © 2023 DevPoli. All rights reserved.
//

import UIKit

protocol FooterViewDelegate: AnyObject {
    func didTapLocalPhone()
}

class FooterView: UIView {

    weak var delegate: FooterViewDelegate?
    
    private let titleLabel: UILabel = createLabel(
        text: "Atendimento",
        font: UIFont.roboto(ofSize: 16, weight: .bold),
        textColor: .black,
        accessibilityIdentifier: "FooterView.titleLabel"
    )
    
    private let phoneLocalLabel: UILabel = createLabel(
        text: "30031234",
        font: UIFont.roboto(ofSize: 16, weight: .regular),
        textColor: DesignSystem.Colors.accent,
        accessibilityIdentifier: "FooterView.phoneLocalLabel"
    )
    
    private let localLabel: UILabel = createLabel(
        text: "(Capitais e regiões metropolitanas)",
        font: UIFont.roboto(ofSize: 14, weight: .regular),
        textColor: .gray,
        accessibilityIdentifier: "FooterView.label"
    )
    
    private let otherLocationsPhoneLabel: UILabel = createLabel(
        text: "08001234567",
        font: UIFont.roboto(ofSize: 16, weight: .regular),
        textColor: DesignSystem.Colors.accent,
        accessibilityIdentifier: "FooterView.otherLocationsPhoneLabel"
    )
    
    private let otherLocationsLabel: UILabel = createLabel(
        text: "(Demais localidades)",
        font: UIFont.roboto(ofSize: 14, weight: .regular),
        textColor: .gray,
        accessibilityIdentifier: "FooterView.otherLocationsLabel"
    )
    
    private let websiteLabel: UILabel = createLabel(
        text: "devpoli.com",
        font: UIFont.roboto(ofSize: 14, weight: .regular),
        textColor: DesignSystem.Colors.secondary,
        accessibilityIdentifier: "FooterView.websiteLabel"
    )
    private let versionLabel: UILabel = createLabel(
        text: "Versão: 1.0.0",
        font: UIFont.roboto(ofSize: 14, weight: .regular),
        textColor: .black,
        accessibilityIdentifier: "FooterView.websiteLabel"
    )
    private let buildLabel: UILabel = createLabel(
        text: " (12345)",
        font: UIFont.roboto(ofSize: 14, weight: .regular),
        textColor: .black,
        accessibilityIdentifier: "FooterView.buildLabel"
    )
    
    private lazy var stackViewPhoneLocal: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.accessibilityIdentifier = "FooterView.stackViewVersion"
        return stackView
    }()
    
    private lazy var stackViewotherLocationsPhone: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.accessibilityIdentifier = "FooterView.stackViewVersion"
        return stackView
    }()
    
    private lazy var stackViewVersion: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.accessibilityIdentifier = "FooterView.stackViewVersion"
        return stackView
    }()
    
    private static func createLabel(text: String, font: UIFont, textColor: UIColor, accessibilityIdentifier: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.textColor = textColor
        label.accessibilityIdentifier = accessibilityIdentifier
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    
    //MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = DesignSystem.Colors.background
        
        setupSubviews()
        setupConstraints()
        setupPhoneLabelsGestures()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - SetupViews
    private func setupSubviews() {
        
        addSubview(titleLabel)
        
        addSubview(stackViewPhoneLocal)
        stackViewPhoneLocal.addArrangedSubview(phoneLocalLabel)
        stackViewPhoneLocal.addArrangedSubview(localLabel)
        
        addSubview(stackViewotherLocationsPhone)
        stackViewotherLocationsPhone.addArrangedSubview(otherLocationsPhoneLabel)
        stackViewotherLocationsPhone.addArrangedSubview(otherLocationsLabel)
        
        addSubview(websiteLabel)
        
        addSubview(stackViewVersion)
        stackViewVersion.addArrangedSubview(versionLabel)
        stackViewVersion.addArrangedSubview(buildLabel)
    }
    
    //MARK: - Actions
    
    @objc private func handlePhoneLocalTap() {
        delegate?.didTapLocalPhone()
    }
    
    @objc private func handleOtherLocationsPhoneTap() {
    }
    
    private func setupPhoneLabelsGestures() {
        let phoneLocalTapGesture = UITapGestureRecognizer(target: self, action: #selector(handlePhoneLocalTap))
        phoneLocalLabel.isUserInteractionEnabled = true
        phoneLocalLabel.addGestureRecognizer(phoneLocalTapGesture)
        
        let otherLocationsPhoneTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleOtherLocationsPhoneTap))
        otherLocationsPhoneLabel.isUserInteractionEnabled = true
        otherLocationsPhoneLabel.addGestureRecognizer(otherLocationsPhoneTapGesture)
    }
    
    //MARK: - Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -22),
            
            stackViewPhoneLocal.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 9),
            stackViewPhoneLocal.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22),
            stackViewPhoneLocal.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -22),
            
            stackViewotherLocationsPhone.topAnchor.constraint(equalTo: stackViewPhoneLocal.bottomAnchor, constant: 10),
            stackViewotherLocationsPhone.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22),
            stackViewotherLocationsPhone.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -22),
            
            websiteLabel.topAnchor.constraint(equalTo: stackViewotherLocationsPhone.bottomAnchor, constant: 5),
            websiteLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            stackViewVersion.topAnchor.constraint(equalTo: websiteLabel.bottomAnchor, constant: 5),
            stackViewVersion.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackViewVersion.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ])
    }
}
