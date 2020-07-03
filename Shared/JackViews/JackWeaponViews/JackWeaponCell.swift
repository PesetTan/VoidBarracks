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
                Toggle(isOn: Binding<Bool>(
                        get: { weapon.selected },
                        set: {
//                            weapons.forEach { $0.selected = false }
                            weapon.selected = $0
                        })) {
                    HStack{
                        Text("\(weapon.name!)")
                        Spacer()
                        Text("\(weapon.cost) points")
                    }
                }
                .toggleStyle(SwitchToggleStyle(tint: .accentColor))
            }
        }
        .sheet(isPresented: $isPresented) {
            JackWeaponInfo(weapon: weapon, isPresented: $isPresented)
        }
    }
}
