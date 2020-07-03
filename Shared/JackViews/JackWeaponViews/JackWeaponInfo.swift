//
//  WeaponInfo.swift
//  iOS
//
//  Created by Peset Tan on 7/2/20.
//

import SwiftUI

struct JackWeaponInfo: View {
    var weapon: Weapon
    @Binding var isPresented: Bool

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text("")
                    WeaponView(weapon: weapon)
                }
            }
            .navigationBarTitle(Text("\(weapon.name!)"), displayMode: .inline)
            .navigationBarItems(trailing: JackWeaponInfoDoneButton(isPresented: $isPresented))
        }
    }
}

struct JackWeaponInfoDoneButton: View {
    @Binding var isPresented: Bool

    var body: some View {
        Button {
            isPresented.toggle()
        } label: {
            Image(systemName: "multiply")
        }

    }
}


