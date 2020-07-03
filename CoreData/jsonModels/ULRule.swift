//
//  Rule.swift
//  WarTracker
//
//  Created by Peset Tan on 6/12/20.
//  Copyright © 2020 WarTracker. All rights reserved.
//

import Foundation

struct ULRule: Codable {
    var id: String
    var name: String
    var rule: String
    
    init() {
        id = ""
        name = ""
        rule = ""
    }
}
