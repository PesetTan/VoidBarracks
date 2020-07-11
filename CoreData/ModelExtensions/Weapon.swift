//
//  Weapon.swift
//  iOS
//
//  Created by Peset Tan on 7/10/20.
//

import Foundation

extension Weapon {

    public var rulesArray: [Rule] {
        let rules = self.rules as? Set<Rule> ?? []
        return rules.sorted{$0.name! < $1.name!}
    }

    public var elementsArray: [Element] {
        let elements = self.elements as? Set<Element> ?? []
        return elements.sorted{$0.name! < $1.name!}
    }

    public var attachmentsArray: [Weapon] {
        let weapons = self.attachments as? Set<Weapon> ?? []
        return weapons.sorted{$0.name! < $1.name!}
    }
}
