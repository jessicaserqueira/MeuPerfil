//
//  MyprofileViewModel.swift
//  DevPoliChallenge-MeuPerfil
//
//  Created by Jessica Serqueira on 12/09/23.
//  Copyright © 2023 DevPoli. All rights reserved.
//

import Foundation

protocol ProfileViewModelDelegate: AnyObject {
    func didSelectProfileImage(_ imageData: Data?)
    func showWebViewController(url: URL?)
    func showController(withTitle title: String)
    func showImagePicker()
    func didRemoveProfileImage()
    func didLogout()
    func openPhoneURL(url: URL?)
}

class ProfileViewModel {
    weak var delegate: ProfileViewModelDelegate?
    var userProfileImageURL: URL?
    var urls = WebURLS()
    var phoneURLS = PhoneURLS()
    var isLocalPhone: Bool = true
    var isSessionClosed = false
    var logoutAction: (() -> Void)?
    
    func selectProfileImage(_ image: Data) {
        saveImageToLocalDirectory(image)
    }
    
    func saveImageToLocalDirectory(_ image: Data) {
        let uniqueFilename = generateUniqueFilename()
        
        if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = documentsDirectory.appendingPathComponent(uniqueFilename)
            
            do {
                try image.write(to: fileURL)
                userProfileImageURL = fileURL
                saveUserProfileImageURL(url: fileURL)
                delegate?.didSelectProfileImage(image)
                updateProfileImage()
            } catch {
                print("Error saving image: \(error)")
            }
        }
    }
    
    func generateUniqueFilename() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMddHHmmssSSS"
        let currentDateTime = formatter.string(from: Date())
        return "profile_image_\(currentDateTime).jpg"
    }
    
    func loadUserProfileImageURL() -> URL? {
        return UserDefaults.standard.url(forKey: "userProfileImageURL")
    }
    
    func saveUserProfileImageURL(url: URL?) {
        UserDefaults.standard.set(url, forKey: "userProfileImageURL")
        UserDefaults.standard.synchronize()
    }
    
    func loadUserProfileImageData() {
        if userProfileImageURL == nil {
            if let imageURL = loadUserProfileImageURL(),
               FileManager.default.fileExists(atPath: imageURL.path),
               let imageData = try? Data(contentsOf: imageURL) {
                userProfileImageURL = imageURL
                delegate?.didSelectProfileImage(imageData)
            }
        }
    }
    
    func updateProfileImage() {
        if let imageURL = userProfileImageURL,
           FileManager.default.fileExists(atPath: imageURL.path),
           let imageData = try? Data(contentsOf: imageURL) {
            delegate?.didSelectProfileImage(imageData)
        }
    }
    
    func removeProfileImage() {
        if let imageURL = userProfileImageURL {
            do {
                try FileManager.default.removeItem(at: imageURL)
                userProfileImageURL = nil
                saveUserProfileImageURL(url: nil)
                delegate?.didRemoveProfileImage()
            } catch {
                print("Error removing image: \(error)")
            }
        }
    }
    
    func performAction(_ option: ProfileMenuOption) {
        let title: String
        
        switch option {
        case .personalData:
            title = "Dados Pessoais"
        case .addresses:
            title = "Endereços"
        case .cards:
            title = "Cartões"
        case .myRequests:
            title = "Meus Pedidos"
        case .extract:
            title = "Extrato"
        case .termsOfUse:
            delegate?.showWebViewController(url: urls.termsOfUseURL)
            return
        case .privacyPolicy:
            delegate?.showWebViewController(url: urls.privacyPolicyURL)
            return
        case .faq:
            delegate?.showWebViewController(url: urls.frequentlyAskedQuestionsURL)
            return
        }
        delegate?.showController(withTitle: title)
    }
    
    func logout() {
        delegate?.didLogout()
    }
    
    func showLocalphone() {
        if let localPhoneURL = phoneURLS.localPhone {
            delegate?.openPhoneURL(url: localPhoneURL)
        }
    }
    
    func showOtherLocationsphone() {
        if let otherLocationsPhoneURL = phoneURLS.otherLocationsPhone {
            delegate?.openPhoneURL(url: otherLocationsPhoneURL)
        }
    }
    
    func showWebView() {
        if let webViewURL = urls.webSite {
            delegate?.showWebViewController(url: webViewURL)
        }
    }
}
