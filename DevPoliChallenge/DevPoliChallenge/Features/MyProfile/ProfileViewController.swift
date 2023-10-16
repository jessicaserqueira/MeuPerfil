//
//  MyProfileViewController.swift
//  DevPoliChallenge-MeuPerfil
//
//  Created by Jessica Serqueira on 05/09/23.
//  Copyright © 2023 DevPoli. All rights reserved.
//

import UIKit

protocol ProfileViewControllerDelegate: AnyObject {
    func presentImagePicker()
    func removeProfileImage()
}

class ProfileViewController: UIViewController, ProfileViewControllerDelegate {
    var customView = ProfileView()
    var viewModel = ProfileViewModel()
    weak var delegate: ProfileViewControllerDelegate?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        setupNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = customView
        customView.delegate = self
        customView.backgroundColor = DesignSystem.Colors.background
        
        viewModel.delegate = self
        viewModel.loadUserProfileImageData()
    }
    
    func setupNavigationBar() {
        let backButton = UIBarButtonItem (
            image: UIImage(named: "left"),
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func showImagePicker() {
        CustomAlertManager.showImagePickerAlert(from: self)
    }
    
    func removeProfileImage() {
        viewModel.removeProfileImage()
    }
    
    func presentImagePicker() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage,
           let imageData = image.jpegData(compressionQuality: 1.0) {
            viewModel.selectProfileImage(imageData)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func showLogoutAlert() {
        CustomAlertManager.showLogoutAlert(from: self)
    }
}

extension ProfileViewController: ProfileViewDelegate {
    func didTapLocalPhone() {
        viewModel.showLocalphone()
    }
    
    func didTapotherLocationsPhone() {
        viewModel.showOtherLocationsphone()
    }
    
    func didTapWebview() {
        viewModel.showWebView()
    }
    
    func didTapLogout() {
        showLogoutAlert()
    }
    
    func didTapCameraIcon() {
        showImagePicker()
    }
    
    func didTapProfileMenuOption(_ option: ProfileMenuOption) {
        viewModel.performAction(option)
    }
}

extension ProfileViewController: ProfileViewModelDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func openPhoneURL(url: URL?) {
        if let phoneURL = url {
            if UIApplication.shared.canOpenURL(phoneURL) {
                UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
            }
        }
    }
    
    func didLogout() {
        let loginViewController = MainViewController()
        let navigationController = UINavigationController(rootViewController: loginViewController)
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let delegate = windowScene.delegate as? SceneDelegate {
            delegate.window?.rootViewController = navigationController
        }
    }
    
    func didRemoveProfileImage() {
        customView.updateProfileImage(image: UIImage(named: "no-image"))
    }
    
    func didSelectProfileImage(_ imageData: Data?) {
        if let imageData = imageData,
           let image = UIImage(data: imageData) {
            customView.updateProfileImage(image: image)
            
        }
    }
    
    func showWebViewController(url: URL?) {
        guard let url = url else { return }
        let vc = WebViewController()
        vc.webURL = url
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func showController(withTitle title: String) {
        let vc = SectionViewController()
        vc.title = title
        navigationController?.pushViewController(vc, animated: true)
    }
}
