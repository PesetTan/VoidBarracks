//
//  LoadJson.swift
//  VoidBarracks
//
//  Created by Peset Tan on 6/11/20.
//  Copyright © 2020 WarTracker. All rights reserved.
//

import Foundation
import CoreData
import Combine
import os

class WarcasterStore: ObservableObject {
    let logger = Logger(subsystem: "VoidBarracks", category: "WarcasterStore")
    let context: NSManagedObjectContext
    let json = GetJson()
    var rawRules: [ULRule] = []
    var rawWeapons: [ULWeapon] = []
    var rawCortex: [ULCortex] = []
    var rawHeros: [ULUnit] = []
    var rawJacks: [ULJack] = []
    var rawAlliance: [ULUnit] = []
    var rawContinuum: [ULUnit] = []
    var rawMarchers: [ULUnit] = []
    var rawCyphers: [ULCypher] = []
    var rawFactions: [ULFaction] = []

    @Published var storeUpdated = false;

    private var cancellables = Set<AnyCancellable>()

    init(_ context: NSManagedObjectContext) {
        self.context = context
    }

    func updateStore() {
        storeUpdated = false

        Publishers.CombineLatest3(json.$factions, json.$rules, json.$weapons)
            .filter { (factions, rules, weapons) in
                !factions.isEmpty && !rules.isEmpty && !weapons.isEmpty
            }
            .sink { [self] (factions, rules, weapons) in
                self.rawFactions = factions
                self.rawRules = rules
                self.rawWeapons = weapons

//                populateRules(rules)

                Publishers.CombineLatest3(self.json.$heros, self.json.$jacks, self.json.$weapons)
                    .filter { (heros, jacks, weapons) in
                        !heros.isEmpty && !jacks.isEmpty && !weapons.isEmpty
                    }
                    .sink {(heros, jacks, weapons)  in
                        self.rawHeros = heros
                        self.rawJacks = jacks
                        self.rawWeapons = weapons

                        Publishers.CombineLatest3(self.json.$allianceUnits, self.json.$continuumUnits, self.json.$marcherUnits)
                            .filter { (alliance, continuum, marchers) in
                                !alliance.isEmpty && !continuum.isEmpty && !marchers.isEmpty
                            }
                            .sink {(alliance, continuum, marchers) in
                                self.rawAlliance = alliance
                                self.rawContinuum = continuum
                                self.rawMarchers = marchers

                                Publishers.CombineLatest(self.json.$cortex, self.json.$cyphers)
                                    .filter{ cortex, cyphers in
                                        !cortex.isEmpty && !cyphers.isEmpty
                                    }
                                    .sink { cortex, cyphers in
                                        self.rawCortex = cortex
                                        self.rawCyphers = cyphers

                                        PersistentCloudKitContainer.deleteContext()
//
//                                        PersistentCloudKitContainer.deleteArmies()
//                                        PersistentCloudKitContainer.deleteFactions()
//                                        PersistentCloudKitContainer.deleteWeapons()
//                                        PersistentCloudKitContainer.deleteCortex()

                                        sleep(4)
                                        let store = self.GetStore()
                                        self.context.insert(store)
                                        self.context.refresh(store, mergeChanges: true)
                                        sleep(1)
                                        try! self.context.save()
                                        self.storeUpdated = true
                                    }
                                    .store(in: &self.cancellables)
                            }
                            .store(in: &self.cancellables)
                    }
                    .store(in: &self.cancellables)


            }
            .store(in: &self.cancellables)
    }

    private func GetStore() -> Store {
        let store: Store = Store(context: self.context)
        store.uuid = UUID().uuidString
        store.lastSourceUpdate = Date()//.addingTimeInterval(5000)
        store.updateAvailable = false
        store.addToArmies(GetArmy(for: "IRON_STAR_ALLIANCE"))
        store.addToArmies(GetArmy(for: "AETERNUS_CONTINUUM"))
        store.addToArmies(GetArmy(for: "MARCHER_WORLDS"))
        return store
    }

    private func GetArmy(for factionId: String) -> Army {
        let army: Army = Army(context: self.context)
        let raw: ULFaction = rawFactions.first{$0.id == factionId}!
        army.id = UUID().uuidString
        army.name = raw.name
        army.shortName = raw.shortName

        var symbol = "circle"
        switch factionId {
            case "IRON_STAR_ALLIANCE": symbol = "circle"
            case "AETERNUS_CONTINUUM": symbol = "triangle"
            case "MARCHER_WORLDS": symbol = "square"
            default: symbol = "circle"
        }

        army.addToHeros(GetHeros(for: factionId, withSymbol: symbol))
        army.addToSolos(GetSolos(for: factionId, withSymbol: symbol))
        army.addToJacks(GetJacks(for: factionId, withSymbol: symbol))
        army.addToSquads(GetSquads(for: factionId, withSymbol: symbol))
        army.rack = GetRack(withSymbol: symbol)
        return army
    }

