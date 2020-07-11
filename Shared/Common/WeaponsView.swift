//
//  WeaponsView.swift
//  VoidBarracks
//
//  Created by Peset Tan on 6/30/20.
//

import SwiftUI

struct WeaponsView: View {
    var weapons: [Weapon]

    var body: some View {
        VStack {
            ForEach(weapons, id:\.id) { weapon in
                Divider()
                WeaponView(weapon: weapon).padding()
            }
        }
    }
}

struct WeaponView: View {
    var weapon: Weapon

    var body: some View {
        VStack {
            Text("\(weapon.type!.uppercased())").font(.headline).foregroundColor(.gray)

            HStack {
                Text("\(weapon.name!)")

                if weapon.rng > 0 {
                    VStack {
                        Text("RNG").font(.subheadline).foregroundColor(.gray)
                        Text("\(weapon.rng)")
                    }
                }

                if weapon.pow > 0 {
                    VStack {
                        Text("POW").font(.subheadline).foregroundColor(.gray)
                        Text("\(weapon.pow)")
                    }
                }

                VStack {
                    Text("ELEMENTS").font(.subheadline).foregroundColor(.gray)
                    ForEach(weapon.elementsArray, id:\.self) { element in
                        Text("\(element.name!)")
                    }
                }
            }

            RulesView(rules: weapon.rulesArray)

            WeaponsView(weapons: weapon.attachmentsArray)

        }
    }
}


