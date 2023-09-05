//
//  UIFont+ext.swift
//  DevPoliChallenge-MeuPerfil
//
//  Created by Jessica Serqueira on 05/09/23.
//  Copyright © 2023 DevPoli. All rights reserved.
//

import UIKit

enum FontName: String {
    case regular = "Roboto-Regular"
    case medium = "Roboto-Medium"
    case bold = "Roboto-Bold"
}

extension UIFont {
    static func roboto(ofSize size: CGFloat, weight: FontName) -> UIFont {
        var fontWeight: UIFont.Weight
        
        switch weight {
        case .regular:
            fontWeight = .regular
        case .medium:
            fontWeight = .medium
        case .bold:
            fontWeight = .bold
        }
        
        if let font = UIFont(name: weight.rawValue, size: size) {
            return font
        } else {
            return UIFont.systemFont(ofSize: size, weight: fontWeight)
        }
    }
}
