//
//  UnitCounter.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/2/20.
//

import SwiftUI

struct UnitCounter: View {
    @ObservedObject var unit: Unit
    @EnvironmentObject var army: Army
    var maxCount: Int = 3

    var body: some View {
        HStack {
            ForEach((0 ..< maxCount).reversed(), id:\.self) { index in
                if index >= unit.count {
                    Image(systemName: "circle").foregroundColor(.gray).opacity(0.5)
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

            if unit is Hero {
                var heroCount: Int16 = 0
                (army.heros as! Set<Hero>).forEach { hero in
                    heroCount += hero.count
                }
                army.heroCount = heroCount
            }
        }
    }

}
