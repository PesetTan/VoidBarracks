//
//  JackWeaponCell.swift
//  iOS
//
//  Created by Peset Tan on 7/2/20.
//

import SwiftUI

struct JackWeaponCell: View {
    @ObservedObject var weapon: Weapon
    var weapons: Set<Weapon>
    @ObservedObject var jack: Jack
    @State private var isPresented: Bool = false

    var body: some View {
        HStack {
            Button {
                isPresented.toggle()
            } label: {
                Text("\(weapon.name!)")
            }
            .sheet(isPresented: $isPresented) {
                JackWeaponInfo(weapon: weapon, isPresented: $isPresented)
            }
            Spacer()

            WeaponToggle(selected: Binding<Bool>(
                get: { weapon.selected },
                set: {weapon.selected = $0}
            ),
            weapon: weapon, group: weapons, jack: jack)

        }

    }
}
