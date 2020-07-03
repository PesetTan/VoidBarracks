//
//  DataController.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/1/20.
//

import Foundation
import CoreData

extension Army {
    public func copy() -> Army {
        let newArmy = Army(context: managedObjectContext!)
        newArmy.id = UUID().uuidString
        newArmy.name = self.name
        self.heros!.allObjects.forEach { hero in
            let newHero = (hero as! Hero)
            newArmy.addToHeros(newHero.copy())
        }

        self.solos!.allObjects.forEach { solo in
            let newSolo = (solo as! Solo)
            newArmy.addToSolos(newSolo.copy())
        }

        self.jacks!.allObjects.forEach { jack in
            let newJack = (jack as! Jack)
            newArmy.addToJacks(newJack.copy())
        }

        self.squads!.allObjects.forEach { squad in
            let newSquad = (squad as! Squad)
            newArmy.addToSquads(newSquad.copy())
        }

        let newRack = Rack(context: managedObjectContext!)
        self.rack!.furies!.allObjects.forEach { cypher in
            let newCypher = (cypher as! Cypher)
            newRack.addToFuries(newCypher.copy())
        }
        self.rack!.geometrics!.allObjects.forEach { cypher in
            let newCypher = (cypher as! Cypher)
            newRack.addToGeometrics(newCypher.copy())
        }
        self.rack!.harmonics!.allObjects.forEach { cypher in
            let newCypher = (cypher as! Cypher)
            newRack.addToHarmonics(newCypher.copy())
        }
        self.rack!.overdrives!.allObjects.forEach { cypher in
            let newCypher = (cypher as! Cypher)
            newRack.addToOverdrives(newCypher.copy())
        }

        newArmy.rack = newRack

        return newArmy
    }
}

extension Hero {
    public func copy() -> Hero {
        let newHero = Hero(context: managedObjectContext!)
        newHero.id = self.id
        newHero.name = self.name
        newHero.cost = self.cost
        newHero.count = self.count
        newHero.title = self.title
        newHero.cost = self.cost
        newHero.spd = self.spd
        newHero.mat = self.mat
        newHero.rat = self.rat
        newHero.def = self.def
        newHero.arm = self.arm
        newHero.foc = self.foc
        newHero.dmg = self.dmg
        self.rules!.allObjects.forEach { rule in
            let newRule = (rule as! Rule)
            newHero.addToRules(newRule.copy())
        }
        self.weapons!.allObjects.forEach { weapon in
            let newWeapon = (weapon as! Weapon)
            newHero.addToWeapons(newWeapon.copy())
        }
        return newHero
    }
}

extension Solo {
    public func copy() -> Solo {
        let newSolo = Solo(context: managedObjectContext!)
        newSolo.id = self.id
        newSolo.name = self.name
        newSolo.count = self.count
        newSolo.cost = self.cost
        newSolo.title = self.title
        newSolo.cost = self.cost
        newSolo.spd = self.spd
        newSolo.mat = self.mat
        newSolo.rat = self.rat
        newSolo.def = self.def
        newSolo.arm = self.arm
        newSolo.foc = self.foc
        newSolo.dmg = self.dmg
        self.rules!.allObjects.forEach { rule in
            let newRule = (rule as! Rule)
            newSolo.addToRules(newRule.copy())
        }
        self.weapons!.allObjects.forEach { weapon in
            let newWeapon = (weapon as! Weapon)
            newSolo.addToWeapons(newWeapon.copy())
        }
        return newSolo
    }
}

extension Squad {
    public func copy() -> Squad {
        let newSquad = Squad(context: managedObjectContext!)
        newSquad.uuid = UUID().uuidString
        newSquad.customName = self.customName
        newSquad.lastModified = self.lastModified
        newSquad.id = self.id
        newSquad.name = self.name
        newSquad.count = self.count
        newSquad.cost = self.cost
        newSquad.title = self.title
        newSquad.cost = self.cost
        newSquad.spd = self.spd
        newSquad.mat = self.mat
        newSquad.rat = self.rat
        newSquad.def = self.def
        newSquad.arm = self.arm
        newSquad.foc = self.foc
        newSquad.dmg = self.dmg
        self.rules!.allObjects.forEach { rule in
            let newRule = (rule as! Rule)
            newSquad.addToRules(newRule.copy())
        }
        self.weapons!.allObjects.forEach { weapon in
            let newWeapon = (weapon as! Weapon)
            newSquad.addToWeapons(newWeapon.copy())
        }
        self.attachments!.allObjects.forEach { attachment in
            let newAttachment = (attachment as! Attachment)
            newSquad.addToAttachments(newAttachment.copy())
        }
        self.customSquads!.allObjects.forEach { squad in
            let newCustomSquad = (squad as! Squad)
            newSquad.addToCustomSquads(newCustomSquad.copy())
        }
        return newSquad
    }
}

