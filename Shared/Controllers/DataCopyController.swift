//
//  DataController.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/1/20.
//

import Foundation
import CoreData

extension ArmyViewModel {
    public func copy() -> ArmyViewModel {
        let newArmy = ArmyViewModel(context: managedObjectContext!)
        newArmy.id = UUID().uuidString
        newArmy.fullName = self.fullName
        newArmy.factionId = self.factionId
        newArmy.customName = self.customName
        newArmy.shortName = self.shortName
        newArmy.lastModified = Date()
        newArmy.heroCount = self.heroCount
        newArmy.heroMax = self.heroMax
        newArmy.unitCount = self.unitCount
        newArmy.unitMax = self.unitMax
        newArmy.gameType = self.gameType
        newArmy.symbol = self.symbol
        self.herosViewModelsArray.forEach { hero in
            newArmy.addToHerosViewModels(hero.copy())
        }

        self.solosViewModelsArray.forEach { solo in
            newArmy.addToSolosViewModels(solo.copy())
        }

        self.jacksViewModelsArray.forEach { jack in
            newArmy.addToJacksViewModels(jack.copy())
        }

        self.squadsViewModelsArray.forEach { squad in
            newArmy.addToSquadsViewModels(squad.copy())
        }

        let newRack = CypherViewModel(context: managedObjectContext!)
        newRack.furyCount = self.rackViewModel!.furyCount
        newRack.geometricCount = self.rackViewModel!.geometricCount
        newRack.harmonicCount = self.rackViewModel!.harmonicCount
        newRack.overdriveCount = self.rackViewModel!.overdriveCount
        self.rackViewModel!.furiesArray.forEach { cypher in
            newRack.addToFuries(cypher.copy())
        }
        self.rackViewModel!.geometricsArray.forEach { cypher in
            newRack.addToGeometrics(cypher.copy())
        }
        self.rackViewModel!.harmonicsArray.forEach { cypher in
            newRack.addToHarmonics(cypher.copy())
        }
        self.rackViewModel!.overdrivesArray.forEach { cypher in
            newRack.addToOverdrives(cypher.copy())
        }

        newArmy.rackViewModel = newRack

        return newArmy
    }
}

extension HeroViewModel {
    public func copy() -> HeroViewModel {
        let newHero = HeroViewModel(context: managedObjectContext!)
        newHero.id = self.id
        newHero.name = self.name
        newHero.count = self.count
        newHero.uuid = UUID().uuidString
        return newHero
    }
}

extension SoloViewModel {
    public func copy() -> SoloViewModel {
        let newSolo = SoloViewModel(context: managedObjectContext!)
        newSolo.id = self.id
        newSolo.name = self.name
        newSolo.count = self.count
        newSolo.uuid = UUID().uuidString

        return newSolo
    }
}

extension SquadViewModel {
    public func copy() -> SquadViewModel {
        let newSquad = SquadViewModel(context: managedObjectContext!)
        newSquad.uuid = UUID().uuidString
        newSquad.customName = self.customName
        newSquad.lastModified = self.lastModified
        newSquad.id = self.id
        newSquad.name = self.name
        newSquad.count = self.count

        self.attachmentViewModelsArray.forEach { attachment in
            newSquad.addToAttachmentViewModels(attachment.copy())
        }
        self.customSquadViewModelsArray.forEach { squad in
            newSquad.addToCustomSquadViewModels(squad.copy())
        }
        return newSquad
    }
}

extension AttachmentViewModel {
    public func copy() -> AttachmentViewModel {
        let newAttachment = AttachmentViewModel(context: managedObjectContext!)
        newAttachment.id = self.id
        newAttachment.name = self.name
        newAttachment.count = self.count
        return newAttachment
    }
}

extension JackViewModel {
    public func copy() -> JackViewModel {
        let newJack = JackViewModel(context: managedObjectContext!)
        newJack.uuid = UUID().uuidString
        newJack.customName = self.customName
        newJack.lastModified = self.lastModified
        newJack.id = self.id
        newJack.name = self.name
        newJack.count = self.count
        newJack.title = self.title
        newJack.armCount = self.armCount
        newJack.shoulderCount = self.shoulderCount
        newJack.weaponPoints = self.weaponPoints
        self.cortexOptionsArray.forEach { cortex in
            newJack.addToCortexOptions(cortex.copy())
        }
        self.arm1OptionsArray.forEach { weapon in
            newJack.addToArm1Options(weapon.copy())
        }
        self.arm2OptionsArray.forEach { weapon in
            newJack.addToArm2Options(weapon.copy())
        }
        self.shoulder1OptionsArray.forEach { weapon in
            newJack.addToShoulder1Options(weapon.copy())
        }
        self.shoulder2OptionsArray.forEach { weapon in
            newJack.addToShoulder2Options(weapon.copy())
        }
        self.customJackViewModelsArray.forEach { jack in
            newJack.addToCustomJackViewModels(jack.copy())
        }
        return newJack
    }
}

extension CortexViewModel {
    public func copy() -> CortexViewModel {
        let newCortex = CortexViewModel(context: managedObjectContext!)
        newCortex.id = self.id
        newCortex.name = self.name
        newCortex.count = self.count
        return newCortex
    }
}

extension WeaponViewModel {
    public func copy() -> WeaponViewModel {
        let newWeapon = WeaponViewModel(context: managedObjectContext!)
        newWeapon.uuid = UUID().uuidString
        newWeapon.id = self.id
        newWeapon.name = self.name
        newWeapon.cost = self.cost
        newWeapon.cost = self.cost
        newWeapon.count = self.count

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

extension CypherViewModel {
    public func copy() -> CypherViewModel {
        let newCypher = CypherViewModel(context: managedObjectContext!)
        newCypher.name = self.name
        newCypher.id = self.id
        newCypher.type = self.type
        newCypher.count = self.count
        return newCypher
    }
}