    private func GetSquads(for factionId: String, withSymbol symbol: String) -> NSSet {
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
            squad.symbol = symbol
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
                    squad.addToWeapons(GetWeapon(weaponId, withSymbol: symbol))
                }
            }
            raw.ruleIds.forEach { ruleId in
                squad.addToRules(GetRule(ruleId))
            }
            if let attachmentIds = raw.attachmentIds {
                attachmentIds.forEach { attachmentId in
                    squad.addToAttachments(GetAttachment(for: factionId, with: attachmentId, withSymbol: symbol))
                }
            }

            squads.append(squad)
        }

        return NSSet(array: squads)
    }

    private func GetAttachment(for factionId: String, with squadId: String, withSymbol symbol: String) -> Attachment {
        var rawUnits: [ULUnit]
        switch factionId {
            case "AETERNUS_CONTINUUM": rawUnits = rawContinuum
            case "IRON_STAR_ALLIANCE": rawUnits = rawAlliance
            case "MARCHER_WORLDS": rawUnits = rawMarchers
            default: rawUnits = rawContinuum
        }

        let raw: ULUnit = rawUnits.first{$0.id == squadId}!
        let squad: Attachment = Attachment(context: self.context)
        squad.symbol = symbol
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
                squad.addToWeapons(GetWeapon(weaponId, withSymbol: symbol))
            }
        }
        raw.ruleIds.forEach { ruleId in
            squad.addToRules(GetRule(ruleId))
        }

        return squad
    }

    private func GetJacks(for factionId: String, withSymbol symbol: String) -> NSSet {
        var jacks: [Jack] = []
        let faction = rawFactions.first{$0.id == factionId}!
        faction.jackIds.forEach { jackId in
            let raw: ULJack = rawJacks.first{$0.id == jackId}!
            let jack: Jack = Jack(context: self.context)
            jack.symbol = symbol
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
                    jack.addToWeapons(GetWeapon(weaponId, withSymbol: symbol))
                }
            }
            raw.ruleIds.forEach { ruleId in
                jack.addToRules(GetRule(ruleId))
            }
            raw.cortexOptionIds.forEach { cortexId in
                jack.addToOptionsForCortex(GetCortex(cortexId, withSymbol: symbol))
            }
            if raw.armCount > 0 {
                raw.armOptionIds.forEach { weaponId in
                    jack.addToOptionsForArm1(GetWeapon(weaponId, withSymbol: symbol))
                }
            }
            if raw.armCount > 1 {
                raw.armOptionIds.forEach { weaponId in
                    jack.addToOptionsForArm2(GetWeapon(weaponId, withSymbol: symbol))
                }
            }
            if raw.shoulderCount > 0 {
                raw.shoulderOptionIds.forEach { weaponId in
                    jack.addToOptionsForShoulder1(GetWeapon(weaponId, withSymbol: symbol))
                }
            }
            if raw.shoulderCount > 1 {
                raw.shoulderOptionIds.forEach { weaponId in
                    jack.addToOptionsForShoulder2(GetWeapon(weaponId, withSymbol: symbol))
                }
            }

            jacks.append(jack)
        }

        return NSSet(array: jacks)
    }

    private func GetSolos(for factionId: String, withSymbol symbol: String) -> NSSet {
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
            solo.symbol = symbol
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
                    solo.addToWeapons(GetWeapon(weaponId, withSymbol: symbol))
                }
            }
            raw.ruleIds.forEach { ruleId in
                solo.addToRules(GetRule(ruleId))
            }

            solos.append(solo)
        }

        return NSSet(array: solos)
    }

    private func GetHeros(for factionId: String, withSymbol symbol: String) -> NSSet {
        var heros: [Hero] = []
        let faction = rawFactions.first{$0.id == factionId}!
        faction.heroIds.forEach { heroId in
            let raw: ULUnit = rawHeros.first{$0.id == heroId}!
            let hero: Hero = Hero(context: self.context)
            hero.symbol = symbol
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
                    hero.addToWeapons(GetWeapon(weaponId, withSymbol: symbol))
                }
            }
            raw.ruleIds.forEach { ruleId in
                hero.addToRules(GetRule(ruleId))
            }

            heros.append(hero)
        }

        return NSSet(array: heros)
    }

    private func GetRack(withSymbol symbol: String) -> Rack{
        let rack: Rack = Rack(context: self.context)
        self.rawCyphers.forEach { raw in
            let cypher = Cypher(context: context)
            cypher.symbol = symbol
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

    private func GetCortex(_ id: String, withSymbol symbol: String) -> Cortex {
        let raw = self.rawCortex.first{$0.id == id}!
        let cortex = Cortex(context: self.context)
        cortex.symbol = symbol
        cortex.id = raw.id
        cortex.name = raw.name
        raw.ruleIds.forEach { id in
            cortex.addToRules(GetRule(id))
        }

        return cortex
    }

    private func GetWeapon(_ id: String, withSymbol symbol: String) -> Weapon {
        let raw = self.rawWeapons.first{$0.id == id}!
        let weapon = Weapon(context: self.context)
        weapon.symbol = symbol
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

        if let multiWeaponIds = raw.multiWeaponIds {
            multiWeaponIds.forEach { weaponId in
                weapon.addToAttachments(GetWeapon(weaponId, withSymbol: symbol))
            }
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
        let raw = self.rawRules.first{$0.id == id}!
        let rule = Rule(context: self.context)
        rule.id = raw.id
        rule.name = raw.name
        rule.text = raw.rule

        return rule
    }
    
}
