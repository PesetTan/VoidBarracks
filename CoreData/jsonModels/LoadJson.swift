//
//  LoadJson.swift
//  VoidBarracks
//
//  Created by Peset Tan on 6/11/20.
//  Copyright © 2020 WarTracker. All rights reserved.
//

import Foundation
import CoreData

class WarcasterData {
    let context: NSManagedObjectContext

    var rawRules: [ULRule]
    var rawWeapons: [ULWeapon]
    var rawCortex: [ULCortex]
    var rawHeros: [ULUnit]
    var rawJacks: [ULJack]
    var rawAlliance: [ULUnit]
    var rawContinuum: [ULUnit]
    var rawMarchers: [ULUnit]
    var rawCyphers: [ULCypher]
    var rawFactions: [ULFaction]

    init(_ persistentContainer: NSPersistentContainer) {
        rawFactions = GetJson.getFactions()!
        rawHeros = GetJson.getHeros()!
        rawJacks = GetJson.getJacks()!
        rawAlliance = GetJson.getAllianceUnits()!
        rawContinuum = GetJson.getContinuumUnits()!
        rawMarchers = GetJson.getMarchersUnits()!
        rawCortex = GetJson.getCortex()!
        rawWeapons = GetJson.getWeapons()!
        rawRules = GetJson.getRules()!
        rawCyphers = GetJson.getCyphers()!
        context = persistentContainer.viewContext
        populateRules(rawRules)


    }

    func setStore() {
        context.insert(GetStore())
        try! context.save()
    }

    private func GetStore() -> Store {
        let store: Store = Store(context: self.context)
        store.uuid = UUID().uuidString
        store.addToFactions(GetArmy(for: "IRON_STAR_ALLIANCE"))
        store.addToFactions(GetArmy(for: "AETERNUS_CONTINUUM"))
        store.addToFactions(GetArmy(for: "MARCHER_WORLDS"))

        return store
    }

    private func GetArmy(for factionId: String) -> Army {
        let army: Army = Army(context: self.context)
        let raw: ULFaction = rawFactions.first{$0.id == factionId}!
        army.id = UUID().uuidString
        army.name = raw.name
        army.shortName = raw.shortName
        army.addToHeros(NSSet(array: GetHeros(for: factionId)))
        army.addToSolos(NSSet(array: GetSolos(for: factionId)))
        army.addToJacks(NSSet(array: GetJacks(for: factionId)))
        army.addToSquads(NSSet(array: GetSquads(for: factionId)))
        army.rack = GetRack()

        return army
    }

    private func GetSquads(for factionId: String) -> [Squad] {
        var rawUnits: [ULUnit]
        switch factionId {
            case "AETERNUS_CONTINUUM": rawUnits = rawContinuum
            case "IRON_STAR_ALLIANCE": rawUnits = rawAlliance
            case "MARCHER_WORLDS": rawUnits = rawMarchers
            default: rawUnits = rawContinuum
        }

        var squads: [Squad] = []
        let faction = rawFactions.first{$0.id == factionId}!
        faction.unitIds.forEach { squadId in
            let raw: ULUnit = rawUnits.first{$0.id == squadId}!
            let squad: Squad = Squad(context: self.context)
            squad.uuid = UUID().uuidString
            squad.id = raw.id
            squad.name = raw.name
            squad.customName = ""
            squad.title = raw.title
            squad.cost = Int16(raw.cost)
            squad.spd = Int16(raw.speed!)
            squad.mat = Int16(raw.meleeAttack!)
            squad.rat = Int16(raw.rangeAttack!)
            squad.def = Int16(raw.defense!)
            squad.arm = Int16(raw.armor!)
            squad.foc = Int16(raw.focus ?? 0)
            squad.dmg = Int16(raw.damage)
            if let weaponIds = raw.weaponIds {
                weaponIds.forEach { weaponId in
                    squad.addToWeapons(GetWeapon(weaponId))
                }
            }
            raw.ruleIds.forEach { ruleId in
                squad.addToRules(GetRule(ruleId))
            }
            if let attachmentIds = raw.attachmentIds {
                attachmentIds.forEach { attachmentId in
                    squad.addToAttachments(GetAttachment(for: factionId, with: attachmentId))
                }
            }

            squads.append(squad)
        }

        return squads
    }

