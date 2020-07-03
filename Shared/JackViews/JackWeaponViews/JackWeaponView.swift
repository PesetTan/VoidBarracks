//
//  JackWeaponView.swift
//  VoidBarracks
//
//  Created by Peset Tan on 7/2/20.
//

import SwiftUI

struct JackWeaponView: View {
    var weapon: Weapon
    var headline: String

    var body: some View {
        VStack {
            Divider()
            Text("\(headline)").font(.headline).foregroundColor(.gray)
            WeaponView(weapon: weapon)
        }
    }
}
