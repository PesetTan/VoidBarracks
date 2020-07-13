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

    var body: some View {
        HStack {
            Text("\(weaponViewModel.cost) points")
                .font(.caption)
                .foregroundColor(.gray)

            if count > 0 {
                Image(systemName: "circle.fill").foregroundColor(.accentColor)
            } else {
                Image(systemName: "circle.fill").foregroundColor(.gray).opacity(0.2)
            }
        }
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

