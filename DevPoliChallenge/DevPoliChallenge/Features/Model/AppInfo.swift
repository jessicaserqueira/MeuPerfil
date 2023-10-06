//
//  AppInfo.swift
//  DevPoliChallenge-MeuPerfil
//
//  Created by Jessica Serqueira on 05/10/23.
//  Copyright © 2023 DevPoli. All rights reserved.
//

import Foundation

struct AppInfo {
    static var appVersion: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "Versão desconhecida"
    }

    static var buildNumber: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "Número de compilação desconhecido"
    }
}
