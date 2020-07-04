//
//  JackWeaponList.swift
//  iOS
//
//  Created by Peset Tan on 7/2/20.
//

import SwiftUI

struct JackWeaponList: View {
    var weapons: Set<Weapon>
    @ObservedObject var jack: Jack
    var body: some View {
        ForEach(weapons.sorted{$0.id! < $1.id!}, id:\.uuid) { weapon in
            JackWeaponCell(weapon: weapon, weapons: weapons, jack: jack)
        }
    }
}
