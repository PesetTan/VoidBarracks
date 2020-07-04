//
//  UnitCounter.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/2/20.
//

import SwiftUI

struct UnitCounter: View {
    @ObservedObject var unit: Unit
    var maxCount: Int = 3

    var body: some View {
        HStack {
            ForEach((0 ..< maxCount).reversed(), id:\.self) { index in
                if index >= unit.count {
                    Image(systemName: "circle").foregroundColor(.gray).opacity(0.35)
                } else {
                    Image(systemName: "circle.fill").foregroundColor(.accentColor)

                }
            }

        }
        .onTapGesture {
            unit.count += 1
            if unit.count > maxCount {
                unit.count = 0
            }
        }
    }

}
