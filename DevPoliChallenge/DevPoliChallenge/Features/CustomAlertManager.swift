//
//  ShowAlertsProtocol.swift
//  DevPoliChallenge-MeuPerfil
//
//  Created by Jessica Serqueira on 13/10/23.
//  Copyright © 2023 DevPoli. All rights reserved.
//

import UIKit

class CustomAlertManager {
    static func showImagePickerAlert(from viewController: UIViewController & ProfileViewControllerDelegate) {
        let actions = [
            UIAlertAction(title: "Alterar Imagem", style: .default) { _ in
                viewController.presentImagePicker()
            },
            UIAlertAction(title: "Remover Imagem", style: .destructive) { _ in
                viewController.removeProfileImage()
            },
            UIAlertAction(title: "Cancelar", style: .cancel)
        ]
        
        let title = "Escolha uma opção"
        let message = ""
        
        UIAlertController.showActionSheet(
            from: viewController,
            title: title,
            message: message,
            actions: actions
        )
    }
    
    static func showLogoutAlert(from viewController: UIViewController & ProfileViewControllerDelegate) {
        guard let profileViewController = viewController as? ProfileViewController else {
            return
        }
        
        let alertTitle = "Encerrar Sessão"
        let alertMessage = "Tem certeza de que deseja encerrar a sessão?"
        
        let confirmAction = UIAlertAction(title: "Sim", style: .destructive) { _ in
            profileViewController.viewModel.logout()
        }
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel)
        
        UIAlertController.showActionSheet(
            from: viewController,
            title: alertTitle,
            message: alertMessage,
            actions: [confirmAction, cancelAction]
        )
    }
}
