//
//  weapon.swift
//  WarTracker
//
//  Created by Peset Tan on 6/11/20.
//  Copyright © 2020 WarTracker. All rights reserved.
//

import Foundation

struct ULWeapon: Codable {
    var id, name: String
    var cost: Int?
    var elements: [String]
    var type: String
    var range, power: Int?
    var ruleIds, multiWeaponIds: [String]?

    enum CodingKeys: String, CodingKey {
        case id, name, cost, elements, type, range, power
        case ruleIds
        case multiWeaponIds
    }
    
}
