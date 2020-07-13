//
//  ClipboardController.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/6/20.
//

import Foundation
import UIKit
import CoreData

class ClipboardController {
//    var fetchRequst: FetchRequest<Army>

//    var army: Army {
//        fetchRequst.wrappedValue.first ?? Army()
//    }

//    let viewModel: ArmyViewModel
//    let army: Army
//
//    init(_ viewModel: ArmyViewModel, context: NSManagedObjectContext) {
//        self.viewModel = viewModel
//        let fetchRequst: NSFetchRequest<Army> = Army.fetchRequest()
//        fetchRequst.predicate = NSPredicate(format: "id == %@", viewModel.factionId!)
//        self.army = context.fetch(fetchRequst).first!
//    }

    public static func copyToClipboard(_ viewModel: ArmyViewModel) {
        var text: String = "Void Barracks: \(viewModel.customName!)\n"

        // copy heros
        if (viewModel.heroCount > 0) {
            text.append("\nHeros: \(viewModel.heroCount)/\(viewModel.heroMax)\n")
            viewModel.herosViewModelsArray.forEach { hero in
                if hero.count > 0 {
                    text.append("x\(hero.count) \(hero.name!)\n")
                }
            }
        }

        text.append("\nUnits: \(viewModel.unitCount)/\(viewModel.unitMax)\n")

        viewModel.solosViewModelsArray.forEach { solo in
            if solo.count > 0 {
                text.append("x\(solo.count) \(solo.name!)\n")
            }
        }

        viewModel.jacksViewModelsArray.forEach { jack in
            jack.customJackViewModelsArray.forEach { configured in
                if configured.count > 0 {
                    text.append("x\(configured.count) \(configured.name!)\n")

                    let selectedCortex = configured.cortexOptionsArray.first{$0.count > 0}!
                    text.append("\tCortex: \(selectedCortex.name!)\n")

                    let selectedArm1 = configured.arm1OptionsArray.first{$0.count > 0}!
                    text.append("\tArm 2: \(selectedArm1.name!)  \(selectedArm1.cost) points\n")

                    let selectedArm2 = configured.arm2OptionsArray.first{$0.count > 0}!
                    text.append("\tArm 1: \(selectedArm2.name!)  \(selectedArm2.cost) points\n")

                    let selectedShoulder1 = configured.shoulder1OptionsArray.first{$0.count > 0}!
                    text.append("\tArm 1: \(selectedShoulder1.name!)  \(selectedShoulder1.cost) points\n")

                    let selectedShoulder2 = configured.shoulder2OptionsArray.first{$0.count > 0}!
                    text.append("\tArm 1: \(selectedShoulder2.name!)  \(selectedShoulder2.cost) points\n")

                }
            }
        }

        viewModel.squadsViewModelsArray.forEach { squad in
            squad.customSquadViewModelsArray.forEach { configured in
                if (configured.count > 0) {
                    if configured.customName! == "" {
                        text.append("x\(configured.count) \(configured.name!):\n")
                    } else {
                        text.append("x\(configured.count) \(configured.customName!):\n")
                    }

                    text.append("\tSquad Type: \(squad.name!)\n")
                    var index = 1
                    configured.attachmentViewModelsArray.forEach { attachment in
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
