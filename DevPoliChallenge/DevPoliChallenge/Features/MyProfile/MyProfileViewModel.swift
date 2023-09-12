//
//  MyProfileViewModel.swift
//  DevPoliChallenge-MeuPerfil
//
//  Created by Jessica Serqueira on 11/09/23.
//  Copyright © 2023 DevPoli. All rights reserved.
//

import Foundation
import UIKit

class MyProfileViewModel: NSObject {
    weak var viewController: MyProfileViewController?
    
    init(viewController: MyProfileViewController) {
        self.viewController = viewController
    }
    
}
