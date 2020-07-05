//
//  CypherToggle.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/3/20.
//

import SwiftUI

struct CypherToggle: View {
    @ObservedObject var cypher: Cypher
    var maxCount: Int = 1
    @EnvironmentObject var army: Army

    var body: some View {
        HStack {
            ForEach(0 ..< maxCount) { index in
                if index >= cypher.count {
                    Image(systemName: "circle").foregroundColor(.gray).opacity(0.5)
                } else {
                    Image(systemName: "circle.fill").foregroundColor(.accentColor)
                }
            }
        }
        .onTapGesture {
            let rack = army.rack!

            cypher.count += 1
            if cypher.count > maxCount {
                cypher.count = 0
            }

            if cypher.count == 1 {
                switch cypher.type {
                    case "FURY": rack.furyCount += 1
                    case "GEOMETRIC": rack.geometricCount += 1
                    case "HARMONIC": rack.harmonicCount += 1
                    case "OVERDRIVE": rack.overdriveCount += 1
                    default: rack.overdriveCount += 1
                }
            } else {
                switch cypher.type {
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

            if army.user != nil {
                army.user!.armies = army.user!.armies
            }

        }
    }
}

