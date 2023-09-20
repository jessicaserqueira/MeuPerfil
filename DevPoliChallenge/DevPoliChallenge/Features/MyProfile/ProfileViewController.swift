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
    var webView: WKWebView!
    
    var customView = ProfileView()
    var viewModel = ProfileViewModel()
    var webViewController = WebViewController()
    var urls = URLS()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = customView
        customView.delegate = self
        customView.backgroundColor = .white
        
        viewModel.delegate = self
        viewModel.loadUserProfileImageData()
    }
    
    func showImagePicker() {
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

extension ProfileViewController:  ProfileViewDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func didTapCameraIcon() {
        showImagePicker()
    }
    
    func didTapTermsOfUseURL() {
        if let url = viewModel.urls.termsOfUseURL {
            showWebViewController(withURL: url)
        }
    }
    
    func didTapPrivacyPolicyURL() {
        if let url = urls.privacyPolicyURL {
            showWebViewController(withURL: url)
        }
    }
    
    func didTapFrequentlyAskedQuestionsURL() {
        if let url = viewModel.urls.frequentlyAskedQuestionsURL {
            showWebViewController(withURL: url)
        }
    }
}

extension ProfileViewController: ProfileViewModelDelegate {
    func didSelectProfileImage(_ imageData: Data) {
        if let image = UIImage(data: imageData) {
            customView.selectedImage = image
        }
    }
    
    func showWebViewController(withURL url: URL) {
        let webViewController = WebViewController()
        webViewController.webURL = url
        navigationController?.pushViewController(webViewController, animated: true)
    }
}
