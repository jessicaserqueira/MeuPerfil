//
//  UIAlertController +ext.swift
//  DevPoliChallenge-MeuPerfil
//
//  Created by Jessica Serqueira on 21/09/23.
//  Copyright © 2023 DevPoli. All rights reserved.
//

import UIKit

extension UIAlertController {
    static func showActionSheet<T>(
          from controller: T,
          title: String?,
          message: String?,
          actions: [UIAlertAction],
          completion: (() -> Void)? = nil
      ) where T: UIViewController {
          let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
          
          for action in actions {
              alert.addAction(action)
          }
          
          if let completion = completion {
              let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel) { _ in
                  completion()
              }
              alert.addAction(cancelAction)
          }
          controller.present(alert, animated: true, completion: nil)
      }
    
    static func showAlert<T>(
        from controller: T,
        title: String?,
        message: String?,
        completion: (() -> Void)? = nil
    ) where T: UIViewController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        })
        
        controller.present(alert, animated: true, completion: nil)
    }
}
