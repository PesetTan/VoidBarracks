//
//  cortex.swift
//  WarTracker
//
//  Created by Peset Tan on 6/11/20.
//  Copyright © 2020 WarTracker. All rights reserved.
//

import Foundation

struct ULCortex: Codable {
    var id, name: String
    var ruleIds: [String]
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case ruleIds
    }
}
