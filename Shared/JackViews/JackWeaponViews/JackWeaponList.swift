//
//  JackWeaponList.swift
//  iOS
//
//  Created by Peset Tan on 7/2/20.
//

import SwiftUI

struct JackWeaponList: View {
    var weapons: Set<Weapon>
    var body: some View {
        ForEach(weapons.sorted{$0.id! < $1.id!}, id:\.id) { weapon in
            JackWeaponCell(weapon: weapon, weapons: weapons)
        }
    }
}
