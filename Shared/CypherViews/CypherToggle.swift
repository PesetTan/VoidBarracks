//
//  CypherToggle.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/3/20.
//

import SwiftUI

struct CypherToggle: View {
    @ObservedObject var viewModel: CypherViewModel
    var maxCount: Int = 1
    @EnvironmentObject var armyViewModel: ArmyViewModel

    var body: some View {
        HStack {
            if let symbol = armyViewModel.symbol {
                ForEach((0 ..< maxCount).reversed(), id:\.self) { index in
                    if index >= viewModel.count {
                        Image("\(symbol)").foregroundColor(.gray).opacity(0.5)
                    } else {
                        Image("\(symbol).fill").foregroundColor(.accentColor)
                    }
                }
            } else {
                ForEach((0 ..< maxCount).reversed(), id:\.self) { index in
                    if index >= viewModel.count {
                        Image("circle").foregroundColor(.gray).opacity(0.5)
                    } else {
                        Image("circle.fill").foregroundColor(.accentColor)
                    }
                }
            }
        }
        .onTapGesture {
            let rack = armyViewModel.rackViewModel!

            viewModel.count += 1
            if viewModel.count > maxCount {
                viewModel.count = 0
            }

            if viewModel.count == 1 {
                switch viewModel.type {
                    case "FURY": rack.furyCount += 1
                    case "GEOMETRIC": rack.geometricCount += 1
                    case "HARMONIC": rack.harmonicCount += 1
                    case "OVERDRIVE": rack.overdriveCount += 1
                    default: rack.overdriveCount += 1
                }
            } else {
                switch viewModel.type {
                    case "FURY": rack.furyCount -= 1
                    case "GEOMETRIC": rack.geometricCount -= 1
                    case "HARMONIC": rack.harmonicCount -= 1
                    case "OVERDRIVE": rack.overdriveCount -= 1
                    default: rack.overdriveCount -= 1
                }
            }

            if armyViewModel.store != nil {
                armyViewModel.store = armyViewModel.store
            }

        }
    }
}

