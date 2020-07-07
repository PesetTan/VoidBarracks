//
//  HeroSection.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/6/20.
//

import SwiftUI

struct HeroSection: View {
    var army: Army
    
    var body: some View {
        Section(header: heroHeader) {
            if let heros = (army.heros as! Set<Hero>) {
                HeroList(heros: heros.sorted{$0.name! < $1.name!})
                    .environmentObject(army)
                    .customCell()
            }
            Spacer()
        }
        .padding(.leading, 10)
        .padding(.trailing, 10)
    }

    var heroHeader: some View {
        return HStack{
            Image(systemName: "star")
            Text("Heros")
            Spacer()
            if army.heroCount > army.heroMax {
                if army.heroCount - army.heroMax == 1 {
                    Text("\(army.heroCount - army.heroMax) Hero Point Over")
                        .font(.caption)
                } else {
                    Text("\(army.heroCount - army.heroMax) Hero Points Over")
                        .font(.caption)
                }
            } else {
                Text("\(army.heroCount)/\(army.heroMax) Heros")
                    .font(.caption)
            }

        }
    }
}
