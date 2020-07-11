//
//  Hero.swift
//  iOS
//
//  Created by Peset Tan on 7/10/20.
//

import Foundation

extension Unit {

    public var rulesArray: [Rule] {
        let rules = self.rules as? Set<Rule> ?? []
        return rules.sorted{$0.name! < $1.name!}
    }

    public var weaponsArray: [Weapon] {
        let weapons = self.weapons as? Set<Weapon> ?? []
        return weapons.sorted{$0.name! < $1.name!}
    }
}
