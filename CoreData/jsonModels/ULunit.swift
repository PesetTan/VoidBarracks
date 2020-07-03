//
//  unit.swift
//  WarTracker
//
//  Created by Peset Tan on 6/11/20.
//  Copyright © 2020 WarTracker. All rights reserved.
//

import Foundation

struct ULUnit: Decodable {
    var id, name, title: String
    var cost, models, damage: Int
    var speed, strength, meleeAttack, rangeAttack, defense, armor, focus: Int?
    var weaponPoints, armCount, shoulderCount: Int?
    var ruleIds: [String]
    var cortexOptionIds, armOptionIds, shoulderOptionIds: [String]?
    var weaponIds, attachmentIds: [String]?

    init() {
        self.id = ""
        self.name = ""
        self.title = ""
        self.cost = -1
        self.models = -1
        self.damage = -1
        self.speed = -1
        self.strength = -1
        self.meleeAttack = -1
        self.rangeAttack = -1
        self.defense = -1
        self.armor = -1
        self.focus = -1
        self.weaponPoints = -1
        self.armCount = -1
        self.shoulderCount = -1
        self.ruleIds = []
        self.cortexOptionIds = []
        self.armOptionIds = []
        self.shoulderOptionIds = []
        self.weaponIds = []
        self.attachmentIds = []
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case cost, models, damage, speed, strength, meleeAttack, rangeAttack, defense, armor, weaponPoints, armCount, shoulderCount
        case ruleIds
        case cortexOptionIds, armOptionIds, shoulderOptionIds, title
        case weaponIds
        case attachmentIds
        case focus
    }
}
