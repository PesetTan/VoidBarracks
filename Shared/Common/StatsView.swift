//
//  StatsView.swift
//  VoidBarracks
//
//  Created by Peset Tan on 6/30/20.
//

import SwiftUI

struct StatsView: View {
    var spd: Int16
    var mat: Int16
    var rat: Int16
    var def: Int16
    var arm: Int16

    var body: some View {
        HStack {
            VStack {
                Text("SPD").font(.headline).foregroundColor(.gray)
                Text("\(spd)")
            }
            VStack {
                Text("MAT").font(.headline).foregroundColor(.gray)
                Text("\(mat)")
            }
            VStack {
                Text("RAT").font(.headline).foregroundColor(.gray)
                Text("\(rat)")
            }
            VStack {
                Text("DEF").font(.headline).foregroundColor(.gray)
                Text("\(def)")
            }
            VStack {
                Text("ARM").font(.headline).foregroundColor(.gray)
                Text("\(arm)")
            }
        }
    }
}
