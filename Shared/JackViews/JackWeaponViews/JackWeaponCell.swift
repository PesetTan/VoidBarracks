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
    @State private var isPresented: Bool = false

    var body: some View {
        Button {
            isPresented.toggle()
        } label: {
            HStack {
                HStack{
                    Text("\(weapon.name!)")
                    Spacer()
                    Text("\(weapon.cost) points")

                    WeaponToggle(selected: Binding<Bool>(
                        get: { weapon.selected },
                        set: {weapon.selected = $0}
                    ),
                    group: weapons)
                }
            }
        }
        .sheet(isPresented: $isPresented) {
            JackWeaponInfo(weapon: weapon, isPresented: $isPresented)
        }
    }
}