    private func GetAttachment(for factionId: String, with squadId: String) -> Attachment {
        var rawUnits: [ULUnit]
        switch factionId {
            case "AETERNUS_CONTINUUM": rawUnits = rawContinuum
            case "IRON_STAR_ALLIANCE": rawUnits = rawAlliance
            case "MARCHER_WORLDS": rawUnits = rawMarchers
            default: rawUnits = rawContinuum
        }

        let raw: ULUnit = rawUnits.first{$0.id == squadId}!
        let squad: Attachment = Attachment(context: self.context)
        squad.id = raw.id
        squad.name = raw.name
        squad.title = raw.title
        squad.cost = Int16(raw.cost)
        squad.spd = Int16(raw.speed!)
        squad.mat = Int16(raw.meleeAttack!)
        squad.rat = Int16(raw.rangeAttack!)
        squad.def = Int16(raw.defense!)
        squad.arm = Int16(raw.armor!)
        squad.foc = Int16(raw.focus ?? 0)
        squad.dmg = Int16(raw.damage)
        if let weaponIds = raw.weaponIds {
            weaponIds.forEach { weaponId in
                squad.addToWeapons(GetWeapon(weaponId))
            }
        }
        raw.ruleIds.forEach { ruleId in
            squad.addToRules(GetRule(ruleId))
        }

        return squad
    }

    private func GetJacks(for factionId: String) -> [Jack] {
        var jacks: [Jack] = []
        let faction = rawFactions.first{$0.id == factionId}!
        faction.jackIds.forEach { jackId in
            let raw: ULJack = rawJacks.first{$0.id == jackId}!
            let jack: Jack = Jack(context: self.context)
            jack.uuid = UUID().uuidString
            jack.id = raw.id
            jack.name = raw.name
            jack.customName = ""
            jack.title = raw.title
            jack.cost = Int16(raw.cost)
            jack.str = Int16(raw.strength!)
            jack.spd = Int16(raw.speed!)
            jack.mat = Int16(raw.meleeAttack!)
            jack.rat = Int16(raw.rangeAttack!)
            jack.def = Int16(raw.defense!)
            jack.arm = Int16(raw.armor!)
            jack.foc = Int16(raw.focus ?? 0)
            jack.dmg = Int16(raw.damage)
            
            jack.weaponPoints = Int16(raw.weaponPoints)
            if let weaponIds = raw.weaponIds {
                weaponIds.forEach { weaponId in
                    jack.addToWeapons(GetWeapon(weaponId))
                }
            }
            raw.ruleIds.forEach { ruleId in
                jack.addToRules(GetRule(ruleId))
            }
            raw.cortexOptionIds.forEach { cortexId in
                jack.addToOptionsForCortex(GetCortex(cortexId))
            }
            if raw.armCount > 0 {
                raw.armOptionIds.forEach { weaponId in
                    jack.addToOptionsForArm1(GetWeapon(weaponId))
                }
            }
            if raw.armCount > 1 {
                raw.armOptionIds.forEach { weaponId in
                    jack.addToOptionsForArm2(GetWeapon(weaponId))
                }
            }
            if raw.shoulderCount > 0 {
                raw.shoulderOptionIds.forEach { weaponId in
                    jack.addToOptionsForShoulder1(GetWeapon(weaponId))
                }
            }
            if raw.shoulderCount > 1 {
                raw.shoulderOptionIds.forEach { weaponId in
                    jack.addToOptionsForShoulder2(GetWeapon(weaponId))
                }
            }

            jacks.append(jack)
        }

        return jacks
    }

    private func GetSolos(for factionId: String) -> [Solo] {
        var rawUnits: [ULUnit]
        switch factionId {
            case "AETERNUS_CONTINUUM": rawUnits = rawContinuum
            case "IRON_STAR_ALLIANCE": rawUnits = rawAlliance
            case "MARCHER_WORLDS": rawUnits = rawMarchers
            default: rawUnits = rawContinuum
        }

        var solos: [Solo] = []
        let faction = rawFactions.first{$0.id == factionId}!
        faction.soloIds.forEach { soloId in
            let raw: ULUnit = rawUnits.first{$0.id == soloId}!
            let solo: Solo = Solo(context: self.context)
            solo.id = raw.id
            solo.name = raw.name
            solo.title = raw.title
            solo.cost = Int16(raw.cost)
            solo.spd = Int16(raw.speed!)
            solo.mat = Int16(raw.meleeAttack!)
            solo.rat = Int16(raw.rangeAttack!)
            solo.def = Int16(raw.defense!)
            solo.arm = Int16(raw.armor!)
            solo.foc = Int16(raw.focus ?? 0)
            solo.dmg = Int16(raw.damage)
            if let weaponIds = raw.weaponIds {
                weaponIds.forEach { weaponId in
                    solo.addToWeapons(GetWeapon(weaponId))
                }
            }
            raw.ruleIds.forEach { ruleId in
                solo.addToRules(GetRule(ruleId))
            }

            solos.append(solo)
        }

        return solos
    }

