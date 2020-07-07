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
            ScrollView {
                VStack {
                    HStack {
                        Spacer()
                        DoneButton(isPresented: $isPresented)
                            .padding()
                    }
                    Text("\(weapon.name!)")
                        .font(.system(size: 25, weight: .bold, design: .default))
                        .padding()

                    WeaponView(weapon: weapon)
                }
            }
        }
    }