extension Attachment {
    public func copy() -> Attachment {
        let newAttachment = Attachment(context: managedObjectContext!)
        newAttachment.id = self.id
        newAttachment.name = self.name
        newAttachment.count = self.count
        newAttachment.cost = self.cost
        newAttachment.title = self.title
        newAttachment.cost = self.cost
        newAttachment.spd = self.spd
        newAttachment.mat = self.mat
        newAttachment.rat = self.rat
        newAttachment.def = self.def
        newAttachment.arm = self.arm
        newAttachment.foc = self.foc
        newAttachment.dmg = self.dmg
        newAttachment.selected = self.selected
        self.rules!.allObjects.forEach { rule in
            let newRule = (rule as! Rule)
            newAttachment.addToRules(newRule.copy())
        }
        self.weapons!.allObjects.forEach { weapon in
            let newWeapon = (weapon as! Weapon)
            newAttachment.addToWeapons(newWeapon.copy())
        }
        return newAttachment
    }
}

extension Jack {
    public func copy() -> Jack {
        let newJack = Jack(context: managedObjectContext!)
        newJack.uuid = UUID().uuidString
        newJack.customName = self.customName
        newJack.lastModified = self.lastModified
        newJack.id = self.id
        newJack.name = self.name
        newJack.count = self.count
        newJack.cost = self.cost
        newJack.title = self.title
        newJack.cost = self.cost
        newJack.spd = self.spd
        newJack.mat = self.mat
        newJack.rat = self.rat
        newJack.def = self.def
        newJack.arm = self.arm
        newJack.foc = self.foc
        newJack.dmg = self.dmg
        newJack.str = self.str
        self.optionsForCortex!.allObjects.forEach { cortex in
            let newCortex = (cortex as! Cortex)
            newJack.addToOptionsForCortex(newCortex.copy())
        }
        self.optionsForArm1!.allObjects.forEach { weapon in
            let newWeapon = (weapon as! Weapon)
            newJack.addToOptionsForArm1(newWeapon.copy())
        }
        self.optionsForArm2!.allObjects.forEach { weapon in
            let newWeapon = (weapon as! Weapon)
            newJack.addToOptionsForArm2(newWeapon.copy())
        }
        self.optionsForShoulder1!.allObjects.forEach { weapon in
            let newWeapon = (weapon as! Weapon)
            newJack.addToOptionsForShoulder1(newWeapon.copy())
        }
        self.optionsForShoulder2!.allObjects.forEach { weapon in
            let newWeapon = (weapon as! Weapon)
            newJack.addToOptionsForShoulder2(newWeapon.copy())
        }
        if let cortex = self.selectedCortex {
            newJack.selectedCortex = cortex.copy()
        }
        if let arm1 = self.selectedArm1 {
            newJack.selectedArm1 = arm1.copy()
        }
        if let arm2 = self.selectedArm2 {
            newJack.selectedArm2 = arm2.copy()
        }
        if let shoulder1 = self.selectedShoulder1 {
            newJack.selectedShoulder1 = shoulder1.copy()
        }
        if let shoulder2 = self.selectedShoulder2 {
            newJack.selectedShoulder2 = shoulder2.copy()
        }
        self.rules!.allObjects.forEach { rule in
            let newRule = (rule as! Rule)
            newJack.addToRules(newRule.copy())
        }
        self.weapons!.allObjects.forEach { weapon in
            let newWeapon = (weapon as! Weapon)
            newJack.addToWeapons(newWeapon.copy())
        }
        self.customJacks!.allObjects.forEach { jack in
            let newCustomJack = (jack as! Jack)
            newJack.addToCustomJacks(newCustomJack.copy())
        }
        return newJack
    }
}

extension Cortex {
    public func copy() -> Cortex {
        let newCortex = Cortex(context: managedObjectContext!)
        newCortex.id = self.id
        newCortex.name = self.name
        newCortex.selected = self.selected
        self.rules!.allObjects.forEach { rule in
            let newRule = (rule as! Rule)
            newCortex.addToRules(newRule.copy())
        }
        return newCortex
    }
}

extension Weapon {
    public func copy() -> Weapon {
        let newWeapon = Weapon(context: managedObjectContext!)
        newWeapon.uuid = UUID().uuidString
        newWeapon.id = self.id
        newWeapon.name = self.name
        newWeapon.cost = self.cost
        newWeapon.cost = self.cost
        newWeapon.pow = self.pow
        newWeapon.rng = self.rng
        newWeapon.type = self.type
        newWeapon.selected = self.selected
        self.elements!.allObjects.forEach { element in
            let newElement = (element as! Element)
            newWeapon.addToElements(newElement.copy())
        }
        self.rules!.allObjects.forEach { rule in
            let newRule = (rule as! Rule)
            newWeapon.addToRules(newRule.copy())
        }
        return newWeapon
    }
}

extension Rule {
    public func copy() -> Rule {
        let newRule = Rule(context: managedObjectContext!)
        newRule.id = self.id
        newRule.name = self.name
        newRule.text = self.text
        return newRule
    }
}

extension Element {
    public func copy() -> Element {
        let newElement = Element(context: managedObjectContext!)
        newElement.name = self.name
        return newElement
    }
}

extension Cypher {
    public func copy() -> Cypher {
        let newCypher = Cypher(context: managedObjectContext!)
        newCypher.name = self.name
        newCypher.id = self.id
        newCypher.pow = self.pow
        newCypher.rule = self.rule
        newCypher.type = self.type
        newCypher.selected = self.selected
        return newCypher
    }
}
