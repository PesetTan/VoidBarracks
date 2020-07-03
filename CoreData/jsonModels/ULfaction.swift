//
//  faction.swift
//  WarTracker
//
//  Created by Peset Tan on 6/11/20.
//  Copyright © 2020 WarTracker. All rights reserved.
//

import Foundation

struct ULFaction: Codable {
    var id, name: String
    var shortName: String
    var unitIds: [String]
    var soloIds: [String]
    var heroIds: [String]
    var jackIds: [String]
    var attachmentIds: [String]

    enum CodingKeys: String, CodingKey {
        case id, name
        case shortName
        case unitIds
        case soloIds
        case heroIds
        case jackIds
        case attachmentIds
    }
}


