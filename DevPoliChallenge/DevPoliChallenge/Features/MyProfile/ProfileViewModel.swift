//
//  MyprofileViewModel.swift
//  DevPoliChallenge-MeuPerfil
//
//  Created by Jessica Serqueira on 12/09/23.
//  Copyright © 2023 DevPoli. All rights reserved.
//

import Foundation

protocol ProfileViewModelDelegate: AnyObject {
    func didSelectProfileImage(_ imageData: Data)
}

class ProfileViewModel {
    
    weak var delegate: ProfileViewModelDelegate?
    
    var userProfileImageURL: URL?
    
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
            } catch {
                print("Erro ao salvar a imagem: \(error)")
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
        if let savedURL = UserDefaults.standard.url(forKey: "userProfileImageURL") {
            return savedURL
        }
        return nil
    }
    
    func saveUserProfileImageURL(url: URL) {
        UserDefaults.standard.set(url, forKey: "userProfileImageURL")
        UserDefaults.standard.synchronize()
    }
    
    func loadUserProfileImageData() {
        if let imageURL = loadUserProfileImageURL(),
           let imageData = try? Data(contentsOf: imageURL) {
            delegate?.didSelectProfileImage(imageData)
        }
    }
}
