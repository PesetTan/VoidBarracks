//
//  WeaponToggle.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/3/20.
//

import SwiftUI

struct WeaponToggle: View {
    @Binding var count: Int16
    @ObservedObject var weaponViewModel: WeaponViewModel
    var groupViewModel: [WeaponViewModel]
    @ObservedObject var jackViewModel: JackViewModel
    @EnvironmentObject var armyViewModel: ArmyViewModel

    var body: some View {
        HStack {
            Text("\(weaponViewModel.cost) points")
                .font(.caption)
                .foregroundColor(.gray)

            if let symbol = armyViewModel.symbol {

                    if count > 0 {
                        Image("\(symbol).fill").foregroundColor(.accentColor)
                    } else {
                        Image("\(symbol).fill").foregroundColor(.gray).opacity(0.2)
                    }

            } else {

                    if count > 0 {
                        Image("circle.fill").foregroundColor(.accentColor)
                    } else {
                        Image("circle.fill").foregroundColor(.gray).opacity(0.2)
                    }

            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            let initialCount = count
            groupViewModel.forEach { item in
                if item.count > 0{
                    item.count = 0
                    return
                }
            }

            count = initialCount == 0 ? 1:0

            jackViewModel.remainingPoints = jackViewModel.weaponPoints

            jackViewModel.arm1OptionsArray.forEach { item in
                if item.count > 0 {
                    jackViewModel.remainingPoints -= item.cost
                }
            }

            jackViewModel.arm2OptionsArray.forEach { item in
                if item.count > 0 {
                    jackViewModel.remainingPoints -= item.cost
                }
            }

            jackViewModel.shoulder1OptionsArray.forEach { item in
                if item.count > 0 {
                    jackViewModel.remainingPoints -= item.cost
                }
            }

            jackViewModel.shoulder2OptionsArray.forEach { item in
                if item.count > 0 {
                    jackViewModel.remainingPoints -= item.cost
                }
            }

            jackViewModel.arm1Options = jackViewModel.arm1Options
            jackViewModel.arm2Options = jackViewModel.arm2Options
            jackViewModel.shoulder1Options = jackViewModel.shoulder1Options
            jackViewModel.shoulder2Options = jackViewModel.shoulder2Options


        }
    }
}

