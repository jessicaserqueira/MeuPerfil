//
//  MyProfileViewController.swift
//  DevPoliChallenge-MeuPerfil
//
//  Created by Jessica Serqueira on 05/09/23.
//  Copyright © 2023 DevPoli. All rights reserved.
//

import UIKit
import WebKit

class ProfileViewController: UIViewController {
    var customView = ProfileView()
    var viewModel = ProfileViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        setupNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = customView
        customView.delegate = self
        customView.backgroundColor = .white
        
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
        let actions = [
            UIAlertAction(title: "Alterar Imagem", style: .default) { [weak self] _ in
                self?.presentImagePicker()
            },
            UIAlertAction(title: "Remover Imagem", style: .destructive) { [weak self] _ in
                self?.removeProfileImage()
            }
        ]
        
        UIAlertController.showActionSheet(
            from: self,
            title: "Escolha uma opção",
            message: nil,
            actions: actions
        )
    }
    
    func removeProfileImage() {
        customView.selectedImage = nil
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
}

extension ProfileViewController:  ProfileViewDelegate {
    func didTapCameraIcon() {
        showImagePicker()
    }
    
    func didTapProfileMenuOption(_ option: ProfileMenuOption) {
        viewModel.performAction(option)
    }
}

extension ProfileViewController: ProfileViewModelDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
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
