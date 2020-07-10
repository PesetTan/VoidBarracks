//
//  ClipboardController.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/6/20.
//

import Foundation
import UIKit

struct ClipboardController {

    public static func copyToClipboard(_ army: Army) {
        var text: String = "Void Barracks: \(army.customName!)\n"
//        Counter.UpdateArmy(army: self)

        // copy heros
        if (army.heroCount > 0) {
            text.append("\nHeros: \(army.heroCount)/\(army.heroMax)\n")
            (army.heros as! Set<Hero>).sorted{$0.id! < $1.id!}.forEach { hero in
                if hero.count > 0 {
                    text.append("x\(hero.count) \(hero.name!)\n")
                }
            }
        }

        text.append("\nUnits: \(army.unitCount)/\(army.unitMax)\n")

        (army.solos as! Set<Solo>).sorted{$0.id! < $1.id!}.forEach { solo in
            if solo.count > 0 {
                text.append("x\(solo.count) \(solo.name!)\n")
            }
        }

        (army.jacks as! Set<Jack>).sorted{$0.id! < $1.id!}.forEach { jack in
            (jack.customJacks as! Set<Jack>).sorted{$0.id! < $1.id!}.forEach { configured in
                if configured.count > 0 {
                    text.append("x\(configured.count) \(configured.name!)\n")
                    if (configured.optionsForCortex as! Set<Cortex>).first(where: {$0.selected}) != nil {
                        let selectedCortex = (configured.optionsForCortex as! Set<Cortex>).first{$0.selected}!
                        text.append("\tCortex: \(selectedCortex.name!)\n")
                    }
                    if (configured.optionsForArm1 as! Set<Weapon>).first(where: {$0.selected}) != nil {
                        let selectedArm1 = (configured.optionsForArm1 as! Set<Weapon>).first{$0.selected}!
                        text.append("\tArm 2: \(selectedArm1.name!)  \(selectedArm1.cost) points\n")
                    }
                    if (configured.optionsForArm2 as! Set<Weapon>).first(where: {$0.selected}) != nil {
                        let selectedArm2 = (configured.optionsForArm2 as! Set<Weapon>).first{$0.selected}!
                        text.append("\tArm 1: \(selectedArm2.name!)  \(selectedArm2.cost) points\n")
                    }
                    if (configured.optionsForShoulder1 as! Set<Weapon>).first(where: {$0.selected}) != nil {
                        let selectedShoulder1 = (configured.optionsForShoulder1 as! Set<Weapon>).first{$0.selected}!
                        text.append("\tArm 1: \(selectedShoulder1.name!)  \(selectedShoulder1.cost) points\n")
                    }
                    if (configured.optionsForShoulder2 as! Set<Weapon>).first(where: {$0.selected}) != nil {
                        let selectedShoulder2 = (configured.optionsForShoulder2 as! Set<Weapon>).first{$0.selected}!
                        text.append("\tArm 1: \(selectedShoulder2.name!)  \(selectedShoulder2.cost) points\n")
                    }
                }
            }
        }

        (army.squads as! Set<Squad>).sorted{$0.id! < $1.id!}.forEach { squad in
            (squad.customSquads as! Set<Squad>).sorted{$0.id! < $1.id!}.forEach { configured in
                if (configured.count > 0) {
                    if configured.customName! == "" {
                        text.append("x\(configured.count) \(configured.name!):\n")
                    } else {
                        text.append("x\(configured.count) \(configured.customName!):\n")
                    }

                    text.append("\tSquad Type: \(squad.name!)\n")
                    var index = 1
                    (configured.attachments as! Set<Attachment>).sorted{$0.id! < $1.id!}.forEach { attachment in
                        if (attachment.count > 0) {
                            text.append("\tAttachment \(index): \(attachment.name!)\n")
                            index += 1
                        }
                    }
                }
            }
        }

        UIPasteboard.general.string = text
    }
}
