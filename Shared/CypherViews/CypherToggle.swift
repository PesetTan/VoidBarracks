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
    @EnvironmentObject var army: ArmyViewModel

    var body: some View {
        HStack {
            ForEach(0 ..< maxCount) { index in
                if index >= viewModel.count {
                    Image(systemName: "circle").foregroundColor(.gray).opacity(0.5)
                } else {
                    Image(systemName: "circle.fill").foregroundColor(.accentColor)
                }
            }
        }
        .onTapGesture {
            let rack = army.rackViewModel!

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

            if army.store != nil {
                army.store = army.store
            }

        }
    }
}