    private func GetHeros(for factionId: String) -> [Hero] {
        var heros: [Hero] = []
        let faction = rawFactions.first{$0.id == factionId}!
        faction.heroIds.forEach { heroId in
            let raw: ULUnit = rawHeros.first{$0.id == heroId}!
            let hero: Hero = Hero(context: self.context)
            hero.id = raw.id
            hero.name = raw.name
            hero.title = raw.title
            hero.cost = Int16(raw.cost)
            hero.spd = Int16(raw.speed!)
            hero.mat = Int16(raw.meleeAttack!)
            hero.rat = Int16(raw.rangeAttack!)
            hero.def = Int16(raw.defense!)
            hero.arm = Int16(raw.armor!)
            hero.foc = Int16(raw.focus ?? 0)
            hero.dmg = Int16(raw.damage)
            if let weaponIds = raw.weaponIds {
                weaponIds.forEach { weaponId in
                    hero.addToWeapons(GetWeapon(weaponId))
                }
            }
            raw.ruleIds.forEach { ruleId in
                hero.addToRules(GetRule(ruleId))
            }

            heros.append(hero)
        }

        return heros
    }

    private func GetRack() -> Rack{
        let rack: Rack = Rack(context: self.context)
        self.rawCyphers.forEach { raw in
            let cypher = Cypher(context: context)
            cypher.id = raw.id
            cypher.name = raw.name
            cypher.pow = Int16(raw.power ?? -1)
            cypher.type = raw.type
            cypher.rule = raw.rule

            switch cypher.type! {
                case "FURY": rack.addToFuries(cypher)
                case "GEOMETRIC": rack.addToGeometrics(cypher)
                case "HARMONIC": rack.addToHarmonics(cypher)
                case "OVERDRIVE": rack.addToOverdrives(cypher)
                default: rack.addToOverdrives(cypher)
            }
        }

        return rack
    }

    private func GetCortex(_ id: String) -> Cortex {
        let raw = self.rawCortex.first{$0.id == id}!
        let cortex = Cortex(context: self.context)
        cortex.id = raw.id
        cortex.name = raw.name
        raw.ruleIds.forEach { id in
            cortex.addToRules(GetRule(id))
        }

        return cortex
    }

    private func GetWeapon(_ id: String) -> Weapon {
        let raw = self.rawWeapons.first{$0.id == id}!
        let weapon = Weapon(context: self.context)
        weapon.uuid = UUID().uuidString
        weapon.id = raw.id
        weapon.name = raw.name

        if let range = raw.range {
            weapon.rng = Int16(range)
        }

        if let power = raw.power {
            weapon.pow = Int16(power)
        }

        if raw.type == "melee weapon" {
            weapon.type = "Melee Weapon"
        } else {
            weapon.type = "Ranged Weapon"
        }

        raw.elements.forEach { elementString in
            let element = Element(context: self.context)
            element.name = elementString
            weapon.addToElements(element)
        }

        weapon.cost = Int16(raw.cost ?? 0)

        if let ruleIds = raw.ruleIds {
            ruleIds.forEach { id in
                weapon.addToRules(GetRule(id))
            }
        }

        return weapon
    }

    private func GetRule(_ id: String) -> Rule {
//        let fetchRequest: NSFetchRequest<Rule> = Rule.fetchRequest()
//        fetchRequest.predicate = NSPredicate(format: "id = %@", id)
//        let rules = try! context.fetch(fetchRequest)
//
//        if rules.count == 0 {
//            print("MISSING \(id)")
//        }
//
//        context.refreshAllObjects()
//        return rules.first!

        let raw = self.rawRules.first{$0.id == id}!
        let rule = Rule(context: self.context)
        rule.id = raw.id
        rule.name = raw.name
        rule.text = raw.rule

        return rule
    }

    private func populateRules(_ rawRules: [ULRule]) {
        rawRules.forEach { raw in
            let rule = Rule(context: self.context)
            rule.id = raw.id
            rule.name = raw.name
            rule.text = raw.rule

            context.insert(rule)
        }

        try! context.save()

    }
    
}
