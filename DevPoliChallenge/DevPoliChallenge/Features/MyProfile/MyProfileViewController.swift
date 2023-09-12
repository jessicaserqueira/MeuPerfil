//
//  MyProfileViewController.swift
//  DevPoliChallenge-MeuPerfil
//
//  Created by Jessica Serqueira on 05/09/23.
//  Copyright © 2023 DevPoli. All rights reserved.
//

import UIKit

class MyProfileViewController: UIViewController {
    
    var customView = MyProfileView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        
        let backButton = UIBarButtonItem(
            image: UIImage(named: "left"),
            style: .plain, target: self,
            action: #selector(backButtonTapped)
        )
        navigationItem.leftBarButtonItem = backButton
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = customView
        customView.delegate = self
        customView.backgroundColor = .white
    }
    
    @objc func backButtonTapped() {
          navigationController?.popViewController(animated: true)
      }
}

extension MyProfileViewController: MyProfileViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func didTapCameraIcon() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            customView.selectedImage = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
