//
//  cypher.swift
//  WarTracker
//
//  Created by Peset Tan on 6/11/20.
//  Copyright © 2020 WarTracker. All rights reserved.
//

import Foundation

struct ULCypher: Codable {
    var id, name: String
    var type: String
    var rule: String
    var power: Int?
}
