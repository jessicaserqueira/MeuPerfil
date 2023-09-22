//
//  Section.swift
//  DevPoliChallenge-MeuPerfil
//
//  Created by Jessica Serqueira on 06/09/23.
//  Copyright © 2023 DevPoli. All rights reserved.
//

import Foundation

struct Section {
    var title: String
    var numberOfRows: Int
    var cells: [ProfileMenuOption]
    
    init(title: String, numberOfRows: Int, cells: [ProfileMenuOption]) {
        self.title = title
        self.numberOfRows = numberOfRows
        self.cells = cells
    }
}
