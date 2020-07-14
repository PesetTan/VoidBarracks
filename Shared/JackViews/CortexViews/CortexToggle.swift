//
//  CortexToggle.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/3/20.
//

import SwiftUI

struct CortexToggle: View {
    @Binding var count: Int16
    @ObservedObject var jackViewModel: JackViewModel
    @EnvironmentObject var armyViewModel: ArmyViewModel

    var body: some View {
        HStack {
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
            jackViewModel.cortexOptionsArray.forEach { item in
                item.count = 0
            }
            count = 1

            jackViewModel.cortexOptions = jackViewModel.cortexOptions
        }
    }
}
