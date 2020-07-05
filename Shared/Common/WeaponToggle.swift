//
//  WeaponToggle.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/3/20.
//

import SwiftUI

struct WeaponToggle: View {
    @Binding var selected: Bool
    @ObservedObject var weapon: Weapon
    var group: Set<Weapon>
    @ObservedObject var jack: Jack

    var body: some View {
        HStack {
            if selected {
                Image(systemName: "circle.fill").foregroundColor(.accentColor)
            } else {
                Image(systemName: "circle.fill").foregroundColor(.gray).opacity(0.2)
            }
        }
        .onTapGesture {
            let initiallySelected = selected
            group.forEach { item in
                if item.selected {
                    item.selected = false
                    return
                }
            }

            selected = !initiallySelected

            jack.remainingPoints = jack.weaponPoints

            (jack.optionsForArm1 as! Set<Weapon>).forEach { item in
                if item.selected {
                    jack.remainingPoints -= item.cost
                    print("remaining:\(jack.remainingPoints) taking:\(item.cost) forArm1")
                }
            }

            (jack.optionsForArm2 as! Set<Weapon>).forEach { item in
                if item.selected {
                    jack.remainingPoints -= item.cost
                    print("remaining:\(jack.remainingPoints) taking:\(item.cost) forArm2")
                }
            }

            (jack.optionsForShoulder1 as! Set<Weapon>).forEach { item in
                if item.selected {
                    jack.remainingPoints -= item.cost
                    print("remaining:\(jack.remainingPoints) taking:\(item.cost) forShoulder1")
                }
            }

            (jack.optionsForShoulder2 as! Set<Weapon>).forEach { item in
                if item.selected {
                    jack.remainingPoints -= item.cost
                    print("remaining:\(jack.remainingPoints) taking:\(item.cost) forShoulder2")
                }
            }

            jack.optionsForArm1 = jack.optionsForArm1
            jack.optionsForArm2 = jack.optionsForArm2
            jack.optionsForShoulder1 = jack.optionsForShoulder1
            jack.optionsForShoulder2 = jack.optionsForShoulder2


        }
    }
}

