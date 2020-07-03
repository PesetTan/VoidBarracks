//
//  StatsView.swift
//  VoidBarracks
//
//  Created by Peset Tan on 6/30/20.
//

import SwiftUI

struct UnitStats: View {
    var unit: Unit

    var body: some View {
        HStack {
            if let jack = unit as? Jack {
                VStack{
                    Text("STR").font(.headline).foregroundColor(.gray)
                    Text("\(jack.str)")
                }

                Divider().frame(height: 40)
            }
            
            VStack {
                Text("SPD").font(.headline).foregroundColor(.gray)
                Text("\(unit.spd)")
            }
            VStack {
                Text("MAT").font(.headline).foregroundColor(.gray)
                Text("\(unit.mat)")
            }
            VStack {
                Text("RAT").font(.headline).foregroundColor(.gray)
                Text("\(unit.rat)")
            }
            VStack {
                Text("DEF").font(.headline).foregroundColor(.gray)
                Text("\(unit.def)")
            }
            VStack {
                Text("ARM").font(.headline).foregroundColor(.gray)
                Text("\(unit.arm)")
            }

            Divider().frame(height: 40)

            if unit.foc > 0 {
                VStack{
                    Text("FOC").font(.headline).foregroundColor(.gray)
                    Text("\(unit.foc)")
                }
            }

            VStack{
                Text("DMG").font(.headline).foregroundColor(.gray)
                Text("\(unit.dmg)")
            }
        }
    }
}
