//
//  FBUnit.swift
//  WarTracker
//
//  Created by Peset Tan on 6/12/20.
//  Copyright © 2020 WarTracker. All rights reserved.
//

import Foundation

struct ULJack : Codable {
    var id, name, title: String
    var cost, models, damage: Int
    var speed, strength, meleeAttack, rangeAttack, defense, armor, focus: Int?
    var weaponPoints, armCount, shoulderCount: Int
    
    var ruleIds: [String]
    var weaponIds: [String]?
    var armOptionIds: [String]
    var shoulderOptionIds: [String]
    var cortexOptionIds: [String]
    
    init() {
        id = ""
        name = ""
        title = ""
        cost = 0
        models = 0
        damage = 0
        speed = nil
        strength = nil
        meleeAttack = nil
        rangeAttack = nil
        defense = nil
        armor = nil
        focus = nil
        weaponPoints = 0
        armCount = 0
        shoulderCount = 0
        ruleIds = [String]()
        weaponIds = [String]()
        armOptionIds = [String]()
        shoulderOptionIds = [String]()
        cortexOptionIds = [String]()
    }
}
